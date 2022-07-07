<template>
  <q-page class="column items-center justify-start">
    <div>page2</div>
    <div class="q-pa-md q-gutter-sm">
      <q-btn color="primary" label="login" @click="login" :to="{ path: '/' }" />
      <q-btn color="primary" label="login push" @click="login" />
      <q-btn color="primary" label="toggle count" @click="$store.count++" />
    </div>
    <TestComponent></TestComponent>
  </q-page>
</template>

<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()

// window['$store'] = $store;
// window['authStore'] = authStore;

const login = () => {
  authStore.setAccessToken('login_token_authenticated')

  router.push({ path: '/' })
}
</script>
