<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { usePopupStore } from 'src/store/popup'
import { ViewPages } from 'src/types'
import { ref } from 'vue'
import CompCalendar from 'src/pages/mobile/main/habit/components/CompCalendar.vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()
const popupIndex = popupStore.drawers.length

const isRecord = ref(true)

const waterIntake = ref('1250ml')

const openPopUp = (name: string) => {
  popupStore.newPopup(ViewPages[name])
}
</script>

<template>
    <CompCalendar class="fixed-top q-mt-lg" >
      <template v-slot:calenderContent >
        <div class="WaterMonthly q-px-sm" style="height: calc(100% - 30px);">
          <div v-if="isRecord" class="q-pa-md" style="height: calc(100% - 60px);">
            <q-card class="full-width">
              <q-item >
                <q-icon name="water_drop" color="light-blue-1" class="bg-light-blue-2 q-pa-xs round" style="border-radius: 50%;"/>
                <span class="q-ml-sm">{{waterIntake}}</span>
              </q-item>
            </q-card>
          </div>
          <div v-else  class="absolute-center message" style="top: 40%;color: grey;" @click="openPopUp('WaterStatistics')">아직 기록 전이에요.</div>
          <!-- <q-btn flat color="white" class="record-btn full-width q-py-sm"
            style="position: fixed; bottom: 5px;"
            label="기록하기" @click="openPopUp('WaterInfo')"/> -->
          <q-btn 
            class="full-width recordBtn"
            :class="{'recordNon': !isRecord}"
            color="v-primary"
            label="기록하기"
            @click="openPopUp('')"/>
        </div>
      </template>
    </CompCalendar>
</template>

<style lang="sass" scoped>
.WaterMonthly
  .recordBtn
    bottom: 10px
    font-size: 15px
    padding: 10px 40px 12px

  .q-item
    align-items: center
  
  .recordBtn.recordNon
    position: relative
    top: 85%

</style>
