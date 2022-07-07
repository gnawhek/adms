package com.dma.share.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ResultResponse<T> extends BaseResponse {
    private T result;

    public ResultResponse() {
    }
}
