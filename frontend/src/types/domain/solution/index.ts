import { ynFlag } from 'src/types'

export interface SolutionCategory {
  C_CODE: string | null
  N_NAME: string | null
  CM_IDS: string | undefined | null
  I_SORT: number
}

export interface SolutionContent {
  I_SEQ: number
  C_CODE: string
  S_TITLE: string
  S_PWI: string
  I_SORT: number
}

export interface SolutionTemplate {
  C_CODE: string
  S_TITLE: string
  S_PWI_SEX: string
  S_PWI_AGE: string
  S_PWI: string
  Y_WEEK: ynFlag
  S_WEEK: string
  C_TYPE: string
  S_CONTENT: string
}
