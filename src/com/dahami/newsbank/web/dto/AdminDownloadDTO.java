package com.dahami.newsbank.web.dto;

public class AdminDownloadDTO extends DownloadDTO {
	private String id;
	private String name;
	private String compName;
	private String media;
	

	public AdminDownloadDTO(String id, String name, String compName, String media) {
		super();
		this.id = id;
		this.name = name;
		this.compName = compName;
		this.media = media;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getCompName() {
		return compName;
	}


	public void setCompName(String compName) {
		this.compName = compName;
	}


	public String getMedia() {
		return media;
	}


	public void setMedia(String media) {
		this.media = media;
	}
	

}
