package com.dma.domain.common.service;


import com.dma.domain.common.mapper.MainMapper;
import com.dma.domain.user.dto.User;
import com.dma.domain.user.mapper.UserMapper;
import com.dma.property.GlobalConstants;
import com.dma.security.JwtTokenProvider;
import com.dma.service.ResponseService;
import com.dma.share.ResultMap;
import com.dma.utils.EncryptUtil;
import com.dma.utils.ImageUtil;
import com.dma.utils.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class MainService extends BaseDataService {
    @Autowired
    protected UserMapper userMapper;
    @Autowired
    protected MainMapper mainMapper;
    @Autowired
    protected JwtTokenProvider jwtTokenProvider;
    @Autowired
    protected ResponseService responseService;
    @Autowired
    protected PasswordEncoder passwordEncoder;

    public Object SELECT_LOGINDATA(HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> param = new HashMap<String, Object>() {{
            put("I_ID", map.get("id"));
        }};
        User user = userMapper.SELECT_LOGIN(param);
        String token = jwtTokenProvider.createToken(String.valueOf(user.getI_ID()), user.getRolesList(), null);

        // User 정보와 토큰 정보를 반환
        HashMap<String, Object> mapUser = JsonUtil.convertObjectToMap(user);
        ResultMap data = new ResultMap();
        data.put("data", mapUser);
        data.put("accessToken", token);

        ArrayList<ResultMap> list = new ArrayList<>();
        list.add(data);

        return list;
    }

    public ResultMap SELECT_LOGIN_ID(HashMap<String, Object> map) {
        return mainMapper.SELECT_LOGIN_ID(map);
    }

//    public ResultResponse USER_NEW_PW(HashMap<String, Object> map) {
//        String endata = (String) map.get(GlobalConstants.Common.DATA);
//        HashMap data = EncryptUtil.decrypt(endata);
//        int result = mainMapper.USER_NEW_PW(data);
//        if(result == -1) {
//            return responseService.createFailResponse();
//        }
//        return responseService.createSuccessResponse();
//    }

    public int USER_NEW_PW(HashMap<String, Object> map) {
        String endata = (String) map.get(GlobalConstants.Common.DATA);
        HashMap<String, Object> data = EncryptUtil.decrypt(endata);
        data.put("password", passwordEncoder.encode((String) data.get("password")));
        return mainMapper.USER_NEW_PW(data);
    }

    public boolean NewMemberRegister(HashMap<String, Object> map) {
        String endata = (String) map.get(GlobalConstants.Common.DATA);
        HashMap<String, Object> data = EncryptUtil.decrypt(endata);
        data.put("password", passwordEncoder.encode((String) data.get("password")));

        //프로파일 사진
        byte[] bytes = ImageUtil.imageBase64ToBytes(data.get("PROFILE"));
        if (bytes != null) {
            data.put("S_PIC_URL", "https://www.hindipro.com/wp-content/uploads/2020/12/caption-for-profile.jpg");
//            ImageUtil.saveImage("F:\\test\\test2.jpg", bytes);
        }

        int result = mainMapper.NewMemberRegister(data);
        return result != -1;
    }
}
