<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { onMounted, onUnmounted, ref } from 'vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()

let tab = ref('mails')
</script>

<template>
  <div class="BowelStatistics panel fit">
    <q-tabs
      v-model="tab"
      dense
      align="justify"
      active-color="primary"
      class="fit"
    >
      <q-tab :ripple="false" name="mails" label="최근 7일" />
      <q-tab :ripple="false" name="alarms" label="최근 30일" />
    </q-tabs>

    <div class="empty_area" />

    <q-tab-panels v-model="tab" animated>
      <q-tab-panel name="mails">
        <div class="text-h6">최근 7일</div>
        최근 7일
      </q-tab-panel>

      <q-tab-panel name="alarms">
        <div class="text-h6">최근 30일</div>
        최근 30일
      </q-tab-panel>
    </q-tab-panels>
  </div>
</template>

<style lang="sass" scoped>
div.BowelStatistics
  min-height: inherit

  ::v-deep(.q-tab)
    border-bottom: 1px solid $v-gray8
    padding: 10px 0

  ::v-deep(.q-tab--inactive)
    color: $v-gray4

  ::v-deep(.q-tab__label)
    font-size: 15px

  div.empty_area
    height: 10px
    width: 100%
    background-color: #f5f5f5c9

</style>
