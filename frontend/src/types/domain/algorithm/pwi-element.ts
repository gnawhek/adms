import { ynFlag } from 'src/types'

export interface AlgPwi
{
  C_PWI: string
  N_PWI: string
  C_PARENT: string
  C_TYPE: string
  C_ALIAS: string
  Y_CHILD: ynFlag
}

export interface AlgPwiElemTuple
{
  C_TYPE: string
  C_PWI: string
  C_PWI_ELEM: string
  N_PWI_ELEM: string
}

export interface AlgPwiElem
{
  C_TYPE: string
  C_PWI_ELEM: string
  N_PWI_ELEM: string
  C_UI_RESULT: string
  Y_UI_RESULT: ynFlag
  Y_ALZ_RESULT: ynFlag
  I_SORT: number
}
