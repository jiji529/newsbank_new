package com.dahami.newsbank.web.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dahami.newsbank.web.dto.HomeDTO;


public interface HomeService {

	public List<HomeDTO> selPhoto(Map<String, Object> Params);

	public List<HashMap<String, String>> selectSample() ;
}
