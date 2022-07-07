<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { onMounted, onUnmounted, ref } from 'vue'
import HealthManagement from 'src/pages/mobile/main/habit/components/HealthManagement.vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()

let tab = ref('management')
const pattrenList = [
  { title: '식사타입', subTitle: '식사', code: 'type', record: true, subList: [
    {progressTitle:'배달음식', value: 10},
    {progressTitle:'집밥', value: 5},
    {progressTitle:'외식', value: 4}
  ]},
  { title: '배변상태', subTitle: '배변', code: 'status', record: true, subList: [
    {progressTitle:'주의', value: 10},
    {progressTitle:'관심', value: 5},
    {progressTitle:'양호', value: 4}
  ]},
]
const getProgressColor = (code:string, val: number) => {
  if(val >= 10 && code ==='type') {
    return 'v-chart5'
  } else if(val >= 10 && code ==='status') {
    return 'v-data-increase'
  } else {
    return 'v-gray6'
  }
}
</script>

<template>
  <div class="HabitWeekReport panel fit">
    <q-tabs
      v-model="tab"
      dense
      align="justify"
      active-color="black"
      indicator-color="v-primary"
      class="fit text-v-gray4"
    >
      <q-tab :ripple="false" name="management" label="건강관리" />
      <q-tab :ripple="false" name="pattern" label="생활패턴" />
    </q-tabs>

    <q-separator></q-separator>

    <q-tab-panels v-model="tab" animated>
      <q-tab-panel name="management" class="q-pa-none">
        <HealthManagement :view-title="'walking'" class="full-height"/>
      </q-tab-panel>

      <q-tab-panel name="pattern">
        <div v-for="item in pattrenList" :key="item.code" class="q-px-sm" :class="{' q-mt-xl': item.code !=='type'}">
          <div class="row q-pb-md justify-between">
            <div class="text-h6">{{ item.title }}</div>
            <div class="q-mr-sm">
              <q-btn label="더 보기" flat style="font-size:1rem;" color="v-gray4" class="q-pa-none">
                <q-icon size="19px">
                  <img src="~assets/images/habit/ic_arrow_r_ss.svg" />
                </q-icon>
              </q-btn>
            </div>
          </div>
          <q-card class="q-pa-md shadow-3">
            <q-card-section v-if="!item.record" class="text-center">
              <div class="text-h6 text-v-gray5 q-pb-md">아직 {{ item.subTitle }}기록이 없습니다</div>
              <div class="text-subtitle2">
                <q-btn :label="`${item.subTitle} 기록하기`" size="md" color="v-primary" class="q-px-lg"/>
              </div>
            </q-card-section>
            <q-card-section v-else class="text-center q-pa-none">
              <div v-for="(subItem, index) in item.subList" :key="index" class="row q-py-sm">
                <div class="col-2 text-v-gray2 text-weight-medium text-right q-pr-lg" style="min-width: 80px;">{{ subItem.progressTitle }}</div>
                <div class="col">
                  <q-linear-progress size="md" :value="subItem.value * 0.1" :color="getProgressColor(item.code, subItem.value)" track-color="v-white" class="q-mt-sm" />
                </div>
                <div class="col-2 text-bold text-right q-pr-sm">{{ subItem.value + '회'}}</div>
              </div>
            </q-card-section>
          </q-card>
          <div style="float: right;" class="text-v-gray5 q-mt-sm">*최근 7일 기준 통계입니다</div>
        </div>
      </q-tab-panel>
    </q-tab-panels>
  </div>
</template>

<style lang="sass">
.HabitWeekReport
  .q-card
    border-radius: 6px
  .q-tab
    padding: 10px 16px
  .q-tab__label
    font-size: 1.4em

</style>
