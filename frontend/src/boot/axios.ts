import { boot } from 'quasar/wrappers'
import axios, { AxiosError, AxiosInstance, AxiosRequestConfig, AxiosResponse } from 'axios'
import { useAuthStore } from 'src/store/auth'
import { useLocaleStore } from 'src/store/locale'
import { emitter } from 'boot/EventBus'
import { EventType } from 'src/types'
import { $$debug, $error, $$table } from 'src/utils/logger'

declare module '@vue/runtime-core' {
  interface ComponentCustomProperties {
    $axios: AxiosInstance
  }
}

const axiosApi = axios.create({ baseURL: process.env.VUE_APP_API + '/' })

export default boot(({ app }) => {
  app.config.globalProperties.$axios = axios
  app.config.globalProperties.$api = axiosApi
})

// 요청 인터셉터 추가
axiosApi.interceptors.request.use((config: AxiosRequestConfig) => {
  const localeStore = useLocaleStore()
  const authStore = useAuthStore()
  if (authStore.getAccessToken() !== null) {
    config['headers'] = {
      'Content-Type': config.headers['Content-Type'] || 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      //Authorization: `Bearer ${authStore.getAccessToken()}`,
      'X-AUTH-TOKEN': `${authStore.getAccessToken()}`,
    }
  }
  //config['headers']['Accept-Language'] = config.headers['Accept-Language'] || localeStore.getLocale.split('-')[0]
  config['headers']['N_LANG'] = localeStore.getLocale.split('-')[0]
  $$debug('request', config)
  return config
})

// 응답 인터셉터 추가
axiosApi.interceptors.response.use(
  (response: AxiosResponse) => {
    $$debug('response', response)
    if (!response.data.encrypt == null || !response.data.encrypt) {
      $$table(response.data.result || response.data)
    }
    return response
  },
  (errors: any) => {
    $error(errors)
    void emitter.emit(EventType.axiosError, errors)
    return Promise.reject(errors)
  },
)

interface IErrorBase<T> {
  error: Error | AxiosError<T>
  type: 'axios-error' | 'stock-error'
}

interface IAxiosError<T> extends IErrorBase<T> {
  error: AxiosError<T>
  type: 'axios-error'
}

interface IStockError<T> extends IErrorBase<T> {
  error: Error
  type: 'stock-error'
}

export function axiosErrorHandler<T>(callback: (err: IAxiosError<T> | IStockError<T>) => void) {
  return (error: Error | AxiosError<T>) => {
    if (axios.isAxiosError(error)) {
      callback({
        error: error,
        type: 'axios-error',
      })
    } else {
      callback({
        error: error,
        type: 'stock-error',
      })
    }
  }
}

export { axios, axiosApi }

