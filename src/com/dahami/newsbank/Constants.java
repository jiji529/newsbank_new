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

	/** 연동 DB */
	public static final String TARGET_DB = "service";
//	public static final String TARGET_DB = "dev";
	
	/** 연동 검색엔진 설정 파라메터 */
	public static final String TARGET_SOLR_PARAM = "COLLECTION_NAME_NEWSBANK_REAL";
//	public static final String TARGET_SOLR_PARAM = "COLLECTION_NAME_NEWSBANK_DEV";
	
	/** 형태소분석 사용 */
//	public static final boolean SEARCH_FIELD_MORP = true;
	public static final boolean SEARCH_FIELD_MORP = false;
	
	/** 검색 정렬 : 스코어 */
//	public static final boolean SEARCH_SORT_SCORE = true;
	public static final boolean SEARCH_SORT_SCORE = false;
}
