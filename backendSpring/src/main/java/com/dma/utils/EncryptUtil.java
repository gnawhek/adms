package com.dma.utils;

import com.dma.utils.cipher.tea.TEA;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;

import java.util.HashMap;

@Slf4j
public class EncryptUtil {

    private EncryptUtil() {
    }

    public static String encrypt(String value) {
        String uuid = TEA.generateUUID();
        TEA tea = new TEA(uuid);
        return uuid + tea.encrypt(value);
    }

    public static String decryptText(String keyEncData) {
        String teaKey = keyEncData.substring(0, 16);
        String encryptValue = keyEncData.substring(16, keyEncData.length());
        TEA tea = new TEA(teaKey);
        return tea.decrypt(encryptValue);
    }

    public static HashMap<String, Object> decrypt(String keyEncData) {
        String value = decryptText(keyEncData);
        JSONObject json = new JSONObject(value);
        return (HashMap<String, Object>) json.toMap();
    }
}
