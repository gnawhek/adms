<script setup lang="ts">
import { useRoute } from 'vue-router'
import { menuToName } from 'src/utils'

const route = useRoute()
</script>

<template>
  <q-page class="column items-center justify-start">
    <q-item-label header>{{ menuToName(route.path) }}</q-item-label>
  </q-page>
</template>

<style lang="sass" scoped></style>
