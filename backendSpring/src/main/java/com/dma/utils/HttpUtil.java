package com.dma.utils;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import com.dma.share.response.BaseResponse;
import com.dma.share.response.ListResponse;
import com.dma.share.response.SingleResponse;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

public class HttpUtil {

    // @formatter:off      
    public static RestTemplate restTemplate = new RestTemplate(); 
    public static RestTemplate sslRestTemplate = new RestTemplate();    

    private static Type TYPE_MAP = new TypeToken<HashMap<?, ?>>() { }.getType();
    private static Type TYPE_LIST = new TypeToken<ArrayList<HashMap<?, ?>>>() { }.getType();
    private static Type TYPE_SINGLE_RESPONSE = new TypeToken<SingleResponse<?>>() { }.getType();
    private static Type TYPE_LIST_RESPONSE = new TypeToken<ListResponse<?>>() { }.getType();
    private static Type TYPE_BASE_RESPONSE = new TypeToken<BaseResponse>() { }.getType();
    // @formatter:on

    private HttpUtil() {    
    }

    public static HttpHeaders getHeaders() {
        HttpHeaders httpHeaders = new HttpHeaders();                
        httpHeaders.set(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE);
        httpHeaders.setAccessControlAllowOrigin("*");
        return httpHeaders;
    }
    public static HttpHeaders getHeaders(@Nullable MultiValueMap<String, String> headers) {
        HttpHeaders httpHeaders = getHeaders();
        httpHeaders.putAll(headers);
        return httpHeaders;
    }

    public static byte[] download(String url) {
        HttpHeaders headers = HttpUtil.getHeaders();
        ResponseEntity<byte[]> exchange = HttpUtil.restTemplate.exchange(url, HttpMethod.GET, new HttpEntity<MultiValueMap<String, Object>>(headers), byte[].class);
        return exchange.getBody();
    }
   
    private static Gson gson = new Gson();


    // JsonUtil.fromJson 대체하려고 만듦
    // 테스트 필요
    public static HashMap<?, ?> fromJson(JsonObject json) {
        return gson.fromJson(json, TYPE_MAP);
    }

    // JsonUtil.fromJson 대체하려고 만듦
    // 테스트 필요
    public static List<Object> fromJson(JsonArray jsonArray) {
        return gson.fromJson(jsonArray, TYPE_LIST);
    }

    private static ArrayList<HashMap<?, ?>> extractDataList(JsonObject json) {
        return gson.fromJson(json.getAsJsonObject("result"), TYPE_LIST);
    }
    private static HashMap<?, ?> extractDataMap(JsonObject json) {
        return gson.fromJson(json.getAsJsonObject("result"), TYPE_MAP);
    }

    public static SingleResponse<?> convertSingleResponse(JsonObject json) {
        return gson.fromJson(json, TYPE_SINGLE_RESPONSE);
    }

    public static ListResponse<?> convertListResponse(JsonObject json) {
        return gson.fromJson(json, TYPE_LIST_RESPONSE);
    }

    public static BaseResponse convertBaseResponse(JsonObject json) {
        return gson.fromJson(json, TYPE_BASE_RESPONSE);
    }

    public static BaseResponse convertResponse(JsonObject json) {
        String type = "";
        try {
            type = json.getAsJsonPrimitive("type").getAsString();
        } catch (Exception e) {
        }

        BaseResponse baseResponse;
        switch (type) {
            case "one":
                baseResponse = convertSingleResponse(json);
                break;
            case "list":
                baseResponse = convertListResponse(json);
                break;
            default:
                baseResponse = convertBaseResponse(json);
        }
        return baseResponse;
    }

    /**
     * GET 요청
     * @param url
     * @param parameters
     * @return
     */

    public static String requestGet(String url, @Nullable MultiValueMap<String, String> parameters) {
        return requestGet(url, parameters, restTemplate);
    }
    public static String requestGet(String url, @Nullable MultiValueMap<String, String> parameters, RestTemplate rest) {
        HttpHeaders headers = getHeaders();
        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url)
                .queryParams(Optional.ofNullable(parameters).orElse(new LinkedMultiValueMap<>()));

        HttpEntity<?> entity = new HttpEntity<>(headers);
        ResponseEntity<String> jsonStr = rest.exchange(builder.toUriString(), HttpMethod.GET, entity,
                String.class);
        String body = jsonStr.getBody();

