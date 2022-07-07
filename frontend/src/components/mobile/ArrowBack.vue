<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { computed, ref } from 'vue'
import { PopupDrawer } from 'src/types'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const props = defineProps<{ currentPopup?: PopupDrawer | null }>()
</script>

<template>
<!--  <q-btn v-if="props.currentPopup != null" flat round icon="arrow_back" @click="props.currentPopup?.closeDrawer" class="text-black" />-->
  <q-btn v-if="props.currentPopup != null" @click="props.currentPopup?.closeDrawer" flat round color="deep-purple-3">
    <q-icon size="19px">
      <img src="~assets/images/main/btn_back.svg" />
    </q-icon>
  </q-btn>
</template>

<style lang="sass" scoped></style>
