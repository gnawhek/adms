<script setup lang="ts">
import { useQuasar } from 'quasar'
import { defineAsyncComponent } from 'vue'
import { useLocalStore } from 'src/store/local'
import DrawersComponent from 'components/drawers/DrawersComponent.vue'

const localStore = useLocalStore()
localStore.isShowMainLayout = true

const $q = useQuasar()
const ViewLayout = defineAsyncComponent(() => {
  if ($q.platform.is.desktop) {
    return import('./desktop/DesktopLayout.vue')
  } else if ($q.platform.is.mobile) {
    return import('./mobile/MobileLayout.vue')
  }
  return import('./UnknownDevice.vue')
})
</script>

<template>
  <q-layout>
    <ViewLayout></ViewLayout>
    <DrawersComponent />
  </q-layout>
</template>
