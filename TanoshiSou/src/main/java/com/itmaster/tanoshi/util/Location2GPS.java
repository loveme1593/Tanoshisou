package com.itmaster.tanoshi.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Location2GPS {

	private static final String clientId = "n5qAlCbyktbD6mXy_z0q";// 애플리케이션
																	// 클라이언트
	// 아이디값";
	private static final String clientSecret = "7OJqj3xhWC";// 애플리케이션
															// 클라이언트
															// 시크릿값";

	public static Map<String, Double> getGeocode(String location) {

		try {
			String addr = URLEncoder.encode(location, "UTF-8");
			String apiURL = "https://openapi.naver.com/v1/map/geocode?query=" + addr; // json
			// String apiURL =
			// "https://openapi.naver.com/v1/map/geocode.xml?query=" + addr; //
			// xml
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			String data = response.toString();
			ObjectMapper objectMapper = new ObjectMapper();
			Map<String, Object> map = (Map<String, Object>) objectMapper.readValue(data,
					new TypeReference<Map<String, Object>>() {
					});
			Map<String, Object> map2 = (Map<String, Object>) map.get("result");
			List<Object> items = (List<Object>) map2.get("items");
			Map<String, Object> map3 = (Map<String, Object>) items.get(0);
			Map<String, Double> result= (Map<String, Double>) map3.get("point");
			
			return result;
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
	}
}
