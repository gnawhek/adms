import { ynFlag } from 'src/types'

export interface ProductCategory {
  C_CODE: string | null
  N_NAME: string | null
  CM_IDS: string | undefined | null
  I_SORT: number
}
export interface ProductGroup {
  C_CODE: string | null
  N_NAME: string | null
  CM_IDS: string | undefined | null
  I_SORT: number
}

export interface ProductProduct {
  I_SEQ: number
  S_ICON: string
  C_CODE: string
  N_BRAND_NAME: string
  N_PRODUCT_NAME: string
  S_PWI: string
  I_SORT: number
}

export interface ProductTemplate {
  C_CODE: string
  N_BRAND_NAME: string
  N_PRODUCT_NAME: string
  S_PWI_SEX: string
  S_PWI_AGE: string
  S_PWI: string
  S_MEMO: string
  Y_URL: ynFlag
  S_URL: string
  Y_ICON: ynFlag
  S_ICON: string
  B_ICON: string
}

export interface CommonCode {
  CODE_ID: number
  CODE_NAME: string
  PARENT_CODE_ID: number
  PARENT_CODE_NAME: string
  EXPLANATION: string
  ETC: string
  ENABLED: number
}
