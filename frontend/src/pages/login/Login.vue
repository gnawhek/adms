<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { computed, reactive, ref, provide } from 'vue'
import { useQuasar } from 'quasar'
import { loginData, loginForm, signin } from 'src/api/auth-api'
import { GlobalConstants, i18n, User, ViewPages } from "src/types";
import { useLocalStore } from 'src/store/local'
import { usePopupStore } from 'src/store/popup'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()
const user = reactive<User>({
  I_ID: undefined,
  password: undefined,
} as User)
const isSave = ref(authStore.isSave)

if (!useLocalStore().isShowMainLayout) {
  Object.assign(user, {
    I_ID: authStore.saveId,
    password: authStore.savePassword,
  })
}

const $q = useQuasar()

// window['$store'] = $store;
// window['authStore'] = authStore;

const loginApply = () => {
  let save = isSave.value
  authStore.isSave = save
  authStore.saveId = save ? user.I_ID : undefined
  authStore.savePassword = save ? user.password : undefined

  router.push({ path: '/' })
}

const logoImage = computed(() => {
  return require('assets/images/login/logo.png')
})

const onSubmit = async () => {
  if (false && isSave.value !== true) {
    $q.notify({
      color: 'red-5',
      textColor: 'white',
      icon: 'warning',
      message: '아이디 저장을 선택하지 않았습니다. [테스트 기능 삭제 예정]',
    })
  } else {
    //await loginDummy(user.I_ID as string, user.password as string)
    //await loginForm(user.I_ID as string, user.password as string)
    await signin(user.I_ID as string, user.password as string)
    //await loginData(user.I_ID as string, user.password as string)

    if (authStore.getAccessToken() != undefined) {
      $q.notify({
        color: 'green-4',
        textColor: 'white',
        icon: 'cloud_done',
        message: '로그인됨',
      })
      loginApply()
    } else {
      $q.notify({
        color: 'red-3',
        textColor: 'white',
        icon: 'cloud_done',
        message: '로그인 정보를 확인해주세요.',
      })
    }
  }
}

function onReset() {
  user.I_ID = undefined
  user.password = undefined
  isSave.value = false
}

const memberRegister = () => {
  popupStore.newPopup(ViewPages.LoginMemberRegister)
}

const findId = () => {
  popupStore.newPopup(ViewPages.FindId)
}

const findPassword = () => {
  popupStore.newPopup(ViewPages.FindPassword)
}
</script>

<!--
[레이아웃 참고]
Layout Builder
https://quasar.dev/layout-builder

CSS Spacing Classe
https://quasar.dev/style/spacing

Flexbox
https://quasar.dev/layout/grid/introduction-to-flexbox

CSS Positioning Classes
https://quasar.dev/style/positioning

Color Palette
https://quasar.dev/style/color-palette

Quasar Icon Sets
https://quasar.dev/options/quasar-icon-sets
https://fonts.google.com/icons?selected=Material+Icons&icon.query=back

Dynamic Translate using vue-i18n
https://medium.com/hong-kong-tech/dynamic-translate-using-vue-i18n-vuejs-c730093a63e2
-->
<template>
  <div class="panel column no-wrap">
    <div class="column col-2" />

    <div class="row col justify-center">
      <div class="login-panel column col">
        <div class="column items-center justify-center q-mb-xl">
          <img src="images/login/logo.png" />
          <!--          public/images-->
          <!--          <img src='~/assets/images/login/logo.png'>-->
          <!--          ~/assets/images-->
          <!--          <img :src='logoImage'>-->
          <!--          Asset Paths in JavaScript-->
        </div>
        <div class="column">
          <q-form @submit="onSubmit" @reset="onReset" class="q-gutter-md col">
            <q-input
              outlined
              autocomplete="username"
              v-model="user.I_ID"
              :label="$t(i18n.login.id.label)"
              :hint="$t(i18n.login.id.hint)"
              lazy-rules
              :rules="[
                (val) => (val && val.length > 0) || $t(i18n.login.id.rules1),
                (val) => (val && val.length >= GlobalConstants.maxIdLength) || $t(i18n.login.id.rules1)
              ]"
            />

            <!-- prettier-ignore -->
            <q-input
              outlined
              type="password"
              autocomplete="current-password"
              v-model="user.password"
              :label="$t(i18n.login.password.label)"
              lazy-rules
              :rules="[
                (val) => (val !== null && val !== undefined && val !== '') || $t(i18n.login.password.rules1),
                // (val) => (val !== undefined && val.length >= GlobalConstants.maxPasswordLength) || $t(i18n.login.password.rules2, {maxPasswordLength: GlobalConstants.maxPasswordLength}),
              ]"
            />

            <q-toggle v-model="isSave" :label="$t('login.isSave')" />
            <!--            <q-checkbox size="xs" v-model="isSave" val="xs" :label="$t('login.isSave')" />-->

            <div class="column">
              <q-btn label="로그인" type="submit" flat class="q-my-sm q-py-sm login-button" />
              <q-btn label="회원가입" type="button" outline class="q-py-sm register-button" @click="memberRegister" />
            </div>
            <div class="search row items-center justify-center">
              <q-btn label="아이디 찾기" type="button" flat @click="findId" />
              <q-separator vertical inset class="q-mx-md" />
              <q-btn label="비밀번호 찾기" type="button" flat @click="findPassword"/>
            </div>
          </q-form>
        </div>
        <div class="column col justify-center q-mt-sm">
          <q-btn type="button" flat class="q-mb-xl q-py-sm kakao-button">
            <div class="row items-center no-wrap">
              <img src="~/assets/images/login/img_kakao_login.png" />
              <div class="text-center q-mx-sm">카카오 로그인</div>
            </div>
          </q-btn>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
$search-color: #666666

.panel
  height: 100vh

  .login-panel
    max-width: 350px

    .login-button
      color: $login-color2
      background: $login-color1

    .register-button
      color: $login-color1

    .search
      color: $search-color
      font-size: 12px

    .kakao-button
      color: $kakao-color
      background: $login-color3
      font-size: 14px
      font-weight: 500
</style>
