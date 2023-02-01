/*******************************************************************************
 * Copyright ⓒ 2018 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : Constants.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2018. 7. 11. 오후 3:39:57
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2018. 7. 11.     JEON,HYUNGGUK		최초작성
 * 2018. 7. 11.     
 *******************************************************************************/

package com.dahami.newsbank;

public class Constants {

	/** 개발/서비스 구분 */
//	private static final boolean IS_SERVICE = true;
	private static final boolean IS_SERVICE = false;

	/** 형태소분석 사용 */
//	public static final boolean SEARCH_FIELD_MORP = true;
	public static final boolean SEARCH_FIELD_MORP = false;
	
	/** 검색 정렬 : 스코어 */
//	public static final boolean SEARCH_SORT_SCORE = true;
	public static final boolean SEARCH_SORT_SCORE = false;
	
	////////////////////////////////////////////////////////////////////////
	// 아래는 수정할 필요 없음
	////////////////////////////////////////////////////////////////////////
	
	/** 연동 DB */
	public static final String TARGET_DB;
	
	/** 연동 검색엔진 주소 설정 파라메터 */
	public static final String TARGET_SOLR_ADDR_CLOUD_PREFIX_PARAM = "ZK_HOSTS";
	public static final String TARGET_SOLR_ADDR_HTTP_PREFIX_PARAM = "SOLR_HOSTS";
	public static final String TARGET_SOLR_ADDR_SUFFIX_PARAM;
	
	/** 연동 검색엔진 컬렉션 파라메터 */
	public static final String TARGET_SOLR_COLLECTION_PREFIX_PARAM = "COLLECTION_NAME_NEWSBANK";
	public static final String TARGET_SOLR_COLLECTION_SUFFIX_PARAM;
	
	static {
		if(IS_SERVICE) {
			TARGET_DB = "service";
			TARGET_SOLR_ADDR_SUFFIX_PARAM = "_REAL";
			TARGET_SOLR_COLLECTION_SUFFIX_PARAM = "_REAL";
		}
		else {
			TARGET_DB = "dev";
			TARGET_SOLR_ADDR_SUFFIX_PARAM = "_DEV";
			TARGET_SOLR_COLLECTION_SUFFIX_PARAM = "_DEV";
		}
	}
	

}
