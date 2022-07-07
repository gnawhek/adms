package com.dma.domain.common.controller;

import com.dma.advice.exception.CMybatisException;
import com.dma.advice.exception.CServiceIncorrectUse;
import com.dma.advice.exception.CServiceNotImplement;
import com.dma.domain.common.dto.AppDto;
import com.dma.property.GlobalConstants;
import com.dma.security.AuthUserService;
import com.dma.service.ResponseService;
import com.dma.share.ResultMap;
import com.dma.share.response.ResultResponse;
import com.dma.share.response.SingleResponse;
import com.dma.utils.CommonUtil;
import com.dma.utils.EncryptUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.*;

@Slf4j
public abstract class BaseDataController extends BaseController {

    @Autowired
    protected AuthUserService authUserService;

    @Autowired
    protected ResponseService responseService; // 결과를 처리할 Service

    @Autowired
    protected HttpServletRequest request;

    @Autowired
    protected AppDto appDto;

    protected List<Object> getServices() {
        return new ArrayList<Object>() {{
            add(getService());
        }};
    }

    protected List<Object> getMappers() {
        return new ArrayList<Object>() {{
            add(getMapper());
        }};
    }

    protected abstract Object getService();

    protected abstract Object getMapper();

    public Object doRequest(String action, HashMap<String, Object> param, boolean isIncludeResult) throws Exception {
        Boolean encrypt = (Boolean) param.get(GlobalConstants.Common.ENCRYPT);
        HashMap<String, Object> data = paramToData(param, encrypt);

        // SecurityContext에서 인증받은 회원의 정보를 얻어온다.
        //String lang = request.getHeader(HttpHeaders.ACCEPT_LANGUAGE);
        String lang = request.getHeader(GlobalConstants.Common.N_LANG);
        data.put(GlobalConstants.Common.N_LANG, lang != null ? lang : Locale.KOREAN.getLanguage());
        data.put(GlobalConstants.Common.LOGIN_I_ID, authUserService.getUserUid());
        data.put(GlobalConstants.Common.LOGIN_C_SHOP, authUserService.getUser().getC_SHOP());
        data.put(GlobalConstants.Common.LOGIN_C_LEVEL, authUserService.getUser().getC_LEVEL());

        if (appDto.isDevProfile()) {
            log.debug(CommonUtil.mapToString(data));
        }

        Object result = serviceMehthod(action, data, isIncludeResult);

        if (result == null) {
            String ACTION = action.toUpperCase();
            if (ACTION.startsWith("SELECT") && ACTION.endsWith("LIST")) {
                result = selectList(null, action, data, isIncludeResult);
            } else if (ACTION.startsWith("SELECT")) {
                result = selectOne(null, action, data, isIncludeResult);
            } else if (ACTION.startsWith("UPDATE")) {
                result = modify(null, action, data);
            } else if (ACTION.startsWith("INSERT")) {
                result = modify(null, action, data);
            } else if (ACTION.startsWith("DELETE")) {
                result = modify(null, action, data);
            }
        }

        return toResult(result, encrypt);
    }

    private Object toResult(Object result, Boolean encrypt) throws Exception {
        if (result != null) {
            if (result instanceof ResultResponse) {
                if (encrypt != null && encrypt) {
                    Gson gson = new Gson();
                    String json = gson.toJson(((ResultResponse<?>) result).getResult());
                    String encryptText = EncryptUtil.encrypt(json);
                    SingleResponse<String> encryptResult = new SingleResponse<String>();
                    encryptResult.setResult(encryptText);
                    encryptResult.encrypt = true;
                    return encryptResult;
                }
            }
            return result;
        }

        throw new Exception("잘못된 접근 입니다.");
    }

    @SuppressWarnings("unchecked")
    private HashMap<String, Object> paramToData(HashMap<String, Object> param, Boolean encrypt) {
        HashMap<String, Object> data = null;
        if (encrypt != null) {
            if (encrypt) {
                String endata = (String) param.get(GlobalConstants.Common.DATA);
                data = EncryptUtil.decrypt(endata);
            } else {
                data = (HashMap<String, Object>) param.get(GlobalConstants.Common.DATA);
            }
        } else {
            data = param;
        }

        if (data == null) {
            data = new HashMap<String, Object>();
        }

        Iterator<String> keys = request.getParameterMap().keySet().iterator();
        while (keys.hasNext()) {
            String key = keys.next();
            Object value = request.getParameter(key);
            data.put(key, value);
        }

        return data;
    }

