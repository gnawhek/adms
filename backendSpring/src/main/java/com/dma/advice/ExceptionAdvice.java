package com.dma.advice;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.dma.advice.exception.CAuthenticationEntryPointException;
import com.dma.advice.exception.CCommunicationException;
import com.dma.advice.exception.CForbiddenWordException;
import com.dma.advice.exception.CHttpRelayServiceFail;
import com.dma.advice.exception.CMybatisException;
import com.dma.advice.exception.CNotOwnerException;
import com.dma.advice.exception.CResourceNotExistException;
import com.dma.advice.exception.CServiceIncorrectUse;
import com.dma.advice.exception.CServiceNotImplement;
import com.dma.advice.exception.CSigninFailedException;
import com.dma.advice.exception.CUnknowException;
import com.dma.advice.exception.CUserExistException;
import com.dma.advice.exception.CUserNotFoundException;
import com.dma.service.ResponseService;
import com.dma.share.response.BaseResponse;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestControllerAdvice
public class ExceptionAdvice {

    private final ResponseService responseService;

    private final MessageSource messageSource;

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    protected BaseResponse defaultException(HttpServletRequest request, Exception e) {
        // 예외 처리의 메시지를 MessageSource에서 가져오도록 수정
        return responseService.createFailResponse(Integer.valueOf(getMessage("unKnown.code")), getMessage("unKnown.message"), e.getMessage());
    }

    @ExceptionHandler(CUnknowException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public BaseResponse unknowException(HttpServletRequest request, CUnknowException e) {
        return responseService.createFailResponse(Integer.valueOf(getMessage("unKnown.code")), getMessage("unKnown.message"), e.getMessage());
    }

    @ExceptionHandler(CUserNotFoundException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    protected BaseResponse userNotFound(HttpServletRequest request, CUserNotFoundException e) {
        return responseService.createFailResponse(Integer.valueOf(getMessage("userNotFound.code")), getMessage("userNotFound.message"), e.getMessage());
    }

    @ExceptionHandler(CSigninFailedException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    protected BaseResponse emailSigninFailed(HttpServletRequest request, CSigninFailedException e) {
        return responseService.createFailResponse(Integer.valueOf(getMessage("emailSigninFailed.code")), getMessage("emailSigninFailed.message"), e.getMessage());
    }

    @ExceptionHandler(CAuthenticationEntryPointException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public BaseResponse authenticationEntryPointException(HttpServletRequest request, CAuthenticationEntryPointException e) {
        return responseService.createFailResponse(Integer.valueOf(getMessage("entryPointException.code")), getMessage("entryPointException.message"), e.getMessage());
    }

    @ExceptionHandler(AccessDeniedException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public BaseResponse accessDeniedException(HttpServletRequest request, AccessDeniedException e) {
        return responseService.createFailResponse(Integer.valueOf(getMessage("accessDenied.code")), getMessage("accessDenied.message"), e.getMessage());
    }

    @ExceptionHandler(CCommunicationException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public BaseResponse communicationException(HttpServletRequest request, CCommunicationException e) {
        return responseService.createFailResponse(Integer.valueOf(getMessage("communicationError.code")), getMessage("communicationError.message"), e.getMessage());
    }

    @ExceptionHandler(CUserExistException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public BaseResponse communicationException(HttpServletRequest request, CUserExistException e) {
        return responseService.createFailResponse(Integer.valueOf(getMessage("existingUser.code")), getMessage("existingUser.message"), e.getMessage());
    }

    @ExceptionHandler(CNotOwnerException.class)
    @ResponseStatus(HttpStatus.NON_AUTHORITATIVE_INFORMATION)
    public BaseResponse notOwnerException(HttpServletRequest request, CNotOwnerException e) {
        return responseService.createFailResponse(Integer.valueOf(getMessage("notOwner.code")), getMessage("notOwner.message"), e.getMessage());
    }

    @ExceptionHandler(CResourceNotExistException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public BaseResponse resourceNotExistException(HttpServletRequest request, CResourceNotExistException e) {
        return responseService.createFailResponse(Integer.valueOf(getMessage("resourceNotExist.code")), getMessage("resourceNotExist.message"), e.getMessage());
    }

    @ExceptionHandler(CForbiddenWordException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public BaseResponse forbiddenWordException(HttpServletRequest request, CForbiddenWordException e) {
        return responseService.createFailResponse(Integer.valueOf(getMessage("forbiddenWord.code")), getMessage("forbiddenWord.message", new Object[]{e.getMessage()}));
    }

    @ExceptionHandler(CServiceNotImplement.class)
    @ResponseStatus(HttpStatus.NOT_IMPLEMENTED)
    public BaseResponse serviceNotImplementException(HttpServletRequest request, CServiceNotImplement e) {
        return responseService.createFailResponse(Integer.valueOf(getMessage("serviceNotImplement.code")), getMessage("serviceNotImplement.message"), e.getMessage());
    }

    @ExceptionHandler(CServiceIncorrectUse.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public BaseResponse serviceIncorrectUseException(HttpServletRequest request, CServiceIncorrectUse e) {
        return responseService.createFailResponse(Integer.valueOf(getMessage("serviceIncorrectUse.code")), getMessage("serviceIncorrectUse.message"), e.getMessage());
    }

    @ExceptionHandler(CHttpRelayServiceFail.class)
    @ResponseStatus(HttpStatus.BAD_GATEWAY)
    public BaseResponse httpRelayServiceFailException(HttpServletRequest request, CHttpRelayServiceFail e) {
        return responseService.createFailResponse(Integer.valueOf(getMessage("httpRelayServiceFail.code")), getMessage("httpRelayServiceFail.message"), e.getDetailMessage());
    }

    @ExceptionHandler(CMybatisException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public BaseResponse mybatisException(HttpServletRequest request, CMybatisException e) {
        return responseService.createFailResponse(Integer.valueOf(getMessage("mybatisException.code")), getMessage("mybatisException.message"), e.getMessage());
    }
    // code정보에 해당하는 메시지를 조회합니다.
    private String getMessage(String code) {
        return getMessage(code, null);
    }

    // code정보, 추가 argument로 현재 locale에 맞는 메시지를 조회합니다.
    private String getMessage(String code, Object[] args) {
        return messageSource.getMessage(code, args, LocaleContextHolder.getLocale());
    }
}
