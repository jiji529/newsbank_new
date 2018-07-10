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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrQuery.ORDER;
import org.apache.solr.client.solrj.SolrRequest.METHOD;
import org.apache.solr.client.solrj.impl.CloudSolrClient;
import org.apache.solr.client.solrj.impl.HttpClientUtil;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.request.QueryRequest;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;

import com.dahami.common.util.HttpUtil;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

@SuppressWarnings("deprecation")
public class SearchDAO extends DAOBase {
	
	private static final SimpleDateFormat fullDf = new SimpleDateFormat("yyyyMMddHHmmss");
	
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
				
				HttpSolrClient.Builder httpSolrBuilder = new HttpSolrClient.Builder();
				CloudSolrClient.Builder cloudBuilder = null;
				if(zkHostList.size() > 0) {
//					cloudBuilder = new CloudSolrClient.Builder(zkHostList, Optional.empty())
					cloudBuilder = new CloudSolrClient.Builder(zkHostList, null)
							.withParallelUpdates(true);
				}
				
				while(solrClients.size() < poolSize) {
					if(zkHostList.size() > 0) {
						CloudSolrClient solr = cloudBuilder
								.withHttpClient(HttpUtil.getBasicAuthHttpClient(solrId,  solrPw))
								.build();
						solr.connect();
						solrClients.add(solr);
					}
					else if(solrHostList.size() > 0) {
						SolrClient solr = httpSolrBuilder
								.withBaseSolrUrl(solrHostList.get(solrHostIdx++))
								.withHttpClient(HttpUtil.getBasicAuthHttpClient(solrId,  solrPw))
								.build();
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
			List<PhotoDTO> photoList = new ArrayList<PhotoDTO>();
			int resultCount = 0;
			int pageVol = 10;
			if(query != null) {
				pageVol = query.getRows();
				// 정렬
				if(query.get("qt") != null && query.get("qt").trim().equals("/mlt")) {
	//				query.addSort("score", ORDER.desc);
				}
				else {
					String sField = param.getSortField();
					ORDER sOrder = param.getSortOrder();
					if(sField != null) {
						query.addSort(sField, sOrder);
					}
					if(sField == null || !sField.equals("uciCode")) {
						query.addSort("uciCode", ORDER.desc);	
					}
				}
				QueryRequest req = makeSolrRequest(query);
				client = getClient();
				long sTime = System.currentTimeMillis();
				res = req.process(client);
				long eTime = System.currentTimeMillis();
				if(query.get("qt") != null && query.get("qt").trim().equals("/mlt")) {
					query.setMoreLikeThis(true);
					logger.debug("MltTime: " + (eTime-sTime) + " msec");
				}
				else {
					logger.debug("QueryTime: " + (eTime-sTime) + " msec");	
				}
				
				SolrDocumentList docList = null;
				if(res.getResults() != null) {
					docList = res.getResults();
				}
				
				if(docList != null && docList.size() > 0) {
					MemberDAO mDao = new MemberDAO();
					List<MemberDTO> mList = mDao.listActiveMedia();
					Map<Integer, MemberDTO> memberMap = new HashMap<Integer, MemberDTO>();
					for(MemberDTO curM : mList) {
						memberMap.put(curM.getSeq(), curM);
					}
					for(SolrDocument doc : docList) {
						PhotoDTO cur = new PhotoDTO(doc);
						int ownerNo = cur.getOwnerNo();
						MemberDTO curMember = memberMap.get(ownerNo);
						if(curMember != null) {
							cur.setOwnerName(curMember.getCompName()); // 회사/기관명
						}
						else {
							logger.warn("멤버정보 없음: seq / " + ownerNo);
						}
						photoList.add(cur);
					}
					resultCount = (int)docList.getNumFound();
					
				}
			}
			ret.put("result", photoList);
			ret.put("count", resultCount);
			ret.put("totalPage", ((resultCount / pageVol) + 1));
		} catch (Exception e) {
			logger.warn("", e);
		}finally {
			releaseClient(client);
		}
		
		return ret;
	}
	
