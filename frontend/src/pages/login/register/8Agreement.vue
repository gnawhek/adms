<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { RegisterDataType } from 'pages/login/LoginMemberRegister.vue'
import { useQuasar } from 'quasar'
import { watch, ref, watchEffect } from 'vue'
import { EventType, ViewPages } from 'src/types'
import { usePopupStore } from 'src/store/popup'
import { NewMemberRegister } from 'src/api/member-api'
import { emitter } from 'boot/EventBus'
import { formatDateTimeToYYYYMMDD, replaceAll } from 'src/utils'
import dialog from 'src/utils/dialog'

const $q = useQuasar()
const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()
const props = defineProps<{ data: RegisterDataType }>()

const allCheck = ref('n')
const requiredCheck = ref(false)
const requiredGroup = ref([''])
const optionGroup = ref([''])
const requiredOptions = [
  {
    value: 'required1',
    label: '[필수] 서비스 이용약관',
  },
  {
    value: 'required2',
    label: '[필수] 셀 이용약관',
  },
  {
    value: 'required3',
    label: '[필수] 개인정보 취급방침',
  },
  {
    value: 'required4',
    label: '[필수] 민감정보 취급방침',
  },
  {
    value: 'required5',
    label: '[필수] 개인정보 제 3자 제공 및 활용',
  },
]

const options = [
  {
    value: 'Y_MARKETING',
    label: '[선택] 마케팅 정보 수신',
  },
  {
    value: 'Y_PUSH',
    label: '[선택] 알림 설정',
  },
  {
    value: 'Y_EMAIL',
    label: '[선택] 이메일 수신',
  },
]

const onAllCheck = () => {
  if (allCheck.value == 'n') {
    requiredGroup.value = []
    optionGroup.value = []
  } else {
    requiredGroup.value = requiredOptions.map((d) => d.value)
    optionGroup.value = options.map((d) => d.value)
  }
}

watchEffect(() => {
  allCheck.value = requiredOptions.length + options.length - (requiredGroup.value.length + optionGroup.value.length) == 0 ? 'y' : 'n'
  requiredCheck.value = requiredOptions.length - requiredGroup.value.length == 0
})

const showTerms = (opt: any) => {
  popupStore.newPopupParam(ViewPages.TermsConditions, opt)
}

const close = () => {
  props.data.currentPopup?.closeDrawer()
}

const apply = async () => {
  console.log('회원 가입 완료')

  props.data.newUser.Y_PRIVACY = 'y'
  options.forEach((d) => {
    const user = props.data.newUser as any
    user[d.value] = <any>optionGroup.value.find((o) => o === d.value) != null ? 'y' : 'n'
  })

  const newUser = Object.assign({}, props.data.newUser, {
    confirmPassword: null,
    I_HP: replaceAll(props.data.newUser.I_HP, '-', ''),
    D_BIRTH: formatDateTimeToYYYYMMDD(new Date(props.data.newUser.YEAR as number, (props.data.newUser.MONTH as number) - 1, props.data.newUser.DAY as number).getTime()),
  })
  const result = await NewMemberRegister(newUser)

  if (result) {
    await dialog.message({
      title: '',
      message: '회원 가입이 정상적으로 처리 되었습니다.',
      callback: close,
    })
  } else {
    $q.notify({
      color: 'red-3',
      textColor: 'white',
      icon: 'cloud_done',
      message: '알 수 없는 문제가 발생했습니다.',
    })
  }
  //props.data.onNext(0)
}
</script>

<template>
  <!-- 약관동의 -->
  <div class="column col q-mt-lg">
    <div>
      <q-checkbox class="allcheck" v-model="allCheck" label="모든 이용약관 & 정보 수신에 동의합니다." true-value="y" false-value="n" @click="onAllCheck" />
    </div>
    <q-separator class="q-ma-sm"></q-separator>
    <q-option-group v-model="requiredGroup" type="checkbox" :options="requiredOptions">
      <template v-slot:label="opt">
        <div class="row items-center">
          <span class="text-grey-6">{{ opt.label }}</span>
          <div class="col" />
          <q-btn flat round color="deep-purple-3" @click.stop.prevent="showTerms(opt)">
            <q-icon size="19px">
              <img src="~assets/images/login/ic_arrow_r_mm.png" />
            </q-icon>
          </q-btn>
        </div>
      </template>
    </q-option-group>
    <q-separator class="q-ma-sm"></q-separator>
    <q-option-group v-model="optionGroup" type="checkbox" :options="options">
      <template v-slot:label="opt">
        <div class="row items-center">
          <span class="text-grey-6">{{ opt.label }}</span>
          <div class="col" />
          <q-btn flat round color="deep-purple-3" @click.stop.prevent="showTerms(opt)">
            <q-icon size="19px">
              <img src="~assets/images/login/ic_arrow_r_mm.png" />
            </q-icon>
          </q-btn>
        </div>
      </template>
    </q-option-group>
    <div class="column q-mt-lg">
      <q-btn label="회원가입" flat class="q-my-sm q-py-sm apply-button" @click="apply" :disable="!requiredCheck" />
    </div>
  </div>
</template>

<style lang="sass" scoped>
@import "register"
//$
.allcheck
  font-size: 14px
  font-weight: 500
  color: #141414

::v-deep(.q-checkbox)
  width: 100%

  .q-checkbox__label
    width: 100%
</style>
