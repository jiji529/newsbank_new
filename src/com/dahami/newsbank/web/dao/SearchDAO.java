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
import java.lang.invoke.MethodHandles;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;
import java.util.Set;
import java.util.TreeSet;

import org.apache.ibatis.session.SqlSession;
import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.SolrQuery.ORDER;
import org.apache.solr.client.solrj.SolrRequest.METHOD;
import org.apache.solr.client.solrj.impl.CloudSolrClient;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.request.QueryRequest;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.params.SolrParams;

import com.dahami.common.util.HttpUtil;
import com.dahami.newsbank.Constants;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

public class SearchDAO extends DAOBase {
	
	private static final SimpleDateFormat fullDf = new SimpleDateFormat("yyyyMMddHHmmss");
	
	private static SolrPoolManager spMgr;
	private static SolrConnectionValidCheck scvChk;
	
	private static int currentUsingSolrCnt;
	private static List<SolrClient> solrClients;
	private static String solrId;
	private static String solrPw;
	
	private static Object monitor;
	private static boolean usingBlockF;
	
	private static boolean isZkUse;
	private static String collectionNameNewsbank;
	
	static {
		monitor = new Object();
		solrClients = new ArrayList<SolrClient>();
	}
	
	public static void destroy() {
		if(spMgr != null && spMgr.isAlive()) {
			spMgr.exitF = true;
			while(spMgr.isAlive()) {
				synchronized (spMgr) {
					try{spMgr.notifyAll();}catch(Exception e){}
				}
				try{Thread.sleep(100);}catch(Exception e){}
			}
			logger.info("SolrPoolManagerT Finished");
		}
		if(scvChk != null && scvChk.isAlive()) {
			scvChk.exitF = true;
			while(scvChk.isAlive()) {
				synchronized(scvChk) {
					try{scvChk.notifyAll();}catch(Exception e){}
				}
				try{Thread.sleep(100);}catch(Exception e){}
			}
			logger.info("SolrConCheckT Finished");
		}
    }
	
	public static void init() {
		if(spMgr == null) {
			synchronized(monitor) {
				if(spMgr == null) {
					spMgr = new SolrPoolManager();
					spMgr.start();
				}
			}
		}
		if(scvChk == null) {
			synchronized (monitor) {
				if(scvChk == null) {
					scvChk = new SolrConnectionValidCheck();
					scvChk.start();
				}
			}
		}
	}
	
	private static SolrClient getClient() {
		while(true) {
			synchronized(solrClients) {
				if(!usingBlockF && solrClients.size() > 0) {
					currentUsingSolrCnt++;
					return solrClients.remove(0);
				}
				else {
					if(currentUsingSolrCnt == scvChk.illigalSolrList.size()) {
						logger.warn("No Available Connection(ALL Error!)");
						solrClients.notifyAll();
						try{solrClients.wait(60000);}catch(Exception e){}	
					}
					else {
						solrClients.notifyAll();
						try{solrClients.wait(100);}catch(Exception e){}	
					}
				}
			}
		}
	}
	
	private static void releaseClient(SolrClient client) {
		if(client == null) {
			return;
		}
		synchronized(solrClients) {
			currentUsingSolrCnt--;
			solrClients.add(client);
			solrClients.notifyAll();
		}
	}
	
	private SolrClient checkConnectionValid(SolrClient client) {
		try{Thread.sleep(1000);}catch(Exception e) {}
		SolrQuery query = makeDummyQuery();
		QueryRequest req = makeSolrRequest(query);
		@SuppressWarnings("unused")
		QueryResponse res = null;
		try {
			res = req.process(client);
			System.out.println();
		}catch(Exception e){
			if(e.getMessage().startsWith("Server refused connection")) {
				if(client instanceof HttpSolrClient) {
					scvChk.addCheckTarget((HttpSolrClient)client);
					client = null;
				}
			}
		}
		return client;
	}
	
	private static SolrQuery makeDummyQuery() {
		SolrQuery query = new SolrQuery();
		if(isZkUse) {
			// 7.x 부터 주키퍼 사용시만 세팅 / 아닌경우 세팅하면 post 요청시 오류발생함
			query.set("collection", collectionNameNewsbank);
		}
		query.setQuery("*:*");
		query.setRows(1);
		return query;
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
//					List<MemberDTO> mList = mDao.listActiveMedia();
					List<MemberDTO> mList = mDao.listManagableMedia();
					
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
			if(!isZkUse && e instanceof SolrServerException) {
				client = checkConnectionValid(client);
			}
			if(client != null) {
				logger.warn("", e);
			}
			else {
				logger.warn("Search Error / RETRY");
				return search(param);
			}
		}finally {
			releaseClient(client);
		}
		
