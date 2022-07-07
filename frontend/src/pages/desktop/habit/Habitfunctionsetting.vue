<script setup lang="ts">
import { useRoute } from 'vue-router'
import { menuToName } from 'src/utils'
import { ViewPages } from 'src/types'
import { reactive } from 'vue'

const route = useRoute()
interface healthNoteOption {
  title: string
  value: boolean
}
const healthNoteSettings = reactive ([
    { title: ViewPages.FoodMain.name, value: false }, 
    { title: '체중기록', value: false}, 
    { title: ViewPages.BowelMonthly.name, value: false}, 
    { title: ViewPages.WaterMonthly.name, value: false},
    { title: '수면기록', value: true}, 
    { title: '혈압', value: false}
  ])

const healthMissionSettings = reactive ([
    { title: '걷기', subtitle: '매일 걸음 수', value: false }, 
    { title: '런닝', subtitle: '런닝 칼로리', value: false}, 
    { title: '따라하기', subtitle: 'tofollow',  value: false}, 
  ])

const options= [ {label: 'on', value: true}, {label: 'off', value: false}]
</script>

<template>
  <q-page class="column justify-start">
    <q-item-label header>{{ menuToName(route.path) }}</q-item-label>
    <q-separator color="black" inset class="q-mx-sm" />
    <q-item-label class="row health-container q-ma-md" style="width: 60%;">
      <div class="col bg-grey-4 q-pt-xl text-center"> 
        <span class="text-h6">건강노트</span>
      </div>
      <div class="col-10 q-pa-md">
        <div v-for="(item, index) in healthNoteSettings" :key="index">
          <div class="text-h6"> {{ $t(item.title) }} 
            <span class="text-grey-6" style="font-size: 16px;">{{`(매일 ${$t(item.title)}기록이 가능한 기능입니다.)`}} </span>
          </div>
          <div class="row q-pa-md"> 
            <q-option-group
              v-model="item.value"
              :options="options"
              inline
              color="primary"
            ></q-option-group>
          </div>
        </div>
      </div>
    </q-item-label>
    <q-item-label class="row health-container q-ma-md" style="width: 60%;">
      <div class="col bg-grey-4 q-pt-xl text-center"> 
        <span class="text-h6">건강미션</span>
      </div>
      <div class="col-10 q-pa-md">
        <div v-for="(item, index) in healthMissionSettings" :key="index">
          <div class="text-h6"> {{ item.title }} 
            <span v-if="item.subtitle !== 'tofollow'" class="text-grey-6" style="font-size: 16px;">{{`(${item.subtitle}측정이 가능한 기능입니다.)`}} </span>
            <span v-else class="text-grey-6" style="font-size: 16px;">{{`(동영상 플레이하여 보고 따라하는 기능입니다.)`}} </span>
          </div>
          <div class="row q-pa-md"> 
            <q-option-group
              v-model="item.value"
              :options="options"
              inline
              color="primary"
            ></q-option-group>
          </div>
        </div>
      </div>
    </q-item-label>
  </q-page>
</template>

<style lang="sass" scoped>
.health-container
  border: solid grey
</style>
