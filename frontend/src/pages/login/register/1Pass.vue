<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { RegisterDataType } from 'pages/login/LoginMemberRegister.vue'
import { replaceAll } from 'src/utils'
import { findLoginId, SELECT_FIND_LOGIN_POOL } from 'src/api/member-api'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const props = defineProps<{ data: RegisterDataType }>()
const applyPass = async () => {
  //이미 가입한 고객인지 여부 확인
  const I_HP = replaceAll(props.data.hp as string, '-', '')
  if (I_HP.length == 0) {
    return
  }
  props.data.user = await findLoginId(I_HP)
  props.data.newUser.I_HP = I_HP
  if (props.data.user?.I_ID != null) {
    //가입 사용자
    props.data.onNext(2)
  } else {
    //미가입 사용자
    //기업의 고객풀에 가입된 고객인지 확인
    const result = await SELECT_FIND_LOGIN_POOL(I_HP)
    if (result?.C_SHOP != null) {
      props.data.onNext(3)
    } else {
      props.data.onNext(4)
    }
  }
}
</script>

<template>
  <!-- PASS 인증 -->
  <div class="column col">
    PASS APP(이름,생년월일,성별,전화번호)
    <!-- prettier-ignore -->
    <q-input
      outlined
      autocomplete='hp'
      v-model='data.hp'
      hq-radioint='전화번호 입력'
      lazy-rules
      mask="###-####-####" inputmode="tel"
    />
    <div class="column">
      <q-btn label="PASS 인증 하기" flat class="q-my-sm q-py-sm apply-button" @click="applyPass" />
    </div>
  </div>
</template>

<style lang="sass" scoped>
@import "register"
//$
</style>
