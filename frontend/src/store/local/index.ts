import { defineStore } from 'pinia'
import { ref, watch } from 'vue'
import { IResizeObserver } from 'src/types'
export * from './code'

export const useLocalStore = defineStore(
  'local-store',
  () => {
    const HeaderSize = ref<IResizeObserver>({ width: 0, height: 51 })

    // watch(HeaderSize, (newValue) => {
    //   console.log('HeaderSize', newValue);
    // })

    return {
      isShowMainLayout: ref(false),
      isDevelopmentMode: process.env.NODE_ENV !== 'production',
      isProductionMode: process.env.NODE_ENV === 'production',
      HeaderSize,
    }
  },
  {
    persistedState: {
      persist: false,
    },
  },
)
