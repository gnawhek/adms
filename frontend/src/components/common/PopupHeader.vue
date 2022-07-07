<script setup lang="ts">
import { useAuthStore } from "src/store/auth";
import { useRouter } from "vue-router";
import { useStore } from "src/store";
import { PopupDrawer } from "src/types";
import ArrowBack from "components/mobile/ArrowBack.vue";
import { inject } from "vue";

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const props = defineProps<{ currentPopup?: PopupDrawer | null }>()

const headerExpose = {
  close: () => {
    props.currentPopup?.closeDrawer()
  }
}
defineExpose(headerExpose)
const myVariableThatIWantToProvide = inject('myVariableThatIWantToProvide', undefined)
</script>

<template>
  <q-header bordered class="bg-white text-black">
    <q-toolbar>
      <q-toolbar-title class="row">
        <ArrowBack v-if="currentPopup != null" :currentPopup="currentPopup" />
        <div class="absolute-center title">{{ $t(myVariableThatIWantToProvide || currentPopup?.title || '') }}</div>
      </q-toolbar-title>
    </q-toolbar>
  </q-header>
</template>

<style lang="sass" scoped>
@import "src/css/title"
</style>