    @SuppressWarnings("unchecked")
    public Object selectList(String command, String sqlId, HashMap<String, Object> param, boolean isIncludeResult) throws Exception {

        if (sqlId == null /* || !sqlId.endsWith("List") */) {
            throw new CServiceIncorrectUse(CommonUtil.format("sqlId={}", sqlId));
        }
        param.put("command", command);
        param.put("sqlId", sqlId);

        try {
            long total = -1;
            List<ResultMap> list = (List<ResultMap>) runMehthod(sqlId, param);
            Integer page = (Integer) param.get("page");
            if (page != null) {
                param.put("TOTAL_COUNT", true);
                List<ResultMap> totalList = (List<ResultMap>) runMehthod(sqlId, param);
                total = totalList == null ? 0 : (long) totalList.get(0).get("count");
            }
            if (list == null) {
                list = new ArrayList<ResultMap>();
            }
            return isIncludeResult ? responseService.createListResponse(list, Math.max(total, list.size())) : list;
        } catch (InvocationTargetException e) {
            String message = CommonUtil.format("selectList-exception={}, sqlId={}, param={}, target={}", e.getTargetException().getMessage(), sqlId, param.toString(), e.getTargetException().getMessage());
            log.error(message);
            throw new CMybatisException(message, e);
        } catch (Exception e) {
            String message = CommonUtil.format("selectList-exception={}, sqlId={}, param={}", e.toString(), sqlId, param.toString());
            log.error(message);
            throw new CServiceIncorrectUse(e.getMessage(), e);
        }
    }

    public Object selectOne(String command, String sqlId, HashMap<String, Object> param, boolean isIncludeResult) throws Exception {

        if (sqlId == null /* || sqlId.endsWith("List") */) {
            throw new CServiceIncorrectUse(CommonUtil.format("sqlId={}", sqlId));
        }
        param.put("command", command);
        param.put("sqlId", sqlId);

        try {
            Object result = runMehthod(sqlId, param);
            return isIncludeResult ? responseService.createSingleResponse(result) : result;
        } catch (InvocationTargetException e) {
            String message = CommonUtil.format("selectOne-exception={}, sqlId={}, param={}, target={}", e.getTargetException().getMessage(), sqlId, param.toString(), e.getTargetException().getMessage());
            log.error(message);
            throw new CMybatisException(message, e);
        } catch (Exception e) {
            String message = CommonUtil.format("selectOne-exception={}, sqlId={}, param={}", e.toString(), sqlId, param.toString());
            log.error(message);
            throw new CServiceIncorrectUse(e.getMessage(), e);
        }
    }

    //public ResultResponse<?> modify(String command, String sqlId, HashMap<String, Object> param) throws Exception {
    public Object modify(String command, String sqlId, HashMap<String, Object> param) throws Exception {
        if (sqlId == null || sqlId.matches("^(insert|delete|update|upsert)")) {
            throw new CServiceIncorrectUse(CommonUtil.format("sqlId={}", sqlId));
        }
        param.put("command", command);
        param.put("sqlId", sqlId);

        try {
            Boolean commit = (Boolean) param.getOrDefault("commit", true);
            if (commit) {
                return runMehthod(sqlId, param);
            }
            return 1;
            //return responseService.createSuccessResponse();
        } catch (InvocationTargetException e) {
            String message = CommonUtil.format("modify-exception={}, sqlId={}, param={}, target={}", e.getTargetException().getMessage(), sqlId, param.toString(), e.getTargetException().getMessage());
            log.error(message);
            throw new CMybatisException(message, e);
        } catch (Exception e) {
            String message = CommonUtil.format("modify-exception={}, sqlId={}, param={}", e.toString(), sqlId, param.toString());
            log.error(message);
            throw new CServiceIncorrectUse(e.getMessage(), e);
        }
    }

    Object runMehthod(String sqlId, HashMap<String, Object> param) throws Exception {
        int count = getMappers().size();
        Exception ex = null;
        for (Object mapper : getMappers()) {
            try {
                Method thisMethod = mapper.getClass().getDeclaredMethod(sqlId, new Class[]{HashMap.class});
                Object result = thisMethod.invoke(mapper, new Object[]{param});
                count--;
                if (result != null) {
                    return result;
                }
            } catch (NoSuchMethodException | SecurityException e) {
                ex = new CServiceNotImplement(e.getMessage(), e);
            } catch (Exception e) {
                ex = new CServiceIncorrectUse(e.getMessage(), e);
            }
        }

        if (count == 0 && ex != null) {
            log.error("run-exception={}: sqlId={}, param={}", ex.toString(), sqlId, param.toString());
            throw ex;
        }
        return null;
    }

    private Method findMehthod(Class<?> clazz, String sqlId) throws Exception {
        Method thisMethod = null;
        if (clazz != null) {
            try {
                thisMethod = clazz.getDeclaredMethod(sqlId, new Class[]{HashMap.class});
            } catch (NoSuchMethodException | SecurityException e) {
                thisMethod = findMehthod(clazz.getSuperclass(), sqlId);
            }
        }
        return thisMethod;
    }

    Object serviceMehthod(String sqlId, HashMap<String, Object> param, boolean isIncludeResult) {
        try {
            for (Object service : getServices()) {
                Method thisMethod = findMehthod(service.getClass(), sqlId);
                if (thisMethod != null) {
                    Object result = thisMethod.invoke(service, new Object[]{param});
                    if (!isIncludeResult) {
                        return result;
                    } else if (result instanceof List) {
                        return responseService.createListResponse((List<?>) result);
                    } else if (result instanceof ResultMap) {
                        return responseService.createSingleResponse((ResultMap) result);
                    } else if (result != null) {
                        return responseService.createResultResponse(result);
                    }
                }
            }
        } catch (Exception e) {
            log.warn("service-exception={}: sqlId={}", e.toString(), sqlId);
        }
        return null;
    }
}
