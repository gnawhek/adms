<script setup lang="ts">
import { useRoute } from 'vue-router'
import { menuToName } from 'src/utils'
import { ref } from 'vue'

const route = useRoute()
const searchOptions = [
  '전체검색', '이름', '아이디', '성별', '기록항목'
]
const search = ref('전체검색')
const searchText = ref('')
const days = ref('7day')
const startDate = ref('2021-01-01')
const endDate = ref('2021-03-01')
</script>

<template>
  <q-page class="HealthNotes column justify-start">
    <q-item-label header>{{ menuToName(route.path) }}</q-item-label>
    <q-separator color="black" inset class="q-mx-sm" />
    <div class="q-pa-md" style="width: 65%;">
      <q-item>
          <q-item-section>
            <q-item-label class="row items-center">
              <div class="col-1">검색 조건</div>
              <div class="col-3 q-px-sm">
                <q-select square outlined dense v-model="search" :options="searchOptions" />
              </div>
              <div class="col-3 q-px-sm">
                <q-input square outlined dense v-model="searchText" />
              </div>
            </q-item-label>
          </q-item-section>
        </q-item>
        <q-item>
          <q-item-section>
            <q-item-label class="row items-center">
              <div class="col-1">진행일자</div>
              <div class="col row q-px-sm">
                <q-input v-model="startDate" square outlined dense type="date" />
                <span class="self-center q-px-md">~</span>
                <q-input v-model="endDate" square outlined dense type="date" />
                <q-btn-toggle
                  v-model="days"
                  no-caps
                  unelevated
                  toggle-color="primary"
                  class="q-ml-md"
                  @click="setDayTerm(days)" 
                  :options="[
                    {label: '오늘', value: 'today'},
                    {label: '7일', value: '7day'},
                    {label: '15일', value: '15day'},
                    {label: '1개월', value: '1month'},
                    {label: '3개월', value: '3month'},
                    {label: '1년', value: '1year'}
                  ]"
              ></q-btn-toggle>
              </div>
              <q-btn style="float: right;width: 100px;" label="검색" color="v-primary" />
            </q-item-label>
          </q-item-section>
        </q-item>
    </div>
  </q-page>
</template>

<style lang="sass">
.HealthNotes
  .q-btn-group > .q-btn-item
    border: solid 1px gray
</style>
