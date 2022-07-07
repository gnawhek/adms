<script lang="ts">
import { defineComponent } from 'vue'
import 'src/assets/fonts/nanumsquare.css'
import 'src/assets/fonts/notosanskr.css'
import RootAppComponent from 'src/components/RootAppComponent.vue'

export default defineComponent({
  name: 'App',
  components: { RootAppComponent },
  setup() {
    return {}
  },
})
</script>

<template>
  <router-view />
  <RootAppComponent />
</template>

<style lang="sass" scoped></style>
