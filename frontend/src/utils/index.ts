import { date } from 'quasar'
import { DataPage, SYS_CODE } from 'src/types'
// import { useI18n } from 'vue-i18n'
import tools from 'src/utils/tools'
import { i18nApi } from 'boot/i18n'

export function $t(value: string): string {
  const i18n = i18nApi.i18n
  return i18n.global.t(value) || value
  // return useI18n().t(value) || value
}

export function menuToName(path: string): string {
  // @ts-ignore
  return $t(`menus${path.replaceAll('/', '.')}`)
}

export const componentsToImportVue = (component: string | undefined) => {
  return tools.componentsToImportVue(component as string)
}

export const menuToComponent = (component: string | undefined) => {
  return tools.menuToComponent(component as string, false)
}

export const menuDevToComponent = (component: string | undefined) => {
  return tools.menuToComponent(component as string, true)
}

export const menuToImportVue = (component: string | undefined) => {
  return tools.menuToImportVue(component as string, false)
}

export const menuDevToImportVue = (component: string | undefined) => {
  return tools.menuToImportVue(component as string, true)
}

export function getStartNumber(page: DataPage<any>): number {
  return (page.totalPages - page.number) * page.size - (page.totalPages * page.size - page.totalElements)
}

export function formatDateTime(dateTime?: string, formatStr?: string): string {
  return dateTime == null ? '' : date.formatDate(date.extractDate(dateTime, 'YYYY-MM-DDTHH:mm:ss'), formatStr ? formatStr : 'YYYY-MM-DD HH:mm:ss')
}

export function formatDateTimeToString(dateTime?: number, formatStr?: string): string {
  return dateTime == null ? '' : date.formatDate(new Date(dateTime), formatStr ? formatStr : 'YYYY-MM-DD HH:mm:ss')
}

export function formatDateTimeToYYYYMMDD(dateTime?: number, join = '-'): string {
  return formatDateTimeToString(dateTime, `YYYY${join}MM${join}DD`)
}

export function formatDateTimeToYYYYMMDDHHmmss(dateTime?: number, join = '-'): string {
  return formatDateTimeToString(dateTime, `YYYY${join}MM${join}DD HH:mm:ss`)
}

export function formatContentDateTime<T>(page: DataPage<T>, key: string, formatStr?: string): void {
  if (page && page.content) {
    page.content.forEach((record: any) => {
      if (record[key]) {
        record[key] = formatDateTime(record[key], formatStr)
      }
    })
  }
}

export function setRowNumbers<T>(page: DataPage<T>, key = 'number'): void {
  if (page && page.content) {
    let startNumber = getStartNumber(page)
    page.content.forEach((record: any) => {
      record[key] = startNumber--
    })
  }
}

export function replaceAll(str: string, searchStr: string, replaceStr: string): string {
  return str == null ? '' : str.split(searchStr).join(replaceStr)
}

export function isEmail(str: string) {
  const reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/
  if (!reg_email.test(str)) {
    return false
  } else {
    return true
  }
}

export function isURL(str: string | null) {
  const urlRegex =
    '^(?!mailto:)(?:(?:http|https|ftp)://)(?:\\S+(?::\\S*)?@)?(?:(?:(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}(?:\\.(?:[0-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))|(?:(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)(?:\\.(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)*(?:\\.(?:[a-z\\u00a1-\\uffff]{2,})))|localhost)(?::\\d{2,5})?(?:(/|\\?|#)[^\\s]*)?$'
  const url = new RegExp(urlRegex, 'i')
  return str != null && str.length < 2083 && url.test(str)
}

export function sysCodeToValues(values: SYS_CODE[]): string {
  const items = [...values].sort((a: any, b: any) => a.index - b.index)
  return items.map((d) => d.C_CODE).join(';')
}
