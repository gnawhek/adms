<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { RegisterDataType } from 'pages/login/LoginMemberRegister.vue'
import { useQuasar } from 'quasar'
import { computed, onMounted, ref } from 'vue'
import { isEmail } from 'src/utils'
import { SELECT_ZIP_CITY_LIST, SELECT_ZIP_STATE_LIST } from 'src/api/common-api'

const $q = useQuasar()
const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const props = defineProps<{ data: RegisterDataType }>()
const directInput = '직접입력'
const options = ['gmail.com', 'naver.com', 'daum.net', '163.com', 'qq.com', 'yahoo.com', 'sina.com.cn', 'hotmail.com', 'foxmail.com', directInput]
const zipStateOptions = ref<{ I_ZIP: number; N_STATE: string }[] | null>()
let zipCityOptions = ref<{ I_ZIP: number; N_CITY: string }[] | null>()
const mail1 = ref()
const mail2 = ref()
const mail3 = ref()
const isEmailDirect = ref(false)

if (props.data.newUser.S_EMAIL != null && props.data.newUser.S_EMAIL.indexOf('@') != -1) {
  isEmailDirect.value = true
  mail1.value = props.data.newUser.S_EMAIL.split('@')[0]
  mail3.value = props.data.newUser.S_EMAIL.split('@')[1]
}

onMounted(async () => {
  zipStateOptions.value = await SELECT_ZIP_STATE_LIST()
})

const changeModel = (value: string) => {
  if (directInput === value) {
    // console.log('직접 입력 모드로 변경')
    isEmailDirect.value = true
  }
}
const getEmail = () => {
  return mail1.value + '@' + (isEmailDirect.value ? mail3.value : mail2.value)
}
const checkEmail = computed(() => {
  return isEmail(getEmail())
})
const I_ZIP = ref()
const I_ZIPCODE = ref<{ N_CITY: string; I_ZIP: number } | null>()
const changeZipState = async (value: any) => {
  I_ZIPCODE.value = null
  zipCityOptions.value = await SELECT_ZIP_CITY_LIST(I_ZIP.value.I_ZIP)
}

function next() {
  props.data.newUser.S_EMAIL = getEmail()
  if (I_ZIPCODE.value != null) {
    props.data.newUser.I_ZIPCODE = I_ZIPCODE.value?.I_ZIP
  }
  props.data.onNext(8)
}
</script>

<template>
  <!-- 기타정보 -->
  <div class="column col">
    <div class="column q-mt-lg">
      <div class="fieldLabel">이메일<span class="required">*</span></div>
      <div class="row">
        <!-- prettier-ignore -->
        <q-input
          outlined
          autocomplete="username"
          v-model="mail1"
          lazy-rules
          class="col-7"
          placeholder="이메일 입력"
        >
          <template v-slot:after>
            <div class="after">@</div>
          </template>
        </q-input>
        <q-select v-if="!isEmailDirect" outlined v-model="mail2" :options="options" label="선택" class="col" @update:model-value="changeModel" />
        <!-- prettier-ignore -->
        <q-input v-else
          outlined
          autocomplete="email"
          v-model="mail3"
          lazy-rules
          class="col-5"
          placeholder="입력"
        >
          <template v-slot:append>
            <q-icon
              name="close"
              class="cursor-pointer"
              @click="isEmailDirect = false"
            />
          </template>
        </q-input>
      </div>
    </div>
    <div class="column q-mt-lg">
      <div class="fieldLabel">주소(선택)</div>
      <q-select outlined v-model="I_ZIP" :options="zipStateOptions" label="광역시/도" class="col" @update:model-value="changeZipState" option-value="I_ZIP" option-label="N_STATE" />
      <q-select outlined v-model="I_ZIPCODE" :options="zipCityOptions" label="시/군/구" option-value="I_ZIP" option-label="N_CITY" class="col q-mt-sm" />
    </div>
    <div class="column q-mt-xl">
      <q-btn label="다음" flat class="q-my-sm q-py-sm apply-button" @click="next" :disable="!checkEmail" />
    </div>
  </div>
</template>

<style lang="sass" scoped>
@import "register"
//$
::v-deep(.q-field)
  .q-field__after
    padding: 0 5px
    font-family: Roboto
    font-size: 20px
    font-weight: bold
    color: #b3b3b3
</style>
