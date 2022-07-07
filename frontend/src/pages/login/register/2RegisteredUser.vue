<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { RegisterDataType } from 'pages/login/LoginMemberRegister.vue'
import { useQuasar } from 'quasar'

const $q = useQuasar()
const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const props = defineProps<{ data: RegisterDataType }>()

const kakao = () => {
  $q.notify({
    color: 'green-4',
    textColor: 'white',
    icon: 'cloud_done',
    message: '카카오 로그인',
  })
}
</script>

<template>
  <!-- 가입 사용자 -->
  <div class="column col">
    <div class="column col items-center">
      <div class="column col-1">
        <div class="label label1 q-my-lg">{{ data.user.N_NAME + '님은 아래 계정 정보로 셀시스에 가입되어 있어요.' }}</div>
      </div>
      <div class="column col">
        <div class="label label3 q-my-lg">{{ data.user.I_ID }} ({{ data.user.N_NAME }})</div>
      </div>
    </div>
    <div class="column col">
      <div class="column col">
        <q-btn type="button" flat class="kakao-button" @click="kakao">
          <div class="row items-center no-wrap">
            <img src="~/assets/images/login/img_kakao_login.png" />
            <div class="text-center q-mx-sm">카카오 로그인</div>
          </div>
        </q-btn>
        <q-btn label="로그인하러 가기" flat class="q-my-sm q-py-sm login-button" @click="data.currentPopup?.closeDrawer" />
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
@import "register"
//$
.label1
  margin: 0 20px
  text-align: left
</style>
