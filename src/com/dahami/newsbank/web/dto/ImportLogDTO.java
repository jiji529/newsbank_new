package com.dahami.newsbank.web.dto;

public class ImportLogDTO {
	private long seq;
	/** 대상 UCI 코드 */
	private String uciCode;
	/** 대상 매체 자체코드 */
	private String compCode;
	/** 미디어 코드 */
	private int member_seq;
	/** 실행 시간 : 타임스탬프 */
	private long runTime;
	/** 원본 xml */
	private String srcXml;
	/** 원본 이미지 */
	private String srcImg;
	/** 실행 결과 */
	private int result;
	/** 등록일자 */
	private String regTime;
	/**
	 * @return the seq
	 */
	public long getSeq() {
		return seq;
	}
	/**
	 * @param seq the seq to set
	 */
	public void setSeq(long seq) {
		this.seq = seq;
	}
	/**
	 * @return the uciCode
	 */
	public String getUciCode() {
		return uciCode;
	}
	/**
	 * @param uciCode the uciCode to set
	 */
	public void setUciCode(String uciCode) {
		this.uciCode = uciCode;
	}
	/**
	 * @return the compCode
	 */
	public String getCompCode() {
		return compCode;
	}
	/**
	 * @param compCode the compCode to set
	 */
	public void setCompCode(String compCode) {
		this.compCode = compCode;
	}
	/**
	 * @return the member_seq
	 */
	public int getMember_seq() {
		return member_seq;
	}
	/**
	 * @param member_seq the member_seq to set
	 */
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}
	/**
	 * @return the runTime
	 */
	public long getRunTime() {
		return runTime;
	}
	/**
	 * @param runTime the runTime to set
	 */
	public void setRunTime(long runTime) {
		this.runTime = runTime;
	}
	/**
	 * @return the srcXml
	 */
	public String getSrcXml() {
		return srcXml;
	}
	/**
	 * @param srcXml the srcXml to set
	 */
	public void setSrcXml(String srcXml) {
		this.srcXml = srcXml;
	}
	/**
	 * @return the srcImg
	 */
	public String getSrcImg() {
		return srcImg;
	}
	/**
	 * @param srcImg the srcImg to set
	 */
	public void setSrcImg(String srcImg) {
		this.srcImg = srcImg;
	}
	/**
	 * @return the result
	 */
	public int getResult() {
		return result;
	}
	/**
	 * @param result the result to set
	 */
	public void setResult(int result) {
		this.result = result;
	}
	/**
	 * @return the regTime
	 */
	public String getRegTime() {
		return regTime;
	}
	/**
	 * @param regTime the regTime to set
	 */
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}
	@Override
	public String toString() {
		return "ImportLogDTO [seq=" + seq + ", uciCode=" + uciCode + ", compCode=" + compCode + ", member_seq="
				+ member_seq + ", runTime=" + runTime + ", srcXml=" + srcXml + ", srcImg=" + srcImg + ", result="
				+ result + ", regTime=" + regTime + "]";
	}
}
