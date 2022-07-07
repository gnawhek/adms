<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import ResultRate from 'src/pages/mobile/main/habit/components/CompHabbitResultRate.vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()

interface ArrayListType {
  name: string
  selected: boolean
}

const bmiArray: ArrayListType[] = [
  { name: '저체중', selected: true},
  { name: '정상', selected: true},
  { name: '과체중', selected: false},
  { name: '비만', selected: false},
  { name: '고도비만', selected: false}
]

const bodyFatArray: ArrayListType[] = [
  { name: '저체중', selected: true},
  { name: '정상', selected: true},
  { name: '과체중', selected: false},
  { name: '비만', selected: false}
]

const bodyWaterArray: ArrayListType[] = [
  { name: '부족', selected: true},
  { name: '표준', selected: true},
  { name: '우수', selected: false}
]

const image = {
  gradient: require('src/assets/images/habit/img-weight-gradation.svg'),
  rectangle: require('src/assets/images/habit/img-rectangle-1625.svg')
}

</script>

<template>
  <div class="WeightInfo panel fit">
    <div class="row full-height flex-center">
      <div class="fit weight_value flex flex-center" style="min-height: 90px;">
        <span> 53 </span>
        <span> kg </span>
      </div>
      <img :src="image.gradient" style="width: 95%; height: 60px; z-index: 2;" />
      <q-img :src="image.rectangle" class="absolute full-width" style="top: 130px; height: 24px;" />

      <div class="column fit detail_result_area">
        <div class="col detail_card fit">
          <div class="title">
            <span> BMI </span>
            <span> 21.6 </span>
          </div>
          <div class="Vector-456"></div>
          <span class="result">정상</span>
          <span class="comment">BMI: 체중 (kg) / 신장 (㎡)</span>
          <ResultRate :resultArray="bmiArray" />
        </div>

        <div class="col detail_card fit">
          <div class="title">
            <span> 체지방율 </span>
            <span> 26.1%</span>
          </div>
          <div class="Vector-456"></div>
          <span class="result">정상</span>
          <span class="comment">
            체지방은 전체 체중중 지방의 비율을 지칭합니다. <br>
            높은 체지방은 비만으로 이어지며 여러 질병의 원인이 됩니다.<br>
            반대로 낮은 체지방은 내분비장애를 일으킬 수 있습니다.<br>
          </span>
          <ResultRate :resultArray="bodyFatArray" />
        </div>
        
        <div class="col detail_card fit">
          <div class="title">
            <span>체수분량 </span>
            <span>50.5%</span>
          </div>
          <div class="Vector-456"></div>
          <span class="result">표준</span>
          <span class="comment">
            수분은 혈액,림프,다른 체액들을 <br>
            포함한 인체안의 모든 물을 뜻합니다.
          </span>
          <ResultRate :resultArray="bodyWaterArray" />
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
div.WeightInfo
  .detail_result_area
    width: 360px
    height: 754px
    padding: 40px 20px 30px
    background-color: $v-gray9

  div.weight_value
    display: flex
    align-items: center
    justify-content: center
    padding-top: 45px

    > span:first-child
      font-family: Roboto
      font-size: 40px
      font-weight: 500
      line-height: normal
      color: $v-primary

    > span:nth-child(2)
      margin: 15px 0 0 5px
      font-family: Roboto
      font-size: 16px
      color: $v-primary

  div.detail_card
    width: 320px
    min-height: 212px
    flex-grow: 0
    margin: 0 0 16px
    padding: 20px
    border-radius: 8px
    background-color: $v-white
    display: flex
    flex-direction: column
    align-items: center
    justify-content: center

    div.title
      font-family: NotoSansCJKKR
      font-size: 16px
      font-weight: 600
      line-height: 1.38
      letter-spacing: -0.24px
      text-align: center

      > span:nth-child(2)
        color: $v-primary

    div.Vector-456
      width: 173px
      height: 1px
      margin: 7.5px 0
      background-color: $v-gray8

    span.result
      margin: 7.5px 70px 0 73px
      font-family: NotoSansCJKKR
      font-size: 16px
      font-weight: 600
      line-height: 1.38
      letter-spacing: -0.24px
      text-align: center
      color: $v-primary

    span.comment
      flex-grow: 0
      margin: 8px 24px 0
      font-family: NotoSansCJKKR
      font-size: 12px
      line-height: 1.83
      letter-spacing: -0.18px
      text-align: center
      color: $v-gray4
  
</style>
