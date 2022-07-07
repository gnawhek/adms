package com.dma.share.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SingleResponse<T> extends ResultResponse<T> {
    public SingleResponse() {
    }
}
