<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { usePopupStore } from 'src/store/popup'
import { CategoryItem, CommonDialogProps, i18n, PartnerItem } from 'src/types'
import VirtualScrollTableComponent from 'components/list/VirtualScrollTableComponent.vue'
import { onMounted, ref, watch } from 'vue'
import { SELECT_CATEGORY_LIST, SELECT_PARTNER_LIST, SELECT_PRODUCT_CATEGORY_LIST } from 'src/api/admin-api'
import dialog from 'src/utils/dialog'

const authStore = useAuthStore()
const popupStore = usePopupStore()

const props = defineProps<{ data: CommonDialogProps<CategoryItem> }>()
props.data.title = '상위코드 검색'

const columns = [
  {
    name: 'code_id',
    required: true,
    label: '코드',
    align: 'center',
    field: (row: any) => row.code_id,
    format: (val: any) => `${val}`,
    sortable: true,
  },
  { name: '코드명', align: 'center', label: '코드명', field: 'code_name' },
  { name: '설명', align: 'center', label: '설명', field: 'explanation' },
  { name: '기타', align: 'center', label: '기타', field: 'etc', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) },
  { name: '사용여부', align: 'center', label: '사용여부', field: 'enabled', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) },
  { name: 'selectRow', align: 'right', label: '', field: 'code_id' },
]

const rows = ref<any[] | null>()

const onSelected = (row?: CategoryItem) => {
  props.data?.callback?.(row)
  props.data.isShow = false
}

//SELECT_PARTNER_LIST >> SELECT_CATEGORY_LIST
//DB 리스트 작업 후 변경해줘야함
const N_CATEGORY = ref<string | null>('')
watch(N_CATEGORY, async (newValue: string | null) => {

})

onMounted(async() => {
  //N_PARTNER.value = props.data.params?.N_PARTNER
  N_CATEGORY.value = null
  rows.value = await SELECT_CATEGORY_LIST()
})

</script>

<template>
  <div class="q-pt-none column">
    <div class="q-py-none">
      <div class="q-gutter-y-md column">
        <q-toolbar class="bg-white text-black shadow-0 rounded-borders">
          <div class="col-4 q-px-md">
            <q-input dense v-model="N_CATEGORY" placeholder="상위코드 검색" clearable debounce="500">
              <template v-slot:append>
                <q-icon name="search" />
              </template>
            </q-input>
          </div>
          <q-space></q-space>
          <!--          <q-separator dark vertical inset></q-separator>-->
          <!--          <q-separator dark vertical></q-separator>-->
<!--          <q-btn stretch flat label="전체" @click="onSelected()"></q-btn>-->
          <q-btn outline color="indigo-13" label="전체" @click="onSelected()"></q-btn>
        </q-toolbar>
      </div>
    </div>

    <!-- prettier-ignore -->
    <VirtualScrollTableComponent
      :columns="columns"
      :rows="rows"
      row-key="NAME"
      height="50vh"
      :on-selected="onSelected"
      select-label="선택"
      :hide-pagination="true"
    />
  </div>

  <!--  <q-btn flat label="닫기" v-close-popup @click="data.isShow = false" />-->
  <!--  <q-card-actions align="right" class="text-primary">-->
  <!--    &lt;!&ndash;    <q-btn flat :label="$t(i18n.common.confirm)" v-close-popup @click="data?.callback?.()" />&ndash;&gt;-->
  <!--    <q-btn flat :label="$t(i18n.common.save)" v-close-popup @click="selected(null)" />-->
  <!--    <q-btn flat :label="$t(i18n.common.cancel)" v-close-popup />-->
  <!--  </q-card-actions>-->
</template>

<style lang="sass" scoped></style>
