<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { PopupDrawer } from 'src/types'
import ArrowBack from 'components/mobile/ArrowBack.vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const props = defineProps<{ currentPopup?: PopupDrawer | null }>()
</script>

<template>
  <PopupHeader v-if="currentPopup != null" :currentPopup="currentPopup" />
  <q-page-container>
    <div class="column col absolute-center message">회원 등록 개발 예정</div>
  </q-page-container>
</template>

<style lang="sass" scoped>
@import "src/css/title"

.message
  color: $v-gray5
</style>