	private SolrQuery makeSolrQuery(SearchParameterBean params) {
		SolrQuery query = new SolrQuery();
		query.set("collection", collectionNameNewsbank);
		String photoId = params.getPhotoId();
		String keyword = params.getKeyword();
		String uciCode = params.getUciCode();
		
		String[] ownerTypes = params.getOwnerType();
		StringBuffer ownerTypeBuf = new StringBuffer();
		for(String ownerType : ownerTypes) {
			if(ownerTypeBuf.length() > 0) {
				ownerTypeBuf.append(" OR " );
			}
			ownerTypeBuf.append(ownerType);
		}
		if(ownerTypeBuf.length() > 0) {
			query.addFilterQuery("ownerType:(" + ownerTypeBuf.toString() + ")");
		}
		
		// 기본적으로 판매건만 보기
		int saleState = params.getSaleState();
		if(saleState == 0) {
			query.addFilterQuery("saleState:" + PhotoDTO.SALE_STATE_OK);
		}
		else {
			StringBuffer buf = new StringBuffer();
//			if((saleState & SearchParameterBean.SALE_STATE_NOT) == SearchParameterBean.SALE_STATE_NOT) {
//				if(buf.length() > 0) {
//					buf.append(" OR ");
//				}
//				buf.append(PhotoDTO.SALE_STATE_NOT);
//			}
			if((saleState & SearchParameterBean.SALE_STATE_OK) == SearchParameterBean.SALE_STATE_OK) {
				if(buf.length() > 0) {
					buf.append(" OR ");
				}
				buf.append(PhotoDTO.SALE_STATE_OK);
			}
			if((saleState & SearchParameterBean.SALE_STATE_BLIND) == SearchParameterBean.SALE_STATE_BLIND) {
				if(buf.length() > 0) {
					buf.append(" OR ");
				}
				buf.append(PhotoDTO.SALE_STATE_STOP);
			}
			if((saleState & SearchParameterBean.SALE_STATE_DEL) == SearchParameterBean.SALE_STATE_DEL) {
				if(buf.length() > 0) {
					buf.append(" OR ");
				}
				buf.append(PhotoDTO.SALE_STATE_DEL);
			}
			query.addFilterQuery("saleState:(" + buf.toString() + ")");
		}
		
		if(uciCode != null && uciCode.trim().length() > 0) {
			
			PhotoDTO pDto = new PhotoDAO().read(uciCode);
			if(pDto == null) {
				return null;
			}
			StringBuffer mltQfBuf = new StringBuffer();
			String pTitle = pDto.getTitle();
			if(pTitle.trim().length() > 1) {
				mltQfBuf.append("morp_title^2");
			}
			else {
				mltQfBuf.append("morp_title");
			}
			
			String pKeyword = pDto.getKeyword();
			if(pKeyword != null && pKeyword.trim().length() > 1) {
				mltQfBuf.append(" morp_keyword^1.5");
			}
			else {
				mltQfBuf.append(" morp_keyword");
			}
			mltQfBuf.append(" morp_description");
			
			query.setRequestHandler("/mlt");
			if(uciCode.startsWith(PhotoDTO.UCI_ORGAN_CODEPREFIX_DAHAMI)) {
				uciCode = uciCode.substring(PhotoDTO.UCI_ORGAN_CODEPREFIX_DAHAMI.length());
			}
			query.setQuery("uciCode:" + uciCode);
			
			query.setMoreLikeThis(true);
			query.setMoreLikeThisFields("morp_title", "morp_keyword", "morp_description");
//			query.set("mlt.fl", "morp_title morp_keyword morp_description");
			
			query.setMoreLikeThisQF(mltQfBuf.toString());
//			query.set("mlt.qf", mltQfBuf.toString());
			
			query.set("mlt.match.include", false);
			
			query.setMoreLikeThisBoost(true);
//			query.set("mlt.boost", true);;
			
			query.setMoreLikeThisMinTermFreq(1);
//			query.set("mlt.mintf", 1);
			
			query.setMoreLikeThisCount(params.getPageVol());
			query.setRows(params.getPageVol());
			
			StringBuffer ownerNoStr = new StringBuffer();
			for(int ownerNo : params.getSearchableUserList()) {
				if(ownerNoStr.length() > 0) {
					ownerNoStr.append(" OR ");
				}
				ownerNoStr.append(ownerNo);
			}
			query.setFilterQueries("ownerNo:(" + ownerNoStr.toString() + ")");
		}
		else {
			query.setRequestHandler("/select");
			
			StringBuffer qBuf = new StringBuffer();
			if(photoId.length() > 0) {
				logger.debug("photoId: " + photoId);
				qBuf.append("_query_:\"{!edismax q.op=AND qf='uciCode compCode oldCode'}")
					.append(normalizeKeywordStr(photoId))
					.append("\"");
			}
			else {
				logger.debug("keyword: " + keyword);
				qBuf.append("_query_:\"{!edismax q.op=AND qf='title description keyword shotperson copyright exif uciCode compCode oldCode'}")
					.append(normalizeKeywordStr(keyword))
					.append("\"");
			}
			query.setQuery(qBuf.toString());
			
			List<Integer> targetUserList = params.getTargetUserList();
			StringBuffer tgtBuf = new StringBuffer();
			if(targetUserList.size() > 0) {
				for(int targetUser : targetUserList) {
					if(tgtBuf.length() > 0) {
						tgtBuf.append(" OR ");
					}
					tgtBuf.append(targetUser);
				}
				query.addFilterQuery("ownerNo:(" + tgtBuf.toString() + ")");
				logger.debug("ownerNo: (" + tgtBuf.toString() + ")");
			}
			else {
				// 서비스 매체 없음 처리
				logger.warn("검색 가능 매체 없음");
				query.addFilterQuery("NOT ownerNo:*");
			}
			
//			String duration = params.getDuration();
			String durationReg = params.getDurationReg();
			String durationTake = params.getDurationTake();
			
//			setDuration(duration, "searchDate", query);
			setDuration(durationReg, "regDate", query);
			setDuration(durationTake, "shotDate", query);
			
			if(params.getContentType() != SearchParameterBean.CONTENT_TYPE_ALL) {
	//			query.addFilterQuery(")
				logger.debug("ContentType: " + params.getContentType());
			}
			
			if(params.getColorMode() != SearchParameterBean.COLOR_ALL) {
				query.addFilterQuery("mono:" + params.getColorMode());
				logger.debug("mono:" + params.getColorMode());
			}
			if(params.getHoriVertChoice() != SearchParameterBean.HORIZONTAL_ALL) {
				query.addFilterQuery("horizontal:" + params.getHoriVertChoice());
				logger.debug("horizontal: " + params.getHoriVertChoice());
			}
			if(params.getIncludePerson() != SearchParameterBean.INCLUDE_PERSON_ALL) {
				query.addFilterQuery("includePerson:" + params.getIncludePerson());
				logger.debug("includePerson: "  + params.getIncludePerson());
			}
			if(params.getPortRight() != SearchParameterBean.PORTRAIT_RIGHT_ALL) {
				query.addFilterQuery("portraitRightState:" + params.getPortRight());
				logger.debug("portraitRightState: " + params.getPortRight());
			}
			if(params.getSize() != SearchParameterBean.SIZE_ALL) {
				int size = params.getSize();
				if(size == (SearchParameterBean.SIZE_SMALL | SearchParameterBean.SIZE_MEDIUM | SearchParameterBean.SIZE_LARGE)) {
					// 전체
				}
				else {
					if((size & SearchParameterBean.SIZE_LARGE) == SearchParameterBean.SIZE_LARGE) {
						query.addFilterQuery("widthPx:[3000 TO *] AND heightPx:[3000 TO *]");
					}
					if((size & SearchParameterBean.SIZE_MEDIUM) == SearchParameterBean.SIZE_MEDIUM) {
						query.addFilterQuery("NOT (widthPx:[3000 TO *] AND heightPx:[3000 TO *])");
						query.addFilterQuery("NOT (widthPx:[* TO 1000] AND heightPx:[* TO 1000])");
					}
					if((size & SearchParameterBean.SIZE_SMALL) == SearchParameterBean.SIZE_SMALL) {
						query.addFilterQuery("widthPx:[* TO 1000] AND heightPx:[* TO 1000]");
					}
				}
			}
			
			int pageNo = params.getPageNo();
			int pageVol = params.getPageVol();
			logger.debug("pageNo: " + pageNo + " / PageVol: " + pageVol);
			if(pageNo < 1) { 
				pageNo = 1;
			}
			if(pageVol < 1) {
				pageVol = 40;
			}
			int startNo = pageVol * (pageNo - 1);
			query.setStart(startNo);
			query.setRows(pageVol);
		}
		return query;
	}
	
