<script setup lang="ts">
import { SYS_CODE } from 'src/types'
import { useVModel } from '@vueuse/core'
import { onMounted, ref, watch } from 'vue'
import { sysCodeToValues } from 'src/utils'
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
  items.value = useCodeStore().weeks()
})
</script>

<template>
  <div class="row">
    <div class="col" tabindex="0" v-for="item in items" :key="item">
      <q-checkbox size="xs" v-model="selected" :label="item.N_CODE" :val="item" />
    </div>
  </div>
</template>

<style lang="sass" scoped></style>
