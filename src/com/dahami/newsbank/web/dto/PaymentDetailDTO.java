/**
 * <%---------------------------------------------------------------------------
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @Package Name   : com.dahami.newsbank.web.dto
 * @fileName : PaymentDetail.java
 * @author   : CHOI, SEONG HYEON
 * @date     : 2017. 11. 6.
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 11. 6.   	  tealight        PaymentDetail.java
 *--------------------------------------------------------------------------%>
 */
package com.dahami.newsbank.web.dto;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.dahami.newsbank.dto.PhotoDTO;

/**
 * @author p153-1706
 *
 */
public class PaymentDetailDTO implements Serializable {
	private static final long serialVersionUID = 7039845313451288322L;
	
	private static final SimpleDateFormat fullDf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	private int paymentDetail_seq;
	private int paymentManage_seq; //paymemtManage 시퀀스
	private int usageList_seq; //usageList 시퀀스
	private String photo_uciCode; //UCI 커드
	private int price;  // 가격
	private String downStart;  //다운로드 시작일
	private String downEnd; //다운로드 종료일
	private String downCount;  // 다운로드 횟수
	private UsageDTO usageDTO;
	private PhotoDTO photoDTO;
	
	/** 다운기한 종료(혹은 미도래) / downStart, downEnd 세팅시 확인 후 설정함 */
	private boolean downExpire;

	public boolean isDownExpire() {
		return this.downExpire;
	}
	
	public int getPaymentManage_seq() {
		return paymentManage_seq;
	}
	public void setPaymentManage_seq(int paymentManage_seq) {
		this.paymentManage_seq = paymentManage_seq;
	}
	public int getUsageList_seq() {
		return usageList_seq;
	}
	public void setUsageList_seq(int usageList_seq) {
		this.usageList_seq = usageList_seq;
	}
	public String getPhoto_uciCode() {
		return photo_uciCode;
	}
	public void setPhoto_uciCode(String photo_uciCode) {
		this.photo_uciCode = photo_uciCode;
	}
	public String getPrice_Str() {
		DecimalFormat df = new DecimalFormat("#,##0");
		return "\\" + df.format( price); // 가격 출력 포멧
	}
	public int getPrice() {
		return price; 
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getDownStart() {
		return downStart;
	}
	public void setDownStart(String downStart) {
		this.downStart = downStart;
		checkDownExpire();
	}
	public String getDownEnd() {
		return downEnd;
	}
	public void setDownEnd(String downEnd) {
		this.downEnd = downEnd;
		checkDownExpire();
	}
	public String getDownCount() {
		return downCount;
	}
	public void setDownCount(String downCount) {
		this.downCount = downCount;
	}
	public int getPaymentDetail_seq() {
		return paymentDetail_seq;
	}
	public void setPaymentDetail_seq(int paymentDetail_seq) {
		this.paymentDetail_seq = paymentDetail_seq;
	}
	public UsageDTO getUsageDTO() {
		return usageDTO;
	}
	public void setUsageDTO(UsageDTO usageDTO) {
		this.usageDTO = usageDTO;
	}
	public PhotoDTO getPhotoDTO() {
		return photoDTO;
	}
	public void setPhotoDTO(PhotoDTO photoDTO) {
		this.photoDTO = photoDTO;
	}
	private void checkDownExpire() {
		try{
			Date downS = fullDf.parse(this.downStart);
			Date downE = fullDf.parse(this.downEnd);
			Date now = new Date();
			if(downS.before(now) && downE.after(now)) {
				this.downExpire = false;
			}
			else {
				this.downExpire = true;
			}
		}catch(Exception e) {
			this.downExpire = true;
		}
	}
	
}
