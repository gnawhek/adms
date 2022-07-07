import http from 'src/api/http'
import { CommonCode, ProductCategory } from 'src/types/domain/product'

export async function SELECT_PARTNER_LIST() {
  return await http.data<CommonCode[] | null>('SELECT_PARTNER_LIST')
}


