import http from 'src/api/http'
import { AlgPwi, AlgPwiElem, AlgPwiElemTuple } from 'src/types/domain/algorithm'

export async function SELECT_PWI_ELEMENT_PWI_LIST() {
  return await http.data<AlgPwi[]>('SELECT_PWI_ELEMENT_PWI_LIST')
}

export async function SELECT_PWI_ELEMENT_TUPLE_LIST(C_PWI: string) {
  return await http.data<AlgPwiElemTuple[]>('SELECT_PWI_ELEMENT_TUPLE_LIST', { C_PWI })
}

export async function INSERT_PWI_ELEMENT_TUPLE_ELEMENT(C_PWI: string, data: AlgPwiElem) {
  return await http.data<number>('INSERT_PWI_ELEMENT_TUPLE_ELEMENT', Object.assign({ C_PWI }, data))
}

export async function DELETE_PWI_ELEMENT_TUPLE_ELEMENT(data: AlgPwiElemTuple) {
  return await http.data<number>('DELETE_PWI_ELEMENT_TUPLE_ELEMENT', data)
}

export async function SELECT_PWI_ELEMENT_LIST(data: AlgPwiElem) {
  return await http.data<AlgPwiElem[]>('SELECT_PWI_ELEMENT_LIST', {
    C_TYPE: data.C_TYPE || '',
    C_PWI_ELEM: data.C_PWI_ELEM || '',
    N_PWI_ELEM: data.N_PWI_ELEM || '',
  })
}

export async function SELECT_PWI_ELEMENT(C_PWI_ELEM: string) {
  return await http.data<AlgPwiElem>('SELECT_PWI_ELEMENT', { C_PWI_ELEM })
}

export async function SELECT_PWI_ELEMENT_EXISTS(C_PWI_ELEM: string) {
  return await http.data<number>('SELECT_PWI_ELEMENT_EXISTS', { C_PWI_ELEM })
}

export async function INSERT_PWI_ELEMENT(data: AlgPwiElem) {
  return await http.data<number>('INSERT_PWI_ELEMENT', data)
}

export async function UPDATE_PWI_ELEMENT(data: AlgPwiElem) {
  return await http.data<number>('UPDATE_PWI_ELEMENT', data)
}

export async function DELETE_PWI_ELEMENT(C_PWI_ELEM: string) {
  return await http.data<number>('DELETE_PWI_ELEMENT', { C_PWI_ELEM })
}