        return body;
    }
 
    public static JsonObject requestGetJsonObject(String url, @Nullable MultiValueMap<String, String> parameters) {       
        return requestGetJsonObject(url, parameters, restTemplate);        
    }
    public static JsonObject requestGetJsonObject(String url, @Nullable MultiValueMap<String, String> parameters, RestTemplate rest) {
        String body = requestGet(url, parameters, rest);        
        JsonObject json = JsonUtil.parse(body);
        return json;        
    }

    public static ArrayList<HashMap<?, ?>> requestGetDataList(String url, @Nullable MultiValueMap<String, String> parameters) {
        return requestGetDataList(url, parameters, restTemplate);
    }
    public static ArrayList<HashMap<?, ?>> requestGetDataList(String url, @Nullable MultiValueMap<String, String> parameters, RestTemplate rest) {
        try {    
            JsonObject json = requestGetJsonObject(url, parameters);
            return extractDataList(json);
        } catch (NullPointerException e) {
            return new ArrayList<HashMap<?, ?>>();
        }
    }

    public static HashMap<?, ?> requestGetDataMap(String url, @Nullable MultiValueMap<String, String> parameters) {
        return requestGetDataMap(url, parameters, restTemplate);
    }
    public static HashMap<?, ?> requestGetDataMap(String url, @Nullable MultiValueMap<String, String> parameters, RestTemplate rest) {
        try {                        
            JsonObject json = requestGetJsonObject(url, parameters, rest);
            return extractDataMap(json);
        } catch (NullPointerException e) {
            return new HashMap<String, Object>();
        }
    }

    /**
     * POST 요청
     * @param url
     * @param headers
     * @param parameters
     * @return
     * @throws URISyntaxException
     */
    public static String requestPost(String url, @Nullable MultiValueMap<String, String> headers,
            @Nullable MultiValueMap<String, Object> parameters) throws URISyntaxException {
        return requestPost(url, headers, parameters, restTemplate);
    }
    public static String requestPost(String url, @Nullable MultiValueMap<String, String> headers,
            @Nullable MultiValueMap<String, Object> parameters, RestTemplate rest) throws URISyntaxException {
        headers = Optional.ofNullable(headers).orElse(new LinkedMultiValueMap<>());
        parameters = Optional.ofNullable(parameters).orElse(new LinkedMultiValueMap<>());        
        HttpHeaders httpHeaders = getHeaders(headers);

        URI uri = new URI(url);
        HttpEntity<MultiValueMap<String, Object> > requestEntity = new HttpEntity<>(parameters, httpHeaders);
        ResponseEntity<String> jsonStr = rest.exchange(uri, HttpMethod.POST, requestEntity, String.class);
        String body = jsonStr.getBody();


        
        // HttpHeaders headers = new HttpHeaders();
        // headers.set("Accept", MediaType.APPLICATION_JSON_VALUE);
        // UriComponentsBuilder builder = UriComponentsBuilder
        //     .fromHttpUrl(url)
        //     .queryParams(Optional.ofNullable(parameters).orElse(new LinkedMultiValueMap<>()));
        
        // HttpEntity<?> entity = new HttpEntity<>(headers);
        // ResponseEntity<String> jsonStr = restTemplate.exchange(builder.toUriString(), HttpMethod.GET, entity, String.class);
        // String body = jsonStr.getBody();

        return body;
    }

    public static JsonObject requestPostJsonObject(String url, @Nullable MultiValueMap<String, String> headers, 
            @Nullable MultiValueMap<String, Object> parameters) throws URISyntaxException {
        return requestPostJsonObject(url, headers, parameters, restTemplate);
    }
    public static JsonObject requestPostJsonObject(String url, @Nullable MultiValueMap<String, String> headers, 
            @Nullable MultiValueMap<String, Object> parameters, RestTemplate rest) throws URISyntaxException {
        String body = requestPost(url, headers, parameters, rest);
        JsonObject json = JsonUtil.parse(body);
        return json;
    }

    public static ArrayList<HashMap<?, ?>> requestPostDataList(String url, @Nullable MultiValueMap<String, String> headers, 
            @Nullable MultiValueMap<String, Object> parameters) throws URISyntaxException {
        return requestPostDataList(url, headers, parameters, restTemplate);
    }
    public static ArrayList<HashMap<?, ?>> requestPostDataList(String url, @Nullable MultiValueMap<String, String> headers, 
            @Nullable MultiValueMap<String, Object> parameters, RestTemplate rest) throws URISyntaxException {
        try {                        
            JsonObject json = requestPostJsonObject(url, headers, parameters, rest);
            return extractDataList(json);            
        } catch (NullPointerException e) {
            return new ArrayList<HashMap<?, ?>>();
        }
    }

    public static HashMap<?, ?> requestPostDataMap(String url, @Nullable MultiValueMap<String, String> headers,
            @Nullable MultiValueMap<String, Object> parameters) throws URISyntaxException {
        return requestPostDataMap(url, headers, parameters, restTemplate);
    }
    public static HashMap<?, ?> requestPostDataMap(String url, @Nullable MultiValueMap<String, String> headers,
            @Nullable MultiValueMap<String, Object> parameters, RestTemplate rest) throws URISyntaxException {
        try {
            JsonObject json = requestPostJsonObject(url, headers, parameters, rest);
            return extractDataMap(json);            
        } catch (NullPointerException e) {
            return new HashMap<String, Object>();
        }
    }

    // public static JsonObject requestHttps(String method, String strUrl, String parameter) {
    //     JsonObject json = null;
    //     try {

    //         HttpsURLConnection.setDefaultSSLSocketFactory(SSLUtil.getSocketFactory());
    //         HttpsURLConnection.setDefaultHostnameVerifier(SSLUtil.getHostnameVerifier());

    //         URL url = new URL(strUrl);
    //         HttpsURLConnection connection = (HttpsURLConnection)url.openConnection();
    //         connection.setRequestProperty("Content-Type", "application/json; utf-8");
    //         connection.setRequestProperty("Accept", "application/json");
    //         // connection.setRequestProperty("tran_id", "618b3293-2b57-4936-94fc-8119a41ad039");
    //         connection.setRequestMethod(method);
    //         connection.setDoOutput(true);

    //         DataOutputStream out = new DataOutputStream(connection.getOutputStream());
    //         out.write(parameter.getBytes("UTF-8"));
    //         out.flush();
    //         out.close();

    //         BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
    //         StringBuilder sb = new StringBuilder();
    //         String line = null;
    //         while ((line = bufferedReader.readLine()) != null) {
    //             sb.append(line);
    //             sb.append("\n");
    //         }
    //         bufferedReader.close();

    //         json = JsonUtil.parse(sb.toString());
    //         System.out.println(url + ": " + json);
    //     } catch (IOException e) {
    //         if (e.getMessage() != null && e.getMessage().indexOf("refused") == -1) {
    //             System.out.println("fetchData error:" + e);
    //         }

    //         json = new JsonObject();
    //         //json.addProperty("error", e.toString());
    //     } catch (Exception e) {
    //         json = new JsonObject();
    //         //json.addProperty("error", e.toString());
    //     }

    //     return json;
    // }

    /** HttpURLConnection GET 방식 */
	public static String getRequest(String targetUrl) {
		String response = "";
		try {
			URL url = new URL(targetUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET"); // 전송 방식
			conn.setRequestProperty("Content-Type", "application/json; charset=utf-8");
			conn.setConnectTimeout(5000); // 연결 타임아웃 설정(5초) 
			conn.setReadTimeout(5000); // 읽기 타임아웃 설정(5초)
			conn.setDoOutput(true);
			
	        System.out.println("getContentType():" + conn.getContentType()); // 응답 콘텐츠 유형 구하기
	        System.out.println("getResponseCode():"    + conn.getResponseCode()); // 응답 코드 구하기
	        System.out.println("getResponseMessage():" + conn.getResponseMessage()); // 응답 메시지 구하기

			Charset charset = Charset.forName("UTF-8");
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), charset));
			
			String inputLine;			
			StringBuffer sb = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				sb.append(inputLine);
			}
			br.close();
			
			response = sb.toString();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return response;
	}
	
	/** HttpURLConnection POST 방식 */
	public static String postRequest(String targetUrl, Map<String, Object> requestMap) {
		String response = "";
		try {
			URL url = new URL(targetUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST"); // 전송 방식
			conn.setRequestProperty("Content-Type", "application/json; charset=utf-8");
			conn.setConnectTimeout(5000); // 연결 타임아웃 설정(5초) 
			conn.setReadTimeout(5000); // 읽기 타임아웃 설정(5초)
			conn.setDoOutput(true);	// URL 연결을 출력용으로 사용(true)
			
			String requestBody = getJsonStringFromMap(requestMap);
			System.out.println("requestBody:" + requestBody);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			bw.write(requestBody);
			bw.flush();
			bw.close();

			System.out.println("getContentType():" + conn.getContentType()); // 응답 콘텐츠 유형 구하기
	        System.out.println("getResponseCode():"    + conn.getResponseCode()); // 응답 코드 구하기
	        System.out.println("getResponseMessage():" + conn.getResponseMessage()); // 응답 메시지 구하기

			Charset charset = Charset.forName("UTF-8");
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), charset));
			
			String inputLine;			
			StringBuffer sb = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				sb.append(inputLine);
			}
			br.close();
			
			response = sb.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return response;
	}
	
	/** Map을 jsonString으로 변환 */
	public static String getJsonStringFromMap(Map<String, Object> map)  throws JsonProcessingException{
		return new ObjectMapper().writeValueAsString(map);
	}

}