		return ret;
	}
	
	private SolrQuery makeSolrQuery(SearchParameterBean params) {
		SolrQuery query = new SolrQuery();
		if(isZkUse) {
			// 7.x 부터 주키퍼 사용시만 세팅 / 아닌경우 세팅하면 post 요청시 오류발생함
			query.set("collection", collectionNameNewsbank);
		}
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
			if(!params.isFullSearch()) {
				query.addFilterQuery("ownerType:(" + ownerTypeBuf.toString() + ")");
			}
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
				if(Constants.SEARCH_FIELD_MORP) {
					qBuf.append("_query_:\"{!edismax q.op=AND qf='morp_title morp_description morp_keyword shotperson copyright exif uciCode compCode oldCode'}");
				}
				else {
					qBuf.append("_query_:\"{!edismax q.op=AND qf='title description keyword shotperson copyright exif uciCode compCode oldCode'}");
				}
				qBuf.append(normalizeKeywordStr(keyword))
					.append("\"");
			}
			query.setQuery(qBuf.toString());
			
			List<Integer> targetUserList = params.getTargetUserList();
			StringBuffer tgtBuf = new StringBuffer();
			if(targetUserList.size() > 0) {
				if(params.isFullSearch()) {
					// 모든 매체 검색
					targetUserList.clear();
				}
				else {
					for(int targetUser : targetUserList) {
						if(tgtBuf.length() > 0) {
							tgtBuf.append(" OR ");
						}
						tgtBuf.append(targetUser);
					}
					query.addFilterQuery("ownerNo:(" + tgtBuf.toString() + ")");
					logger.debug("ownerNo: (" + tgtBuf.toString() + ")");
				}
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
	
	protected static QueryRequest makeSolrRequest(SolrQuery query) {
		QueryRequest req = new QueryRequest(query, METHOD.POST);
		req.setBasicAuthCredentials(solrId, solrPw);
		return req;
	}
	
	/**
	 * 사용 대상 검색엔진 정보 테이블(searchEngine)을 모니터링하여 커넥션을 관리(재생성) 하는 쓰레드 
	 */
	private static class SolrPoolManager extends Thread {
		private String befSolrStr;
		private boolean exitF;
		
		private Properties conf;
		private int poolSize;
		
		public SolrPoolManager() {
			super("SolrPoolManager");
		}
		
		public void run() {
			befSolrStr = "";
			
			loadProperties();
			solrId = conf.getProperty("AUTH_SOLR_ID");
			solrPw = conf.getProperty("AUTH_SOLR_PW");
			collectionNameNewsbank = (String) conf.get(Constants.TARGET_SOLR_COLLECTION_PREFIX_PARAM + Constants.TARGET_SOLR_COLLECTION_SUFFIX_PARAM);
			poolSize = Integer.parseInt(conf.getProperty("SOLR_POOL"));
			
			while(!exitF) {
				// 30초마다 엔진 리스트 읽어서 갱신된 경우 클라이언트 리스트 재생성
				List<String> engineList = getEngineListIfModified();
				if(engineList != null && engineList.size() > 0) {
					// 연결 사용중단 세팅 후 모두 반납될 때 까지 대기
					usingBlockF = true;
					while(true) {
						synchronized(solrClients) {
							int solrPoolSize = scvChk.illigalSolrList.size() + solrClients.size();
							if(solrPoolSize == 0 || solrPoolSize >= poolSize) {
								break;
							}
							try{solrClients.wait(100);}catch(Exception e){}
						}
					}
					
					List<String> zkHostList = new ArrayList<String>();
					List<String> solrHostList = new ArrayList<String>();
					for(String url : engineList) {
						if(url.startsWith("http")) {
							solrHostList.add(url);
						}
						else if(url.startsWith("zk")) {
							zkHostList.add(url);
						}
					}
					
					synchronized(solrClients) {
						// 모두 반납됨 / 기존 연결 모두 제거
						for(SolrClient client : solrClients) {
							try{client.close();}catch(Exception e){}
						}
						solrClients.clear();
						for(SolrClient client : scvChk.illigalSolrList) {
							try{client.close();}catch(Exception e){}
						}
						scvChk.illigalSolrList.clear();
						
						logger.info("(Re)Make SOLR connection: " + befSolrStr);
						// 연결 새로 생성
						CloudSolrClient.Builder cloudBuilder = null;
						if(zkHostList.size() > 0) {
							cloudBuilder = 
							// 6.6.x
//								new CloudSolrClient.Builder().withZkHost(zkHostList)
							// 7.x
							new CloudSolrClient.Builder(zkHostList, Optional.empty()).withParallelUpdates(true);
							
							cloudBuilder.withHttpClient(HttpUtil.getBasicAuthHttpClient(solrId, solrPw));
						}
							
						int solrHostIdx = 0;
						while(solrClients.size() < poolSize) {
							if(cloudBuilder != null) {
								CloudSolrClient solr = cloudBuilder.build();
								solr.setZkClientTimeout(60000);
								solr.setZkConnectTimeout(60000);
								solr.setDefaultCollection(collectionNameNewsbank);
								// 6.x
//									solr.setParallelUpdates(true);
								solr.connect();
								solrClients.add(solr);
							}
							else if(solrHostList.size() > 0) {
								String addr = solrHostList.get(solrHostIdx++);
								if(addr == null) {
									addr = "";
								}
								addr = addr.trim();
								if(!addr.endsWith("/")) {
									addr += "/";
								}
								
								HttpSolrClient.Builder httpSolrBuilder = new HttpSolrClient.Builder()
										.withBaseSolrUrl(addr + collectionNameNewsbank)
										.withHttpClient(HttpUtil.getBasicAuthHttpClient(solrId, solrPw));
								@SuppressWarnings("serial")
								HttpSolrClient solr =
										// 6.x
//											httpSolrBuilder.build();
										// 7.x
										new HttpSolrClient(httpSolrBuilder) {
											public QueryResponse query(SolrParams params) throws SolrServerException, IOException {
												return super.query(params, METHOD.POST);
											}
										};
										
								solrClients.add(solr);
								if(solrHostIdx >= solrHostList.size()) {
									solrHostIdx = 0;
								}
							}
							else {
								break;
							}
						}
						
						// 사용중단 리셋
						usingBlockF = false;
						solrClients.notifyAll();
					}
				}
				else {
					synchronized(this) {
						try{this.wait(30000);}catch(Exception e){}
					}
				}
			}
			logger.info("Finish");
		}
		
		private List<String> getEngineListIfModified() {
			List<String> ret = new ArrayList<String>();
			SqlSession session = null;
			Set<String> retSet = new TreeSet<String>();
			try {
				session = sf.getSession();
				List<Map<String, Object>> engineList = session.selectList("searchEngine.listActiveEngine");
				
				for(Map<String, Object> engine : engineList) {
					String url = (String) engine.get("url");
					
					if(url.startsWith("http") || url.startsWith("zk")) {
						retSet.add(url);	
					}
					else {
						logger.warn("Illigal Solr Host: " + url);
					}
				}
				ret.addAll(retSet);
				String newSolrStr = "";
				for(String url : ret) {
					newSolrStr += ";" + url;
				}
				if(newSolrStr.equals(befSolrStr)) {
					ret.clear();
				}
				befSolrStr = newSolrStr;
			}catch(Exception e) {
				logger.warn("", e);
			}finally {
				try {session.close();}catch(Exception e){}
			}
			return ret;
		}
		
		private void loadProperties() {
			InputStream confStream = null;
			conf = new Properties();
			try {
				confStream = MethodHandles.lookup().lookupClass().getClassLoader().getResource("com/dahami/newsbank/web/dao/conf/solr.properties").openStream();
				conf.load(confStream);
			} catch (IOException e) {
				logger.error("Fail to Load properties File", e);
				System.exit(-1);
			}finally {
				try{confStream.close();}catch(Exception e){}
			}
		}
	}

	private static class SolrConnectionValidCheck extends Thread {
		private boolean exitF;
		private List<HttpSolrClient> illigalSolrList;
		
		public SolrConnectionValidCheck() {
			super("SolrConnectionValidCheck");
			illigalSolrList = new ArrayList<HttpSolrClient>();
		}
		
		private void addCheckTarget(HttpSolrClient client) {
		logger.warn("isolate Error Connection: " + client.getBaseURL());
			synchronized(illigalSolrList) {
				illigalSolrList.add(client);
				illigalSolrList.notifyAll();
			}
		}
		
		public void run() {
			@SuppressWarnings("unused")
			QueryResponse res = null;
			while(!exitF) {
				boolean modifyF = false;
				synchronized(solrClients) {
					if(illigalSolrList.size() > 0) {
						for(int i = 0; !usingBlockF && i < illigalSolrList.size(); i++) {
							HttpSolrClient client = illigalSolrList.get(i);
							SolrQuery query = makeDummyQuery();
							QueryRequest req = makeSolrRequest(query);
							try {
								res = req.process(client);
								// 성공 / 제거하기
								illigalSolrList.remove(i--);
								releaseClient(client);
								logger.info("Connection recovered: " + client.getBaseURL());
								modifyF = true;
								solrClients.notifyAll();
							}catch(Exception e){
								// 오류시 그대로 유지
							}
						}
					}
				}
				
				if(!modifyF) {
					synchronized(this) {
						try{this.wait(10000);}catch(Exception e){}
					}	
				}
			}
			logger.info("Finish");
		}
	}
}
