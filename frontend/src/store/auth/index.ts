import { defineStore } from 'pinia'
import { computed, Ref, ref } from 'vue'
import { GlobalConstants, User } from 'src/types'
import jwt_decode from 'jwt-decode'

interface JWTPayload {
  exp: number
}

export const useAuthStore = defineStore(
  'auth-store',
  () => {
    const count = ref(0)
    const accessToken = ref()
    const refreshToken = ref()
    const saveId = ref()
    const savePassword = ref()
    const isSave = ref(false)
    const loginUser: Ref<User | undefined | null> = ref<User>()
    const customer: Ref<User | undefined | null> = ref<User>()
    const decodedAccessToken = ref()

    const reset = () => {
      accessToken.value = null
      refreshToken.value = null
    }

    const login = (user: User, token?: string) => {
      loginUser.value = user
      accessToken.value = token
      setCustomer(user)
    }

    const logout = () => {
      reset()
      loginUser.value = undefined
      setCustomer(null)
      // saveId.value = null;
      // savePassword.value = null;
    }

    const setCustomer = (user: User | null) => {
      customer.value = user
    }

    const getAccessToken = () => {
      return accessToken.value
    }

    const getRefreshToken = () => {
      return refreshToken.value
    }

    const setAccessToken = (token: string) => {
      accessToken.value = token
    }

    const setRefreshToken = (token: string) => {
      refreshToken.value = token
    }

    const isAuthenticated = () => getSecondsUntilExpired() > 0

    const decodeJWT = (token: string) => {
      const decoded = jwt_decode(token)
      if (!decoded) return undefined
      return decoded as JWTPayload
    }

    const getUnixTimestampSeconds = () => {
      return Math.round(new Date().getTime() / 1000)
    }

    const getSecondsUntilExpired = () => {
      const token = getAccessToken()
      if (!token) return 0
      const decoded = decodeJWT(token)
      if (!decoded) return 0
      return (decoded.exp - getUnixTimestampSeconds()) * 1000
    }

    const profileImage = computed(() => {
      return loginUser.value?.S_PIC_URL || require('assets/images/login/img_profile_square.png')
    })

    return {
      loginUser,
      customer,
      user: customer,
      profileImage,
      saveId,
      savePassword,
      isSave,
      accessToken,
      refreshToken,
      login,
      reset,
      logout,
      getAccessToken,
      getRefreshToken,
      setAccessToken,
      setRefreshToken,
      isAuthenticated,
      decodeJWT,
      getUnixTimestampSeconds,
      getSecondsUntilExpired,
      decodedAccessToken,
      isStaff() {
        return GlobalConstants.Y === loginUser.value?.Y_STAFF
      },
      toggleStaff() {
        if (loginUser.value) {
          loginUser.value.Y_STAFF = loginUser.value.Y_STAFF == 'y' ? 'n' : 'y'
        }
      },
      //이하 테스트 기능
      count,
      increment() {
        count.value++
      },
      doubleCount() {
        return count.value * 2
      },
    }
  },
  {
    persistedState: {
      persist: true,
    },
  },
)
