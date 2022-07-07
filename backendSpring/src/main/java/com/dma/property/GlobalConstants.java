package com.dma.property;

public class GlobalConstants {

    // mybatis 결과 resultMap 에서 키를 camelcase 로 변경 여부 (CREATE_TIME > createTime)
    // public static final Boolean CONVERT_CAMELCASE_KEY = false;

    public static class CustomCacheKey {

        public static final int DEFAULT_EXPIRE_SEC = 60; // 1 minutes

        public static final String USER = "user";
        public static final int USER_EXPIRE_SEC = 60 * 5; // 5 minutes
    }

    public static class KEY {
        public static final String RSA_KEY = "RsaKey";
        public static final String AES_KEY = "dma";
    }

    public static class Common {
        public static final String DATA = "data";
        public static final String N_LANG = "N_LANG";
        public static final String ENCRYPT = "encrypt";
        public static final String I_ID = "I_ID";
        public static final String LOGIN_I_ID = "LOGIN_I_ID";
        public static final String LOGIN_C_SHOP = "LOGIN_C_SHOP";
        public static final String LOGIN_C_LEVEL = "LOGIN_C_LEVEL";
    }
}