	private String normalizeKeywordStr(String keyword) {
		StringBuffer kwBuf = new StringBuffer();
		for(String curKw : keyword.trim().split("\\p{Space}+")) {
			if(curKw.startsWith(PhotoDTO.UCI_ORGAN_CODEPREFIX_DAHAMI)) {
				curKw = curKw.substring(PhotoDTO.UCI_ORGAN_CODEPREFIX_DAHAMI.length());
			}
			if(kwBuf.length() > 0) {
				kwBuf.append(" ");
			}
			kwBuf.append(curKw);
		}
		return kwBuf.toString();
	}
		
	
	private void setDuration(String duration, String field, SolrQuery query) {
		if(duration != null && duration.trim().length() > 0) {
			if(!duration.startsWith("C")) {
				Calendar sCal = Calendar.getInstance();
				sCal.add(Calendar.DAY_OF_YEAR, 1);
				sCal.set(Calendar.HOUR_OF_DAY, 0);
				sCal.set(Calendar.MINUTE, 0);
				sCal.set(Calendar.SECOND, 0);
				sCal.set(Calendar.MILLISECOND, 0);
				Calendar eCal = (Calendar) sCal.clone();
				if(duration.equals("1d")) {
					sCal.add(Calendar.DAY_OF_MONTH, -1);
				}
				else if(duration.equals("1w")) {
					sCal.add(Calendar.DAY_OF_MONTH, -7);
				}
				else if(duration.equals("1m")) {
					sCal.add(Calendar.MONTH, -1);
				}
				else if(duration.equals("1y")) {
					sCal.add(Calendar.YEAR, -1);
				}
				else {
//					logger.warn("잘못된 기간 형식: " + duration);
					sCal = null;
				}
				
				if(sCal != null) {
					query.addFilterQuery(field + ":[" + fullDf.format(sCal.getTime()) + " TO "+ fullDf.format(eCal.getTime()) +"}");
				}
			}
			else {
				String[] durationArry = duration.substring(1).split("~");
				query.addFilterQuery(field + ":[" + durationArry[0] + "000000 TO " + durationArry[1] + "235959]");
			}
			logger.debug(field + ": " + duration);
		}
	}
	
	protected QueryRequest makeSolrRequest(SolrQuery query) {
		QueryRequest req = new QueryRequest(query, METHOD.POST);
		req.setBasicAuthCredentials(solrId, solrPw);
		return req;
	}
}
