import { store } from 'quasar/wrappers'
import { createPinia, defineStore } from 'pinia'
import { createPersistedStatePlugin } from 'pinia-plugin-persistedstate-2'
// // @ts-ignore
import SecureLS from 'secure-ls'
import { ref } from 'vue'

export const storeKey = 'store'
export const useStore = defineStore(
  storeKey,
  () => {
    const count = ref(0)
    return {
      storeKey: storeKey,
      count,
    }
  },
  {
    persistedState: {
      persist: true,
    },
  },
)

export function createStore() {
  const store = createPinia()
  let persistedStatePlugin = null
  if (process.env.PROD) {
    const ls = new SecureLS({
      encodingType: 'aes',
      isCompression: true,
      encryptionSecret: 'dma-secret',
    })
    persistedStatePlugin = createPersistedStatePlugin({
      storage: {
        getItem(key): any {
          return ls.get(key)
        },
        setItem: (key, value) => ls.set(key, value),
        removeItem: (key) => ls.remove(key),
      },
    })
  }
  store.use(persistedStatePlugin ?? createPersistedStatePlugin())
  return store
}

export default store(function (/* { ssrContext } */) {
  return createStore()
})
