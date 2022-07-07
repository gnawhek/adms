<script setup lang="ts">
import { useRoute } from 'vue-router'
import { menuToName } from 'src/utils'
import { ref, reactive } from 'vue'

const route = useRoute()
const weekQuest = reactive({ participation: 70, cell: 500 })
const healthMissionCell = ref(20)
const eventCell = ref(100)
const healthLevel = reactive({ onStepUp: 100, maintain: 100, maintainLevel: 8 })
const cellLogShare = reactive({ meal: 100, care: 100 })
</script>

<template>
  <q-page class="Cellpolicysetting column justify-start">
    <q-item-label header>{{ menuToName(route.path) }}</q-item-label>
    <q-separator color="black" inset class="q-mx-sm" />
    <div class="q-pa-md">
    <q-input dense debounce="300" v-model="filter" placeholder="Search" style="width: 150px;">
      <template v-slot:append>
        <q-icon name="search" />
      </template>
    </q-input>
    <q-list  padding style="width: 80%;">
     <q-item>
      <q-item-section class="q-pb-md">
        <q-item-label header class="text-bold text-light-blue">습관 건강노트 주간 퀘스트 셀 지급</q-item-label>
        <q-item-label class="row items-center q-pb-lg">
          주간 퀘스트 참여도 <q-input square outlined dense v-model="weekQuest.participation" type="number" step="10" min="0" max="100" class="q-mx-md"/>
          달성시 매주 <q-input square outlined dense v-model="weekQuest.cell" type="number" step="100" class="q-mx-md"/> 셀/주 지급합니다.
          <q-btn class="q-ml-xl" label="적용" unelevated color="black" />
        </q-item-label>

        <q-item-label header class="text-bold text-light-blue">습관 건강미션 셀 지급</q-item-label>
        <q-item-label class="row items-center q-pb-lg">
          정기배송 상품 결제 금액의 <q-input square outlined dense v-model="healthMissionCell" type="number" step="10" min="0" max="100" class="q-mx-md"/>
          를 셀로 지급합니다.
          <q-btn class="q-ml-xl" label="적용" unelevated color="black" />
        </q-item-label>

        <q-item-label header class="text-bold text-light-blue">이벤트 셀 지급</q-item-label>
        <q-item-label class="row items-center">
          <span class="text-bold q-pr-md"> 자가진단 </span>(자가진단 진행할 때마다 셀을 지급합니다.)
          <q-btn class="q-ml-xl" label="적용" unelevated color="black" />
        </q-item-label>
        <q-item-label class="row items-center">
          <q-input square outlined dense v-model="eventCell" type="number" step="100" class="q-mx-md"/> 셀/월 1회
        </q-item-label>
      </q-item-section>
     </q-item>
     <q-separator spaced></q-separator>
     
     <q-item>
      <q-item-section class="q-pb-md">
        <q-item-label header class="row text-bold">
          <span class="text-black q-pr-md">건강레벨</span>
          <span class="text-v-gray4"> (현재 건강레벨이 지난번 대비 한 단계 레벨 상승 하였거나 유지했을 경우 셀을 지급합니다.) </span>
          <q-btn class="q-ml-xl" label="적용" unelevated color="black" />
        </q-item-label>
        <div style="width: 100%">
        <q-item-label class="row items-center" >
          <div class="col">건강레벨 한 단계 상승 시 </div>
          <div class="col"><q-input square outlined dense v-model="healthLevel.onStepUp" type="number" step="100" class="q-mx-md"/> </div>
          <div class="col">셀/월 1회</div>
        </q-item-label>
        <q-item-label class="row items-center" >
          <div class="col">건강레벨 유지 시 </div>
          <div class="col"><q-input square outlined dense v-model="healthLevel.maintain" type="number" step="100" class="q-mx-md"/></div>
          <div class="col"> 셀/월 1회 </div>
        </q-item-label>
        <q-item-label class="row items-center">
          <div class="col">* 건강레벨 유지는 </div>
          <div class="col"> <q-input square outlined dense v-model="healthLevel.maintainLevel" type="number" step="100" class="q-mx-md"/> </div>
          <div class="col">레벨 부터 적용 </div>
        </q-item-label>
        </div>
      </q-item-section>
     </q-item>
     <q-separator spaced></q-separator>
     <q-item>
      <q-item-section class="q-pb-md">
        <q-item-label header class="row text-bold">
          <span class="text-black q-pr-md">셀로그 공유</span>
          <span class="text-v-gray4"> (셀로그에 공유할때다다 셀을 지급합니다.) </span>
          <q-btn class="q-ml-xl" label="적용" unelevated color="black" />
        </q-item-label>
        <div style="width: 100%">
        <q-item-label class="row items-center" >
          <div class="col">식사기록 공유시 </div>
          <div class="col"><q-input square outlined dense v-model="cellLogShare.meal" type="number" step="100" class="q-mx-md"/> </div>
          <div class="col">셀/1회</div>
        </q-item-label>
        <q-item-label class="row items-center" >
          <div class="col">케어영상 업로드시</div>
          <div class="col"><q-input square outlined dense v-model="cellLogShare.care" type="number" step="100" class="q-mx-md"/></div>
          <div class="col"> 셀/1회 </div>
        </q-item-label>
        </div>
      </q-item-section>
     </q-item>

    </q-list>
    </div>
  </q-page>
</template>

<style lang="sass">
.Cellpolicysetting
  .q-list
    .q-input, .q-field__control
      width: fit-content
      .q-field__native
        text-align: center
</style>
