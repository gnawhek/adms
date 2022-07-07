<template>
  <div class="row">
    <div class="column">
      <p>Global TestComponent</p>
      <p>useStore count: {{ $store.count }}</p>
      <p>authStore token: {{ authStore.getAccessToken() }}</p>
      <p>{{ $t('main.success') }}</p>
      <div class="q-field__native">dma</div>
    </div>
    <div class="row items-start justify-start">
      <!--      <pre>{{ $store }}</pre>-->
      <!--      <pre>{{ authStore }}</pre>-->
    </div>
  </div>
</template>

<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useStore } from 'src/store'

const $store = useStore()
const authStore = useAuthStore()
</script>
