<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { usePopupStore } from 'src/store/popup'
import { CommonDialogProps, GlobalConstants, i18n, PartnerItem } from 'src/types'
import VirtualScrollTableComponent from 'components/list/VirtualScrollTableComponent.vue'
import { computed, onMounted, ref } from 'vue'
import { DELETE_PRODUCT_GROUP, INSERT_PRODUCT_GROUP, SELECT_PARTNER_LIST, SELECT_PRODUCT_GROUP_EXISTS, UPDATE_PRODUCT_GROUP } from 'src/api/admin-api'
import { QTable, useQuasar } from 'quasar'
import { $t } from 'src/utils'
import { ProductCategory } from 'src/types/domain/product'
import dialog from 'src/utils/dialog'

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
const selectedItem = ref<ProductCategory | null>(<ProductCategory>{})
let isUpdate = ref(false)
let category: ProductCategory
onMounted(async () => {
  category = props.data.params.category
  isUpdate.value = props.data.params.row != null
  props.data.title = isUpdate.value ? '그룹 수정' : '그룹 추가'
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

const codeCheck = ref<boolean | null>(null)
const currentCode = ref()
const codeConfirm = async () => {
  const code = selectedItem.value?.C_CODE
  if (code == null || code.length < GlobalConstants.maxCodeLength) {
    return
  }
  currentCode.value = null
  const result = await SELECT_PRODUCT_GROUP_EXISTS(code)
  codeCheck.value = result === 0
  if (codeCheck.value) {
    currentCode.value = code
    $q.notify({
      color: 'green-4',
      textColor: 'white',
      icon: 'cloud_done',
      message: '사용 가능한 코드입니다.',
    })
  } else {
    $q.notify({
      color: 'red-3',
      textColor: 'white',
      icon: 'cloud_done',
      message: '사용할 수 없는 코드입니다.',
    })
  }
}

const IsConfirmCode = computed(() => {
  return isUpdate.value || (codeCheck.value && currentCode.value === selectedItem.value?.C_CODE)
})
const getCodeHint = computed(() => {
  if (isUpdate.value) {
    return ''
  } else if (IsConfirmCode.value) {
    return '사용 가능한 코드입니다.'
  } else if (selectedItem.value?.C_CODE == null || selectedItem.value.C_CODE.length == 0) {
    return '첫 글자는 영문입니다. (A0000)'
  } else if (selectedItem.value.C_CODE.length < GlobalConstants.maxCodeLength) {
    return '숫자 4자리를 입력해주세요. (A0000)'
  }
  return '코드 중복확인을 해주세요.'
})

const saveItem = async () => {
  const data: ProductCategory = Object.assign({}, selectedItem.value, { C_CODE_CTGY: category.C_CODE, CM_IDS: qtable.value?.selected?.map((d) => d.CM_ID).join(';') })
  let result: number
  if (isUpdate.value) {
    result = await UPDATE_PRODUCT_GROUP(data)
  } else {
    result = await INSERT_PRODUCT_GROUP(data)
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
    message: '그룹를 삭제하겠습니까?',
    callback: async (state: boolean) => {
      if (state) {
        const data: ProductCategory = Object.assign({}, selectedItem.value)
        let result: number = await DELETE_PRODUCT_GROUP(data)
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
        <div class="fieldLabel">코드<span class="required">*</span></div>
        <div class="row">
          <!-- prettier-ignore -->
          <q-input
            spellcheck="false"
            outlined
            autocomplete="C_CODE"
            v-model="selectedItem.C_CODE"
            :hint="getCodeHint"
            lazy-rules
            :rules="[
                (val) => (val && val.length > 0) || '코드를 입력하지 않았습니다.',
                (val) => (val && val.length >= GlobalConstants.maxCodeLength) || '코드는 5자리입니다.'
              ]"
            class="col"
            placeholder="코드명을 입력해주세요"
            mask='A####'
            :readonly="isUpdate"
            @keyup.enter="codeConfirm"
          />
          <q-btn
            v-if="!isUpdate"
            label="중복확인"
            flat
            class="q-ml-xs apply-button"
            @click="codeConfirm"
            :disable="selectedItem.C_CODE == null || selectedItem.C_CODE?.length < GlobalConstants.maxCodeLength"
            style="margin-bottom: 20px"
          />
        </div>
      </div>
      <div class="column q-my-md">
        <div class="fieldLabel">그룹명<span class="required">*</span></div>
        <div class="row">
          <!-- prettier-ignore -->
          <q-input
            spellcheck="false"
            outlined
            autocomplete="N_NAME"
            v-model="selectedItem.N_NAME"
            lazy-rules
            :rules="[
                (val) => (val && val.length > 0) || '그룹명을 입력하지 않았습니다.',
              ]"
            class="full-width"
            maxlength="50"
            placeholder="그룹명을 입력해주세요"
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
      :disable="qtable?.selected.length === 0 || !IsConfirmCode || selectedItem.C_CODE?.length < GlobalConstants.maxCodeLength || (selectedItem.N_NAME || '').length === 0"
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
