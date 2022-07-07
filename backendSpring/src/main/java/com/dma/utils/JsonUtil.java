package com.dma.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.dma.share.Data;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import lombok.extern.slf4j.Slf4j;

/**
 * JsonUtil
 */
@Slf4j
public class JsonUtil {

    private JsonUtil() {}

    private static Gson gson = new Gson();

    public static String toJsonString(Object object) {
        return gson.toJson(object);
    }

    public static JsonObject parse(String json) {        
        JsonObject jsonObject = gson.fromJson(json, JsonObject.class);    
        return jsonObject;        
    }

    /* 
        해당 클래스나 맴버에 아래 어노테이션을 붙이면 json covert 시 제외 된다. 
        @JsonIgnoreProperties(ignoreUnknown = true) 
        @JsonIgnore 
    */
    private static ObjectMapper objectMapper = new ObjectMapper()
        .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
        .registerModule(new JavaTimeModule())
        .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
        ;
    
    /*
     * Map map = Utils.convertJsonToClass(json, Map.class)
     */
    public static <T> T convertJsonToClass(String json, Class<T> valueType)
            throws IOException, JsonParseException, JsonMappingException {
        return objectMapper.readValue(json, valueType);
    }

    public static <T> T convertJsonToObject(String json, T obj)
            throws IOException, JsonParseException, JsonMappingException {
        return objectMapper.readValue(json, new TypeReference<T>() {});
    }

    public static <T> List<T> convertJsonToListClass(String json, Class<T> valueType)
            throws IOException, JsonParseException, JsonMappingException {
        List<T> list = Arrays.asList(objectMapper.readValue(json, valueType));
        return list;
    }

    public static <T> List<T> convertJsonToListClass2(String json, Class<T> valueType)
            throws IOException, JsonParseException, JsonMappingException {
        List<T> list = objectMapper.readValue(json, objectMapper.getTypeFactory().constructCollectionType(List.class, valueType));
        return list;
    }

    public static JsonObject convertJsonToJsonObject(String json) {
        JsonObject jsonObject = gson.fromJson(json, JsonObject.class);
        return jsonObject;        
    }
    public static JsonArray convertJsonToJsonArray(String json) {
        JsonArray jsonArray = gson.fromJson(json, JsonArray.class);
        return jsonArray;        
    }

    // 테스트 안됨
    // public static <T> T convertMapToObject(HashMap<String, Object> map, Class<T> valueType)  {
    //     return objectMapper.convertValue(map, valueType);
    // }

    public static HashMap<String, Object> convertObjectToMap(Object object)  {
        HashMap<String, Object> map = objectMapper.convertValue(object, new TypeReference<HashMap<String, Object>>() {});
        return map;
    }
    public static MultiValueMap<String, String> convertObjectToMultiValueMap(Object object) 
            throws IOException, JsonParseException, JsonMappingException {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        Map<String, String> map = objectMapper.convertValue(object, new TypeReference<Map<String, String>>() {});
        params.setAll(map);
        return params;
    }
    public static MultiValueMap<String, String> convertMapToMultiValueMap(HashMap<String, String> map) 
            throws IOException, JsonParseException, JsonMappingException {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();        
        params.setAll(map);
        return params;
    }
    
    public static String convertClassToJsonString(Object object) throws JsonProcessingException {
        return objectMapper.writeValueAsString(object);
    }

    public static String convertClassToJsonStringPretty(Object object) throws JsonProcessingException {
        String json = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(object);
        return json;
    }

    public static byte[] convertClassToJsonBytes(Object object) throws JsonProcessingException {
        return objectMapper.writeValueAsBytes(object);
    }    

    public static JSONObject toJson(Data map) {
        return toJson(map.getMap());
    }

    public static JSONObject toJson(Map<String, Object> map) {
        JSONObject jsonObject = new JSONObject();

        for (String key : map.keySet()) {
            try {
                Object obj = map.get(key);
                if (obj instanceof Data) {
                    jsonObject.put(key, toJson(((Data) obj)));
                } else if (obj instanceof Map) {
                    jsonObject.put(key, toJson((Map) obj));
                } else if (obj instanceof List) {
                    jsonObject.put(key, toJson((List) obj));
                } else if (obj instanceof Date) {
                    jsonObject.put(key, new SimpleDateFormat("yyyy-MM-dd HH:ss:mm").format(((Date) obj)));
                /* } else if (obj instanceof org.postgresql.util.PGobject) {
                    String jsonString = value.toString();
                    if(jsonString.startsWith("[")){
                        JSONArray jsonObject = new JSONArray(jsonString);
                        jsonObject.put(key, jsonObject);
                    } else {
                        JSONObject jsonObject = new JSONObject(jsonString);
                        jsonObject.put(key, jsonObject);
                    } */
                } else if (obj instanceof BigDecimal) {
                    jsonObject.put(key, ((BigDecimal)obj).floatValue());
                } else {
                    jsonObject.put(key, map.get(key));
                }
            } catch (JSONException jsone) {
                log.error("RequestManager", "Failed to put value for " + key + " into JSONObject.", jsone);
            }
        }

        return jsonObject;
    }

