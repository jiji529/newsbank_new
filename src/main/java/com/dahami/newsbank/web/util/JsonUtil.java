package com.dahami.newsbank.web.util;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class JsonUtil {
	/**
	 * List<Map>을 jsonString으로 변환한다.
	 *
	 * @param list List<Map<String, Object>>.
	 * @return String.
	 */
	@SuppressWarnings("unchecked")
	public static String getJsonStringFromList( List<Map<String, Object>> list ) {
		JSONArray jsonArray = new JSONArray();
		for( Map<String, Object> map : list ) {
			jsonArray.add( getJsonStringFromMap( map ) );
		}
		return jsonArray.toJSONString();
	}
	
	/**
	 * Map을 json으로 변환한다.
	 *
	 * @param map Map<String, Object>.
	 * @return String.
	 */
	@SuppressWarnings("unchecked")
	public static JSONObject getJsonStringFromMap( Map<String, Object> map ) {
		JSONObject json = new JSONObject();
		for( Map.Entry<String, Object> entry : map.entrySet() ) {
			String key = entry.getKey();
			Object value = entry.getValue();
			json.put(key, value);
		}
		return json;
	}
	
	/**
	 * List<Map>을 jsonArray으로 변환한다.
	 *
	 * @param list List<Map<String, Object>>.
	 * @return JSONArray.
	 */
	@SuppressWarnings("unchecked")
	public static JSONArray getJsonArrayFromList( List<Map<String, Object>> list ) {
		JSONArray jsonArray = new JSONArray();
		for( Map<String, Object> map : list ) {
			jsonArray.add( getJsonStringFromMap( map ) );
		}
		return jsonArray;
	}
}
