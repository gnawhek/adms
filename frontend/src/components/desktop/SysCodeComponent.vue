<script setup lang="ts">
import { SYS_CODE } from 'src/types'
import { useVModel } from '@vueuse/core'
import { PropType, ref, watch } from 'vue'
import { sysCodeToValues } from 'src/utils'

const emit = defineEmits<{
  (name: 'modelValue', v: SYS_CODE[]): void
}>()

const props = defineProps({
  modelValue: {
    type: Array as PropType<SYS_CODE[]>,
    default: <SYS_CODE[]>[],
  },
})

const value = useVModel(props, 'modelValue', emit)
</script>

<template>
  <slot :models="value" />
</template>

<style lang="sass" scoped></style>
