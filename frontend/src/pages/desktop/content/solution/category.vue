<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { usePopupStore } from 'src/store/popup'
import { CommonDialogProps, GlobalConstants, i18n, PartnerItem } from 'src/types'
import VirtualScrollTableComponent from 'components/list/VirtualScrollTableComponent.vue'
import { onMounted, ref } from 'vue'
import { DELETE_SOLUTION_CATEGORY, INSERT_SOLUTION_CATEGORY, SELECT_PARTNER_LIST, SELECT_SOLUTION_CATEGORY_EXISTS, UPDATE_SOLUTION_CATEGORY } from 'src/api/admin-api'
import { QTable, useQuasar } from 'quasar'
import { $t } from 'src/utils'
import { SolutionCategory } from 'src/types/domain/solution'
import dialog from 'src/utils/dialog'
import InputCodeComponent from 'components/desktop/InputCodeComponent.vue'

const $q = useQuasar()
const authStore = useAuthStore()
const popupStore = usePopupStore()

const props = defineProps<{ data: CommonDialogProps }>()
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
]
const rows = ref<PartnerItem[] | null>()
const selectedItem = ref<SolutionCategory | null>(<SolutionCategory>{})
let isUpdate = ref(false)
onMounted(async () => {
  isUpdate.value = props.data.params.row != null
  IsConfirmCode.value = isUpdate.value
  props.data.title = isUpdate.value ? '카테고리 수정' : '카테고리 추가'
  selectedItem.value = Object.assign({}, props.data.params.row)
  rows.value = await SELECT_PARTNER_LIST()

  const CM_IDS = selectedItem.value?.CM_IDS + ';'
  rows.value?.forEach((row) => {
    if (CM_IDS.indexOf(row.CM_ID + ';') != -1) {
      qtable.value?.selected?.push(row)
    }
  })
})

const qtable = ref<QTable>()
const initQTable = (table: QTable) => {
  qtable.value = table
}

const IsConfirmCode = ref<boolean>()
async function isCodeCheck(code: string) {
  return await SELECT_SOLUTION_CATEGORY_EXISTS(code)
}

const saveItem = async () => {
  const data: SolutionCategory = Object.assign({}, selectedItem.value, { CM_IDS: qtable.value?.selected?.map((d) => d.CM_ID).join(';') })
  console.log(data)
  let result: number
  if (isUpdate.value) {
    result = await UPDATE_SOLUTION_CATEGORY(data)
  } else {
    result = await INSERT_SOLUTION_CATEGORY(data)
  }
  await dialog.message({
    message: result != -1 ? $t(i18n.common.BeProcessed) : $t(i18n.common.FailedBeProcessed),
    callback: () => {
      if (result != -1) {
        props.data?.callback?.()
        props.data.isShow = false
      }
    },
  })
}

const deleteItem = () => {
  dialog.confirmMessage({
    title: '',
    message: '카테고리를 삭제하겠습니까?',
    callback: async (state: boolean) => {
      if (state) {
        const data: SolutionCategory = Object.assign({}, selectedItem.value)
        let result: number = await DELETE_SOLUTION_CATEGORY(data)
        await dialog.message({
          message: result != -1 ? $t(i18n.common.BeProcessed) : $t(i18n.common.FailedBeProcessed),
          callback: () => {
            if (result != -1) {
              props.data?.callback?.()
              props.data.isShow = false
            }
          },
        })
      }
    },
  })
}
</script>

<template>
  <div class="q-pt-none column">
    <!--    <pre>{{ selectedItem }}</pre>-->
    <!--    <pre>{{ qtable?.selected.length }}</pre>-->
    <div class="q-pa-none">
      <div class="q-gutter-y-md column">
        <q-toolbar class="bg-white text-black rounded-borders">
          <q-item-label header>파트너사 선택<span class="required">*</span></q-item-label>
        </q-toolbar>
      </div>
    </div>

    <div class="rounded-borders q-mx-lg">
      <!-- prettier-ignore -->
      <VirtualScrollTableComponent
        ref="table"
        :columns="columns"
        :rows="rows"
        row-key="CM_ID"
        height="300px"
        select-label="선택"
        :hide-pagination="true"
        selection='multiple'
        :bordered='true'
        :init-q-table="initQTable"
      />
    </div>

    <div class="q-pa-lg">
      <div class="column">
        <div class="fieldLabel">코드<span class="required">*</span>{{IsConfirmCode}}</div>
        <InputCodeComponent v-model:code="selectedItem.C_CODE" v-model:is-update="isUpdate" v-model:confirm-code="IsConfirmCode" @update="IsConfirmCode = $event" :is-code-check="isCodeCheck" />
      </div>
      <div class="column q-my-md">
        <div class="fieldLabel">카테고리명<span class="required">*</span></div>
        <div class="row">
          <!-- prettier-ignore -->
          <q-input
            spellcheck="false"
            outlined
            autocomplete="N_NAME"
            v-model="selectedItem.N_NAME"
            lazy-rules
            :rules="[
                (val) => (val && val.length > 0) || '카테고리명을 입력하지 않았습니다.',
              ]"
            class="full-width"
            maxlength="50"
            placeholder="카테고리명을 입력해주세요"
          />
        </div>
      </div>
    </div>
  </div>

  <q-card-actions align="right" class="text-primary q-pb-md">
    <q-btn
      color="primary"
      :label="$t(i18n.common.save)"
      @click="saveItem"
      style="width: 150px"
      :disable="qtable?.selected.length === 0 || !IsConfirmCode || (selectedItem.C_CODE || '').length < GlobalConstants.maxCodeLength || (selectedItem.N_NAME || '').length === 0"
    />
    <q-btn v-if="isUpdate" color="red" :label="$t(i18n.common.delete)" @click="deleteItem" style="width: 100px" />
    <q-btn flat :label="$t(i18n.common.cancel)" v-close-popup style="width: 100px" />
  </q-card-actions>
</template>

<style lang="sass" scoped>
//$
@import "src/pages/login/register/register"
::v-deep(.q-table) td
  padding: 0 16px
  height: 33px
</style>
