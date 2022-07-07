<script setup lang="ts">
import { usePopupStore } from 'src/store/popup'
import PopupDrawerComponent from 'components/drawers/PopupDrawerComponent.vue'

const popupStore = usePopupStore()
</script>

<template>
  <template v-for="(_, index) in popupStore.drawers" :key="_.index">
    <PopupDrawerComponent :index="index" :currentPopup='_'></PopupDrawerComponent>
  </template>
</template>
