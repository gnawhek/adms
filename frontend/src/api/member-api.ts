import http from './http'
import { Member } from 'src/types'
import Encrypt from 'assets/libs/Encrypt'
import tools from 'src/utils/tools'

/**
 * 사용자 목록
 * @param SORT 정렬 정보
 * @param TO_LOAD 시작위치
 * @param TO_LIMIT 가져올 ROW 개수
 */
export async function $hAsyncMemberSearchCustomerList(SORT: string, TO_LOAD: number, TO_LIMIT: number) {
  const response = await http.data<Member[]>('SELECT_SEARCH_EXISTING_CUSTOMERS_LIST', {
    SORT,
    TO_LOAD,
    TO_LIMIT,
  })
  return response
}

/**
 * 사용자 목록
 * @param SORT 정렬 정보
 * @param TO_LOAD 시작위치
 * @param TO_LIMIT 가져올 ROW 개수
 */
export function $hMemberSearchCustomerList(SORT: string, TO_LOAD: number, TO_LIMIT: number) {
  return http.data<Member[]>('SELECT_SEARCH_EXISTING_CUSTOMERS_LIST', {
    SORT,
    TO_LOAD,
    TO_LIMIT,
  })
}

/**
 * 사용자 목록 전체 개수
 */
export async function $hMemberSearchCustomerCount() {
  const count = await http.data<{ COUNT: number }>('SELECT_SEARCH_EXISTING_CUSTOMERS_COUNT', {})
  return count
}

/**
 * 아이디 유무 확인
 * @param I_ID
 */
export async function idExists(I_ID: string) {
  const response = await http.data<{ COUNT: number }>('SELECT_LOGIN_ID', {
    I_ID,
  })
  return response
}

/**
 * 아이디 유무 확인
 * @param I_ID
 */
export async function idExistsService(I_ID: string) {
  const response = await http.service<{ COUNT: number }>('SELECT_LOGIN_ID', {
    I_ID,
  })
  return response
}

/**
 * 신규비밀번호 설정
 * @param I_ID
 * @param password
 */
export async function newPassword(I_ID: string, password: string) {
  const response = await http.data<number>('USER_NEW_PW', {
    data: tools.toEncrypt(JSON.stringify({ I_ID, password })),
  })
  return response
}

/**
 * 아이디 찾기
 * @param I_HP
 */
export async function findLoginId(I_HP: string) {
  const response = await http.data<{ I_ID: string; N_NAME: string; D_REG_DT: number } | null>('SELECT_FIND_LOGIN_ID', {
    I_HP,
  })
  return response
}

/**
 * 기업의 고객풀에 가입된 고객인지 확인
 * @param I_HP
 */
export async function SELECT_FIND_LOGIN_POOL(I_HP: string) {
  const response = await http.data<{ C_SHOP: string } | null>('SELECT_FIND_LOGIN_POOL', {
    I_HP,
  })
  return response
}

/**
 * 추천인 코드에서 c_shop 과 추천인 코드를 확인한다.
 * @param I_RECOMM_CODE
 */
export async function SELECT_FIND_RECOMM_CODE(I_RECOMM_CODE: string) {
  const response = await http.data<{ C_SHOP: string; I_RECOMM_CODE: string } | null>('SELECT_FIND_RECOMM_CODE', {
    I_RECOMM_CODE,
  })
  return response
}


export async function NewMemberRegister(newUser: any) {
  const response = await http.data<boolean>('NewMemberRegister', {
    data: tools.toEncrypt(JSON.stringify(newUser)),
  })
  return response
}