    public static JSONArray toJson(List<?> list) {
        JSONArray jsonArray = new JSONArray();

        for (Object obj : list) {
            if (obj instanceof Map) {
                jsonArray.put(toJson((Map) obj));
            } else if (obj instanceof List) {
                jsonArray.put(toJson((List<?>) obj));
            } else {
                jsonArray.put(obj);
            }
        }

        return jsonArray;
    }
    public static Map<String, Object> fromJson(JsonObject jsonObject) {
        Map<String, Object> map = new HashMap<String, Object>();

        Iterator<String> keyIterator = jsonObject.keySet().iterator();
        while (keyIterator.hasNext()) {
            String key = keyIterator.next();
            try {
                Object obj = jsonObject.get(key);
                if (obj instanceof JsonObject) {
                    map.put(key, fromJson((JsonObject) obj));
                } else if (obj instanceof JsonArray) {
                    map.put(key, fromJson((JsonArray) obj));
                } else {
                    map.put(key, obj);
                }
            } catch (Exception jsone) {
                log.error("fromJson Failed to get value for from JsonObject: {}", jsone);
            }
        }

        return map;
    }


    public static Map<String, Object> fromJson(JSONObject jsonObject) {
        Map<String, Object> map = new HashMap<String, Object>();

        Iterator<String> keyIterator = jsonObject.keys();
        while (keyIterator.hasNext()) {
            String key = keyIterator.next();
            try {
                Object obj = jsonObject.get(key);

                if (obj instanceof JSONObject) {
                    map.put(key, fromJson((JSONObject) obj));
                } else if (obj instanceof JSONArray) {
                    map.put(key, fromJson((JSONArray) obj));
                } else {
                    map.put(key, obj);
                }
            } catch (JSONException jsone) {
                log.error("fromJson Failed to get value for from JSONObject: {}", jsone);
            }
        }

        return map;
    }

    // 검증필요
    public static List<Object> fromJson(JsonArray jsonArray) {
        return fromJson(toJsonArray(jsonArray));
    }

    public static List<Object> fromJson(JSONArray jsonArray) {
        List<Object> list = new ArrayList<Object>();
        for (int i = 0; i < jsonArray.length(); i++) {
            try {
                Object obj = jsonArray.get(i);

                if (obj instanceof JSONObject) {
                    list.add(fromJson((JSONObject) obj));
                } else if (obj instanceof JSONArray) {
                    list.add(fromJson((JSONArray) obj));
                } else {
                    list.add(obj);
                }
            } catch (JSONException jsone) {
                log.error("RequestManager", "Failed to get value at index " + i + " from JSONArray.", jsone);
            }
        }
        return list;
    }

    public static JSONObject toJsonObject(JsonObject jsonObject) {
        return new JSONObject(jsonObject.toString());
    }

    public static JsonObject toJsonObject(JSONObject jsonObject) {
        JsonParser jsonParser = new JsonParser();
        return (JsonObject) jsonParser.parse(jsonObject.toString());
    }

    // 검증필요
    public static JSONArray toJsonArray(JsonArray jsonArray) {
        return new JSONArray(jsonArray.toString());
    }

    // 검증필요
    public static JsonArray toJsonArray(JSONArray jsonObject) {
        JsonParser jsonParser = new JsonParser();
        return (JsonArray) jsonParser.parse(jsonObject.toString());
    }

    // 삭제예정
    public static List<Map<String, Object>> readJsonFileToList(String path) throws JsonParseException, JsonMappingException, IOException {
        File file = new File(path);
        List<Map<String, Object>> list = objectMapper.readValue(file, new TypeReference<List<Map<String, Object>>>(){});
        return list;
    }

    // 삭제예정
    public static void writeJsonFile(List<HashMap<?, ?>> array, String path) throws JsonGenerationException, JsonMappingException, IOException {
        File file = new File(path);
        objectMapper.writerWithDefaultPrettyPrinter().writeValue(file, array);
    }

    public static Object readJsonFile(String path) throws FileNotFoundException, UnsupportedEncodingException {
        File file = new File(path);
        // FileReader reader = new FileReader(file);    // 한글 깨짐 때문에 아래와 같이 InputStreamReader 를 사용.
        InputStreamReader reader = new InputStreamReader(new FileInputStream(file), "UTF8");

        JsonParser jsonParser = new JsonParser();
        Object obj = jsonParser.parse(reader);

        // log.info("type={}, value={}", obj.getClass().getName(), obj.toString());
        return obj;
    }

    public static void writeJsonFile(Object json, String path) throws IOException {
        FileWriter file = new FileWriter(path);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String string = gson.toJson(json);
        file.write(string);
        file.flush();
        file.close();
    }
   
}
