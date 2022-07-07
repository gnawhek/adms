export interface User {
  I_MEMID: string
  Y_STAFF: string,
  I_ID?: string | undefined | null
  N_NAME: string
  C_SEX: string,
  D_BIRTH: string
  I_AGE: number
  I_HEIGHT: number
  I_WEIGHT: number
  I_LEVEL: number
  I_HP: string
  S_EMAIL: string
  I_ZIPCODE: number
  C_QCODE: string
  C_SHOP: string
  N_SHOP: string
  S_PIC_URL: string
  D_LAST_LOGIN: string
  password?: string | undefined | null
  confirmPassword?: string | undefined | null
  accessToken?: string | undefined | null
  C_LEVEL: string
  Y_ADM: string
  Y_ONL: string
  Y_OFL: string
  Y_CEL: string
}
