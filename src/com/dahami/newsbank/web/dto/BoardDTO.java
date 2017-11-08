package com.dahami.newsbank.web.dto;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.HashMap;
import java.util.Map;

public class BoardDTO {

	private int seq; // 공지 고유번호
	private String title; // 공지 제목
	private String description; // 공지 내용
	private String fileName; // 첨부파일 이름
	private String popup; // 팝업 유무
	private int hitCount; // 조회수
	private String regDate; // 등록일자
	
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getPopup() {
		return popup;
	}
	public void setPopup(String popup) {
		this.popup = popup;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	/**
	 * @methodName  : convertToMap
	 * @author      : LEE. GWANGHO
	 * @date        : 2017. 11. 18. 오전 10:28:03
	 * @methodCommet: 
	 * @return
	 * @throws Exception 
	 * @returnType  : Map<String,Object>
	 */
	public Map<String, Object> convertToMap() throws Exception {
		Field[] fields = this.getClass().getDeclaredFields();
		Map<String, Object> result = new HashMap<String, Object>();
		
		for(Field cur : fields) {
			int modifier = cur.getModifiers();
			if((modifier & Modifier.STATIC) == Modifier.STATIC) {
				continue;
			}
					
			
			result.put(cur.getName(), cur.get(this));
			
		}
		return result;
	}

}
