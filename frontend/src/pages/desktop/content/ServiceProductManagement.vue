<script setup lang="ts">
import DragTableComponent from 'components/list/draggable/DragTableComponent.vue'
import TableStickyHeadersComponent from 'components/list/TableStickyHeadersComponent.vue'
import { computed, onMounted, ref } from 'vue'
import { CommonDialogProps, EventType, i18n, PartnerItem } from 'src/types'
import dialog from 'src/utils/dialog'
import { useLocalStore } from 'src/store/local'
import { emitter } from 'boot/EventBus'
import {
  DELETE_PRODUCT_PRODUCT,
  INSERT_PRODUCT_PRODUCT,
  SELECT_PRODUCT_CATEGORY_LIST,
  SELECT_PRODUCT_GROUP_LIST,
  SELECT_PRODUCT_PRODUCT_LIST,
  SELECT_PRODUCT_TEMPLATE,
  SELECT_PRODUCT_TEMPLATE_LIST,
  UPDATE_PRODUCT_CATEGORY_SORT,
  UPDATE_PRODUCT_GROUP_SORT,
  UPDATE_PRODUCT_PRODUCT_SORT,
} from 'src/api/admin-api'
import { ProductCategory, ProductGroup, ProductProduct, ProductTemplate } from 'src/types/domain/product'
import { $t } from 'src/utils'
import PartnerComponent from 'components/desktop/PartnerComponent.vue'
import SearchPanelComponent from 'components/desktop/SearchPanelComponent.vue'
import Splitter22Component from 'components/desktop/Splitter22Component.vue'

const localStore = useLocalStore()

const selectedPartner = ref<PartnerItem>(<PartnerItem>{})
function setPartner(result: PartnerItem) {
  selectedPartner.value = result || {}
  loadCategory()
}

const dragDisabled = computed(() => {
  return (getCM_ID() || '').length > 0
})

const searchItems = [
  { label: '코드', name: 'C_CODE', style: 'width: 100px;', maxlength: 5 },
  { label: '브랜드명', name: 'N_BRAND_NAME' },
  { label: '상품명', name: 'N_PRODUCT_NAME' },
  { label: 'PWI Type', name: 'S_PWI' },
]

const selectedCategory = ref<ProductCategory | null>()
const categoryItems = ref<ProductCategory[] | null>([])
const cagegoryData = {
  get columns() {
    return [
      { label: '카테고리명', name: 'N_NAME', textClass: 'text-left', columnClass: 'text-left', style: 'max-width: 140px;overflow-wrap: break-word;' },
      { label: '코드', name: 'C_CODE', textClass: 'text-center', columnClass: 'text-center' },
      { label: '파트너사', name: 'CM_IDS', textClass: 'text-left', columnClass: 'text-left', style: 'max-width: 150px;overflow-wrap: break-word;' },
    ]
  },
  click: (row: any) => {
    selectedCategory.value = row
    loadGroup()
  },
  edit: (row: any) => {
    openCategory(row)
  },
  checkMove: (evt: any) => {
    return evt.from == evt.to
  },
  onChange: async (evt: any, items: any[]) => {
    const list = items.map((item: any, index) => {
      item.I_SORT = index + 1
      return item
    })
    await UPDATE_PRODUCT_CATEGORY_SORT({ list })
  },
}
function openCategory(row?: any) {
  void emitter.emit(EventType.commonDialog, <CommonDialogProps<any>>{
    component: 'src/pages/desktop/content/product/category.vue',
    callback: () => {
      loadCategory()
    },
    isComponentAction: true,
    params: {
      row,
    },
    style: 'min-width: 800px',
  })
}

const selectedGroup = ref<ProductGroup | null>()
const groupItems = ref<ProductGroup[] | null>([])
const groupData = {
  get columns() {
    return [
      { label: '카테고리명', name: 'N_NAME', textClass: 'text-left word-break', columnClass: 'text-left', style: 'max-width: 140px;' },
      { label: '코드', name: 'C_CODE', textClass: 'text-center', columnClass: 'text-center' },
      { label: '파트너사', name: 'CM_IDS', textClass: 'text-left word-break', columnClass: 'text-left', style: 'max-width: 150px;' },
    ]
  },
  click: (row: any) => {
    selectedGroup.value = row
    loadProduct()
  },
  edit: (row: any) => {
    openGroup(row)
  },
  checkMove: (evt: any) => {
    return evt.from == evt.to
  },
  onChange: async (evt: any, items: any[]) => {
    const list = items.map((item: any, index) => {
      item.I_SORT = index + 1
      return item
    })
    await UPDATE_PRODUCT_GROUP_SORT({ list })
  },
}
function openGroup(row?: any) {
  void emitter.emit(EventType.commonDialog, <CommonDialogProps<any>>{
    component: 'src/pages/desktop/content/product/group.vue',
    callback: () => {
      loadGroup()
    },
    isComponentAction: true,
    params: {
      category: selectedCategory.value,
      row,
    },
    style: 'min-width: 800px',
  })
}

