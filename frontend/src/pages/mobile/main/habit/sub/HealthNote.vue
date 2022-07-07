<script setup lang="ts">
import { computed, ref, onMounted, nextTick } from 'vue'
import { ViewPages } from 'src/types'
import { usePopupStore } from 'src/store/popup'

const popupStore = usePopupStore()

const meal = ['아침', '점심', '저녁', '간식']

const perform = ref(4)
const icon = ref(false)

const helthNote = [
  { title:'식사', code: 'FoodMain', show: true, record: true },
  { title:'체중', code: 'WeightMonthly', show: true, record: true , unit: 'kg'},
  { title:'배변', code: 'BowelMonthly', show: true, record: true, unit: '점', },
  { title:'수분섭취', code: 'WaterMonthly', show: true, record: true, unit: 'ml'},
  { title:'수면', code: 'sleep', show: true, record: true  },
  { title:'혈압', code: 'bloodPressure', show: true, record: true, unit: 'mmHg' },
  { title:'혈당', code: 'bloodSugar', show: true, record: true, unit: 'mg/dL' },
]
const quest = [
  { title:'식사', percent: ref(28) },
  { title:'배변', percent: ref(0) },
  { title:'체중기록', percent: ref(28) },
]
const percentAvg = computed(() => {
  let sum = 0
  quest.forEach((item) => {
    sum += item.percent.value
    console.log(sum) 
  })
  return Math.round(sum / quest.length)
})
const onOpenPopup = (name: string) => {
  if(!ViewPages[name]) {
    return false
  }
  popupStore.newPopup(ViewPages[name])
}
onMounted(() => {
  console.log('onMounted')
})

const getMarkers = (target: number) => {
  nextTick(() => {
    document.documentElement.style.setProperty('--target-number', `${target}%`)
  })
  return target
}

</script>

