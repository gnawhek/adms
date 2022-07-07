export interface INoticeProps {
  title?: string | null
  message: string
  detailMessage?: string | null
  callback?: any
}

export interface CommonDialogProps<T = any> {
  title?: string
  component: string
  params?: any
  style?: any
  callback: (result?: T) => void
  isComponentAction: boolean
  isShow: boolean
  isBackdropDismiss: boolean
  isComponentScrollable: boolean
}

export interface PartnerItem {
  CM_ID: string
  N_PARTNER: string
  D_REG_DT: number
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

export interface SYS_CODE {
  index: number
  P_CODE: string

  C_GRP: string
  C_CODE: string
  N_CODE: string
  C_EXTRA: string
  S_COMMENT: string
  I_SORT: number
}

export type ynFlag = 'y' | 'n'