const selectedProduct = ref<ProductProduct | null>()
const productItems = ref<ProductProduct[] | null>([])
const productData = {
  get columns() {
    return [
      { label: '이미지', name: 'S_ICON', textClass: 'text-center', columnClass: 'text-center', type: 'img', style: 'width: 100px' },
      { label: '코드', name: 'C_CODE', textClass: 'text-center', columnClass: 'text-center' },
      { label: '브랜드명', name: 'N_BRAND_NAME', textClass: 'text-left', columnClass: 'text-left' },
      { label: '상품명', name: 'N_PRODUCT_NAME', textClass: 'text-left', columnClass: 'text-left' },
      { label: 'PWI Type', name: 'S_PWI', textClass: 'text-left word-break', columnClass: 'text-left', style: 'max-width: 150px;' },
    ]
  },
  click: (row: any) => {
    selectedProduct.value = row
  },
  edit: (row: any) => {
    editTemplate(row.C_CODE)
  },
  delete: (row: any) => {
    dialog.confirmMessage({
      title: '',
      message: '제품 목록에서 제외 하시겠습니까?',
      callback: async (state: boolean) => {
        if (state) {
          const data: ProductProduct = Object.assign({}, row)
          let result: number = await DELETE_PRODUCT_PRODUCT(data)
          await dialog.message({
            message: result != -1 ? $t(i18n.common.BeProcessed) : $t(i18n.common.FailedBeProcessed),
          })
          await loadProduct()
        }
      },
    })
  },
  checkMove: (evt: any) => {
    return evt.from == evt.to
  },
  onChange: async (evt: any, items: any[]) => {
    const list = items.map((item: any, index) => {
      item.I_SORT = index + 1
      return item
    })
    await UPDATE_PRODUCT_PRODUCT_SORT({ list })
  },
}

const dataTemplate = ref<ProductTemplate>(<ProductTemplate>{ C_CODE: '', N_BRAND_NAME: '', N_PRODUCT_NAME: '', S_PWI: '' })
const selectedTemplate = ref<ProductTemplate | null>()
let sourceTemplateItems: ProductTemplate[] | null
const templateItems = ref<ProductTemplate[] | null>([])
const templateData = {
  get columns() {
    return [
      { label: '이미지', name: 'S_ICON', textClass: 'text-center', columnClass: 'text-center', type: 'img', style: 'width: 100px' },
      { label: '코드', name: 'C_CODE', textClass: 'text-center', columnClass: 'text-center' },
      { label: '브랜드명', name: 'N_BRAND_NAME', textClass: 'text-left', columnClass: 'text-left' },
      { label: '상품명', name: 'N_PRODUCT_NAME', textClass: 'text-left', columnClass: 'text-left' },
      { label: 'PWI Type', name: 'S_PWI', textClass: 'text-left word-break', columnClass: 'text-left', style: 'max-width: 150px' },
    ]
  },
  click: (row: any) => {
    selectedTemplate.value = row
  },
  edit: (row: any) => {
    editTemplate(row.C_CODE)
  },
}
function editTemplate(C_CODE: string) {
  SELECT_PRODUCT_TEMPLATE(C_CODE).then((row) => {
    openTemplate(row)
  })
}
function openTemplate(row?: any) {
  void emitter.emit(EventType.commonDialog, <CommonDialogProps<any>>{
    component: 'src/pages/desktop/content/product/template.vue',
    callback: () => {
      loadProduct()
      loadTemplate()
    },
    isComponentScrollable: true,
    isComponentAction: true,
    params: {
      row,
    },
    style: 'min-width: 800px',
  })
}

const getCM_ID = () => {
  return selectedPartner.value.CM_ID
}

const loadCategory = async () => {
  categoryItems.value = await SELECT_PRODUCT_CATEGORY_LIST(getCM_ID())
  selectedCategory.value = null
  groupItems.value = null
  selectedGroup.value = null
  productItems.value = null
  selectedProduct.value = null
}

const getCategoryCode = () => {
  return selectedCategory.value?.C_CODE
}

