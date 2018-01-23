package com.dahami.newsbank.web.dto;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.builder.HashCodeBuilder;

import com.sun.xml.internal.ws.wsdl.writer.UsingAddressing;

public class UsageDTO {

	private int usageList_seq; // 고유번호
	private String usage; // 사용 용도
	private String division1; // 구분1
	private String division2; // 구분2
	private String division3; // 구분3
	private String division4; // 구분4
	private String usageDate; // 사용기한
	private int price; // 가격
	
	
	public int getUsageList_seq() {
		return usageList_seq;
	}
	public void setUsageList_seq(int usageList_seq) {
		this.usageList_seq = usageList_seq;
	}
	public String getUsage() {
		return usage;
	}
	public void setUsage(String usage) {
		this.usage = usage;
	}
	public String getDivision1() {
		return division1;
	}
	public void setDivision1(String division1) {
		this.division1 = division1;
	}
	public String getDivision2() {
		return division2;
	}
	public void setDivision2(String division2) {
		this.division2 = division2;
	}
	public String getDivision3() {
		return division3;
	}
	public void setDivision3(String division3) {
		this.division3 = division3;
	}
	public String getDivision4() {
		return division4;
	}
	public void setDivision4(String division4) {
		this.division4 = division4;
	}	
	public String getUsageDate() {
		return usageDate;
	}
	public void setUsageDate(String usageDate) {
		this.usageDate = usageDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}	
	public String getPrice_Str() {
		DecimalFormat df = new DecimalFormat("#,##0");
		return "\\" + df.format(price); // 가격 출력 포멧
	}
	
	public String formatPrice(int value) {
		DecimalFormat df = new DecimalFormat("#,##0");
		return "\\" + df.format(value); // 가격 출력 포멧
	}
	
	/**
	 * @methodName  : convertToMap
	 * @author      : LEE, GWAGNHO
	 * @date        : 2017. 10. 31. 오전 11:28:03
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
	
	/*@Override
	public int hashCode() {
		return new HashCodeBuilder().append(usageList_seq).toHashCode();
	}
	
	@Override
	public boolean equals(Object obj) {
		if(obj instanceof UsageDTO) {
			UsageDTO temp = (UsageDTO) obj;
			if(this.usageList_seq == temp.usageList_seq) {
				return true;
			}
		}
		return false;
	}*/
	
	
}
