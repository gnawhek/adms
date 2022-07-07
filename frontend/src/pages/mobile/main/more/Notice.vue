<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { reactive, ref, onMounted, nextTick } from 'vue'
import { usePopupStore } from 'src/store/popup'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()

const search = ref('전체')
let params
onMounted(() => {
  nextTick(() => {
    console.log('onMounted///', popupStore)
    const currentPopupIndex =popupStore.drawers.length - 1
    params = popupStore.drawers[currentPopupIndex].params
  })
})

const loadNotice = (id: number) => {
  // api
}
</script>

<template>
  <div class="Notice q-pa-md">
    <q-list>
      <q-item>
        <q-item-section>
          <q-item-label class="notice-title text-h6">건강노트 기능 안내</q-item-label>
          <q-item-label class="q-py-sm notice-date" caption>2021.07.23</q-item-label>
        </q-item-section>
      </q-item>
      <q-separator spaced></q-separator>
      <q-item>
        <q-item-section>
          <q-item-label class="notice-content">
            <pre >
            안녕하세요 
            셀시스 운영진입니다

            건강노트 기능에 대해 궁금하신가요?
            건강노트한 식습관, 체중, 배변 등을 매일 기록하여
            나의 생활 패턴을 분석하고 개선할 수 있는 기능입니다.

            건강노트 기능에 대해 궁금하신가요?
            건강노트한 식습관, 체중, 배변 등을 매일 기록하여
            나의 생활 패턴을 분석하고 개선할 수 있는 기능입니다.

            건강노트 기능에 대해 궁금하신가요?
            건강노트한 식습관, 체중, 배변 등을 매일 기록하여
            나의 생활 패턴을 분석하고 개선할 수 있는 기능입니다.
            건강노트한 식습관, 체중, 배변 등을 매일 기록하여
            나의 생활 패턴을 분석하고 개선할 수 있는 기능입니다

            감사합니다.
            셀시스 운영진 올림.
            </pre>
          </q-item-label>
        </q-item-section>
      </q-item>
    </q-list>
  </div>
</template>

<style lang="sass">
.Notice
  .notice-title
    font-size
  .notice-date 
    font-size: 1em
    color: $v-gray5
  .notice-content
    pre
      white-space: pre-line
      font-family: none
      color: $v-gray2
</style>
