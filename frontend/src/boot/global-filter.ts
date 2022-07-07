import { boot } from 'quasar/wrappers'
import { formatDateTimeToYYYYMMDD, formatDateTimeToYYYYMMDDHHmmss } from 'src/utils'

export default boot(({ app }) => {
  app.config.globalProperties.$filters = {
    YYYYMMDD(value?: number, join = '.') {
      return formatDateTimeToYYYYMMDD(value, join)
    },
    YYYYMMDDHHmmss(value?: number, join = '.') {
      return formatDateTimeToYYYYMMDDHHmmss(value, join)
    },
    _YYYYMMDD(value?: number, join = '-') {
      return formatDateTimeToYYYYMMDD(value, join)
    },
    _YYYYMMDDHHmmss(value?: number, join = '-') {
      return formatDateTimeToYYYYMMDDHHmmss(value, join)
    },
  }
})
