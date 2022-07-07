import { defineStore } from 'pinia'
import { ref } from 'vue'
import { SYS_CODE } from 'src/types'
import { SELECT_ALG_TS_TYPE_LIST, SELECT_ALG_SEX_LIST, SELECT_PWI_AGE_LIST, SELECT_PWI_TYPE_LIST, SELECT_ALG_RESULT_UI_LIST } from 'src/api/admin-api'

export const useCodeStore = defineStore(
  'code-store',
  () => {
    const sexuality = ref<SYS_CODE[]>()
    const ages = ref<SYS_CODE[]>()
    const pwiTypes = ref<[SYS_CODE[]]>()
    const algTsTypes = ref<SYS_CODE[]>()
    const algTsUiTypes = ref<SYS_CODE[]>()
    const weeks = ['ALL', 'SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']

    return {
      sexuality: async () => {
        if (sexuality.value == null) {
          sexuality.value = await SELECT_ALG_SEX_LIST()
        }
        return sexuality.value
      },
      ages: async () => {
        if (ages.value == null) {
          ages.value = await SELECT_PWI_AGE_LIST()
        }
        return ages.value
      },
      pwiTypes: async () => {
        if (pwiTypes.value == null) {
          pwiTypes.value = await SELECT_PWI_TYPE_LIST()
        }
        return pwiTypes.value
      },
      algTsTypes: async () => {
        if (algTsTypes.value == null) {
          algTsTypes.value = await SELECT_ALG_TS_TYPE_LIST()
        }
        return algTsTypes.value
      },
      algTsUiTypes: async () => {
        if (algTsUiTypes.value == null) {
          algTsUiTypes.value = await SELECT_ALG_RESULT_UI_LIST()
        }
        return algTsUiTypes.value
      },
      weeks: () => {
        return weeks.map((v, k) => <SYS_CODE>{index: k, C_CODE: v, N_CODE: v })
      },
    }
  },
  {
    persistedState: {
      persist: false,
    },
  },
)
