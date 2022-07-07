<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { usePopupStore } from 'src/store/popup'
import { MenuDevPages } from 'src/types/MenusDev'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()
const popupIndex = popupStore.drawers.length
</script>

<template>
  <q-page class="q-gutter-lg">
    <div class="column col">PopupSample {{ popupIndex }}</div>
    <div class="row q-gutter-lg">
      <q-btn dense label="new open" @click="popupStore.newPopup(MenuDevPages.PopupSample)" color="primary" />
      <div v-if="popupIndex > 0">
        <q-btn dense label="delay all close" @click="popupStore.allCloseDelay()" />
        <q-btn dense label="all close" @click="popupStore.allClose()" />
      </div>
    </div>
  </q-page>
</template>

<style lang="sass" scoped></style>
