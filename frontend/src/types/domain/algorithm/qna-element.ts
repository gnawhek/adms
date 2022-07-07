export interface AlgPwiElemQna {
  C_PWI_ELEM: string
  C_CODE: string
  S_EXCEPTION: string

  template: AlgQnaTemplate
}

export interface AlgQnaTpl {
  C_QNA_GRP: string
  C_CODE: string
  S_QUESTION: string
  I_SORT: number
}

export interface AlgQnaTemplate {
  C_CODE: string
  S_PWI_SEX: string
  S_PWI_AGE: string
  S_ICON_URL: string
  S_QUESTION: string
  S_ANS: string

  B_ICON: string
}
