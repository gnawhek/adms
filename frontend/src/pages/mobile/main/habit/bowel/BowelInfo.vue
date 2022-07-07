<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { usePopupStore } from 'src/store/popup'
import { PopupDrawer } from 'src/types'
import { ref } from 'vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()
const props = defineProps<{ currentPopup?: PopupDrawer | null }>()

interface BasicOption {
  text: string
  value: string
}

interface TypeOption extends BasicOption {
  image: string
}

interface ColorOption extends BasicOption {
  color: string
}

const bowelTypeOption: TypeOption[] = [
  {text: '촉촉한', value: 'moist', image: require('src/assets/images/habit/img_poo1_moist.png')},
  {text: '물같은', value: 'watery', image: require('src/assets/images/habit/img_poo2_watery.png')},
  {text: '갈라진', value: 'split', image: require('src/assets/images/habit/img_poo3_split.png')},
  {text: '울퉁불퉁한', value: 'bumpy', image: require('src/assets/images/habit/img_poo4_bumpy.png')},
  {text: '딱딱한', value: 'hard', image: require('src/assets/images/habit/img_poo5_hard.png')}
]

const bowelColorOption: ColorOption[] = [
  { text: '회색', value: 'grey', color: 'grey-5' },
  { text: '노란색', value: 'yellow', color: 'amber' },
  { text: '황토색', value: 'ocher', color: 'ocher' },
  { text: '갈색', value: 'brown', color: 'brown' },
  { text: '어두운 갈색', value: 'dark-brown', color: 'dark-brown' },
  { text: '초록색', value: 'green', color: 'light-green-10' },
  { text: '검정색', value: 'black', color: 'grey-9' },
  { text: '빨강색', value: 'red', color: 'red-4' }
]

const bowelSmellOption: BasicOption[] = [
  { text: '약간 심함', value: '1' },
  { text: '매우 심함', value: '2' },
  { text: '참을 수 없음', value: '3' }
]

const bowelProcessOption: BasicOption[] = [
  { text: '시원함', value: '1' },
  { text: '잔변감', value: '2' },
  { text: '고통스러움', value: '3' }
]

const bowelHourOption: BasicOption[] = [
  { text: '3분 미만', value: '1' },
  { text: '3~5분 미만', value: '2' },
  { text: '5~10분 미만', value: '3' },
  { text: '10분 이상', value: '4' }
]

let bowelType = ref('moist')
let bowelColor = ref('grey')
let bowelSmell = ref(1)
let bowelProcess = ref(1)
let bowelHour = ref(1)

</script>

<template>
  <div class="BowelInfo panel fit column q-pa-lg">
    <div class="col q-pb-sm">
      <span class="info_title">배변 형태</span>
      <div class="row info_contents">
        <q-radio
          v-model="bowelType"
          v-for="(type, i) in bowelTypeOption"
          :key="i"
          :val="type.value"
        >
          <img :src="type.image" :srcset="type.image" />
          <label> {{type.text}} </label>
        </q-radio>
      </div>
    </div>
    <div class="col q-pb-sm">
      <span class="title">배변 색깔</span>
      <div class="row info_contents">
        <q-radio
          size="48px"
          v-model="bowelColor"
          v-for="(color, i) in bowelColorOption"
          :key="i"
          :val="color.value"
          keep-color
          :color="color.color"
          class="full_radio"
        >
        </q-radio>
      </div>
    </div>
    <div class="col q-pb-sm">
      <span class="title">배변 냄새</span>
      <div class="row info_contents">
        <q-btn
          outline rounded color="grey-5"
          v-for="(smell, i) in bowelSmellOption"
          :key="i"
          :label="smell.text"
          class="q-mr-sm q-mb-sm"
          :class="{selected: bowelSmell === smell.value}"
          size="13px"
          @click="bowelSmell = smell.value"
        />
      </div>
    </div>
    <div class="col q-pb-sm">
      <span class="title">배변 과정</span>
      <div class="row info_contents">
        <q-btn
          outline rounded color="grey-5"
          v-for="(process, i) in bowelProcessOption"
          :key="i"
          :label="process.text"
          class="q-mr-sm q-mb-sm"
          :class="{selected: bowelProcess === process.value}"
          @click="bowelProcess = process.value"
          size="13px"
        />
      </div>
    </div>
    <div class="col q-pb-sm">
      <span class="title">배변 시각</span>
      <div class="row info_contents">
        <input type="time" />
      </div>
    </div>
    <div class="col q-pb-sm">
      <span class="title">배변에 걸린 시간</span>
      <div class="row info_contents">
        <q-btn
          outline rounded color="grey-5"
          v-for="(hour, i) in bowelHourOption"
          :key="i"
          :label="hour.text"
          class="q-mr-sm q-mb-sm"
          :class="{selected: bowelHour === hour.value}"
          @click="bowelHour = hour.value"
          size="13px"
        />
      </div>
    </div>
    <div class="footer flex flex-center q-pt-lg q-mb-sm absolute-bottom q-mx-md">
      <q-btn outline color="grey" label="취소" @click="currentPopup?.closeDrawer" />
      <q-btn class="bg-v-primary" label="저장" />
    </div>
  </div>
</template>

<style lang="sass" scoped>
span.info_title
  height: 21px
  font-family: NotoSansCJKKR
  font-size: 14px
  font-weight: 600
  text-align: left
  color: $v-gray2

div.info_contents
  padding: 10px 0
  margin-bottom: 5px
  text-align: center

  .q-radio
    width: 20%
    display: block

  ::v-deep(.q-radio__inner)
    margin: auto

  ::v-deep(.q-radio__inner--falsy)
    color: $v-gray6

  ::v-deep(.q-radio__label)
    color: $v-gray4
    font-size: 12px
    text-align: center

  ::v-deep(.q-radio__label > img)
    margin: auto
    margin-bottom: 2px
    display: block

  .full_radio ::v-deep(.q-radio__inner--falsy .q-radio__check)
    transform: scale3d(2,2,2)

  .full_radio ::v-deep(.q-radio__inner--truthy .q-radio__check)
    transform: scale3d(1.3, 1.3, 1.3)

  .full_radio.q-radio
    width: 12.5%

  .q-btn.selected
    transition: all 1s
    color: #000 !important

div.footer > button
  width: calc(50% - 8px)
  height: 42px
  margin-left: 8px
  padding: 10px 40px 12px
  color: $v-white
</style>
