import http from 'src/api/http'
import { PartnerItem, SYS_CODE, CommonCode } from 'src/types'

export * from './product'
export * from './solution'
export * from './algorithm'

export async function SELECT_PARTNER_LIST(N_PARTNER?: string) {
  return await http.data<PartnerItem[] | null>('SELECT_PARTNER_LIST', { N_PARTNER })
}

export async function SELECT_ALG_SEX_LIST() {
  const items = await http.data<SYS_CODE[] | null>('SELECT_ALG_SEX_LIST')
  items?.forEach((d, index) => (d.index = index))
  return <SYS_CODE[]>items
}

export async function SELECT_PWI_AGE_LIST() {
  const items = await http.data<SYS_CODE[] | null>('SELECT_PWI_AGE_LIST')
  items?.forEach((d, index) => (d.index = index))
  return <SYS_CODE[]>items
}

export async function SELECT_PWI_TYPE_LIST() {
  const items = await http.data<SYS_CODE[] | null>('SELECT_PWI_TYPE_LIST')
  const pwiTypes: any = {}
  let index = 0
  items
    ?.filter((d) => d.P_CODE == '')
    .forEach((d) => {
      pwiTypes[d.C_CODE] = [Object.assign({ index: index++ }, d)]
    })
  items
    ?.filter((d) => d.P_CODE != '')
    .forEach((d) => {
      pwiTypes[d.P_CODE].push(Object.assign({ index: index++ }, d))
    })
  return <[SYS_CODE[]]>Object.keys(pwiTypes).map((type) => pwiTypes[type])
}

export async function SELECT_ALG_TS_TYPE_LIST() {
  const items = await http.data<SYS_CODE[] | null>('SELECT_ALG_TS_TYPE_LIST')
  items?.forEach((d, index) => (d.index = index))
  return <SYS_CODE[]>items
}

export async function SELECT_ALG_RESULT_UI_LIST() {
  const items = await http.data<SYS_CODE[] | null>('SELECT_ALG_RESULT_UI_LIST')
  items?.forEach((d, index) => (d.index = index))
  return <SYS_CODE[]>items
}

export async function SELECT_CATEGORY_LIST(N_CATEGORY?: string) {
  return await http.data<CommonCode[] | null>('SELECT_CATEGORY_LIST', { N_CATEGORY })
}
