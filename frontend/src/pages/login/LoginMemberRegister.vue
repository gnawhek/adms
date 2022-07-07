<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { PopupDrawer } from 'src/types'
import { computed, ref } from 'vue'
import { usePopupStore } from 'src/store/popup'
import { menuToComponent } from 'src/utils'
import { useQuasar } from 'quasar'

const $q = useQuasar()
const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()
const props = defineProps<{ currentPopup?: PopupDrawer | null }>()

interface NewUser {
  Y_VERIFICATION: string
  C_SHOP: number
  I_RECOMM_CODE: string
  N_NAME: string
  I_HP: string
  YEAR: number | string
  MONTH: number | string
  DAY: number | string
  C_SEX: string
  CELL_NAME: string
  PROFILE: string
  I_ID: string
  password: string
  confirmPassword: string
  I_HEIGHT: string
  I_WEIGHT: string
  S_EMAIL: string
  I_ZIPCODE: number | null
  Y_PRIVACY: string
  Y_MARKETING: string
  Y_PUSH: string
  Y_EMAIL: string
}

export interface RegisterDataType {
  currentPopup?: PopupDrawer | null
  onNext: (value: number) => void
  hp?: string | null
  user: { I_ID: string; N_NAME: string; D_REG_DT: number } | null | undefined
  code?: string | null
  newUser: NewUser
}

const views = [
  { index: 0, label: '본인인증', component: 'login/register/0Confirm.vue' },
  { index: 1, label: 'PASS인증', component: 'login/register/1Pass.vue' },
  { index: 2, label: '회원가입', component: 'login/register/2RegisteredUser.vue' },
  { index: 3, label: '추천코드', component: 'login/register/3Recomm.vue' },
  { index: 4, label: '기본정보입력', component: 'login/register/4BasicInfo.vue' },
  { index: 5, label: '아이디/비밀번호', component: 'login/register/5IdPw.vue' },
  { index: 6, label: '신체정보 입력', component: 'login/register/6BodyInfo.vue' },
  { index: 7, label: '기타정보', component: 'login/register/7EtcInfo.vue' },
  { index: 8, label: '약관동의', component: 'login/register/8Agreement.vue' },
]
const step = ref(0)
const data = ref({
  currentPopup: props.currentPopup,
  onNext: (value: number) => {
    nextStep(value)
  },
  hp: null,//'010-6299-400',
  user: null,
  code: null,//'mad73f907f',
  codeResult: null,
  newUser: <NewUser>{
    // C_SEX: 'm',
    // C_SHOP: 100000,
    // I_RECOMM_CODE: 'mad73f907f',
    // N_NAME: '홍길동',
    // I_HP: '123-4123-4123',
    // YEAR: '1999',
    // MONTH: '5',
    // DAY: '10',
    // CELL_NAME: 'CellName',
    // I_ID: 'testid',
    // password: '12341234',
    // confirmPassword: '12341234',
    // I_HEIGHT: '123',
    // I_WEIGHT: '22.3',
    // S_EMAIL: 'email@gmail.com',
    // I_ZIPCODE: 30170,
    // Y_PRIVACY: 'y',
    // Y_MARKETING: 'y',
    // Y_PUSH: 'y',
    // Y_EMAIL: 'y',
    // PROFILE: 'data:image/png;base64,...',
  },
} as RegisterDataType)

const nextStep = (value: number) => {
  let view = views[value]
  props.currentPopup?.setTitle(view.label)
  step.value = value
}
const currentComponent = computed(() => menuToComponent(views[step.value].component))
</script>

<template>
  <div class="panel column col">
    <component :is="currentComponent" :data="data" />
    <!--    <pre style="width: 360px; overflow: auto">{{ data }}</pre>-->
  </div>
</template>

<style lang="sass" scoped>
.panel
  padding: 20px
</style>
