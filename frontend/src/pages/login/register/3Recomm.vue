<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { RegisterDataType } from 'pages/login/LoginMemberRegister.vue'
import { SELECT_FIND_RECOMM_CODE } from 'src/api/member-api'
import { useQuasar } from 'quasar'
import { emitter } from 'boot/EventBus'
import { EventType, GlobalConstants } from 'src/types'
import dialog from 'src/utils/dialog'

const $q = useQuasar()
const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const props = defineProps<{ data: RegisterDataType }>()

const codeConfirm = async () => {
  const result = await SELECT_FIND_RECOMM_CODE(props.data.code as string)
  if (result?.C_SHOP != null) {
    Object.assign(props.data.newUser, result)
    await dialog.message({
      title: '',
      message: '추천코드를 적용했습니다.',
      callback: () => {},
    })
  } else {
    await dialog.message({
      title: '',
      message: '채널에 회원등록이 되어있지 않습니다.\n추천코드를 전달해주신 담당자에게 문의해주세요.',
      callback: () => {},
    })
  }
}
</script>

<template>
  <!-- 추천코드 -->
  <div class="column col">
    <div class="column col justify-center">
      <div class="label label1 column col justify-center">{{ '추천코드가 있으면 \n코드를 입력해주세요' }}</div>
      <div class="col">
        <div class="row">
          <!-- prettier-ignore -->
          <q-input
              outlined
              autocomplete='code'
              v-model='data.code'
              lazy-rules
              class='col'
            />
          <q-btn label="코드확인" flat class="q-ml-xs apply-button" @click="codeConfirm" :disable="(props.data.code || '').length < GlobalConstants.maxIdLength" />
        </div>
      </div>
    </div>
    <div class="column col">
      <div class="column col">
        <div class="label label2 q-my-sm">{{ '코드가 없으면 다음 단계로 이동해주세요' }}</div>
        <q-btn label="다음" flat class="q-my-sm q-py-sm apply-button" @click="data.onNext(4)" />
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
@import "register"
//$
</style>
