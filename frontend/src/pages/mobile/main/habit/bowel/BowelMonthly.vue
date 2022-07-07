<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { usePopupStore } from 'src/store/popup'
import { ViewPagesMobile } from 'src/types'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()

interface BowelType {
  text: string
  value: string
  image: string
}

interface TestDataType {
  time: string
  score: number
  result: string
  bowel: string
}

const bowelTypes: BowelType[] = [
  {text: '촉촉한', value: 'moist', image: require('src/assets/images/habit/img_poo1_moist.png')},
  {text: '물같은', value: 'watery', image: require('src/assets/images/habit/img_poo2_watery.png')},
  {text: '갈라진', value: 'split', image: require('src/assets/images/habit/img_poo3_split.png')},
  {text: '울퉁불퉁한', value: 'bumpy', image: require('src/assets/images/habit/img_poo4_bumpy.png')},
  {text: '딱딱한', value: 'hard', image: require('src/assets/images/habit/img_poo5_hard.png')}
]

const testData: TestDataType[] = [
  {time: '09:30', score: 68, result: '보통', bowel: 'moist'},
  {time: '12:30', score: 70, result: '높음', bowel: 'hard'},
  {time: '21:30', score: 68, result: '보통', bowel: 'split'}
]

function openPopUp(name: string) {
  popupStore.newPopup(ViewPagesMobile[name])
}

function getBowelTypeImage (value: string) {
  const result = bowelTypes.find(type => type.value === value)
  return result?.image ?? ''
}

</script>

<template>
  <div class="BowelMonthly panel fit">
    <div class="column full-height">
      <div class="col" style="min-height: 400px;" @click="openPopUp('BowelStatistics')">
        클릭 시 배변 기록 통계로 이동
      </div>
      <div class="col column weight-record-area">
        <div class="col" style="max-height: 30px;">
          <span class="weight_record_date">17일 (화)</span>
        </div>
        <div class="col fit flex q-mt-lg">
          <div class="oval"> {{testData.length + '회'}} </div>

          <div class="recordList q-mt-sm">
            <div class="record flex no-wrap" v-for="(data, i) in testData" :key="i">
              <div class="rectangle" v-show="testData.length - 1 > i" />
              <div class="small-oval" />
              <span class="time">{{data.time}}</span>
              <div class="bowel-record flex no-wrap">
                <span class="score">{{data.score + '점'}}</span>
                <span class="text-score">{{data.result}}</span>
                <img :src="getBowelTypeImage(data.bowel)" align="center" />  
              </div>
            </div>
          </div>
        </div>
        <q-btn @click="openPopUp('BowelInfo')" class="fit recordBtn" label="기록하기" />
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
div.BowelMonthly
  min-height: inherit
  
  > *
    min-height: inherit

  div.weight-record-area
    padding: 35px 20px
    min-height: 400px
    background-color: $v-gray9

    span.weight_record_date
      font-family: Roboto
      font-size: 18px
      font-weight: 600
      color: $v-primary

  div.oval 
    width: 36px
    height: 36px
    margin: 0 10px 22px 0
    padding: 7px 7px 9px 8px
    background-color: $v-gray2
    color: white
    border-radius: 100%

  div.small-oval
    width: 7px
    height: 7px
    background-color: $v-gray6
    border-radius: 100%
    margin-right: 15px
    margin-top: 7px

  div.record:not(:first-child)
    margin-top: 13px

  div.rectangle
    background-color: $v-gray6
    width: 2px
    position: absolute
    height: 70px
    margin-left: 2px
    margin-top: 10px

  span.time
    font-family: Roboto
    font-size: 14px
    font-weight: 500
    color: $v-gray1
    margin-top: 2px

  div.bowel-record
    width: fit-content
    height: 60px
    margin: -17px 0 15px 20px
    padding: 15px 20px
    border-radius: 6px
    border: solid 1px $v-gray8

    span.score
      margin: 3px 6px 5px 0
      font-family: Roboto
      font-size: 14px
      font-weight: 600
      color: $v-gray1

    span.text-score
      margin: 3px 20px 5px 6px
      font-family: NotoSansCJKkr
      font-size: 14px
      color: $v-gray4

  button.recordBtn
    font-size: 15px
    background-color: $v-primary !important
    padding: 10px 40px 12px
    border-radius: 3px
    color: $v-white
</style>
