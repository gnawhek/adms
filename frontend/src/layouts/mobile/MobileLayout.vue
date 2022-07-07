<template>
  <component :is="View" />
  <!--  <ViewLayout></ViewLayout>-->
</template>

<script setup lang="ts">
import { computed, defineAsyncComponent } from 'vue'
import { useAuthStore } from 'src/store/auth'

const authStore = useAuthStore()
const View = computed(() => {
  return authStore.isStaff()
    ? defineAsyncComponent(() => import('../../pages/mobile/staff/StaffMain.vue'))
    : defineAsyncComponent(() => import('../../pages/mobile/main/UserMain.vue'))
})

// const ViewLayout = defineAsyncComponent(() => {
//   if (authStore.isStaff()) {
//     return import('../../pages/mobile/staff/StaffMain.vue')
//   } else {
//     return import('../../pages/mobile/main/UserMain.vue')
//   }
// })
</script>
