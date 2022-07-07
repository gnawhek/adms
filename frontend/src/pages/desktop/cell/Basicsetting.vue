<script setup lang="ts">
import { useRoute } from 'vue-router'
import { menuToName } from 'src/utils'
import { ref, reactive  } from 'vue'
import { ViewPages } from 'src/types'

const route = useRoute()
const options= [ {label: '', value: true}, {label: 'off', value: false}]


const healthNoteSettings = reactive ([
    { title: ViewPages.FoodMain.name, value: false }, 
    { title: '체중기록', value: false}, 
    { title: ViewPages.BowelMonthly.name, value: false}, 
  ])
const useOptions = [{label: '사용함', value: true}, {label: '사용하지 않음', value: false}]

const isCellPayment = ref(true)
const isPaymentsTarget = ref(true)
const isHabitHealthMission = ref(true)
const isSelfDiagnosis = ref(true)
const isHealthLevelOneStep = ref(true)
const isHealthLevelMaintain = ref(true)
const isMealShare = ref(true)
const isCareVideoUpload = ref(true)
</script>

<template>
  <q-page class="column justify-start">
    <q-item-label header>{{ menuToName(route.path) }}</q-item-label>
    <q-separator color="black" inset class="q-mx-sm" />
    <div class="q-pa-md">
    <q-input dense debounce="300" v-model="filter" placeholder="Search" style="width: 150px;">
      <template v-slot:append>
        <q-icon name="search" />
      </template>
    </q-input>
    <q-list  padding style="width: 100vw;">
      <q-item-label header>셀 지급 설정</q-item-label>

      <q-item>
        <q-item-section>
          <q-item-label class="q-pb-md text-bold">습관 건강노트 주간 퀘스트</q-item-label>
          <q-item-label >셀 지급 사용여부</q-item-label>
          <q-item-label>
            <q-option-group
              v-model="isCellPayment"
              :options="useOptions"
              inline
              color="primary"
            ></q-option-group>
          </q-item-label>
          <q-item-label>지급대상 선택</q-item-label>
          <q-item-label>
            <q-option-group
              v-model="isPaymentsTarget"
              :options="[{label: '모든회원', value: true}, {label: '정기배송 상품 구매 회원', value: false}]"
              inline
              color="primary"
            ></q-option-group>
          </q-item-label>
           <q-item-label class="row health-container q-ma-md" style="width: 60%; border: solid 2px grey;">
            <div class="col bg-grey-4 q-pt-xl text-center"> 
              <span class="text-h6">건강노트</span>
            </div>
            <div class="col-10 q-pa-md">
              <div v-for="(item, index) in healthNoteSettings" :key="index">
                <div class="text-h6"> {{ $t(item.title) }} 
                  <span class="text-red" style="font-size: 14px;">{{`(매일 한끼 ${$t(item.title)} 완료 했을 경우 주간 퀘스트 참여도가 올라갑니다.)`}} </span>
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
        </q-item-section>
      </q-item>

      <q-item >
        <q-item-section>
          <q-item-label ><span class="text-bold">습관 건강미션 </span>
            <span class="text-red" style="font-size: 14px;">(정기배송 상품 구매 회원한테만 셀을 지급합니다.)</span>
          </q-item-label>
          <q-item-label>
             <q-option-group
              v-model="isHabitHealthMission"
              :options="useOptions"
              inline
              color="primary"
            ></q-option-group>
          </q-item-label>
        </q-item-section>
      </q-item>

      <q-separator spaced></q-separator>
      <q-item >
        <q-item-section>
          <q-item-label ><span class="text-bold">자가진단 </span>
            <span class="text-v-gray4">(자가진단을 진행할 때마다 셀을 지급합니다.)</span>
          </q-item-label>
          <q-item-label>
             <q-option-group
              v-model="isSelfDiagnosis"
              :options="useOptions"
              inline
              color="primary"
            ></q-option-group>
          </q-item-label>
        </q-item-section>
      </q-item>
      <q-separator spaced></q-separator>
      <q-item >
        <q-item-section>
          <q-item-label class="q-pb-lg"><span class="text-bold">건강레벨 </span>
            <span class="text-v-gray4">(현재 건강레벨이 지난번 대비 한 단계 상승 하였거나 유지했을 경우 셀을 지급합니다.)</span>
          </q-item-label>
          <q-item-label>건강레벨 한 단계 상승 시</q-item-label>
          <q-item-label>
             <q-option-group
              v-model="isHealthLevelOneStep"
              :options="useOptions"
              inline
              color="primary"
            ></q-option-group>
          </q-item-label>
          <q-item-label>건강레벨 유지 시</q-item-label>
          <q-item-label>
             <q-option-group
              v-model="isHealthLevelMaintain"
              :options="useOptions"
              inline
              color="primary"
            ></q-option-group>
          </q-item-label>
        </q-item-section>
      </q-item>
      <q-separator spaced></q-separator>
      <q-item >
        <q-item-section>
          <q-item-label class="q-pb-lg"><span class="text-bold">셀로그 공유</span>
            <span class="text-v-gray4"> (셀로그에 공유하는 경우 셀을 지급합니다.)</span>
          </q-item-label>
          <q-item-label>식사기록 공유시</q-item-label>
          <q-item-label>
             <q-option-group
              v-model="isMealShare"
              :options="useOptions"
              inline
              color="primary"
            ></q-option-group>
          </q-item-label>
          <q-item-label>케어영상 업로드시</q-item-label>
          <q-item-label>
             <q-option-group
              v-model="isCareVideoUpload"
              :options="useOptions"
              inline
              color="primary"
            ></q-option-group>
          </q-item-label>
        </q-item-section>
      </q-item>
    </q-list>
    </div>
  </q-page>
</template>

<style lang="sass" scoped>
</style>
