import http from './http'
import { ServerConfig } from 'src/types/domain/ServerConfig'

/**
 * 샘플
 */
export async function $hSampleCommonList() {
  const response = await http.data<any[]>('SELECT_SAMPLE', {})
  return response
}

/**
 * 광역시/도
 * @constructor
 */
export async function SELECT_ZIP_STATE_LIST() {
  return await http.data<{ I_ZIP: number; N_STATE: string }[] | null>('SELECT_ZIP_STATE_LIST', {})
}

/**
 * 시/군/구
 * @param I_ZIP
 * @constructor
 */
export async function SELECT_ZIP_CITY_LIST(I_ZIP: number) {
  return await http.data<{ I_ZIP: number; N_CITY: string }[] | null>('SELECT_ZIP_CITY_LIST', {
    I_ZIP,
  })
}

/**
 * 서버 환경 정보
 * @constructor
 */
export async function GetServerConfig() {
  return await http.get<ServerConfig | null>('config', { timeout: 500 })
}
