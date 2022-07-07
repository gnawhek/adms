<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { onMounted, onUnmounted } from "vue";
import HealthManagement from 'src/pages/mobile/main/habit/components/HealthManagement.vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
onMounted(() => {
  console.log('onMounted')
})

onUnmounted(() => {
  console.log('onUnmounted')
})
</script>

<template>
  <div class="panel q-pa-md">
    <div class="column col text-h5 q-mb-xl">홈 메인</div>
    <q-card class="my-card">
      <q-parallax src="https://cdn.quasar.dev/img/parallax1.jpg" :height="150" />

      <q-card-section>
        <div class="text-h6">타이틀</div>
        <div class="text-subtitle2">내용</div>
      </q-card-section>
    </q-card>
    <q-card class="my-card">
      <q-parallax src="https://cdn.quasar.dev/img/parallax1.jpg" :height="150" />

      <q-card-section>
        <div class="text-h6">타이틀</div>
        <div class="text-subtitle2">내용</div>
      </q-card-section>
    </q-card>
    <q-card class="my-card">
      <q-card-section>
        <HealthManagement />
      </q-card-section>
    </q-card>
    <q-card class="my-card">
      <q-parallax src="https://cdn.quasar.dev/img/parallax1.jpg" :height="150" />

      <q-card-section>
        <div class="text-h6">타이틀</div>
        <div class="text-subtitle2">내용</div>
      </q-card-section>
      <q-card class="my-card">
        <q-parallax src="https://cdn.quasar.dev/img/parallax1.jpg" :height="150" />

        <q-card-section>
          <div class="text-h6">타이틀</div>
          <div class="text-subtitle2">내용</div>
        </q-card-section>
      </q-card>
      <q-card class="my-card">
        <q-parallax src="https://cdn.quasar.dev/img/parallax1.jpg" :height="150" />

        <q-card-section>
          <div class="text-h6">타이틀</div>
          <div class="text-subtitle2">내용</div>
        </q-card-section>
      </q-card>
      <q-card class="my-card">
        <q-parallax src="https://cdn.quasar.dev/img/parallax1.jpg" :height="150" />

        <q-card-section>
          <div class="text-h6">타이틀</div>
          <div class="text-subtitle2">내용</div>
        </q-card-section>
      </q-card>
    </q-card>
  </div>
</template>

<style lang="sass" scoped>
</style>
