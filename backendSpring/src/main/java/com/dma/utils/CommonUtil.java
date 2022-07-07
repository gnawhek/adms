package com.dma.utils;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.exception.ExceptionUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CommonUtil {

    private CommonUtil() {}

    public static String format(String s, Object... var2) {
        int i = 0;
        while(s.contains("{}")) {
            s = s.replaceFirst(Pattern.quote("{}"), "{"+ i++ +"}");
        }
        return MessageFormat.format(s, var2);
    }

    public static boolean isCheckKr(String s) {
        boolean isKr = false;
        try {
            isKr = s.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isKr;
    }

    public static boolean isCheckDigits(String s) {
        boolean isKr = false;
        try {
            isKr = s.matches(".*\\d.*");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isKr;
    }

    public static int getOnlyDigits(String s) {
        Pattern pattern;
        Matcher matcher;
        int number = 0;
        try {
            if (s != null) {
                pattern = Pattern.compile("[^0-9]");
                matcher = pattern.matcher(s);
                number = Integer.parseInt(matcher.replaceAll(""));
            }
        } catch (Exception e) {
            return 0;
        }
        return number;
    }

    public static String getOnlyStrings(String s) {
        Pattern pattern;
        Matcher matcher;
        String number = null;
        try {
            if (s != null) {
                pattern = Pattern.compile("[^a-z A-Z]");
                matcher = pattern.matcher(s);
                number = matcher.replaceAll("");
            }
        } catch (Exception e) {
            return null;
        }
        return number;
    }

    public static String toString(Object obj) {
        return toString(obj, "");
    }

    public static String toString(Object obj, String defaultValue) {
        return Optional.ofNullable(obj.toString()).orElse(defaultValue);
    }

    public static String lTrim(String str) {
        String result = null;
        try {
            result = str.replaceAll("^\\s+", "");
        } catch (Exception e) {
            log.error(">>>>>>>>>>[CommonUtil] ltrim(" + str + ") error : " + ExceptionUtils.getStackTrace(e)
                    + " <<<<<<<<<<<<<<<<<");
        }
        return result;
    }

    public static String rTrim(String str) {
        return rTrim(str, "\\s+$");
    }

    public static String rTrim(String str, String exp) {
        String result = null;
        try {
            result = str.replaceAll(exp, "");
        } catch (Exception e) {
            log.error(">>>>>>>>>>[CommonUtil] rTrim(" + str + ") error : " + ExceptionUtils.getStackTrace(e)
                    + " <<<<<<<<<<<<<<<<<");
        }
        return result;
    }

    // public static String snakeToCamel(String str) {
    //     return JdbcUtils.convertUnderscoreNameToPropertyName(str);
    // }

    public static String camelToSnake(String str) {
        // Regular Expression
        String regex = "([a-z])([A-Z]+)";

        // Replacement string
        String replacement = "$1_$2";

        // Replace the given regex
        // with replacement string
        // and convert it to lower case.
        str = str.replaceAll(regex, replacement).toLowerCase();

        // return string
        return str;
    }

    public static String mapToString(HashMap<String, Object> dataMap) {
        StringBuilder message = new StringBuilder("\n\n");
        for (String key : dataMap.keySet()) {
            Object value = dataMap.get(key);
            message.append(key).append(": ").append(value).append("\n");
        }
        return message.toString();
    }
}
