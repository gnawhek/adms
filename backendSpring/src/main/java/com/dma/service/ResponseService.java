package com.dma.service;

import java.util.List;
import java.util.Map;

import com.dma.share.Data;
import com.dma.share.response.ErrorResponse;
import com.dma.share.response.ListResponse;
import com.dma.share.response.ResultResponse;
import com.dma.share.response.SingleResponse;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ResponseService {

    // enum으로 api 요청 결과에 대한 code, message를 정의합니다.
    public enum CommonResponse {
        SUCCESS(20000, "성공하였습니다.");

        int code;
        String message;

        CommonResponse(int code, String message) {
            this.code = code;
            this.message = message;
        }

        public int getCode() {
            return code;
        }

        public String getMessage() {
            return message;
        }
    }

    public <T> ResultResponse<T> createResultResponse(T data) {
        ResultResponse<T> response = new ResultResponse<>();
        response.setResult(data);
        setSuccessResponse(response);
        return response;
    }


    // 단일건 결과를 처리하는 메소드
    public <T> SingleResponse<T> createSingleResponse(T data) {
        SingleResponse<T> response = new SingleResponse<>();
        response.setResult(data);
        setSuccessResponse(response);
        return response;
    }

    public SingleResponse<Map<String, Object>> createSingleDataResponse(Data data) {
        return createSingleResponse(data.getMap());
    }

    // 다중건 결과를 처리하는 메소드
    public <T> ListResponse<T> createListResponse(List<T> list) {
        return createListResponse(list, list.size());
    }

    public <T> ListResponse<T> createListResponse(List<T> list, long total) {
        ListResponse<T> response = new ListResponse<T>();
        response.setResult(list);
        // response.getResult().setItems(list);
        // response.getResult().setTotal(Math.toIntExact(total));
        setSuccessResponse(response);
        return response;
    }

    // 성공 결과만 처리하는 메소드
    public ResultResponse<Boolean> createSuccessResponse() {
        ResultResponse<Boolean> response = new ResultResponse<Boolean>();
        response.setResult(true);
        setSuccessResponse(response);
        return response;
    }

    public ResultResponse<Boolean> createFailResponse() {
        return createFailResponse(-999, "알 수 없는 오류가 발생하였습니다.", null);
    }

    // 실패 결과만 처리하는 메소드
    public ResultResponse<Boolean> createFailResponse(int code, String message) {
        return createFailResponse(code, message, null);
    }

    // 실패 결과만 처리하는 메소드
    public ResultResponse<Boolean> createFailResponse(int code, String message, String detailMessage) {
        ErrorResponse response = new ErrorResponse();
        // response.setCode(code);
        response.setMessage(message);
        response.setDetailMessage(detailMessage);
        return response;
    }

    // 결과 모델에 api 요청 성공 데이터를 세팅해주는 메소드
    private void setSuccessResponse(ResultResponse<?> response) {
        // response.setCode(CommonResponse.SUCCESS.getCode());
    }
}
