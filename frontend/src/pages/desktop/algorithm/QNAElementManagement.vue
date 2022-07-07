<script setup lang="ts">
import DragTableComponent from 'components/list/draggable/DragTableComponent.vue'
import TableStickyHeadersComponent from 'components/list/TableStickyHeadersComponent.vue'
import { onMounted, ref } from 'vue'
import { CommonDialogProps, EventType, i18n } from 'src/types'
import dialog from 'src/utils/dialog'
import { useCodeStore, useLocalStore } from 'src/store/local'
import { emitter } from 'boot/EventBus'
import { DELETE_QNA_ELEMENT_QNA_ELEMENT, INSERT_QNA_ELEMENT_QNA_ELEMENT, SELECT_QNA_ELEMENT_CODE_LIST, SELECT_QNA_ELEMENT_QNA_LIST, SELECT_QNA_ELEMENT_TEMPLATE_LIST, UPDATE_QNA_ELEMENT_QNA_ELEMENT } from 'src/api/admin-api'
import { $t } from 'src/utils'
import SearchPanelComponent from 'components/desktop/SearchPanelComponent.vue'
import Splitter12Component from 'components/desktop/Splitter12Component.vue'
import { AlgPwi, AlgPwiElem, AlgPwiElemQna, AlgPwiElemTuple, AlgQnaTemplate } from 'src/types/domain/algorithm'

const localStore = useLocalStore()

const searchItems = ref()
onMounted(async () => {
  searchItems.value = [
    { label: '코드', name: 'C_CODE', style: 'width: 150px;' },
    { label: '설명', name: 'S_QUESTION' },
  ]
})

const selectedCode = ref<AlgPwiElem | null>()
const codeItems = ref<AlgPwiElem[] | null>([])
const codeData = {
  get columns() {
    return [
      { label: 'PWI Element', name: 'C_PWI_ELEM', textClass: 'text-left', columnClass: 'text-left', style: 'width: 100px;' },
      { label: '설명', name: 'N_PWI_ELEM', textClass: 'text-left', columnClass: 'text-left' },
    ]
  },
  click: (row: any) => {
    selectedCode.value = row
    loadContent()
  },
}

const selectedContent = ref<AlgPwiElemQna | null>()
const contentItems = ref<AlgPwiElemQna[] | null>([])
const contentData = {
  get columns() {
    return [
      { label: 'QNA Code', name: 'C_CODE', textClass: 'text-center', columnClass: 'text-center', style: 'width: 60px;' },
      { label: 'Question', name: 'S_QUESTION', textClass: 'text-center', columnClass: 'text-center' },
      { label: 'Exception', name: 'S_EXCEPTION', textClass: 'text-left', columnClass: 'text-left' },
    ]
  },
  click: (row: any) => {
    selectedContent.value = row
  },
  edit: (row: any) => {
    openElement(row)
  },
  delete: (row: any) => {
    dialog.confirmMessage({
      title: '',
      message: '목록에서 제외 하시겠습니까?',
      callback: async (state: boolean) => {
        if (state) {
          const data: AlgPwiElemQna = Object.assign({}, row)
          let result: number = await DELETE_QNA_ELEMENT_QNA_ELEMENT(data)
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
}

const dataTemplate = ref<AlgQnaTemplate>(<AlgQnaTemplate>{ C_CODE: '', S_QUESTION: '' })
const selectedTemplate = ref<AlgQnaTemplate | null>()
let sourceTemplateItems: AlgQnaTemplate[] | null
const templateItems = ref<AlgQnaTemplate[] | null>([])
const templateData = {
  get columns() {
    return [
      { label: 'CODE', name: 'C_CODE', textClass: 'text-center', columnClass: 'text-left', style: 'width: 60px;' },
      { label: 'Question', name: 'S_QUESTION', textClass: 'text-left', columnClass: 'text-left' },
    ]
  },
  click: (row: any) => {
    selectedTemplate.value = row
  }
}

function openElement(row?: any) {
  void emitter.emit(EventType.commonDialog, <CommonDialogProps<any>>{
    component: 'src/pages/desktop/algorithm/qnaElement/template.vue',
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
  codeItems.value = await SELECT_QNA_ELEMENT_CODE_LIST()
  selectedCode.value = null
  contentItems.value = null
  selectedContent.value = null
}

const getC_PWI_ELEM = () => {
  return selectedCode.value?.C_PWI_ELEM
}

const loadContent = async () => {
  contentItems.value = await SELECT_QNA_ELEMENT_QNA_LIST(getC_PWI_ELEM() as string)
  selectedContent.value = null
  filterLoadTemplate()
}

const loadTemplate = async () => {
  sourceTemplateItems = await SELECT_QNA_ELEMENT_TEMPLATE_LIST(dataTemplate.value)
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

  openElement(Object.assign({C_PWI_ELEM: getC_PWI_ELEM()}, selectedTemplate.value))
}
</script>

<template>
  <q-page>
    <Splitter12Component :offset="{ left: 0, rightTop: 0, rightBottom: 64 }">
      <template v-slot:left="{ size }">
        <DragTableComponent :data="codeData" :items="codeItems" :size="size" :drag-disabled="'false'" />
      </template>
      <template v-slot:rightTop="{ size }">
        <DragTableComponent :data="contentData" :items="contentItems" :size="size" :drag-disabled="'false'" />
      </template>
      <template v-slot:rightBottom="{ size }">
        <div>
          <div class="q-ma-md row justify-center">
            <q-btn outline color="deep-purple-13" @click="addItem()" icon="arrow_upward" label="선택" :disable="selectedCode == null || selectedTemplate == null"> </q-btn>
          </div>
          <div class="text-h6 q-ma-md row">
            <div>QNA Template</div>
            <div class="col" />
          </div>
          <SearchPanelComponent v-model="dataTemplate" :items="searchItems" :load="loadTemplate" />
          <div>
            <TableStickyHeadersComponent :data="templateData" :items="templateItems" :size="size" :debug="false" />
          </div>
        </div>
      </template>
    </Splitter12Component>
<!--        <div>{{ selectedCode }}</div>-->
<!--        <div>{{ selectedContent }}</div>-->
<!--        <div>{{ selectedTemplate }}</div>-->
  </q-page>
</template>

<style lang="sass" scoped>
.material-icons
  font-size: 33px
</style>
