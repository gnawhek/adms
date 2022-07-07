<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { computed, onMounted, ref } from 'vue'
import { RegisterDataType } from 'pages/login/LoginMemberRegister.vue'
import { useQuasar } from 'quasar'
import { takePicture } from 'src/utils/camera'
import tools from 'src/utils/tools'

const $q = useQuasar()
const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const props = defineProps<{ data: RegisterDataType }>()

const profileSrc = ref()
const profileImage = computed(() => {
  return profileSrc.value || require('assets/images/login/img_profile_square.png')
})

const $refFile = ref()
const selectedProfile = () => {
  takePicture('#take-picture', (base64) => {
    // console.log(base64)
    profileSrc.value = base64 as string
  })
  $refFile.value.click()
}
const isValidateBasic = computed(() => {
  return (
    props.data.newUser.N_NAME?.length > 0 &&
    props.data.newUser.I_HP?.length >= 11 &&
    props.data.newUser.YEAR >= 1900 &&
    props.data.newUser.YEAR <= 2100 &&
    props.data.newUser.MONTH >= 1 &&
    props.data.newUser.MONTH <= 12 &&
    props.data.newUser.DAY >= 1 &&
    props.data.newUser.DAY <= 31 &&
    props.data.newUser.C_SEX != null &&
    props.data.newUser.C_SEX.length > 0
  )
})

const profile = ref<HTMLImageElement | null>()
let canvas: HTMLCanvasElement | null
let dataURL: string | null
onMounted(() => {
  canvas = <HTMLCanvasElement>document.getElementById('viewport')

  if (profile.value != null) {
    profile.value.onload = () => {
      if (profile.value != null && canvas != null) {
        tools.scaleToFill(profile.value, canvas)
        dataURL = canvas?.toDataURL()
        // console.log(dataURL)
      }
    }
  }
  if (props.data.newUser.PROFILE != null) {
    profileSrc.value = props.data.newUser.PROFILE
  }
})

const next = () => {
  if (profileSrc.value != null && dataURL != null) {
    props.data.newUser.PROFILE = dataURL
  }
  props.data.onNext(5)
}
</script>

<template>
  <!-- 미가입 사용자: 기본정보입력 -->
  <div class="column col">
    <div class="column items-center q-mt-lg">
      <div class="relative-position">
        <q-btn type="button" flat @click="selectedProfile" class="q-pa-none" style="border-radius: 13px">
          <img ref="profile" :src="profileImage" style="width: 90px; height: 90px; object-fit: cover; border-radius: 13px; display: none" />
          <canvas id="viewport" width="90" height="90" style="border-radius: 13px"></canvas>
        </q-btn>
        <img src="~/assets/images/login/btn_camera.png" class="absolute-bottom-right no-pointer-events" />
      </div>
      <input type="file" id="take-picture" accept="image/*" ref="$refFile" v-show="false" />
    </div>
    <div class="column q-mt-lg">
      <div class="fieldLabel">이름<span class="required">*</span></div>
      <q-input outlined autocomplete="name" v-model="data.newUser.N_NAME" lazy-rules placeholder="이름을 입력하세요" autocapitalize="off" maxlength="50" />
    </div>
    <div class="column q-mt-lg">
      <div class="fieldLabel">휴대폰 번호<span class="required">*</span></div>
      <q-input outlined autocomplete="name" v-model="data.newUser.I_HP" lazy-rules placeholder="휴대폰번호를 입력하세요" mask="###-####-####" inputmode="tel" readonly />
    </div>
    <div class="column q-mt-lg">
      <div class="fieldLabel">생년월일<span class="required">*</span></div>
      <div class="row items-center yearField">
        <q-input
          spellcheck="false"
          autocomplete="name"
          v-model="data.newUser.YEAR"
          lazy-rules
          class="row col"
          placeholder="YYYY"
          type="text"
          mask="####"
          inputmode="numeric"
          :rules="[(val) => val !== undefined && val >= 1900, (val) => val !== undefined && val <= 2100]"
        />
        <div class="dateLabel" style="margin-right: 50px">년</div>
        <q-input
          autocomplete="name"
          v-model="data.newUser.MONTH"
          lazy-rules
          class="row col"
          placeholder="MM"
          type="text"
          mask="##"
          inputmode="numeric"
          :rules="[(val) => val !== undefined && val >= 1, (val) => val !== undefined && val <= 12]"
        />
        <div class="dateLabel" style="margin-right: 50px">월</div>
        <q-input
          autocomplete="name"
          v-model="data.newUser.DAY"
          lazy-rules
          class="row col"
          placeholder="DD"
          type="text"
          mask="##"
          inputmode="numeric"
          :rules="[(val) => val !== undefined && val >= 1, (val) => val !== undefined && val <= 31]"
        />
        <div class="dateLabel">일</div>
      </div>
    </div>
    <div class="column q-mt-lg">
      <div class="fieldLabel">성별</div>
      <div class="q-gutter-sm">
        <q-radio v-model="data.newUser.C_SEX" val="m" label="남성" />
        <q-radio v-model="data.newUser.C_SEX" val="w" label="여성" />
      </div>
    </div>
    <div class="column q-mt-lg">
      <div class="fieldLabel">셀네임</div>
      <q-input outlined autocomplete="name" v-model="data.newUser.CELL_NAME" lazy-rules placeholder="셀네임을 입력하세요" autocapitalize="off" maxlength="50" />
    </div>
    <div class="column q-mt-lg">
      <q-btn label="다음" flat class="q-my-sm q-py-sm apply-button" @click="next" :disable="!isValidateBasic" />
    </div>
    <!--      <pre>{{ data.newUser }}</pre>-->
  </div>
</template>

<style lang="sass" scoped>
@import "register"
//$
</style>