const loadGroup = async () => {
  groupItems.value = await SELECT_PRODUCT_GROUP_LIST(getCategoryCode() as string, getCM_ID())
  selectedGroup.value = null
  productItems.value = null
  selectedProduct.value = null
  filterLoadTemplate()
}

const getGroupCode = () => {
  return selectedGroup.value?.C_CODE
}

const loadProduct = async () => {
  productItems.value = await SELECT_PRODUCT_PRODUCT_LIST(getGroupCode())
  selectedProduct.value = null
  filterLoadTemplate()
}

const loadTemplate = async () => {
  sourceTemplateItems = await SELECT_PRODUCT_TEMPLATE_LIST(dataTemplate.value)
  filterLoadTemplate()
}

const filterLoadTemplate = () => {
  templateItems.value = (sourceTemplateItems || []).filter((t) => {
    return (productItems.value || []).find((p) => p.C_CODE == t.C_CODE) == null
  })
  selectedTemplate.value = null
}

onMounted(async () => {
  await loadCategory()
  // await loadTemplate()
})

async function addProduct() {
  const result = await INSERT_PRODUCT_PRODUCT(selectedGroup.value?.C_CODE as string, selectedTemplate.value?.C_CODE as string)
  await dialog.message({
    message: result != -1 ? $t(i18n.common.BeProcessed) : $t(i18n.common.FailedBeProcessed),
  })
  await loadProduct()
  filterLoadTemplate()
}
</script>

<template>
  <q-page>
    <Splitter22Component>
      <template v-slot:leftTop="{ size }">
        <div>
          <div class="q-pa-md row">
            <PartnerComponent class="col-6" v-model="selectedPartner.N_PARTNER" @setPartner="setPartner"></PartnerComponent>
          </div>
          <div class="text-h6 q-ma-md row">
            <div>Category</div>
            <div class="col" />
            <q-btn flat dense round color="deep-purple-3" @click="openCategory()">
              <span class="material-icons text-v-primary"> add </span>
              <q-tooltip anchor="center right" self="center left"> 카테고리 추가 </q-tooltip>
            </q-btn>
          </div>
          <div>
            <DragTableComponent :data="cagegoryData" :items="categoryItems" :size="size" :drag-disabled="dragDisabled" />
          </div>
        </div>
      </template>
      <template v-slot:leftBottom="{ size }">
        <div>
          <div class="text-h6 q-ma-md row">
            <div>Group</div>
            <div class="col" />
            <q-btn flat dense round color="deep-purple-3" @click="openGroup()" :disable="selectedCategory == null">
              <span class="material-icons text-v-primary"> add </span>
              <q-tooltip anchor="center right" self="center left"> 그룹 추가 </q-tooltip>
            </q-btn>
          </div>
          <div>
            <DragTableComponent :data="groupData" :items="groupItems" :size="size" :drag-disabled="dragDisabled" />
          </div>
        </div>
      </template>
      <template v-slot:rightTop="{ size }">
        <div>
          <div class="text-h6 q-ma-md">Product</div>
          <div>
            <DragTableComponent :data="productData" :items="productItems" :size="size" />
          </div>
        </div>
      </template>
      <template v-slot:rightBottom="{ size }">
        <div>
          <div class="q-ma-md row justify-center">
            <q-btn outline color="deep-purple-13" @click="addProduct()" icon="arrow_upward" label="추가" :disable="selectedGroup == null || selectedTemplate == null"> </q-btn>
          </div>
          <div class="text-h6 q-ma-md row">
            <div>Template</div>
            <div class="col" />
            <q-btn flat dense round color="deep-purple-3" @click="openTemplate()">
              <span class="material-icons text-v-primary"> add </span>
              <q-tooltip anchor="center left" self="center right"> 템플릿 추가 </q-tooltip>
            </q-btn>
          </div>
          <SearchPanelComponent v-model="dataTemplate" :items="searchItems" :load="loadTemplate" />
          <div>
            <TableStickyHeadersComponent :data="templateData" :items="templateItems" :size="size" :debug="false" />
          </div>
        </div>
      </template>
    </Splitter22Component>
    <!--    <div>{{ selectedCategory }}</div>-->
    <!--    <div>{{ selectedGroup }}</div>-->
    <!--    <div>{{ selectedProduct }}</div>-->
    <!--    <div>{{ selectedTemplate }}</div>-->
  </q-page>
</template>

<style lang="sass" scoped>
.material-icons
  font-size: 33px
</style>
