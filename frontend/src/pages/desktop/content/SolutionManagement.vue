<script setup lang="ts">
import DragTableComponent from 'components/list/draggable/DragTableComponent.vue'
import TableStickyHeadersComponent from 'components/list/TableStickyHeadersComponent.vue'
import { computed, onMounted, ref } from 'vue'
import { CommonDialogProps, EventType, i18n, PartnerItem } from 'src/types'
import dialog from 'src/utils/dialog'
import { useLocalStore } from 'src/store/local'
import { emitter } from 'boot/EventBus'
import {
  DELETE_SOLUTION_CONTENT,
  INSERT_SOLUTION_CONTENT,
  SELECT_SOLUTION_CATEGORY_LIST,
  SELECT_SOLUTION_CONTENT_LIST,
  SELECT_SOLUTION_TEMPLATE,
  SELECT_SOLUTION_TEMPLATE_LIST,
  UPDATE_SOLUTION_CATEGORY_SORT,
  UPDATE_SOLUTION_CONTENT_SORT,
} from 'src/api/admin-api'
import { SolutionCategory, SolutionContent, SolutionTemplate } from 'src/types/domain/solution'
import { $t } from 'src/utils'
import PartnerComponent from 'components/desktop/PartnerComponent.vue'
import SearchPanelComponent from 'components/desktop/SearchPanelComponent.vue'
import Splitter12Component from 'components/desktop/Splitter12Component.vue'

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
  { label: '내용명', name: 'S_TITLE' },
  { label: 'PWI Type', name: 'S_PWI' },
]

const selectedCategory = ref<SolutionCategory | null>()
const categoryItems = ref<SolutionCategory[] | null>([])
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
    loadContent()
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
    await UPDATE_SOLUTION_CATEGORY_SORT({ list })
  },
}
function openCategory(row?: any) {
  void emitter.emit(EventType.commonDialog, <CommonDialogProps<any>>{
    component: 'src/pages/desktop/content/solution/category.vue',
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

const selectedContent = ref<SolutionContent | null>()
const contentItems = ref<SolutionContent[] | null>([])
const contentData = {
  get columns() {
    return [
      { label: '코드', name: 'C_CODE', textClass: 'text-center', columnClass: 'text-center' },
      { label: '내용명', name: 'S_TITLE', textClass: 'text-left', columnClass: 'text-left' },
      { label: 'PWI Type', name: 'S_PWI', textClass: 'text-left word-break', columnClass: 'text-left', style: 'max-width: 150px;' },
    ]
  },
  click: (row: any) => {
    selectedContent.value = row
  },
  edit: (row: any) => {
    editTemplate(row.C_CODE)
  },
  delete: (row: any) => {
    dialog.confirmMessage({
      title: '',
      message: '내용 목록에서 제외 하시겠습니까?',
      callback: async (state: boolean) => {
        if (state) {
          const data: SolutionContent = Object.assign({}, row)
          let result: number = await DELETE_SOLUTION_CONTENT(data)
          await dialog.message({
            message: result != -1 ? $t(i18n.common.BeProcessed) : $t(i18n.common.FailedBeProcessed),
          })
          await loadContent()
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
    await UPDATE_SOLUTION_CONTENT_SORT({ list })
  },
}

const dataTemplate = ref<SolutionTemplate>(<SolutionTemplate>{ C_CODE: '', S_TITLE: '', S_PWI: '' })
const selectedTemplate = ref<SolutionTemplate | null>()
let sourceTemplateItems: SolutionTemplate[] | null
const templateItems = ref<SolutionTemplate[] | null>([])
const templateData = {
  get columns() {
    return [
      { label: '코드', name: 'C_CODE', textClass: 'text-center', columnClass: 'text-center' },
      { label: '내용명', name: 'S_TITLE', textClass: 'text-left', columnClass: 'text-left' },
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
  SELECT_SOLUTION_TEMPLATE(C_CODE).then((row) => {
    openTemplate(row)
  })
}
function openTemplate(row?: any) {
  void emitter.emit(EventType.commonDialog, <CommonDialogProps<any>>{
    component: 'src/pages/desktop/content/solution/template.vue',
    callback: () => {
      loadContent()
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
  return selectedPartner.value?.CM_ID
}

const loadCategory = async () => {
  categoryItems.value = await SELECT_SOLUTION_CATEGORY_LIST(getCM_ID())
  selectedCategory.value = null
  contentItems.value = null
  selectedContent.value = null
}

const getCategoryCode = () => {
  return selectedCategory.value?.C_CODE
}

const loadContent = async () => {
  contentItems.value = await SELECT_SOLUTION_CONTENT_LIST(getCategoryCode() as string)
  selectedContent.value = null
  filterLoadTemplate()
}

const loadTemplate = async () => {
  sourceTemplateItems = await SELECT_SOLUTION_TEMPLATE_LIST(dataTemplate.value)
  filterLoadTemplate()
}

const filterLoadTemplate = () => {
  templateItems.value = (sourceTemplateItems || []).filter((t) => {
    return (contentItems.value || []).find((p) => p.C_CODE == t.C_CODE) == null
  })
  selectedTemplate.value = null
}

onMounted(async () => {
  await loadCategory()
  // await loadTemplate()
})

async function addProduct() {
  const result = await INSERT_SOLUTION_CONTENT(getCategoryCode() as string, selectedTemplate.value?.C_CODE as string)
  await dialog.message({
    message: result != -1 ? $t(i18n.common.BeProcessed) : $t(i18n.common.FailedBeProcessed),
  })
  await loadContent()
  filterLoadTemplate()
}
</script>

<template>
  <q-page>
    <Splitter12Component>
      <template v-slot:left="{ size }">
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
      <template v-slot:rightTop="{ size }">
        <div>
          <div class="text-h6 q-ma-md">Product</div>
          <div>
            <DragTableComponent :data="contentData" :items="contentItems" :size="size" />
          </div>
        </div>
      </template>
      <template v-slot:rightBottom="{ size }">
        <div>
          <div class="q-ma-md row justify-center">
            <q-btn outline color="deep-purple-13" @click="addProduct()" icon="arrow_upward" label="추가" :disable="selectedCategory == null || selectedTemplate == null"> </q-btn>
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
    </Splitter12Component>
    <!--    <div>{{ selectedCategory }}</div>-->
    <!--    <div>{{ selectedContent }}</div>-->
    <!--    <div>{{ selectedTemplate }}</div>-->
  </q-page>
</template>

<style lang="sass" scoped>
::v-deep(.q-splitter).Template
  .q-splitter__before, .q-splitter__after
    overflow-y: hidden
    overflow-x: auto

.material-icons
  font-size: 33px
</style>
