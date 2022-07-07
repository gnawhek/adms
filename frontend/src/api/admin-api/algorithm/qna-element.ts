import http from 'src/api/http'
import { AlgPwiElem, AlgPwiElemQna, AlgQnaTemplate } from 'src/types/domain/algorithm'

export async function SELECT_QNA_ELEMENT_CODE_LIST() {
  return await http.data<AlgPwiElem[]>('SELECT_QNA_ELEMENT_CODE_LIST')
}

export async function SELECT_QNA_ELEMENT_QNA_LIST(C_PWI_ELEM: string) {
  return await http.data<AlgPwiElemQna[]>('SELECT_QNA_ELEMENT_QNA_LIST', { C_PWI_ELEM })
}

export async function SELECT_QNA_ELEMENT_TEMPLATE_LIST(data: AlgQnaTemplate) {
  return await http.data<AlgQnaTemplate[]>('SELECT_QNA_ELEMENT_TEMPLATE_LIST', {
    C_CODE: data.C_CODE,
    S_QUESTION: data.S_QUESTION,
  })
}

export async function SELECT_QNA_ELEMENT_TEMPLATE(C_CODE: string) {
  return await http.data<AlgQnaTemplate>('SELECT_QNA_ELEMENT_TEMPLATE', { C_CODE })
}

export async function INSERT_QNA_ELEMENT_QNA_ELEMENT(data: AlgPwiElemQna) {
  return await http.data<number>('INSERT_QNA_ELEMENT_QNA_ELEMENT', {
    C_PWI_ELEM: data.C_PWI_ELEM,
    C_CODE: data.C_CODE,
    S_EXCEPTION: data.S_EXCEPTION || '',
  })
}

export async function UPDATE_QNA_ELEMENT_QNA_ELEMENT(data: AlgPwiElemQna) {
  return await http.data<number>('UPDATE_QNA_ELEMENT_QNA_ELEMENT', {
    C_PWI_ELEM: data.C_PWI_ELEM,
    C_CODE: data.C_CODE,
    S_EXCEPTION: data.S_EXCEPTION || '',
  })
}

export async function DELETE_QNA_ELEMENT_QNA_ELEMENT(data: AlgPwiElemQna) {
  return await http.data<number>('DELETE_QNA_ELEMENT_QNA_ELEMENT', {
    C_PWI_ELEM: data.C_PWI_ELEM,
    C_CODE: data.C_CODE,
  })
}
