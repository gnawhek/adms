<script setup lang="ts">
import { ref, onMounted, reactive, computed } from 'vue'
import { $t } from 'src/utils'
import { LooseDictionary } from 'quasar/dist/types/ts-helpers'
import { QTable } from 'quasar'

const emit = defineEmits<{
  (e: 'rowClick', evt: PointerEvent, row: LooseDictionary, index: number, column: LooseDictionary): void
  (e: 'rowDbclick', evt: PointerEvent, row: LooseDictionary, index: number): void
}>()

const mainProps = defineProps({
  title: {
    type: String,
    default: undefined,
  },
  columns: {
    type: Array,
    default: undefined,
  },
  autoColumns: {
    type: Array,
    default: undefined,
  },
  rows: {
    type: Array,
    default: undefined,
  },
  fetchFromServer: {
    type: Function,
  },
  getRowsNumberCount: {
    type: Function,
  },
})

const qtable = ref<QTable>()
const selected = ref([])
const rows = ref([])
const filter = ref('')
const loading = ref(false)
const pagination = ref({
  sortBy: null,
  descending: false,
  page: 1,
  rowsPerPage: 15,
  rowsNumber: 10,
})
const pagesNumber = computed(() => {
  if (pagination.value.rowsPerPage > 0) {
    return Math.ceil(pagination.value.rowsNumber / pagination.value.rowsPerPage)
  }
  return 1
})

const getColumns = () => {
  if (mainProps.columns == undefined) {
    const bindColumns = [...(mainProps.autoColumns || [])].map((d: any) => {
      const column = { ...d }
      if (column.hasOwnProperty('translate') && column.translate) {
        if (column.label != null) {
          let label = column.label
          column.label = computed(() => $t(label))
        }
      }
      return column
    })
    return reactive(bindColumns)
  }
  return mainProps.columns
}

const originalRows = Object.assign(mainProps.rows || [])

// emulate ajax call
// SELECT * FROM ... WHERE...LIMIT...
function fetchFromServer(startRow: any, count: any, filter: any, sortBy: string, descending: any) {
  const data = filter ? originalRows.filter((row: { name: string | any[] }) => row.name.includes(filter)) : originalRows.slice()

  // handle sortBy
  if (sortBy) {
    const sortFn =
      sortBy === 'desc'
        ? descending
          ? (a: any, b: any) => (a.name > b.name ? -1 : a.name < b.name ? 1 : 0)
          : (a: any, b: any) => (a.name > b.name ? 1 : a.name < b.name ? -1 : 0)
        : descending
        ? (a: any, b: any) => parseFloat(b[sortBy]) - parseFloat(a[sortBy])
        : (a: any, b: any) => parseFloat(a[sortBy]) - parseFloat(b[sortBy])
    data.sort(sortFn)
  }

  return data.slice(startRow, startRow + count)
}

// emulate 'SELECT count(*) FROM ...WHERE...'
function getRowsNumberCount(filter: any) {
  if (!filter) {
    return originalRows.length
  }
  let count = 0
  originalRows.forEach((treat: { name: string | any[] }) => {
    if (treat.name.includes(filter)) {
      ++count
    }
  })
  return count
}

async function onRequest(props: { pagination: any; filter: any }) {
  const { page, rowsPerPage, sortBy, descending } = props.pagination
  const filter = props.filter

  loading.value = true

  // emulate server
  //setTimeout(async () => {
  // get all rows if "All" (0) is selected
  const fetchCount = rowsPerPage === 0 ? pagination.value.rowsNumber : rowsPerPage

  // calculate starting row of data
  const startRow = (page - 1) * rowsPerPage

  // update rowsCount with appropriate value
  pagination.value.rowsNumber = await (mainProps.getRowsNumberCount || getRowsNumberCount)(filter)

  // fetch data from "server"
  const returnedData: [] = await (mainProps.fetchFromServer || fetchFromServer)(startRow, fetchCount, filter, sortBy, descending)

  // clear out existing data and add new
  rows.value.splice(0, rows.value.length, ...returnedData)

  // don't forget to update local pagination object
  pagination.value.page = page
  pagination.value.rowsPerPage = rowsPerPage
  pagination.value.sortBy = sortBy
  pagination.value.descending = descending

  // ...and turn of loading indicator
  loading.value = false
  //}, 500);
}

onMounted(() => {
  // get initial data from server (1st page)
  onRequest({
    pagination: pagination.value,
    filter: undefined,
  })
})

const onRowClick = (evt: any, row: any, index: number) => {
  let col = -1
  evt.path[1].childNodes.forEach((d: EventTarget | null, i: number) => {
    if (evt.target == d) {
      col = i
    }
  })
  emit('rowClick', evt, Object.assign({}, row), index, Object.assign({}, col == -1 ? null : (qtable.value?.columns || [])[col]))
}

const updatePage = (value: any) => {
  qtable.value?.requestServerInteraction()
}

const beforeSelection = (selection: { rows: any[]; keys: any }) => {
  selection.rows = selection.rows.filter((r) => r.status != 'offline')
  selection.keys = selection.rows.map((r) => r.id) // `id` is the `row-key` I had set.
  console.log(selection) // a simple log confirms we modified the seleted rows correctly
}
const flag = false
</script>

<template>
  <div class="q-pa-none full-width">
    <q-table
      flat
      :bordered="flag"
      ref="qtable"
      :title="title"
      :rows="rows"
      :columns="getColumns()"
      row-key="id"
      v-model:pagination="pagination"
      :loading="loading"
      :filter="filter"
      @request="onRequest"
      binary-state-sort
      @row-click="onRowClick"
      @row-dblclick="(evt, row, index) => emit('rowDbclick', evt, row, index)"
      :hide-pagination="flag"
      selection="none"
      v-model:selected="selected"
      @selection="beforeSelection"
    >
      <template v-slot:top-right>
        <q-input borderless dense debounce="300" v-model="filter" placeholder="Search">
          <template v-slot:append>
            <q-icon name="search" />
          </template>
        </q-input>
      </template>

      <!--      <template v-slot:header-selection="scope">-->
      <!--        <q-toggle v-model="scope.selected" />-->
      <!--      </template>-->

      <!--      <template v-slot:body-selection="scope">-->
      <!--        <q-toggle v-model="scope.selected" />-->
      <!--      </template>-->
    </q-table>
    <div class="q-pa-lg flex flex-center">
      <q-pagination
        v-model="pagination.page"
        :max="pagesNumber"
        direction-links
        boundary-links
        icon-first="skip_previous"
        icon-last="skip_next"
        icon-prev="fast_rewind"
        icon-next="fast_forward"
        size="sm"
        @update:model-value="updatePage"
      />
    </div>
    <div class="q-pa-lg flex flex-center">
      <q-pagination v-model="pagination.page" :max="pagesNumber" @update:model-value="updatePage" />
    </div>
    <div class="q-mt-md">Selected: {{ JSON.stringify(selected) }}</div>
  </div>
</template>

<style lang="sass" scoped></style>
