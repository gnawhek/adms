<script setup lang="ts">
import { useRoute } from 'vue-router'
import { menuToName } from 'src/utils'
import { ref } from 'vue'

const route = useRoute()

const searchOptions = [
  '이름', '아이디', '성별'
]
const habitItemOptions = [
  '건강노트', '건강미션'
]
const search = ref('이름')
const searchText = ref('')
const habitItem = ref('건강노트')
const habitItemText = ref('')
const date = ref('2021-09')

</script>

<template>
  <q-page class="HabitMonthParticipationRate column justify-start">
    <q-item-label header>{{ menuToName(route.path) }}</q-item-label>
    <q-separator color="black" inset class="q-mx-sm" />
     <div class="q-ma-lg" style="width: 60%;">
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
              <div class="col-1">습관항목</div>
              <div class="col-3 q-px-sm"><q-select square outlined dense v-model="habitItem" :options="habitItemOptions" /></div>
              <div class="col-3 q-px-sm"><q-input square outlined  dense v-model="habitItemText" /></div>
            </q-item-label>
          </q-item-section>
        </q-item>
        <q-item>
          <q-item-section>
            <q-item-label class="row items-center">
              <div class="col-1">월선택</div>
              <div class="col-6 row q-px-sm">
                <!-- 월선택 type으로 변경 핋요 -->
                <q-input v-model="date" square outlined dense type="date" />
              </div>
              <q-btn style="float: right;width: 100px;" label="검색" color="v-primary" />
            </q-item-label>
          </q-item-section>
        </q-item>
      </div>
  </q-page>
</template>

<style lang="sass">
.HabitMonthParticipationRate
</style>
