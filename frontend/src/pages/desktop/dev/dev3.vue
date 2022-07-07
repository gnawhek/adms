<script setup lang="ts">
import { useRoute } from 'vue-router'
import FilterTableComponent from 'components/list/FilterTableComponent.vue'
import { $t, formatDateTimeToString, menuToName } from 'src/utils'
import { $hAsyncMemberSearchCustomerList, $hMemberSearchCustomerCount } from 'src/api/member-api'

const route = useRoute()
const columns = [
  {
    name: 'N_NAME',
    required: true,
    label: 'Name',
    align: 'left',
    field: (row: { N_NAME: any }) => {
      return row.N_NAME
    },
    format: (val: any) => `${val}`,
    sortable: true,
    translate: true,
    //style: 'width: 200px; font-size: 2em;',
    //classes: ['text-weight-bold', row => row.specialClassName1]
  },
  {
    name: 'I_ID',
    align: 'center',
    label: 'ID',
    field: (row: { I_ID: any }) => row.I_ID,
    format: (val: any) => {
      return `[ ${val} ]`
    },
    sortable: true,
    translate: true,
  },
  {
    name: 'C_SEX',
    field: 'C_SEX',
    label: 'Sex',
    sortable: true,
    translate: true,
    format: (val: any) => {
      return $t(`common.${val}`)
    },
  },
  { name: 'I_AGE', field: 'I_AGE', label: 'Age',falign: 'right', sortable: true, translate: false },
  { name: 'N_SHOP', field: 'N_SHOP', label: 'BranchName', align: 'center', sortable: true, translate: true },
  { name: 'I_HP', field: 'I_HP', label: 'PhoneNumber', align: 'left', sortable: true, translate: true },
  { name: 'S_EMAIL', field: 'S_EMAIL', label: 'Email', align: 'left', sortable: true, translate: true },
  {
    name: 'D_REG_DT',
    field: 'D_REG_DT',
    label: 'DateOfRegistration',
    align: 'center',
    sortable: true,
    translate: true,
    format: (val: number) => {
      return formatDateTimeToString(val)
    },
  },
]

// SELECT * FROM ... WHERE...LIMIT...
async function fetchFromServer(startRow: number, count: number, filter: any, sortBy: any, descending: any) {
  let sort = sortBy
  if(sort != null && descending) {
    sort = '-' + sort
  }
  const data = await $hAsyncMemberSearchCustomerList(sort, startRow, count)
  // data.forEach((d, i) => d.id = i);
  return data
}

// emulate 'SELECT count(*) FROM ...WHERE...'
// async function getRowsNumberCount(filter: any) {
//   const data = await $hMemberSearchCustomerCount()
//   return data?.COUNT ?? 0
// }

function getRowsNumberCount(filter: any) {
  return 20
}


const onRowClick = (evt: any, row: any, index: any, column: any) => {
  console.log('onRowClick', evt)
  console.log('row', index, row)
  console.log('column', column)
  console.log('')
}

const onRowDblClick = (evt: any, row: any, index: any) => {
  console.log('onRowDblClick', evt, row, index)
}
</script>

<template>
  <q-page class="column items-center justify-start">
    <!--    <q-item-label header>{{ menuToName(route.path) }}</q-item-label>-->
    <FilterTableComponent
      :title="menuToName(route.path)"
      :auto-columns="columns"
      :fetchFromServer="fetchFromServer"
      :getRowsNumberCount="getRowsNumberCount"
      @row-click="onRowClick"
      @row-dbclick="onRowDblClick"
    />
  </q-page>
</template>

<style lang="sass" scoped></style>
