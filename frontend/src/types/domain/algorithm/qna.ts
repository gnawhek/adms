import { ynFlag } from 'src/types'

export interface AlgQnaGroup {
  C_CODE: string
  N_CODE: string
  C_EXTRA: ynFlag
}

export interface QnaItem {
  I_MEMID: string
  S_DATE: string
  C_QCODE: string
  I_BMI: string
  C_BMICODE: string
  I_HEIGHT: string
  I_WEIGHT: string
  I_BFR: string
  I_VWC: string
  I_ROM: string
  C_VER: string
  S_QNA: string
  Y_FIN: ynFlag
}
