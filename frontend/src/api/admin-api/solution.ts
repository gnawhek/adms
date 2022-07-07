import http from 'src/api/http'
import { SolutionCategory, SolutionContent, SolutionTemplate } from 'src/types/domain/solution'

export async function SELECT_SOLUTION_CATEGORY_LIST(CM_ID = '') {
  return await http.data<SolutionCategory[] | null>('SELECT_SOLUTION_CATEGORY_LIST', { CM_ID })
}

export async function SELECT_SOLUTION_CATEGORY_EXISTS(C_CODE: string) {
  return await http.data<number>('SELECT_SOLUTION_CATEGORY_EXISTS', { C_CODE })
}

export async function INSERT_SOLUTION_CATEGORY(data: SolutionCategory) {
  return await http.data<number>('INSERT_SOLUTION_CATEGORY', data)
}

export async function UPDATE_SOLUTION_CATEGORY(data: SolutionCategory) {
  return await http.data<number>('UPDATE_SOLUTION_CATEGORY', data)
}

export async function DELETE_SOLUTION_CATEGORY(data: SolutionCategory) {
  return await http.data<number>('DELETE_SOLUTION_CATEGORY', data)
}

export async function UPDATE_SOLUTION_CATEGORY_SORT(data: { list: SolutionCategory[] }) {
  return await http.data<number>('UPDATE_SOLUTION_CATEGORY_SORT', data)
}

export async function SELECT_SOLUTION_CONTENT_LIST(C_CODE_CGY: string | undefined | null) {
  return await http.data<SolutionContent[] | null>('SELECT_SOLUTION_CONTENT_LIST', { C_CODE_CGY })
}

export async function INSERT_SOLUTION_CONTENT(C_CODE_CGY: string, C_CODE: string) {
  return await http.data<number>('INSERT_SOLUTION_CONTENT', { C_CODE_CGY, C_CODE })
}

export async function DELETE_SOLUTION_CONTENT(data: SolutionContent) {
  return await http.data<number>('DELETE_SOLUTION_CONTENT', { I_SEQ: data.I_SEQ })
}

export async function UPDATE_SOLUTION_CONTENT_SORT(data: { list: SolutionContent[] }) {
  return await http.data<number>('UPDATE_SOLUTION_CONTENT_SORT', data)
}

export async function SELECT_SOLUTION_TEMPLATE_LIST(data: SolutionTemplate) {
  return await http.data<SolutionTemplate[] | null>('SELECT_SOLUTION_TEMPLATE_LIST', {
    C_CODE: data.C_CODE || '',
    S_TITLE: data.S_TITLE || '',
    S_PWI: data.S_PWI || '',
  })
}

export async function SELECT_SOLUTION_TEMPLATE_EXISTS(C_CODE: string) {
  return await http.data<number>('SELECT_SOLUTION_TEMPLATE_EXISTS', { C_CODE })
}

export async function SELECT_SOLUTION_TEMPLATE(C_CODE: string | undefined | null) {
  return await http.data<SolutionTemplate | null>('SELECT_SOLUTION_TEMPLATE', { C_CODE })
}

export async function INSERT_SOLUTION_TEMPLATE(data: SolutionTemplate) {
  return await http.data<number>('INSERT_SOLUTION_TEMPLATE', data)
}

export async function UPDATE_SOLUTION_TEMPLATE(data: SolutionTemplate) {
  return await http.data<number>('UPDATE_SOLUTION_TEMPLATE', data)
}

export async function DELETE_SOLUTION_TEMPLATE(data: SolutionTemplate) {
  return await http.data<number>('DELETE_SOLUTION_TEMPLATE', { C_CODE: data.C_CODE })
}
