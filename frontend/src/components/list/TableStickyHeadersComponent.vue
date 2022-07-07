<script setup lang="ts">
import { ref, watch } from 'vue'
import { IResizeObserver } from 'src/types'

interface DragEvent {
  columns: { label: string; name: string }[]
  click: (element: any) => void
  edit: (element: any) => void
  delete: (element: any) => void
}
interface DragData {
  data: DragEvent
  debug: boolean
  items: any[]
  size: IResizeObserver
}
const props = withDefaults(defineProps<DragData>(), {
  data: <any>{
    get columns() {
      return []
    },
    click: (element: any) => {
      console.log(element)
      element.fixed = !element.fixed
    },
    edit: (element: any) => {
      console.log('edit', element)
    },
    delete: (element: any) => {
      console.log('delete', element)
    }
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
    list.value = items
  },
)

const selectedRow = ref<{ row: any; index: number } | null>()
const clickRow = (row: any, index: number) => {
  selectedRow.value = {
    row,
    index,
  }
  props.data.click && props.data.click(row)
}
</script>

<template>
  <div class="column">
    <q-virtual-scroll
      type="table"
      :style="{ height: (props.size == null ? 300 : props.size.height) + 'px' }"
      :virtual-scroll-item-size="38"
      :virtual-scroll-sticky-size-start="38"
      :virtual-scroll-sticky-size-end="32"
      :items="list"
    >
      <template v-slot:before>
        <thead class="thead-custom-sticky text-left">
          <tr>
            <th v-for="col in props.data.columns" :key="col.name" :class="`${col.columnClass || 'text-center'}`">
              {{ col.label }}
            </th>
            <th v-if="props.data.edit != null"></th>
            <th v-if="props.data.delete != null"></th>
          </tr>
        </thead>
      </template>

      <template v-slot="{ item: row, index }">
        <tr v-ripple:indigo-11 :key="index" @click="clickRow(row, index)" :class="{ selected: selectedRow?.index === index }">
          <td v-for="col in props.data.columns" :key="col.name" :class="`label ${col.textClass || 'text-center'}`" :style="`${col.style}`">
            <div v-if="col.type === 'img'" style="display: flex;justify-content: center">
              <img ref="profile" :src="row[col.name]" style="width: auto; height: 38px;" />
            </div>
            <div v-else>{{ row[col.name] }}</div>
          </td>
          <td class='action' v-if="props.data.edit != null">
            <q-btn flat dense round color="deep-purple-3" @click.stop="clickRow(row, index);props.data.edit(row)">
              <span class="material-icons edit text-v-primary"> edit </span>
            </q-btn>
          </td>
          <td class='action' v-if="props.data.delete != null">
            <q-btn flat dense round color="deep-purple-3" @click.stop="clickRow(row, index);props.data.delete(row)">
              <span class="material-icons edit text-grey-5"> delete_forever </span>
            </q-btn>
          </td>
        </tr>
      </template>
    </q-virtual-scroll>
  </div>
</template>

<style lang="sass" scoped>
.action
  width: 34px

.thead-custom-sticky tr > *
  position: sticky
  opacity: 1
  z-index: 1
  background-color: white
  color: black

.thead-custom-sticky tr:last-child > *
  top: 0

.q-table__card
  color: $v-gray3

.selected
  background: $v-gray9

.q-table tbody tr
  position: relative

.q-table tbody td
  font-size: 12px
  height: 40px
  padding: 0 16px

</style>
