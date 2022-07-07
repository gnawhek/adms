import { defineStore } from 'pinia'
import { computed, ref } from 'vue'
import { useAuthStore } from 'src/store/auth'
import { AuthType, User } from 'src/types'
import { Staff } from 'src/types/domain/Staff'
import { useLocalStore } from 'src/store/local'

export const useStaffStore = defineStore(
  'staff-store',
  () => {
    const authStore = useAuthStore()
    const loginUser = ref<User | undefined | null>(authStore.loginUser)
    const staff = computed<Staff>(() => {
      return <Staff>{
        get isStaff() {
          return loginUser.value?.Y_STAFF == 'y'
        },
        get authority() {
          switch (loginUser.value?.C_LEVEL) {
            case AuthType.super.code:
              return AuthType.super
            case AuthType.operator.code:
              return AuthType.operator
            case AuthType.master.code:
              return AuthType.master
            case AuthType.manager.code:
              return AuthType.manager
          }
          return AuthType.customer
        },
        get isSuper() {
          return loginUser.value?.C_LEVEL === AuthType.super.code
        },
        get isOperator() {
          return loginUser.value?.C_LEVEL === AuthType.operator.code
        },
        get isMaster() {
          return loginUser.value?.C_LEVEL === AuthType.master.code
        },
        get isManager() {
          return loginUser.value?.C_LEVEL === AuthType.manager.code
        },
        get isCustomer() {
          return loginUser.value?.C_LEVEL == null || loginUser.value?.C_LEVEL.trim().length === 0
        },
      }
    })

    if (useLocalStore().isDevelopmentMode) {
      const win = window as any
      win['loginUser'] = loginUser
    }
    return {
      staff,
    }
  },
  {
    persistedState: {
      persist: false,
    },
  },
)
