<script setup lang="ts">
import draggable from 'vuedraggable'
import { computed, ref, watch } from 'vue'
import { IResizeObserver } from 'src/types'

interface DragEvent {
  columns: { label: string; name: string }[]
  click: (element: any, index: number) => void
  edit: (element: any) => void
  delete: (element: any) => void
  checkMove: (evt: any) => void
  onChange: (evt: any, list: any[]) => void
  onEnd: (evt: any) => void
}
interface DragData {
  data: DragEvent
  debug: boolean
  items: any[]
  size: IResizeObserver
  dragDisabled: boolean
}
const props = withDefaults(defineProps<DragData>(), {
  data: <any>{
    get columns() {
      return []
    },
    click: (element: any, index: number) => {
      console.log(element)
      element.fixed = !element.fixed
    },
    edit: (element: any) => {
      console.log('edit', element)
    },
    delete: (element: any) => {
      console.log('delete', element)
    },
    checkMove: (evt: any) => {
      return evt.from == evt.to
    },
    onChange: (evt: any, list: any[]) => {
      console.log('onChange', evt, list)
    },
    onEnd: (evt: any) => {
      console.log('onEnd', evt)
    },
  },
  items: () => <any[]>[],
  debug: false,
  size: () => <IResizeObserver>{ width: 500, height: 500 },
})

let list = ref<any[]>()
watch(
  () => props.items,
  (items) => {
    selectedRow.value = null
    list.value = items?.map((item: any, index) => {
      item.order = index + 1
      return item
    })
  },
)

const drag = ref<boolean>(false)
const dragDisabled = ref<boolean>(true)
const disabled = computed(() => {
  return props.dragDisabled || dragDisabled.value
})
const dragOptions = computed(() => ({
  animation: 200,
  group: 'listgroup',
  disabled: disabled.value,
  ghostClass: 'ghost',
  direction: 'vertical',
  delay: 200,
  delayOnTouchOnly: true,
  onChange: (evt: any) => {
    props.data.onChange(evt, list.value as any[])
  },
  // 요소 드래그 종료 시
  onEnd: props.data.onEnd,
}))

const selectedRow = ref<{ row: any; index: number } | null>()
const clickRow = (row: any, index: number) => {
  selectedRow.value = {
    row,
    index,
  }
  props.data.click && props.data.click(row, index)
}
</script>

<template>
  <div class="column q-table__card" :style="{ height: props.size == null ? 0 : props.size.height + 'px', overflow: 'auto' }">
    <table>
      <thead class="thead-custom-sticky text-left">
        <tr>
          <th v-for="col in props.data.columns" :key="col.name" :class="`${col.columnClass || 'text-center'}`">
            {{ col.label }}
          </th>
          <th></th>
          <th v-if="props.data.edit != null"></th>
          <th v-if="props.data.delete != null"></th>
          <th class="dummy"></th>
        </tr>
      </thead>
      <!-- prettier-ignore -->
      <draggable v-model="list" v-bind="dragOptions" tag="tbody"
       @start="drag = true"
       @end="drag = false"
       item-key="order"
       :move="props.data.checkMove"
      >
        <template #item="{ element, index }">
          <tr v-ripple:indigo-11 class="list-group-item"  @click="clickRow(element, index)" :class="{ selected: selectedRow?.row === element }">
            <td v-for="col in props.data.columns" :key="col.name" :class="`label ${col.textClass || 'text-center'}`" :style="`${col.style}`" @mouseenter="dragDisabled = true">
              <div v-if="col.type === 'img'" style="display: flex;justify-content: center">
                <img ref="profile" :src="element[col.name]" style="width: auto; height: 38px;" />
              </div>
              <div :style="`${col.divStyle}`" v-else>{{ element[col.name] }}</div>
            </td>
            <td class='action'>
              <q-btn flat dense color="deep-purple-3" class="move" @mouseenter="dragDisabled = false" v-if="!props.dragDisabled">
                <span class="material-icons text-v-primary" title="이동"> dehaze </span>
              </q-btn>
            </td>
            <td class='action' v-if="props.data.edit != null">
              <q-btn flat dense round color="deep-purple-3" @click.stop="clickRow(element, index);props.data.edit(element)">
                <span class="material-icons edit text-v-primary"> edit </span>
              </q-btn>
            </td>
            <td class='action' v-if="props.data.delete != null">
              <q-btn flat dense round color="deep-purple-3" @click.stop="clickRow(element, index);props.data.delete(element)">
                <span class="material-icons edit text-grey-5"> delete_forever </span>
              </q-btn>
            </td>
            <td class='dummy'><div></div></td>
          </tr>
        </template>
      </draggable>
    </table>
  </div>
</template>

<style lang="sass" scoped>
.q-table__card
  border-radius: 0

.button
  margin-top: 35px

.flip-list-move
  transition: transform 0.5s

.no-move
  transition: transform 0s

.ghost
  opacity: 0.5
  background: #c8ebfb

.action
  width: 34px

.material-icons
  font-size: 19px

table
  border-spacing: 0

table .dummy
  padding: 0 !important
  width: 0 !important
  div
    min-height: 34px

.thead-custom-sticky tr > *
  position: sticky
  opacity: 1
  z-index: 1
  background-color: white
  color: black

.thead-custom-sticky tr:last-child > *
  top: 0

thead
  height: 48px

.selected
  background: $v-gray8

.list-group-item
  color: $v-gray3
  position: relative

.list-group-item:hover
  background: $v-gray10

.list-group-item td, thead th
  border-bottom: 1px solid rgba(0, 0, 0, 0.125)
  padding: 2px 10px

.list-group-item .move
  cursor: move

.list-group-item + .list-group-item
  border-top-width: 0
</style>
