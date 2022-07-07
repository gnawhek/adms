import { boot } from 'quasar/wrappers'
import { createI18n } from 'vue-i18n'

import messages from 'src/i18n'
import { useLocaleStore } from 'src/store/locale'

const i18nApi: {i18n: any} = {i18n: null};
export default boot(({ app }) => {
  // const lang = app.config.globalProperties.$q.lang;
  // const defaultLocale = lang.isoName;

  const localeStore = useLocaleStore()
  const defaultLocale = localeStore.getLocale

  i18nApi.i18n = createI18n({
    locale: defaultLocale,
    fallbackLocale: defaultLocale,
    messages,
  })

  // Set i18n instance on app
  app.use(i18nApi.i18n)
})

export { i18nApi }
