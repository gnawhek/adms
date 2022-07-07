<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { usePopupStore } from 'src/store/popup'
import { ViewPages } from 'src/types'
import { ref } from 'vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()

let tab = ref('week')
</script>

<template>
  <div class="FoodStatistics panel fit">
    <q-tabs
      v-model="tab"
      dense
      align="justify"
      active-color="primary"
      class="fit"
    >
      <q-tab :ripple="false" name="week" label="최근 7일" />
      <q-tab :ripple="false" name="month" label="최근 30일" />
    </q-tabs>

    <div class="empty_area" />

    <q-tab-panels v-model="tab" animated>
      <q-tab-panel name="week">
        <div class="text-h6">최근 7일</div>
        최근 7일
      </q-tab-panel>

      <q-tab-panel name="month">
        <div class="text-h6">최근 30일</div>
        최근 30일
      </q-tab-panel>
    </q-tab-panels>
  </div>
</template>

<style lang="sass">
div.FoodStatistics
  min-height: inherit
  .q-tab
    border-bottom: 1px solid $v-gray8
    padding: 10px 0

  .q-tab--inactive
    color: $v-gray4

  .q-tab__label
    font-size: 15px
    color: $v-primary
  
  .q-tab__indicator
    color: $v-primary

  div.empty_area
    height: 10px
    width: 100%
    background-color: #f5f5f5c9
</style>
