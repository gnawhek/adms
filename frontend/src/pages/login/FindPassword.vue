<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { GlobalConstants, i18n, PopupDrawer, User } from 'src/types'
import { ref } from 'vue'
import { useQuasar } from 'quasar'
import { idExists, newPassword } from 'src/api/member-api'

const $q = useQuasar()
const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const props = defineProps<{ currentPopup?: PopupDrawer | null}>()

const isAuthentication = ref(false)
const findUser = ref<User>(<User>{ I_ID: undefined, password: undefined, confirmPassword: undefined })
const user = ref(<User>{ I_ID: props.currentPopup?.params })

const done = () => {
  isAuthentication.value = true
  props.currentPopup?.setTitle('신규비밀번호 설정')
}

const onFindSubmit = async () => {
  // const result = await idExistsService(user.value.I_ID as string)
  const result = await idExists(user.value.I_ID as string)
  if (result.COUNT > 0) {
    findUser.value = <User>{
      I_ID: user.value.I_ID,
      password: null,
      confirmPassword: null,
    }
  } else {
    $q.notify({
      color: 'red-3',
      textColor: 'white',
      icon: 'cloud_done',
      message: '아이디를 확인해주세요.',
    })
  }
}

const onSubmit = async () => {
  const result = await newPassword(findUser.value.I_ID as string, findUser.value.password as string)
  if (result >= 0) {
    $q.notify({
      color: 'green-4',
      textColor: 'white',
      icon: 'cloud_done',
      message: '비밀번호 변경 완료',
    })
    if (props.currentPopup != null) {
      props.currentPopup.closeDrawer()
    }
  } else {
    $q.notify({
      color: 'red-3',
      textColor: 'white',
      icon: 'cloud_done',
      message: '비밀번호를 변경하지 못했습니다.',
    })
  }
}
</script>

<template>
  <PopupHeader v-if="currentPopup != null" :currentPopup="currentPopup" />
  <div class="panel">
    <!--        <q-btn label="창닫기" type="button" flat @click="close" />-->
    <div v-if="isAuthentication">
      <q-form @submit="onSubmit" class="q-gutter-md col column">
        <div class="idLabel">새로운 비밀번호</div>
        <!-- prettier-ignore -->
        <q-input
            outlined
            type="password"
            autocomplete="current-password"
            v-model="findUser.password"
            lazy-rules
            :rules="[
                (val) => (val !== null && val !== undefined && val !== '') || $t(i18n.login.password.rules1),
                (val) => (val !== null && val !== undefined && val.length >= GlobalConstants.maxPasswordLength) || $t(i18n.login.password.rules2, {maxPasswordLength: GlobalConstants.maxPasswordLength}),
              ]"
            placeholder="새로운 비밀번호"
            hint="숫자, 영문, 특수문자 조합 8자 이상으로 입력해주세요."
          />
        <!--        <div class="tooltip">숫자, 영문, 특수문자 조합 8자 이상으로 입력해주세요.</div>-->
        <!-- prettier-ignore -->
        <q-input
            outlined
            type="password"
            autocomplete="current-password"
            v-model="findUser.confirmPassword"
            lazy-rules
            :rules="[
                (val) => (val !== null && val !== undefined && val !== '') || $t(i18n.login.password.rules1),
                (val) => (val !== null && val !== undefined && val.length >= GlobalConstants.maxPasswordLength) || $t(i18n.login.password.rules2, {maxPasswordLength: GlobalConstants.maxPasswordLength}),
                (val) => (val !== null && val !== undefined && val === findUser.password) || $t(i18n.login.password.rules3),
              ]"
            placeholder="새로운 비밀번호 확인"
            hint="위에 입력한 비밀번호와 동일하게 입력해주세요."
          />
        <!--        <div class="tooltip">위에 입력한 비밀번호와 동일하게 입력해주세요.</div>-->
        <q-btn :label="$t(i18n.common.confirm)" type="submit" flat class="q-my-sm q-py-sm login-button" style="margin-top: 40px" />
      </q-form>
    </div>
    <div v-else-if="findUser.I_ID != undefined" class="column col absolute-center message">
      <div class="message">PASS 인증 하기</div>
      <q-btn label="인증 완료" flat class="q-my-sm q-py-sm login-button" @click="done" />
    </div>
    <div v-else>
      <q-form @submit="onFindSubmit">
        <div class="column">
          <div class="idLabel">아이디</div>
          <!-- prettier-ignore -->
          <q-input
            outlined
            autocomplete="username"
            v-model="user.I_ID"
            :hint="$t('login.id.hint')"
            lazy-rules
            :rules="[
              (val) => (val !== undefined && val !== '') || $t(i18n.login.id.rules1),
              (val) => (val !== undefined && val.length >= GlobalConstants.maxIdLength) || $t(i18n.login.id.rules2, {maxIdLength: GlobalConstants.maxIdLength})
              ]"
          />
          <q-btn label="비밀번호 찾기" type="submit" flat class="q-my-sm q-py-sm login-button" style="margin-top: 40px" />
        </div>
      </q-form>
    </div>
  </div>
</template>

<style lang="sass" scoped>
.panel
  padding: 20px

.message
  color: $v-gray5

.login-button
  color: $login-color2
  background: $login-color1

.idLabel
  font-size: 14px
  color: #141414
  margin-bottom: 10px

.idInput
  padding: 15px 5px
  border: 1px solid rgba(0, 0, 0, 0.24)
  font-size: 16px
  color: #141414

.tooltip
  font-size: 12px
  min-height: 20px
  line-height: 1
  color: rgba(0, 0, 0, 0.54)
  padding: 0 12px 0
</style>
