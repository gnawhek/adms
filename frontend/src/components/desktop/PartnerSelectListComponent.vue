<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { usePopupStore } from 'src/store/popup'
import { CommonDialogProps, i18n, PartnerItem } from 'src/types'
import VirtualScrollTableComponent from 'components/list/VirtualScrollTableComponent.vue'
import { onMounted, ref, watch } from 'vue'
import { SELECT_PARTNER_LIST } from 'src/api/admin-api'

const authStore = useAuthStore()
const popupStore = usePopupStore()

const props = defineProps<{ data: CommonDialogProps<PartnerItem> }>()
props.data.title = '파트너선택'

const columns = [
  {
    name: 'CM_ID',
    required: true,
    label: '파트너ID',
    align: 'center',
    field: (row: any) => row.CM_ID,
    format: (val: any) => `${val}`,
    sortable: true,
  },
  { name: 'N_PARTNER', align: 'center', label: '파트너명', field: 'N_PARTNER', sortable: true },
  { name: 'D_REG_DT', align: 'center', label: '등록일자', field: 'D_REG_DT', sortable: true, format: (val: any) => `${val.replace('T',' ')}`, },
  { name: 'selectRow', align: 'right', label: '', field: 'CM_ID' },
]
const rows = ref<any[] | null>()

const onSelected = (row?: PartnerItem) => {
  props.data?.callback?.(row)
  props.data.isShow = false
}

const N_PARTNER = ref<string | null>('')
watch(N_PARTNER, async (newValue: string | null) => {
  rows.value = await SELECT_PARTNER_LIST(newValue as string)
})

onMounted(() => {
  //N_PARTNER.value = props.data.params?.N_PARTNER
  N_PARTNER.value = null
})
</script>

<template>
  <div class="q-pt-none column">
    <div class="q-my-lg">
      <div class="q-gutter-y-md column">
        <q-toolbar class="bg-white text-black shadow-0 rounded-borders">
          <div class="col-4 q-px-md">
            <q-input dense v-model="N_PARTNER" placeholder="파트너명" clearable debounce="500">
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
      row-key="CM_ID"
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
