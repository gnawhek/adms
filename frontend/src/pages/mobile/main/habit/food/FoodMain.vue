<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { usePopupStore } from 'src/store/popup'
import { ViewPages } from 'src/types'
import { ref } from 'vue'
import  CompCalendar from 'src/pages/mobile/main/habit/components/CompCalendar.vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()
const popupIndex = popupStore.drawers.length

const isRecord = ref(false)

const timeLineList = [
  {title:'간식', code:'snack', time:'15:20', cardTitle: '집밥', cardContent: '딱좋음'},
  {title:'점심', code:'lunch', time:'12:20', cardTitle: '배달음식', cardContent: '배부름'},
  {title:'아침',code:'breakfast', time:'07:20', cardTitle: '집밥', cardContent: '딱좋음'}
]
const openPopUp = (name: string) => {
  popupStore.newPopup(ViewPages[name])
}
</script>

<template>
  <div class="FoodMain fit">
    <CompCalendar :view-name="'foodMain'">
      <template v-slot:calenderContent >
        <div class="FoodMain q-px-sm" style="height: calc(100% - 30px);">
          <div v-if="isRecord" class="q-px-md">
            <q-timeline color="grey"  style="margin-bottom: 30px !important;">
                <q-timeline-entry v-for="item in timeLineList" 
                  :key="item.code" 
                  >
                  <div style="display:block;">
                    <div class="q-timeline__title"> {{item.title}}</div>
                    <div class="text-grey-6"> {{item.time}}</div>
                  </div>
                <q-card flat bordered class="q-ml-md bg-grey-2" style="width: 100%;">
                  <q-card-section horizontal class="justify-between q-px-md">
                    <q-card-actions vertical class="col-5" >
                      <div class="card-title">{{item.cardTitle}}</div>
                    <div class="text-grey-6">{{item.cardContent}}</div>
                    </q-card-actions>
                    <div class="self-center">
                      이미지                    
                    </div>
                  </q-card-section>
                </q-card>
                </q-timeline-entry>
            </q-timeline>
          </div>
          <div v-else class="absolute-center message" style="top: 40%;color: grey;" @click="openPopUp('FoodStatistics')">아직 기록 전이에요.</div>
          <q-btn 
            class="full-width recordBtn"
            :class="{'recordNon': !isRecord}"
            color="v-primary"
            label="기록하기"
            @click="openPopUp('FoodInfo')"/>
        </div>
      </template>
    </CompCalendar>
  </div>
</template>

<style lang="sass" scoped>
.FoodMain
  .q-timeline
    margin-bottom: 0
    .q-timeline__content
      display: flex
      padding-bottom: 5px
    
    .q-card__section
      .card-title
        font-size: 1.1em
        font-weight: 500

    .q-timeline__title
      font-size: 1.1em
      margin: 0px

    .q-timeline__dot:after
      width: 2px
      height: 5.3em
      top: 21px
      left: 18px

  .q-timeline__dot:before 
    height: 10px
    width: 10px
    top: 11px
    left: 14px

  .recordBtn
    bottom: 10px
    font-size: 15px
    padding: 10px 40px 12px

  .recordBtn.recordNon
    position: relative
    top: 85%

</style>
