<script setup lang="ts">
import { SYS_CODE } from 'src/types'
import { useVModel } from '@vueuse/core'
import { onMounted, PropType, ref, watch } from 'vue'
import { sysCodeToValues } from 'src/utils'
import { SELECT_ALG_SEX_LIST } from 'src/api/admin-api'
import { useCodeStore } from 'src/store/local'

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

const items = ref<[SYS_CODE[]]>([[]])
const selected = ref<SYS_CODE[]>([])
watch(selected, () => (value.value = sysCodeToValues(selected.value)))
watch(items, () => {
  selected.value = items.value?.flatMap<SYS_CODE>((d) => d).filter((d) => (value.value + ';').indexOf(d.C_CODE + ';') != -1)
})

onMounted(async () => {
  items.value = await useCodeStore().pwiTypes()
})
</script>

<template>
  <div class="column inline items-start pwi-container full-width">
    <template v-for="types in items" :key="types">
      <div v-for="item in types" :key="item" class="pwi-cell" tabindex="0">
        <q-checkbox size="xs" v-model="selected" :label="item.N_CODE" :val="item" />
      </div>
      <div class="flex-break q-px-xs" />
    </template>
  </div>
</template>

<style lang="sass" scoped>
.flex-break
  flex: 1 0 100% !important
  width: 0 !important

.pwi-container
  height: 180px

  .pwi-cell
    //box-shadow: inset 0 0 0 2px $grey-6
    width: 14%

  .flex-break
    border-left: 1px solid $grey-4

  .flex-break:last-child
    border: none
</style>