<template>
  <div class="HealthNote q-pa-md bg-grey-3">
    <q-card class="q-mb-md q-pa-sm text-v-gray1">
      <q-item>
        <q-item-section avatar class="menu-title" style="display: block;">
          주간퀘스트
          <img src="~assets/images/habit/btn_question_round.svg"  @click="icon = true" />
           <q-dialog v-model="icon">
              <q-card >
                <q-card-section class="row items-center q-pb-none">
                  <q-space></q-space>
                  <q-btn icon="close" flat round dense v-close-popup></q-btn>
                </q-card-section>

                <q-card-section  class="text-center q-pt-none">
                  <div class="text-h5 q-mb-lg">주간 퀘스트란?</div>
                  <div class="text-h">일상 관리 미션으로<br /> 꾸준히 기록하면 매주 상금을 받을수 있습니다.</div>
                </q-card-section>
              </q-card>
            </q-dialog>
        </q-item-section>
      </q-item>
      <q-item>
        <q-item-label class="text-body1">이번주 수행 가능한 시간이 
          <span class="text-red text-h6 text-weight-bold">{{ perform }}</span>
          일 남았어요
        </q-item-label>
      </q-item>
      <q-item class="items-center justify-between">
        <q-item-label class="text-body1">평균 참여도 
          <span class="text-h5 text-v-primary text-weight-bold">{{ percentAvg }}
          </span>
          <span class="text-v-primary">%</span>
        </q-item-label>
          <q-chip size="sm" outline class="q-pa-md bg-amber-2">
            <span class="text-subtitle2 text-weight-bold">+500C</span>
          </q-chip>
      </q-item>
      <q-item>
        <!-- <q-linear-progress  rounded size="lg" :value="percentAvg * 0.01"></q-linear-progress> -->
        <q-slider
          id="sliderAvg"
          v-model="percentAvg"
          color="v-primary"
          inner-track-color="v-gray8"
          marker-labels
          readonly
          :min="0"
          :max="100"
          :max-value="0"
          :tabindex="5"
          :markers="getMarkers(70)"
          :step="100"
          marker-labels-class="text-v-gray5"
          track-size="10px"
        ></q-slider>
      </q-item>
      <q-list bordered class="rounded-borders">
      <q-expansion-item class="quest-custom" >
        <q-card>
          <q-card-section v-for="(item, index) in quest" :key="index">
            <span class="text-v-gray1">{{ item.title }}</span>
            <span class="q-pa-sm text-v-gray3" style="float: right;">{{ item.percent.value + '% '}}</span>
            <q-linear-progress rounded color="v-chart2" size="lg" :value="item.percent.value * 0.01"></q-linear-progress>
          </q-card-section>
        </q-card>
      </q-expansion-item>
    </q-list>
    </q-card>
    <q-card v-show="item.show" v-for="item in helthNote" :key="item.code" class="q-mb-md q-pa-sm text-v-gray1">
      <q-item class="items-center">
        <q-item-section avatar class="menu-title">
            {{ item.title }}
        </q-item-section>
        <q-item-label v-if="!item.record && (item.code==='WeightMonthly'|| item.code==='BowelMonthly')" class="text-grey">기록을 시작해 보세요.</q-item-label>
        <q-item-label v-else-if="item.code==='WeightMonthly' && item.record" >
          <span class="point-font">54</span>
          <span class="unit-font">
            kg
          </span>
          <span class="text-body1 text-deep-purple-13">
            (<q-icon name="south"/>0.5)
          </span>
        </q-item-label>
        <q-item-label v-else-if="item.code==='BowelMonthly'&&item.record" >
          <span class="point-font">68</span>
          <span class="text-body1 text-bold"> 점</span> 
          <span class="text-body1 text-bold text-grey">&#183; 보통</span>
        </q-item-label>

        <q-item-section class="text-right">
          <q-item-label>
            <q-btn flat size="sm" class="q-pa-none"  @click="onOpenPopup(item.code)">
              <!-- <q-chip size="sm" :class="{'bg-amber-5':item.record, 'bg-grey-5 text-white':!item.record}" >
                <span class="text-subtitle2">+50C</span>
              </q-chip> -->
              <!-- <q-icon  size="sm" name="keyboard_arrow_right" /> -->
              <img src="~assets/images/habit/ic_arrow_r_mm.svg" />
              </q-btn>
          </q-item-label>
        </q-item-section>
      </q-item>

      <q-item v-if="!item.record && item.code!=='FoodMain' && item.code!=='WeightMonthly' && item.code!=='BowelMonthly'">
        <q-item-label  class="text-grey">기록을 시작해 보세요.</q-item-label>
      </q-item>

      <q-item v-else-if="item.code==='WaterMonthly' && item.record">
        <span class="text-blue-9 text-bold"> 1700</span> 
        / 2000ml
      </q-item>
      <q-item v-else-if="item.code==='sleep' && item.record">
        <span class="point-font">6<span class="text-body2">시간</span>30<span  class="text-body2">분</span></span>
      </q-item>
      <q-item v-else-if="item.code==='bloodPressure' && item.record">
        <span class="point-font">126/70 <span class="text-body2 text-bold">mmHg</span></span>
        
      </q-item>
      <q-item v-else-if="item.code==='bloodSugar' && item.record">
        <span class="point-font">90<span class="text-body2 text-bold">mg/dL</span></span>
        
      </q-item>

      <q-item v-if="item.code==='FoodMain'">
        <q-item-section v-for="(item, index) in meal" :key="index" class="items-center" >
          <q-item-label class="meal-add-item q-pa-lg" @click="onOpenPopup('FoodInfo')"><img src="~assets/images/habit/ic-meal-plus.svg"></q-item-label>
          <q-item-label class="text-grey-5">{{ item }}</q-item-label>
        </q-item-section>
      </q-item>
      
      <q-btn v-show="item.code==='WeightMonthly'" class="q-px-md q-mb-md" style="margin-left: 6em;" outline color="grey-8" label="체중계 연결" />
    </q-card>
    <div class="column text-center items-center">
      <q-btn flat size="md"  @click="onOpenPopup('HealthNoteAdd')">
        <img src="~assets/images/habit/icon/btn_add.svg" />
      </q-btn>
      <span>추가</span>
    </div>
  </div>

</template>

<style lang="sass">
:root 
  --target-number: 0%
.HealthNote
  min-height: inherit
  .q-card
    border-radius: 10px
    box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.04)

    .meal-add-item
      border: dashed 1px #cccccc
      border-radius: 50%

    .point-font
      font-size: 2.3em
      font-weight: 500
    
    .unit-font
      font-size: 1.3em
    
    .q-chip--outline
      border: 1px solid #ffbc00

    .q-slider
      .q-slider__markers--h
        background-size: 15px !important
        margin-left: 4.7px
        background-repeat: no-repeat
        background-position-x: var(--target-number)
        background-image: url("src/assets/images/habit/ic_slider_target.svg") !important
      .q-slider__markers--h:after
        width: 0px
      .q-slider__thumb-shape
        stroke-width: 3px
      .q-slider__thumb-shape path
        stroke: #fff
    
  .q-expansion-item--expanded.quest-custom
    .q-expansion-item__container
      .q-item
        transform: translateY(17em)
        transition: all 0.2s
        
      .q-expansion-item__content
        transform: translateY(-3.3em)
        transition: all 0.5s

  .q-expansion-item--collapsed.quest-custom
    .q-expansion-item__container
      .q-item
        transform: translateY(0em)
        transition: all 0.5s

  .q-expansion-item.quest-custom
    .q-item__section
      flex: 0 27%
  
    .q-item__section--main ~ .q-item__section--side
      padding-left: 0px

.menu-title
  font-size: 18px
  font-weight: bold


  .q-btn
    height: 30px
  
</style>
