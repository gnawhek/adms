<script setup lang="ts">
import VirtualScrollTableComponent from 'components/list/VirtualScrollTableComponent.vue'
import { useLocalStore } from 'src/store/local'
import { ref } from 'vue'
import { QTable } from 'quasar'
const localStore = useLocalStore()

const columns = [
  {
    name: 'index',
    label: '#',
    field: 'index',
  },
  {
    name: 'name',
    required: true,
    label: 'Dessert (100g serving)',
    align: 'left',
    field: (row: any) => row.name,
    format: (val: any) => `${val}`,
    sortable: true,
  },
  { name: 'calories', align: 'center', label: 'Calories', field: 'calories', sortable: true },
  { name: 'fat', label: 'Fat (g)', field: 'fat', sortable: true },
  { name: 'carbs', label: 'Carbs (g)', field: 'carbs' },
  { name: 'protein', label: 'Protein (g)', field: 'protein' },
  { name: 'sodium', label: 'Sodium (mg)', field: 'sodium' },
  { name: 'calcium', label: 'Calcium (%)', field: 'calcium', sortable: true, sort: (a: any, b: any) => parseInt(a, 10) - parseInt(b, 10) },
  { name: 'iron', label: 'Iron (%)', field: 'iron', sortable: true, sort: (a: any, b: any) => parseInt(a, 10) - parseInt(b, 10) },
  { name: 'selectRow', label: '', field: 'name' },
]

const seed = [
  {
    name: 'Frozen Yogurt',
    calories: 159,
    fat: 6.0,
    carbs: 24,
    protein: 4.0,
    sodium: 87,
    calcium: '14%',
    iron: '1%',
  },
  {
    name: 'Ice cream sandwich',
    calories: 237,
    fat: 9.0,
    carbs: 37,
    protein: 4.3,
    sodium: 129,
    calcium: '8%',
    iron: '1%',
  },
  {
    name: 'Eclair',
    calories: 262,
    fat: 16.0,
    carbs: 23,
    protein: 6.0,
    sodium: 337,
    calcium: '6%',
    iron: '7%',
  },
  {
    name: 'Cupcake',
    calories: 305,
    fat: 3.7,
    carbs: 67,
    protein: 4.3,
    sodium: 413,
    calcium: '3%',
    iron: '8%',
  },
  {
    name: 'Gingerbread',
    calories: 356,
    fat: 16.0,
    carbs: 49,
    protein: 3.9,
    sodium: 327,
    calcium: '7%',
    iron: '16%',
  },
  {
    name: 'Jelly bean',
    calories: 375,
    fat: 0.0,
    carbs: 94,
    protein: 0.0,
    sodium: 50,
    calcium: '0%',
    iron: '0%',
  },
  {
    name: 'Lollipop',
    calories: 392,
    fat: 0.2,
    carbs: 98,
    protein: 0,
    sodium: 38,
    calcium: '0%',
    iron: '2%',
  },
  {
    name: 'Honeycomb',
    calories: 408,
    fat: 3.2,
    carbs: 87,
    protein: 6.5,
    sodium: 562,
    calcium: '0%',
    iron: '45%',
  },
  {
    name: 'Donut',
    calories: 452,
    fat: 25.0,
    carbs: 51,
    protein: 4.9,
    sodium: 326,
    calcium: '2%',
    iron: '22%',
  },
  {
    name: 'KitKat',
    calories: 518,
    fat: 26.0,
    carbs: 65,
    protein: 7,
    sodium: 54,
    calcium: '12%',
    iron: '6%',
  },
]

// we generate lots of rows here
let rows: any[] = []
for (let i = 0; i < 1000; i++) {
  rows = rows.concat(seed.slice(0).map((r) => ({ ...r })))
}
rows.forEach((row, index) => {
  row.index = index
})

const onRowClick = (evt: any, row: any, index: any, column: any) => {
  console.log('onRowClick', evt)
  console.log('row', index, row)
  console.log('column', column)
  console.log('')
}

const onSelected = (row: any) => {
  console.log('row', row)
}

const onChecked = (rows: any[]) => {
  console.log(rows)
  // console.log(qtable.selected)
}

const qtable = ref<QTable>()
const initQTable = (table: QTable) => {
  qtable.value = table
}

const allSelected = (state: boolean) => {
  qtable.value?.clearSelection()
  if (state) {
    setTimeout(() => {
      qtable.value?.selected?.push(...(qtable.value.rows || []))
    })
  }
}
</script>

<template>
  <!-- prettier-ignore -->
  <VirtualScrollTableComponent
    :columns="columns"
    :rows="rows"
    row-key="index"
    :offset-height="localStore.HeaderSize.height"
    @row-click="onRowClick"
    :on-selected="onSelected"
    select-label="선택"
    :hide-pagination="false"
    selection='none'
    :bordered='true'
    :on-checked="onChecked"
    :init-q-table="initQTable"
  />
</template>

<style lang="sass" scoped></style>
