import http from './http'
import { useAuthStore } from 'src/store/auth'
import { ResultData, User } from 'src/types'
import { AxiosResponse } from 'axios'
import Encrypt from 'assets/libs/Encrypt'
import tools from 'src/utils/tools'

/**
 * 인증처리 (사용자 및 토큰 설정)
 * @param response
 */
const updateAuthenticated = (user: User) => {
  if (user != null) {
    const authStore = useAuthStore()
    const accessToken = user.accessToken
    if (accessToken != null) {
      delete user.accessToken
      authStore.login(user, accessToken)

      //토큰 확인용
      // authStore.decodedAccessToken = authStore.decodeJWT(accessToken);
      // console.log(Object.assign({}, authStore.decodedAccessToken));
    }
  }
  return user
}

/**
 * 로그인 개발용
 * @param username
 * @param password
 */
export async function loginDummy(id: string, password: string) {
  return new Promise((resolve) => {
    updateAuthenticated({
      accessToken: 'login_token_authenticated',
      N_NAME: '홍길동',
      I_ID: 'master',
    } as User)
    resolve({})
  })
}

/**
 * 로그인
 * @param id
 * @param password
 */
export async function loginForm(id: string, password: string) {
  const formData = new FormData()
  formData.append('id', id)
  formData.append('password', password)
  return await loginFormData(formData)
}

/**
 * 로그인: FormData 사용 방식
 * @param formData
 */
export async function loginFormData(formData: FormData) {
  const user = await http.post<User>('loginform', formData)
  return updateAuthenticated(user)
}

/**
 * 로그인: signin
 * @param username
 * @param password
 */
export async function signin(id: string, password: string) {
  //const response = await http.post( 'data?action=LOGINDATA', {username,password});
  const data = await getkey({
    id,
    password,
  })
  const user = await http.post<User>('signin', { data })
  return updateAuthenticated(user)
}

/**
 * 로그인: Data 사용 방식
 * @param username
 * @param password
 */
export async function loginData(id: string, password: string) {
  //const response = await http.post( 'data?action=LOGINDATA', {username,password});
  const response = await http.data('SELECT_LOGINDATA', {
    id,
    password,
  })
  return updateAuthenticated(response)
}

/**
 * 토큰을 가져옴
 * @param token
 */
export async function getToken(token: string) {
  const response = await http.post('data?action=TOKEN', {
    token,
  })
  return response
}

/**
 * 토큰 갱신
 * 서버에서 토큰을 가져오도록 수정해야함
 * 현재임시 토큰을 리턴
 * @param token
 */
const getAccessTokenFromRefreshToken = (token: string) => {
  return Promise.resolve('new-access-token')
  //return getToken(token).then(res => res.data.token);
}

/**
 * 토큰을 관리
 * 주기적으로 호출하도록 처리해야됨
 * [현재 사용하지 않음]
 */
const ensureAuth = async () => {
  const auth = useAuthStore()
  try {
    // If id token is expired attempt to get another via the refresh token
    if (!auth.isAuthenticated()) {
      const refreshToken = auth.getRefreshToken()
      if (!refreshToken) throw new Error('Missing refresh token')
      const accessToken = await getAccessTokenFromRefreshToken(refreshToken)
      auth.setAccessToken(accessToken)
    }
    return auth.getAccessToken()
  } catch (e) {
    // If unable to get a new id token then purge everything for a fresh login
    // Perform any actions necessary to reflect an unauthenticated state
    auth.reset()
    throw new Error('Unauthorized to complete request')
  }
}

/**
 * RSA 인증키
 */
const getkey = async (data: any) => {
  const response = await http.post('getkey')
  tools.cipher.setKeys(response.data)
  return { ...tools.cipher.enc(JSON.stringify(data)), m: response.data.m }
}
