<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { ProductCategory} from 'src/types/domain/product'
import { CommonCode, CommonDialogProps, GlobalConstants, i18n, PartnerItem } from 'src/types'
import { SELECT_PRODUCT_CATEGORY_LIST, SELECT_PRODUCT_GROUP_EXISTS, SELECT_PARTNER_LIST } from 'src/api/admin-api'
import { useQuasar } from 'quasar'
import dialog from 'src/utils/dialog'

const $q = useQuasar()

const selectedItem = ref<ProductCategory | null>(<ProductCategory>{})
const codeCheck = ref<boolean | null>(null)
const currentCode = ref()
let isUpdate = ref(false)
let category: ProductCategory

const splitterModel = ref(30) // start at 50%

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

const selectedCategory = ref<CommonCode | null>(<CommonCode>{})
function searchCategory() {
  void dialog.category((result: CommonCode) => {
    selectedCategory.value = result || {}
    loadCategory()
  }, selectedCategory.value)
}

const getC_CODE = () => {
  return selectedCategory.value?.CODE_ID
}

//카테고리 > 선택 버튼 관련
const loadCategory = async () => {
  // categoryItems.value = await SELECT_PRODUCT_CATEGORY_LIST(getC_CODE())
  // selectedCategory.value = null
  // groupItems.value = null
  // selectedGroup.value = null
  // productItems.value = null
  // selectedProduct.value = null
}

const enabled = ref('false')

</script>

<template>
  <div>
    <q-splitter
      v-model="splitterModel"
      :limits='[20,50]'
      style="height: 100%"
    >

      <template v-slot:before>
        <div class="q-pa-lg">
          <div class="text-h4 q-mb-md">Before</div>
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
                placeholder="코드를 입력해주세요"
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
            <div class="fieldLabel">코드명<span class="required">*</span></div>
            <div class='row'>
              <q-input
                spellcheck="false"
                outlined
                autocomplete="C_CODE_NAME"
                v-model="selectedItem.C_CODE_NAME"
                lazy-rules
                :rules="[
                (val) => (val && val.length > 0) || '코드를 입력하지 않았습니다.',
              ]"
                class="col"
                placeholder="코드명을 입력해주세요"
                @keyup.enter="codeConfirm"
              />
            </div>
            <div class='row'>
              <div class="searchPartner col-6" @click="searchCategory()" v-ripple:indigo-11>
                <q-input dense v-model="selectedCategory. N_CATEGOTY" placeholder="상위코드 검색" readonly>
                  <template v-slot:append>
                    <q-icon name="search" />
                  </template>
                </q-input>
              </div>
            </div>
          </div>
          {{selectedItem.C_CODE}}
          {{selectedItem.C_CODE_NAME}}
          <q-select outlined filled v-model="parent_code_id" :options="options" label="상위 카테고리" />
          <q-input outlined v-model="order_idx" label="정렬 순서" />
          <q-input outlined v-model="explanation" label="설명" />
          <q-toggle outlined left-label label="설명" v-model="enabled" false-value='true' true-value='false'/>
          <q-input outlined v-model="etc" label="기타" />
          <q-btn color="secondary" label="등록" />
        </div>

      </template>

      <template v-slot:after>
        <div class="q-pa-md">
          <div class="text-h4 q-mb-md"></div>
          <div class="q-pa-md">
            <!--q-table
              class="my-sticky-header-table"
              title="코드 전체"
              :rows="rows"
              :columns="columns"
              row-key="name"
              :selected-rows-label="getSelectedString"
              selection='multiple'
              v-model:selected='selected'
              v-model:pagination="pagination"
              :rows-per-page-options="[0]"
              flat
              bordered
            />
            <div class="q-mt-md">
              Selected: {{ JSON.stringify(selected) }}
            </div-->
          </div>
        </div>
      </template>

    </q-splitter>
  </div>
</template>



<style lang="sass">
.q-input, .q-toggle, .q-select
  margin-bottom: 10px

.q-btn
  float: right

.my-sticky-header-table
  /* height or max-height is important */
  //height: 1000px

  .q-table__top,
  .q-table__bottom,
  thead tr:first-child th
    /* bg color is important for th; just specify one */
    background-color: #c1f4cd

  thead tr th
    position: sticky
    z-index: 1
  thead tr:first-child th
    top: 0

  /* this is when the loading indicator appears */
  &.q-table--loading thead tr:last-child th
    /* height of all previous header rows */
    top: 48px

  .q-table tr td
    text-overflow: ellipsis
    white-space: nowrap
    max-width: 300px
    overflow: hidden
</style>



<!--export default {
setup () {
const selected = ref([])

return {
code_name: ref(''),
order_idx: ref(''),
explanation: ref(''),
enabled: ref('ture'),
etc: ref(''),
dense: ref(false),
parent_code_id:ref('카테고리 선택'),
selected,
columns,
rows,
//options:['카테고리1', '카테고리2', '카테고리3', '카테고리4'],
getSelectedString() {
return selected.value.length === 0 ? '' : `${selected.value.length} record${selected.value.length > 1 ? 's' : ''} selected of ${rows.length}`
},
pagination: ref({
rowsPerPage: 15
})
}
}
-->
const columns = [
  {
    name: 'name',
    label: '상위코드',
    align: 'center',
    field: row => row.parent_code_id,
    format: val => `${val}`,
    sortable: true
  },
  { name: '상위코드명', align: 'center', label: '상위코드명', field: 'parent_code_name', sortable: true },
  { name: '코드', required: true, align: 'center', label: '코드', field: 'code_id' },
  { name: '코드명', align: 'center', label: '코드명', field: 'code_name' },
  { name: '설명', align: 'center', label: '설명', field: 'explanation' },
  { name: '기타', align: 'center', label: '기타', field: 'etc', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) },
  { name: '사용여부', align: 'center', label: '사용여부', field: 'enabled', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) },
  { name: '수정', align: 'center', label: '수정', field: 'iron', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) }
]
