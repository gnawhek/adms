<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { RegisterDataType } from 'pages/login/LoginMemberRegister.vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const props = defineProps<{ data: RegisterDataType }>()
</script>

<template>
  <!-- 본인 인증 -->
  <div class="column col">
    <div class="column col items-center justify-center">
      <img src="~/assets/images/login/img_certification.png" />
      <div class="label label1 q-my-lg">{{ '원활한 서비스 제공을 위해 \n본인인증이 필요해요' }}</div>
    </div>
    <div class="column col">
      <div class="column col justify-center">
        <div class="label label2 row justify-center q-my-sm">{{ '번호는 안전하게 보관되며 \n동의 없이 어디에도 공개되지 않아요' }}</div>
        <q-btn label="본인인증" flat class="q-my-sm q-py-sm apply-button" @click="data.onNext(1)" />
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
@import "register"
//$
</style>
