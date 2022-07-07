<script setup lang="ts">
import { SYS_CODE } from 'src/types'
import { useVModel } from '@vueuse/core'
import { onMounted, PropType, ref, watch } from 'vue'
import { sysCodeToValues } from 'src/utils'
import { SELECT_ALG_SEX_LIST } from 'src/api/admin-api'
import { useCodeStore } from 'src/store/local'
import { codeWatch } from 'src/utils/common'

const emit = defineEmits<{
  (name: 'modelValue', v: string): void
  // (name: 'models', v: SYS_CODE[]): void
}>()

const props = defineProps({
  modelValue: {
    default: '',
  },
  // models: Array as PropType<SYS_CODE[]>,
})

const value = useVModel(props, 'modelValue', emit)
// const models = useVModel(props, 'models', emit)
const items = ref<SYS_CODE[]>([])
const selected = ref<SYS_CODE[]>([])

codeWatch(value, items, selected)

onMounted(async () => {
  items.value = await useCodeStore().sexuality()
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
