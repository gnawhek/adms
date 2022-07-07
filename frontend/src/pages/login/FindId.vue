<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { PopupDrawer, User, ViewPages } from 'src/types'
import { ref, inject, provide, Ref } from 'vue'
import { usePopupStore } from 'src/store/popup'
import { findLoginId, idExists } from 'src/api/member-api'
import { useQuasar } from 'quasar'
import { replaceAll } from 'src/utils'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()
const props = defineProps<{ currentPopup?: PopupDrawer | null }>()

const headerExpose = ref<any>(undefined)
const close = () => {
  headerExpose.value.close()
}

const myVariableThatIWantToProvide = ref(props.currentPopup?.title)
provide('myVariableThatIWantToProvide', myVariableThatIWantToProvide)

const $q = useQuasar()
const isAuthentication = ref(false)
const user: Ref<{ I_ID: string; N_NAME: string; D_REG_DT: number } | null | undefined> = ref()
const hp = ref()

const getFindLoginId = async () => {
  const I_HP = replaceAll(hp.value, '-', '')
  user.value = await findLoginId(I_HP)
  if (user.value?.I_ID != null) {
    isAuthentication.value = true
  } else {
    $q.notify({
      color: 'red-3',
      textColor: 'white',
      icon: 'cloud_done',
      message: '인증 실패',
    })
  }
}

const findPassword = () => {
  popupStore.newPopupParam(ViewPages.FindPassword, user.value?.I_ID)
  popupClose(500, () => {})
}

const popupClose = (timeout = 500, callback?: () => void) => {
  props.currentPopup?.closeDrawer(timeout, callback)
}
</script>

<template>
  <PopupHeader v-if="currentPopup != null" :currentPopup="currentPopup" ref="headerExpose" />
  <div class="panel column col">
    <!--        <q-btn label="창닫기" type="button" flat @click="close" />-->
    <div v-if="!isAuthentication" class="column col absolute-center message">
      <!-- prettier-ignore -->
      <q-input
        outlined
        autocomplete="hp"
        v-model="hp"
        hint="전화번호 입력"
        lazy-rules
      />
      <q-btn label="인증 완료" flat class="q-my-sm q-py-sm password-button" @click="getFindLoginId" />
    </div>
    <div class="column col" v-else>
      <div class="column items-center justify-center" style="white-space: pre-line; height: 200px; font-size: 20px; font-weight: 500; color: #444">{{ `아이디 찾기가 \n완료되었습니다.` }}</div>
      <div class="column items-center justify-center" style="height: 82px; border-radius: 4px; background-color: #f6f6f6">
        <div>{{ user?.I_ID }} ({{ user?.N_NAME }})</div>
      </div>
      <div class="column items-center q-mt-sm" style="font-size: 12px; color: #b3b3b3">가입일: {{ $filters.YYYYMMDD(user?.D_REG_DT) }}</div>
      <div class="col"></div>
      <div class="column">
        <q-btn label="비밀번호 찾기" flat class="q-my-sm q-py-sm password-button" @click="findPassword" />
        <q-btn label="로그인하러 가기" flat class="q-my-sm q-py-sm login-button" @click="popupClose" />
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
.panel
  padding: 20px

.message
  color: $v-gray5

.password-button
  color: $login-color2
  background: $login-color1

.login-button
  color: $login-color1

.idLabel
  font-size: 14px
  color: #141414
  margin-bottom: 10px

.idInput
  padding: 15px 5px
  border: 1px solid rgba(0, 0, 0, 0.24)
  font-size: 16px
  color: #141414
</style>
