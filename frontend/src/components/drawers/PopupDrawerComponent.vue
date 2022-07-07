<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { usePopupStore } from 'src/store/popup'
import { defineAsyncComponent, onMounted, ref } from 'vue'
import { PopupDrawer } from 'src/types'
import ArrowBack from 'components/mobile/ArrowBack.vue'

const authStore = useAuthStore()
const popupStore = usePopupStore()

interface Props {
  index: number
  currentPopup: PopupDrawer
}

const props = withDefaults(defineProps<Props>(), { index: 0 })
// const props = withDefaults(defineProps<{index: number}>(), { index: 0 })
// const popup = popupStore.drawers[props.index]

const Component = props.currentPopup.getComponent()

const view = ref()

function headerFixed() {
  view.value = 'hHh lpR fFf'
}

function headerUnFixed() {
  view.value = 'hhh lpR fFf'
}

props.currentPopup.closeDrawer = (timeout?, callback?: () => void) => {
  removePopup(timeout, callback)
}

function removePopup(timeout = 500, callback?: () => void) {
  if (props.currentPopup.isActionClose) {
    callback && callback()
    return
  }

  props.currentPopup.closePopup()

  setTimeout(() => {
    popupStore.removePopup()
    setTimeout(() => {
      callback && callback()
    })
  }, timeout)
}

onMounted(() => {
  headerFixed()
  setTimeout(() => {
    props.currentPopup.drawerOpen = true
  })
})

const onHide = () => {
  removePopup(0)
}
</script>

<template>
  <q-drawer v-model="props.currentPopup.drawerOpen" side="right" overlay bordered behavior="mobile" :width="$q.screen.width" @hide="onHide" :no-swipe-close="props.currentPopup.noSwipeClose">
    <q-layout :view="view">
      <q-header bordered class="bg-white text-black">
        <q-toolbar>
          <q-toolbar-title class="row">
            <ArrowBack v-if="props.currentPopup != null" :currentPopup="props.currentPopup" />
            <div class="absolute-center title">{{ $t(props.currentPopup.title) }}</div>
          </q-toolbar-title>
        </q-toolbar>
      </q-header>

      <q-page-container>
        <q-page class="column">
          <component :is="Component" :currentPopup="props.currentPopup"></component>
        </q-page>
      </q-page-container>
    </q-layout>
  </q-drawer>
</template>

<style lang="sass" scoped>
@import "src/css/title"
</style>
