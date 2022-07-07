<script setup lang="ts">
import { SYS_CODE } from 'src/types'
import { useVModel } from '@vueuse/core'
import { onMounted, ref, watch } from 'vue'
import { sysCodeToValues } from 'src/utils'
import SysCodeComponent from 'components/desktop/SysCodeComponent.vue'
import { useCodeStore } from 'src/store/local'
import { codeWatch } from 'src/utils/common'

const emit = defineEmits<{
  (name: 'modelValue', v: string): void
}>()

const props = defineProps({
  modelValue: {
    default: '',
  },
})

const value = useVModel(props, 'modelValue', emit)
const items = ref<SYS_CODE[]>([])
const selected = ref<SYS_CODE[]>([])

codeWatch(value, items, selected)

onMounted(async () => {
  items.value = await useCodeStore().ages()
})
</script>

<template>
  <div class="column inline items-start age-container">
    <SysCodeComponent v-model="items" v-slot:default="slotProps">
      <div class="age-cell" tabindex="0" v-for="item in slotProps.models" :key="item">
        <q-checkbox size="xs" v-model="selected" :label="item.N_CODE" :val="item" />
      </div>
    </SysCodeComponent>
  </div>
</template>

<style lang="sass" scoped>
.age-container
  height: 63px

  .age-cell
    width: 150px
</style>
