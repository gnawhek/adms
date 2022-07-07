<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { usePopupStore } from 'src/store/popup'
import { MenuPages } from 'src/types'
import { useStaffStore } from 'src/store/staff'
import { useLocalStore } from 'src/store/local'

const loginUser = useAuthStore().loginUser
const popupStore = usePopupStore()
const staffStroe = useStaffStore()
const localStore = useLocalStore()
</script>

<template>
  <q-page class="column justify-start q-ma-lg">
    <q-item-label header>메인 화면: frontend/src/_dev/pages/Index.vue</q-item-label>
    <q-item-label header>ServerConfig 정보</q-item-label>
    <q-item-label caption>
      <pre class="q-ml-lg">{{ $serverConfig }}</pre>
    </q-item-label>
    <q-item-label header>로그인 정보</q-item-label>
    <q-item-label caption>
      <pre class="q-ml-lg">{{ loginUser }}</pre>
    </q-item-label>
    <q-item-label header>staffStore 정보</q-item-label>
    <q-item-label caption>
      <pre class="q-ml-lg">{{ staffStroe }}</pre>
    </q-item-label>
    <q-item-label header>localStore 정보</q-item-label>
    <q-item-label caption>
      <pre class="q-ml-lg">{{ localStore }}</pre>
    </q-item-label>
  </q-page>
</template>

<style lang="sass" scoped></style>
