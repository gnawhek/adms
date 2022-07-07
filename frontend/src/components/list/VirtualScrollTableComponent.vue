<script setup lang="ts">
import { onMounted, ref, watch } from 'vue'
import { QTable } from 'quasar'
import { LooseDictionary } from 'quasar/dist/types/ts-helpers'

const qtable = ref<QTable>()
const myProps = defineProps<{
  initQTable?: (qtable: QTable | undefined) => void
  columns: any[]
  rows: any[]
  rowKey: string
  height?: string
  offsetHeight?: number
  onSelected?: (row: any) => void
  onChecked?: (rows: any[]) => void
  selectLabel?: string
  hidePagination: boolean
  title?: string
  selection: 'none' | 'single' | 'multiple'
  bordered: boolean
}>()

const pagination = ref({
  rowsPerPage: 0,
})

const emit = defineEmits<{
  (e: 'rowClick', evt: PointerEvent, row: LooseDictionary, index: number, column: LooseDictionary): void
}>()

const selected = ref<any[]>([])
const onRowClick = (evt: any, row: any, index: number) => {
  if (myProps.selection == null || myProps.selection == 'none') {
    selected.value = [row]
  }

  let col = -1
  evt.path[1].childNodes.forEach((d: EventTarget | null, i: number) => {
    if (evt.target == d) {
      col = i
    }
  })
  emit('rowClick', evt, Object.assign({}, row), index, Object.assign({}, col == -1 ? null : (qtable.value?.columns || [])[col]))
}
watch(selected, (newValue) => {
  myProps.onChecked?.(newValue)
})

onMounted(() => {
  myProps.initQTable?.(qtable.value)
})
</script>

<template>
  <div class="q-pa-none">
    <q-table
      ref="qtable"
      flat
      :bordered="myProps.bordered"
      class="my-sticky-virtscroll-table"
      virtual-scroll
      v-model:pagination="pagination"
      :rows-per-page-options="[0]"
      :hide-pagination="myProps.hidePagination"
      :virtual-scroll-sticky-size-start="48"
      :row-key="myProps.rowKey"
      :title="myProps.title"
      :rows="myProps.rows"
      :columns="columns"
      :style="`height: calc(${myProps.height == null ? '100vh' : myProps.height} - ${myProps.offsetHeight == null ? 0 : myProps.offsetHeight}px`"
      no-data-label="데이터가 없습니다."
      :selection="myProps.selection || 'none'"
      v-model:selected="selected"
      @row-click="onRowClick"
    >
      <template v-slot:body-cell-selectRow="props">
        <q-td :props="props">
          <q-btn outline dense class="q-px-sm" color="grey-14" :label="myProps.selectLabel || props.value" @click.stop="myProps.onSelected(props.row)" />
        </q-td>
      </template>
      <template v-slot:no-data="{ icon, message, filter }">
        <div class="full-width row flex-center text-accent q-gutter-sm">
          <q-icon size="2em" :name="filter ? 'filter_b_and_w' : icon" />
          <span>{{ message }}</span>
        </div>
      </template>
    </q-table>
  </div>
</template>

<style lang="sass" scoped>
::v-deep(.my-sticky-virtscroll-table)
  /* height or max-height is important */
  //height: calc(100vh - 51px)

  .q-table__top,
  .q-table__bottom,
  thead tr:first-child th /* bg color is important for th; just specify one */
    background-color: #fff

  thead tr th
    position: sticky
    z-index: 1
  /* this will be the loading indicator */
  thead tr:last-child th
    /* height of all previous header rows */
    top: 48px
  thead tr:first-child th
    top: 0

  tr > td
    color: #666666
    font-size: 12px
</style>
