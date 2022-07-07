<script setup lang="ts">
import DrawersComponent from 'components/drawers/DrawersComponent.vue'
</script>
<template>
  <q-layout view="lHh Lpr lFf">
    <q-page-container class="full-height">
      <router-view />
    </q-page-container>
    <DrawersComponent />
  </q-layout>
</template>
