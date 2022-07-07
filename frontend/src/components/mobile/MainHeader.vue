<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { computed, ref } from 'vue'
import { PopupDrawer } from 'src/types'
import ArrowBack from 'components/mobile/ArrowBack.vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const props = defineProps<{ currentPopup?: PopupDrawer,
  tab: string
}>()

const isNotice = ref(true)
const noticeSvg = computed(() => {
  const opacity = isNotice.value ? 1 : 0
  const color = props.tab === 'habit'? 'white' :'%23444'
  return `img:data:image/svg+xml;charset=utf8,<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 22c1.1 0 2-.9 2-2h-4c0 1.1.9 2 2 2zm6-6v-5c0-3.07-1.63-5.64-4.5-6.32V4c0-.83-.67-1.5-1.5-1.5s-1.5.67-1.5 1.5v.68C7.64 5.36 6 7.92 6 11v5l-2 2v1h16v-1l-2-2zm-2 1H8v-6c0-2.48 1.51-4.5 4-4.5s4 2.02 4 4.5v6z" fill="${color}"/><ellipse cx="21.5" cy="2.784" rx="2.5" ry="2.529" fill="%23FB4542" opacity="${opacity}"/></svg>`
})
const logout = () => {
  authStore.logout()
  router.push({ path: '/login' })
}
console.log('props: ' + props)
</script>

<template>
  <q-toolbar :class="{ 'habit-header':props.tab === 'habit'}">
    <q-toolbar-title class="row text-black">
      <ArrowBack :currentPopup="props.currentPopup" />
      <q-avatar @click="logout">
        <img src="~assets/images/main/img_account_circle.svg" />
      </q-avatar>
      <q-page-sticky v-if="props.currentPopup == null" position="bottom-left" :offset="[18, 18]">
        <q-btn flat dense color="orange-14" size="md" @click="authStore.toggleStaff" label="Staff 전환(On/Off)" no-caps> </q-btn>
      </q-page-sticky>
      <q-space />
      <div v-if="props.tab === 'habit'" class="absolute-center title text-white">TODAY</div>
      <q-btn flat round color="deep-purple-3" class="text-white" size="md" @click="isNotice = !isNotice">
        <q-icon size="24px" :name="noticeSvg" />
      </q-btn>
    </q-toolbar-title>
  </q-toolbar>
</template>

<style lang="sass" scoped>
</style>
