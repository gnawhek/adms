import http from 'src/api/http'
import { AlgQnaGroup, AlgQnaTemplate, AlgQnaTpl, QnaItem } from 'src/types/domain/algorithm'

export async function SELECT_QNA_MANAGEMENT_CODE_LIST() {
  return await http.data<AlgQnaGroup[]>('SELECT_QNA_MANAGEMENT_CODE_LIST')
}

export async function SELECT_QNA_MANAGEMENT_CODE_QNA_LIST(C_QNA_GRP: string) {
  return await http.data<AlgQnaTpl[]>('SELECT_QNA_MANAGEMENT_CODE_QNA_LIST', { C_QNA_GRP })
}

export async function UPDATE_QNA_MANAGEMENT_CODE_QNA_SORT(data: { list: AlgQnaTpl[] }) {
  return await http.data<number>('UPDATE_QNA_MANAGEMENT_CODE_QNA_SORT', data)
}

export async function INSERT_QNA_MANAGEMENT_CODE_QNA(C_CODE: string, data: AlgQnaTemplate) {
  return await http.data<number>('INSERT_QNA_MANAGEMENT_CODE_QNA', Object.assign({ C_QNA_GRP: C_CODE }, data))
}

export async function DELETE_QNA_MANAGEMENT_CODE_QNA(data: AlgQnaTpl) {
  return await http.data<number>('DELETE_QNA_MANAGEMENT_CODE_QNA', data)
}

export async function SELECT_QNA_MANAGEMENT_TEMPLATE_LIST(data: AlgQnaTemplate) {
  return await http.data<AlgQnaTemplate[]>('SELECT_QNA_MANAGEMENT_TEMPLATE_LIST', { C_CODE: data.C_CODE || '', S_QUESTION: data.S_QUESTION || '' })
}

export async function SELECT_QNA_MANAGEMENT_TEMPLATE_EXISTS(C_CODE: string) {
  return await http.data<number>('SELECT_QNA_MANAGEMENT_TEMPLATE_EXISTS', { C_CODE })
}

export async function SELECT_QNA_MANAGEMENT_TEMPLATE(C_CODE: string) {
  return await http.data<AlgQnaTemplate>('SELECT_QNA_MANAGEMENT_TEMPLATE', { C_CODE })
}

export async function INSERT_QNA_MANAGEMENT_TEMPLATE(data: AlgQnaTemplate) {
  return await http.data<number>('INSERT_QNA_MANAGEMENT_TEMPLATE', data)
}

export async function UPDATE_QNA_MANAGEMENT_TEMPLATE(data: AlgQnaTemplate) {
  return await http.data<number>('UPDATE_QNA_MANAGEMENT_TEMPLATE', data)
}

export async function DELETE_QNA_MANAGEMENT_TEMPLATE(C_CODE: string) {
  return await http.data<number>('DELETE_QNA_MANAGEMENT_TEMPLATE', { C_CODE })
}

export async function INSERT_QNA_ITEM(data: QnaItem) {
  return await http.data<number>('INSERT_QNA_ITEM', data)
}
