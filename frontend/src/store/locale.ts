import { defineStore } from 'pinia'

export const useLocaleStore = defineStore({
  id: 'locale',
  state: () => ({
    locale: 'ko-KR',
  }),
  getters: {
    getLocale(): string {
      return this.locale
    },
  },
  actions: {
    setLocale(locale: string) {
      this.locale = locale
    },
  },
})
