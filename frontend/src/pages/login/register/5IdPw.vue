<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { RegisterDataType } from 'pages/login/LoginMemberRegister.vue'
import { useQuasar } from 'quasar'
import { GlobalConstants, i18n, User } from 'src/types'
import { computed, ref } from 'vue'
import { $t } from 'src/utils'
import { idExists } from 'src/api/member-api'

const $q = useQuasar()
const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const props = defineProps<{ data: RegisterDataType }>()
const idCheck = ref<boolean | null>(null)
const currentId = ref()
const idConfirm = async () => {
  const id = props.data.newUser.I_ID
  if (id == null || id.length < GlobalConstants.maxIdLength) {
    return
  }
  currentId.value = null
  const result = await idExists(id)
  idCheck.value = result.COUNT === 0
  if (idCheck.value) {
    currentId.value = id
    $q.notify({
      color: 'green-4',
      textColor: 'white',
      icon: 'cloud_done',
      message: '사용 가능한 아이디입니다.',
    })
  } else {
    $q.notify({
      color: 'red-3',
      textColor: 'white',
      icon: 'cloud_done',
      message: '사용할 수 없는 아이디입니다.',
    })
  }
}
const IsConfirmId = computed(() => {
  return idCheck.value && currentId.value === props.data.newUser.I_ID
})
const getIdHint = computed(() => {
  if (IsConfirmId.value) {
    return '사용 가능한 아이디입니다.'
  }
  return $t(i18n.login.id.hint2)
})
const isPwd = ref(true)
</script>

<template>
  <!-- 아이디/비밀번호 -->
  <div class="column col">
    <div class="column q-mt-lg">
      <div class="fieldLabel">아이디<span class="required">*</span></div>
      <div class="row">
        <!-- prettier-ignore -->
        <q-input
          spellcheck="false"
          outlined
          autocomplete="username"
          v-model="data.newUser.I_ID"
          :hint="getIdHint"
          lazy-rules
          :rules="[
              (val) => (val && val.length > 0) || $t(i18n.login.id.rules1),
              (val) => (val && val.length >= GlobalConstants.maxIdLength) || $t(i18n.login.id.rules2, {maxIdLength: GlobalConstants.maxIdLength})
            ]"
          class="col"
          placeholder="아이디를 입력해주세요"
          style="ime-mode:disabled;"
          mask='xxxxxxxxxxxxxxxx'
          @keyup.enter="idConfirm"
          />
        <q-btn
          label="중복확인"
          flat
          class="q-ml-xs apply-button"
          @click="idConfirm"
          :disable="(data.newUser.I_ID || '').length < GlobalConstants.maxIdLength"
          style="margin-bottom: 20px"
        />
      </div>
    </div>
    <div class="fieldLabel" style="margin-top: 20px">비밀번호<span class="required">*</span></div>
    <div class="fieldPanel">
      <!-- prettier-ignore -->
      <q-input
        outlined
        :type="isPwd ? 'password' : 'text'"
        autocomplete="current-password"
        v-model="data.newUser.password"
        lazy-rules
        :rules="[
                (val) => (val !== null && val !== undefined && val !== '') || $t(i18n.login.password.rules1),
                (val) => (val !== null && val !== undefined && val.length >= GlobalConstants.maxPasswordLength) || $t(i18n.login.password.rules2, {maxPasswordLength: GlobalConstants.maxPasswordLength}),
              ]"
        placeholder="비밀번호"
        hint="숫자, 영문, 특수문자 조합 8자 이상으로 입력해주세요."
      >
        <template v-slot:append>
          <q-icon
            :name="isPwd ? 'visibility_off' : 'visibility'"
            class="cursor-pointer"
            @click="isPwd = !isPwd"
          />
        </template>
      </q-input>
    </div>
    <div class="fieldPanel">
      <!-- prettier-ignore -->
      <q-input
        outlined
        :type="isPwd ? 'password' : 'text'"
        autocomplete="current-password"
        v-model="data.newUser.confirmPassword"
        lazy-rules
        :rules="[
                (val) => (val !== null && val !== undefined && val !== '') || $t(i18n.login.password.rules1),
                (val) => (val !== null && val !== undefined && val.length >= GlobalConstants.maxPasswordLength) || $t(i18n.login.password.rules2, {maxPasswordLength: GlobalConstants.maxPasswordLength}),
                (val) => (val !== null && val !== undefined && val === data.newUser.password) || $t(i18n.login.password.rules3),
              ]"
        placeholder="비밀번호 확인"
        hint="위에 입력한 비밀번호와 동일하게 입력해주세요."
      >
        <template v-slot:append>
          <q-icon
            :name="isPwd ? 'visibility_off' : 'visibility'"
            class="cursor-pointer"
            @click="isPwd = !isPwd"
          />
        </template>
      </q-input>
    </div>
    <div class="column">
      <q-btn
        label="다음"
        flat
        class="q-my-sm q-py-sm apply-button"
        @click="data.onNext(6)"
        :disable="
          !IsConfirmId || (data.newUser.confirmPassword || '').length < GlobalConstants.maxPasswordLength || data.newUser.password !== data.newUser.confirmPassword
        "
      />
    </div>
  </div>
</template>

<style lang="sass" scoped>
@import "register"
//$
.fieldPanel
  margin-bottom: 10px
</style>
