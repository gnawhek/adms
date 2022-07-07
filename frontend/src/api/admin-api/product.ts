import http from '../http'
import { ProductCategory, ProductGroup, ProductProduct, ProductTemplate } from 'src/types/domain/product'

export async function SELECT_PRODUCT_CATEGORY_LIST(CM_ID = '') {
  return await http.data<ProductCategory[] | null>('SELECT_PRODUCT_CATEGORY_LIST', { CM_ID })
}

export async function SELECT_PRODUCT_CATEGORY_EXISTS(C_CODE: string) {
  return await http.data<number>('SELECT_PRODUCT_CATEGORY_EXISTS', { C_CODE })
}

export async function INSERT_PRODUCT_CATEGORY(data: ProductCategory) {
  return await http.data<number>('INSERT_PRODUCT_CATEGORY', data)
}

export async function UPDATE_PRODUCT_CATEGORY(data: ProductCategory) {
  return await http.data<number>('UPDATE_PRODUCT_CATEGORY', data)
}

export async function DELETE_PRODUCT_CATEGORY(data: ProductCategory) {
  return await http.data<number>('DELETE_PRODUCT_CATEGORY', data)
}

export async function UPDATE_PRODUCT_CATEGORY_SORT(data: { list: ProductCategory[] }) {
  return await http.data<number>('UPDATE_PRODUCT_CATEGORY_SORT', data)
}

export async function SELECT_PRODUCT_GROUP_LIST(C_CODE_CTGY: string, CM_ID = '') {
  return await http.data<ProductGroup[] | null>('SELECT_PRODUCT_GROUP_LIST', { C_CODE_CTGY, CM_ID })
}

export async function SELECT_PRODUCT_GROUP_EXISTS(C_CODE: string) {
  return await http.data<number>('SELECT_PRODUCT_GROUP_EXISTS', { C_CODE })
}

export async function INSERT_PRODUCT_GROUP(data: ProductGroup) {
  return await http.data<number>('INSERT_PRODUCT_GROUP', data)
}

export async function UPDATE_PRODUCT_GROUP(data: ProductGroup) {
  return await http.data<number>('UPDATE_PRODUCT_GROUP', data)
}

export async function DELETE_PRODUCT_GROUP(data: ProductGroup) {
  return await http.data<number>('DELETE_PRODUCT_GROUP', data)
}

export async function UPDATE_PRODUCT_GROUP_SORT(data: { list: ProductGroup[] }) {
  return await http.data<number>('UPDATE_PRODUCT_GROUP_SORT', data)
}

export async function SELECT_PRODUCT_PRODUCT_LIST(C_CODE_GRP: string | undefined | null) {
  return await http.data<ProductProduct[] | null>('SELECT_PRODUCT_PRODUCT_LIST', { C_CODE_GRP })
}

export async function INSERT_PRODUCT_PRODUCT(C_CODE_GRP: string, C_CODE: string) {
  return await http.data<number>('INSERT_PRODUCT_PRODUCT', { C_CODE_GRP, C_CODE })
}

export async function DELETE_PRODUCT_PRODUCT(data: ProductProduct) {
  return await http.data<number>('DELETE_PRODUCT_PRODUCT', { I_SEQ: data.I_SEQ })
}

export async function UPDATE_PRODUCT_PRODUCT_SORT(data: { list: ProductProduct[] }) {
  return await http.data<number>('UPDATE_PRODUCT_PRODUCT_SORT', data)
}

export async function SELECT_PRODUCT_TEMPLATE_LIST(data: ProductTemplate) {
  return await http.data<ProductTemplate[] | null>('SELECT_PRODUCT_TEMPLATE_LIST', {
    C_CODE: data.C_CODE || '',
    N_BRAND_NAME: data.N_BRAND_NAME || '',
    N_PRODUCT_NAME: data.N_PRODUCT_NAME || '',
    S_PWI: data.S_PWI || '',
  })
}

export async function SELECT_PRODUCT_TEMPLATE_EXISTS(C_CODE: string) {
  return await http.data<number>('SELECT_PRODUCT_TEMPLATE_EXISTS', { C_CODE })
}

export async function SELECT_PRODUCT_TEMPLATE(C_CODE: string | undefined | null) {
  return await http.data<ProductTemplate | null>('SELECT_PRODUCT_TEMPLATE', { C_CODE })
}

export async function INSERT_PRODUCT_TEMPLATE(data: ProductTemplate) {
  return await http.data<number>('INSERT_PRODUCT_TEMPLATE', data)
}

export async function UPDATE_PRODUCT_TEMPLATE(data: ProductTemplate) {
  return await http.data<number>('UPDATE_PRODUCT_TEMPLATE', data)
}

export async function DELETE_PRODUCT_TEMPLATE(data: ProductTemplate) {
  return await http.data<number>('DELETE_PRODUCT_TEMPLATE', { C_CODE: data.C_CODE })
}
