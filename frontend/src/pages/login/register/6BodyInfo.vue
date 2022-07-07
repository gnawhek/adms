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
</script>

<template>
  <!-- 신체정보 입력 -->
  <div class="column col">
    <div class="column items-center justify-center" style="white-space: pre-line; height: 200px; font-size: 20px; font-weight: 500; color: #444; text-align: center">
      {{ `${data.newUser.N_NAME || ''}님,\n정확한 운동/케어량 측정을 위해\n키와 체중을 입력해주세요` }}
    </div>
    <div class="column items-center justify-center q-gutter-y-sm">
      <q-input filled v-model="data.newUser.I_HEIGHT" mask="###">
        <template v-slot:before>
          <div class="before">키</div>
        </template>
        <template v-slot:after>
          <div class="after">cm</div>
        </template>
      </q-input>
      <q-input filled v-model="data.newUser.I_WEIGHT" mask="###.#" reverse-fill-mask maxlength="5">
        <template v-slot:before>
          <div class="before">체중</div>
        </template>
        <template v-slot:after>
          <div class="after">kg</div>
        </template>
      </q-input>
    </div>
    <div class="column" style="margin-top: 40px">
      <q-btn label="다음" flat class="q-my-sm q-py-sm apply-button" @click="data.onNext(7)" :disable="!(data.newUser.I_HEIGHT > 0) || !(data.newUser.I_WEIGHT > 0)" />
    </div>
  </div>
</template>

<style lang="sass" scoped>
@import "register"

::v-deep(.q-field__inner)
  width: 115px

::v-deep(input)
  text-align: center
  font-family: Roboto
  font-size: 16px
  font-weight: 500
  color: $v-gray2

::v-deep(.q-field)
  .q-field__before
    font-size: 14px
    font-weight: 500
    color: $v-gray1
    padding-right: 20px

  .q-field__after
    font-size: 14px
    font-weight: 500
    color: $v-gray1
    padding-left: 20px

.before
  text-align: right

.before, .after
  width: 40px
</style>
