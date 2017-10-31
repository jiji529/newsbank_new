/*******************************************************************************
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : SearchDAO.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2017. 10. 10. 오후 3:39:50
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 10. 10.     JEON,HYUNGGUK		최초작성
 * 2017. 10. 10.     
 *******************************************************************************/

package com.dahami.newsbank.web.dao;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletConfig;

import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrRequest.METHOD;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.CloudSolrClient;
import org.apache.solr.client.solrj.impl.HttpClientUtil;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.json.simple.JSONObject;

import com.dahami.common.util.ObjectUtil;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

public class SearchDAO extends DAOBase {
	
	private static Properties conf;
	private static List<SolrClient> solrClients;
	private static List<String> zkHostList;
	private static List<String> solrHostList;
	
	private static String collectionNameNewsbank;
	
	private static String solrId;
	private static String solrPw;
	
	private static boolean initialized;
	private static Object monitor;
	
	static {
		monitor = new Object();
	}
	
	public void init() {
		synchronized(monitor) {
			if(initialized) {
				return;
			}
			loadProperties();
			
			if(solrClients == null) {
				// 로컬 개발시 / 서버 서비스시 다른 설정을 적용하기 위해
				boolean isDevServer = false;
				String userDomain = System.getenv().get("USERDOMAIN");
				if(conf.getProperty("ZK_HOSTS_" + userDomain) != null
						|| conf.getProperty("SOLR_HOSTS_" + userDomain) != null) {
					isDevServer = true;
				}
				
				solrId = conf.getProperty("AUTH_SOLR_ID");
				solrPw = conf.getProperty("AUTH_SOLR_PW");
				
				try{
					zkHostList = new ArrayList<String>();
					String[] zkHostArry = null;
					if(isDevServer) {
						zkHostArry = conf.getProperty("ZK_HOSTS_" + userDomain).split("\\s*\\,\\s*");
					}
					else {
						zkHostArry = conf.getProperty("ZK_HOSTS").split("\\s*\\,\\s*");
					}
					for(String zkHost : zkHostArry) {
						zkHostList.add(zkHost);	
					}
				}catch(Exception e) {}
				if(zkHostList.size() == 0) {
					solrHostList = new ArrayList<String>();
					String[] solrHostArry = null;
					if(isDevServer) {
						solrHostArry = conf.getProperty("SOLR_HOSTS_" + userDomain).split("\\s*\\,\\s*");;	
					}
					else {
						solrHostArry = conf.getProperty("SOLR_HOSTS").split("\\s*\\,\\s*");;
					}
					for(String solrHost : solrHostArry) {
						solrHostList.add(solrHost);
					}
				}
				
				collectionNameNewsbank = (String) conf.get("COLLECTION_NAME_NEWSBANK");
				
				solrClients = new ArrayList<SolrClient>();
				int poolSize = Integer.parseInt(conf.getProperty("SOLR_POOL"));
				int solrHostIdx = 0;
				while(solrClients.size() < poolSize) {
					if(zkHostList.size() > 0) {
						CloudSolrClient solr = new CloudSolrClient(zkHostList, null);
						solr.setParallelUpdates(true);
						solr.connect();
						setSolrAuth(solr);
						solrClients.add(solr);
					}
					else if(solrHostList.size() > 0) {
						SolrClient solr = new HttpSolrClient(solrHostList.get(solrHostIdx++));
						setSolrAuth(solr);
						solrClients.add(solr);
						if(solrHostIdx >= solrHostList.size()) {
							solrHostIdx = 0;
						}
					}
					else {
						break;
					}
				}
			}
			initialized = true;
		}
	}

	private void setSolrAuth(SolrClient solr) {
		HttpClient httpClient = null;
		if(solr instanceof HttpSolrClient) {
			httpClient = ((HttpSolrClient)solr).getHttpClient();
		}
		else if(solr instanceof CloudSolrClient) {
			httpClient = ((CloudSolrClient)solr).getLbClient().getHttpClient();
		}
		HttpClientUtil.setBasicAuth((DefaultHttpClient)httpClient, this.solrId, this.solrPw);
	}

	private void loadProperties() {
		InputStream confStream = null;
		conf = new Properties();
		try {
			confStream = getClass().getClassLoader().getResource("com/dahami/newsbank/web/dao/conf/solr.properties").openStream();
			conf.load(confStream);
		} catch (IOException e) {
			logger.error("Fail to Load properties File", e);
			System.exit(-1);
		}finally {
			try{confStream.close();}catch(Exception e){}
		}
	}
	
	private SolrClient getClient() {
		while(true) {
			synchronized(solrClients) {
				if(solrClients.size() > 0) {
					return solrClients.remove(0);
				}
				try{solrClients.wait(50);}catch(Exception e){}
			}
		}
	}
	private void releaseClient(SolrClient client) {
		if(client == null) {
			return;
		}
		synchronized(solrClients) {
			solrClients.add(client);
			solrClients.notifyAll();
		}
	}
	
	/**
	 * @methodName  : search
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2017. 10. 12. 오전 11:11:31
	 * @methodCommet: 주어진 조건으로 검색하여 결과리스트 리턴
	 * @param param
	 * @return 
	 * @returnType  : Map<String, Object> / count:결과 숫자(Integer) / result:결과물 리스트(List<PhotoDTO>)
	 */
	public Map<String, Object> search(SearchParameterBean param) {
		Map<String, Object> ret = new HashMap<String, Object>();
		
		SolrClient client = null;
		QueryResponse res = null;
		try {
			SolrQuery query = makeSolrQuery(param);
			client = getClient();
			res = client.query(query, METHOD.POST);
			SolrDocumentList docList = res.getResults();
			ret.put("count", (int)docList.getNumFound());
			List<PhotoDTO> photoList = new ArrayList<PhotoDTO>();
			for(SolrDocument doc : docList) {
				photoList.add(new PhotoDTO(doc));
			}
			ret.put("result", photoList);
			System.out.println();
		} catch (Exception e) {
			logger.warn("", e);
		}finally {
			releaseClient(client);
		}
		
		
		
		
//		List<PhotoDTO> photoList = new ArrayList<PhotoDTO>();
//		List<PhotoDTO> totalList = (List<PhotoDTO>) ObjectUtil.loadObject(PhotoDTO.class.getResourceAsStream("photoList.obj"));
//		
//		int pageVol = param.getPageVol();
//		int pageNo = param.getPageNo();
//		
//		int start = (pageNo-1) * pageVol;
//		
//		if(start >= 0 && start < totalList.size()) {
//			for(int i = 0; i < pageVol; i++) {
//				PhotoDTO cur = null;
//				try {
//					cur = totalList.get(start + i);
//					if(cur != null) {
//						photoList.add(cur);
//					}
//				}catch(Exception e) {
//					break;
//				}
//			}
//		}
//		
//		ret.put("count", totalList.size());
//		ret.put("result", photoList);
		
		return ret;
	}
	
	private SolrQuery makeSolrQuery(SearchParameterBean params) {
		SolrQuery qry = new SolrQuery();
		qry.set("collection", collectionNameNewsbank);
		String keyword = params.getKeyword();
		qry.setQuery(keyword);
		return qry;
	}
}
