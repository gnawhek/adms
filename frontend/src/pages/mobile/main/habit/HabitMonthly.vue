<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { usePopupStore } from 'src/store/popup'
import { MenuDevPages } from 'src/types/MenusDev'
import CompCalendar from 'src/pages/mobile/main/habit/components/CompCalendar.vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()
const popupIndex = popupStore.drawers.length

const tempCheck = [
  {code:'meal', title: '식사', data: 52},
  {code:'weight', title: '체중', data: 52},
  {code:'bowelmovement', title: '배변', data: 81},
  {code:'walking', title: '걷기', data: 83},
]
</script>

<template>
  <div class="HabitMonthily fit">
    <CompCalendar :view-name="'habitMonthily'" >
      <template v-slot:calenderContent >
        <div class="progress-container q-pa-lg">
          <div v-for="item in tempCheck" :key="item.code" class="row q-pa-sm text-center items-center">
            <div class="col text-h6 text-v-gray1">{{ item.title }}</div>
            <div class="col-8">
            <q-linear-progress  rounded size="lg" :value="item.data * 0.01"></q-linear-progress>
            </div>
            <div class="col text-h6 text-v-gray1">{{ item.data + '% '}}</div>
          </div>
        </div>
      </template>
    </CompCalendar>
  </div>
</template>

<style lang="sass" scoped>
.HabitMonthily
  .progress-container
    height: calc(100% - 30px)
    display: grid
    align-content: space-evenly

    .q-linear-progress
      opacity: 0.4
</style>
