import { axiosApi, axiosErrorHandler } from 'boot/axios'
import { AxiosRequestConfig, AxiosResponse, Method } from 'axios'
import { EventType } from 'src/types'
import Encrypt from 'assets/libs/Encrypt'
import tools from 'src/utils/tools'
import { emitter } from 'boot/EventBus'
import { $$table, $ssfDebug } from 'src/utils/logger'
import { serverConfig } from 'boot/server-config'
import dialog from 'src/utils/dialog'

export const ServicePath = {
  service: 'service',
  data: 'data',
}

const instance = {
  //로그인이 필요하지 않은 데이터 요청
  data: async <T = any, R = T>(action: string, data?: any, config?: AxiosRequestConfig): Promise<R> => {
    const url = `${ServicePath.data}?action=${action}`
    $ssfDebug(instance.data, 'url:', url, data)
    return await send<T, R>('post', url, data || {}, config, serverConfig.encrypt)
  },
  //로그인을 했을 경우에만 가져올 수 있는 데이터 요청
  service: async <T = any, R = T>(action: string, data?: any, config?: AxiosRequestConfig): Promise<R> => {
    const url = `${ServicePath.service}?action=${action}`
    $ssfDebug(instance.data, 'url:', url, data)
    return await send<T, R>('post', url, data || {}, config, serverConfig.encrypt)
  },
  get: async <T = any, R = T>(url: string, config?: AxiosRequestConfig): Promise<R> => {
    $ssfDebug(instance.get, 'url:', url)
    return await send<T, R>('get', url, null, config)
  },
  post: async <T = any, R = T>(url: string, data?: any, config?: AxiosRequestConfig): Promise<R> => {
    $ssfDebug(instance.post, 'url:', url, data)
    return await send<T, R>('post', url, data, config)
  },
  put: async <T = any, R = T>(url: string, data?: any, config?: AxiosRequestConfig): Promise<R> => {
    $ssfDebug(instance.put, 'url:', url, data)
    return await send<T, R>('put', url, data, config)
  },
  patch: async <T = any, R = T>(url: string, data?: any, config?: AxiosRequestConfig): Promise<R> => {
    $ssfDebug(instance.patch, 'url:', url, data)
    return await send<T, R>('patch', url, data, config)
  },
  delete: async <T = any, R = T>(url: string, config?: AxiosRequestConfig): Promise<R> => {
    $ssfDebug(instance.delete, 'url:', url)
    return await send<T, R>('delete', url, null, config)
  },
}

/**
 * 데이터 요청
 * @param method
 * @param url
 * @param data
 * @param config
 * @param configEncrypt
 */
const send = <T = any, R = T>(method: Method, url: string, data?: any, config?: AxiosRequestConfig, configEncrypt = false): Promise<R> => {
  return new Promise<R>((resolve, reject) => {
    if (data != null) {
      if (configEncrypt) {
        /**
         * Tiny Encryption Algorithm(XXTEA)
         * 암호화
         */
        const encrypt = new Encrypt(null, JSON.stringify(data))
        const encryptText = encrypt.key + encrypt.data
        // console.log('encryptText', encryptText)
        /**
         * 복호화
         */
        // const key = encryptText.substring(0, 16)
        // const decryptText = encrypt.decrypt(encryptText.substring(16, encryptText.length), key)
        // console.log('decryptText', decryptText)

        data = {
          encrypt: encryptText != null,
          data: encryptText || data,
        }
      }
    }

    if (config == null) {
      config = {} as AxiosRequestConfig
    }
    config.method = config.method || method || 'post'
    config.url = url
    config.data = data

    /**
     * 서비스 호출
     */
    axiosApi(config)
      .then((response: AxiosResponse<T>) => {
        const data: any = response.data
        let result = null

        //암호화 상태일 경우 복호화
        if (configEncrypt && data?.encrypt) {
          result = tools.toDecrypt(data.result)
          $$table(result)
        } else if (data?.hasOwnProperty('result')) {
          result = data.result
        } else {
          result = data
        }

        if (result?.message != null) {
          void dialog.message({
            message: result.message + '\n' + url.replace('data?action=', '').replace('service?action=', ''),
          })
        }

        resolve(result)
      })
      .catch(
        axiosErrorHandler<any>((res) => {
          if (res.type === 'axios-error') {
            //type is available here
            const error = res.error
          } else {
            //stock error
            const error = res.error
          }
          reject(res)
        }),
      )
  })
}

export default instance
