<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { reactive, ref} from 'vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()

const noticeMenus = reactive([
  {title: '1:1 상담', value: false},
  {title: '셀로그', value: false},
  {title: '습관', value: true, subMenus: [
    {title: '식사기록', value: false},
    {title: '수분섭취', value: false},
    {title: '배변기록', value: true},
    {title: '걷기', value: true},
    {title: '따라하기', value: false},
  ]},
  {title: '이벤트 및 공지사항', value: false},
  {title: '분석', value: false},
])
const value = ref(false)
</script>

<template>
  <div class="PushPrefence q-pa-md">
    <q-item
      v-for="(menu, index) in noticeMenus"
      :key="index"
      class="q-pa-sm">
      <q-item-section>
        <q-item-label class="row justify-between q-pb-md">
          <div class="text-h6 text-v-gray1 self-center">{{ menu.title }}</div>
          <q-toggle
            v-model="menu.value"
            size="xl"
            color="primary"
          ></q-toggle>
        </q-item-label>
        <q-item-label v-show="menu.subMenus" class="column q-pb-md">
          <div
            v-for="(subMenu, index) in menu.subMenus" 
            :key="index"
            class="row">
            <div class="col text-h6 text-v-gray3 self-center q-pl-lg">{{ subMenu.title }}</div>
            <q-toggle
            v-model="subMenu.value"
            size="xl"
            color="primary"
          ></q-toggle>
          </div>
        </q-item-label>
        <q-separator v-show="menu.title !== '분석'" color="v-gray8" spaced />
      </q-item-section>
    </q-item>
  </div>
</template>

<style lang="sass">
.PushPrefence
  .q-toggle__track
    opacity: 1

  .q-toggle__inner--falsy .q-toggle__track
    background: $v-gray7
    
  .q-toggle__inner--truthy .q-toggle__thumb:after
    background: $v-white

</style>
