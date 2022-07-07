<script setup lang="ts">
import DragTableComponent from 'components/list/draggable/DragTableComponent.vue'
import TableStickyHeadersComponent from 'components/list/TableStickyHeadersComponent.vue'
import { onMounted, ref } from 'vue'
import { CommonDialogProps, EventType, i18n } from 'src/types'
import dialog from 'src/utils/dialog'
import { useLocalStore } from 'src/store/local'
import { emitter } from 'boot/EventBus'
import {
  DELETE_QNA_MANAGEMENT_CODE_QNA,
  INSERT_QNA_MANAGEMENT_CODE_QNA,
  SELECT_QNA_MANAGEMENT_CODE_LIST,
  SELECT_QNA_MANAGEMENT_CODE_QNA_LIST,
  SELECT_QNA_MANAGEMENT_TEMPLATE,
  SELECT_QNA_MANAGEMENT_TEMPLATE_LIST,
  UPDATE_QNA_MANAGEMENT_CODE_QNA_SORT,
} from 'src/api/admin-api'
import { $t } from 'src/utils'
import SearchPanelComponent from 'components/desktop/SearchPanelComponent.vue'
import Splitter12Component from 'components/desktop/Splitter12Component.vue'
import { AlgQnaGroup, AlgQnaTemplate, AlgQnaTpl } from 'src/types/domain/algorithm'

const localStore = useLocalStore()

const searchItems = [
  { label: '코드', name: 'C_CODE', style: 'width: 100px;', maxlength: 5 },
  { label: '문진', name: 'S_QUESTION' },
]

const selectedCode = ref<AlgQnaGroup | null>()
const codeItems = ref<AlgQnaGroup[] | null>([])
const codeData = {
  get columns() {
    return [
      { label: '코드', name: 'C_CODE', textClass: 'text-left', columnClass: 'text-left', style: 'width: 100px;' },
      { label: '설명', name: 'N_CODE', textClass: 'text-left', columnClass: 'text-left', style: 'max-width: 150px;overflow-wrap: break-word;' },
    ]
  },
  click: (row: any) => {
    selectedCode.value = row
    loadContent()
  },
}

const selectedContent = ref<AlgQnaTpl | null>()
const contentItems = ref<AlgQnaTpl[] | null>([])
const contentData = {
  get columns() {
    return [
      { label: '코드', name: 'C_CODE', textClass: 'text-center', columnClass: 'text-left', style: 'width: 60px;' },
      { label: 'Question', name: 'S_QUESTION', textClass: 'text-left', columnClass: 'text-left' },
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
          const data: AlgQnaTpl = Object.assign({}, row)
          let result: number = await DELETE_QNA_MANAGEMENT_CODE_QNA(data)
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
    await UPDATE_QNA_MANAGEMENT_CODE_QNA_SORT({ list })
  },
}

const dataTemplate = ref<AlgQnaTemplate>(<AlgQnaTemplate>{ C_CODE: '', S_QUESTION: '' })
const selectedTemplate = ref<AlgQnaTemplate | null>()
let sourceTemplateItems: AlgQnaTemplate[] | null
const templateItems = ref<AlgQnaTemplate[] | null>([])
const templateData = {
  get columns() {
    return [
      { label: '코드', name: 'C_CODE', textClass: 'text-center', columnClass: 'text-left', style: 'width: 60px;' },
      { label: 'Question', name: 'S_QUESTION', textClass: 'text-left', columnClass: 'text-left' },
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
  SELECT_QNA_MANAGEMENT_TEMPLATE(C_CODE).then((row) => {
    openTemplate(row)
  })
}
function openTemplate(row?: any) {
  void emitter.emit(EventType.commonDialog, <CommonDialogProps<any>>{
    component: 'src/pages/desktop/algorithm/qna/template.vue',
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

const loadCodeList = async () => {
  codeItems.value = await SELECT_QNA_MANAGEMENT_CODE_LIST()
  selectedCode.value = null
  contentItems.value = null
  selectedContent.value = null
}

const getCode = () => {
  return selectedCode.value?.C_CODE
}

const loadContent = async () => {
  contentItems.value = await SELECT_QNA_MANAGEMENT_CODE_QNA_LIST(getCode() as string)
  selectedContent.value = null
  filterLoadTemplate()
}

const loadTemplate = async () => {
  sourceTemplateItems = await SELECT_QNA_MANAGEMENT_TEMPLATE_LIST(dataTemplate.value)
  filterLoadTemplate()
}

const filterLoadTemplate = () => {
  templateItems.value = (sourceTemplateItems || []).filter((t) => {
    return (contentItems.value || []).find((p) => p.C_CODE == t.C_CODE) == null
  })
  selectedTemplate.value = null
}

onMounted(async () => {
  await loadCodeList()
  // await loadTemplate()
})

async function addItem() {
  if (selectedTemplate.value == null) {
    return
  }

  const result = await INSERT_QNA_MANAGEMENT_CODE_QNA(getCode() as string, selectedTemplate.value)
  await dialog.message({
    message: result != -1 ? $t(i18n.common.BeProcessed) : $t(i18n.common.FailedBeProcessed),
  })
  await loadContent()
  filterLoadTemplate()
}
</script>

<template>
  <q-page>
    <Splitter12Component :offset="{ left: 0, rightTop: 0, rightBottom: 64 }">
      <template v-slot:left="{ size }">
        <DragTableComponent :data="codeData" :items="codeItems" :size="size" :drag-disabled="'false'" />
      </template>
      <template v-slot:rightTop="{ size }">
        <DragTableComponent :data="contentData" :items="contentItems" :size="size" />
      </template>
      <template v-slot:rightBottom="{ size }">
        <div>
          <div class="q-ma-md row justify-center">
            <q-btn outline color="deep-purple-13" @click="addItem()" icon="arrow_upward" label="선택" :disable="selectedCode == null || selectedTemplate == null"> </q-btn>
          </div>
          <div class="text-h6 q-ma-md row">
            <div>QNA Template</div>
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
    <!--    <div>{{ selectedCode }}</div>-->
    <!--    <div>{{ selectedContent }}</div>-->
    <!--    <div>{{ selectedTemplate }}</div>-->
  </q-page>
</template>

<style lang="sass" scoped>
.material-icons
  font-size: 33px
</style>
