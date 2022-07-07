<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { usePopupStore } from 'src/store/popup'
import { ViewPagesMobile } from 'src/types'
import { onMounted, onUnmounted } from 'vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()

const image = {
  arrow: require('src/assets/images/habit/icon/ic-arrow-r-mm.svg'),
  gradient: require('src/assets/images/habit/img-weight-gradation.svg'),
  scale: require('src/assets/images/habit/icon/ic-weight-scale.svg')
}

function openPopUp(name: string) {
  popupStore.newPopup(ViewPagesMobile[name])
}

</script>

<template>
  <div class="WeightMonthly panel fit">
    <div class="column full-height">
      <div class="col" style="min-height: 400px;" @click="openPopUp('WeightStatistics')">
        클릭 시 체중기록 통계로 이동
      </div>
      <div class="col column weight_record_area">
        <div class="col" style="max-height: 30px;">
          <span class="weight_record_date text-v-primary">17일 (화)</span>
          <q-btn class="float-right text-subtitle2" outline color="grey" label="체중계 연결" />
        </div>
        <div class="col row q-pa-lg flex flex-center weight_area fit">
          <div class="column" style="height: 45px;">
            <span>55.2</span>
            <span class="kg">kg</span>
            <img :src="image.arrow" class="ic_arrow_r_mm" @click="openPopUp('WeightInfo')" >
          </div>
          <div class="column fit flex flex-center">
            <img :src="image.gradient" />
          </div>
          <div class="column">
            <img :src="image.scale" />
          </div>
        </div>
        <q-btn 
          class="fit recordBtn"
          color="v-primary" 
          label="기록하기" 
          @click="openPopUp('WeightInput')"
        />
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
.WeightMonthly
  min-height: inherit
  
  > *
    min-height: inherit

  .weight_record_area
    padding: 20px
    min-height: 400px
    background-color: $v-gray9

    ::v-deep(.q-btn--outline:before)
      border: 1px solid #d1d1d1
      box-shadow: 1px 0px 3px 0px #d1d1d1 !important

    .recordBtn
      font-size: 15px
      padding: 10px 40px 12px

    .weight_record_date
      font-family: Roboto
      font-size: 18px
      font-weight: 600

  .weight_area
    span
      margin: 0 2px 0 0
      font-family: Roboto
      font-size: 40px
      font-weight: 500
      text-align: right
      color: $v-gray1

    span.kg
      margin: 22px 6px 6px 2px
      font-family: Roboto
      font-size: 16px

    .ic_arrow_r_mm
      margin: 20px 0 0px 6px

    .ic_arrow_r_mm:hover,
    .ic_arrow_r_mm:focus,
    .ic_arrow_r_mm:active
      transition: all 0.3s
      opacity: 0.5

</style>
