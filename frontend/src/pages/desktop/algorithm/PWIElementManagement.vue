<script setup lang="ts">
import DragTableComponent from 'components/list/draggable/DragTableComponent.vue'
import TableStickyHeadersComponent from 'components/list/TableStickyHeadersComponent.vue'
import { onMounted, ref } from 'vue'
import { CommonDialogProps, EventType, i18n } from 'src/types'
import dialog from 'src/utils/dialog'
import { useCodeStore, useLocalStore } from 'src/store/local'
import { emitter } from 'boot/EventBus'
import {
  DELETE_PWI_ELEMENT_TUPLE_ELEMENT,
  INSERT_PWI_ELEMENT_TUPLE_ELEMENT,
  SELECT_PWI_ELEMENT,
  SELECT_PWI_ELEMENT_LIST,
  SELECT_PWI_ELEMENT_PWI_LIST,
  SELECT_PWI_ELEMENT_TUPLE_LIST,
} from 'src/api/admin-api'
import { $t } from 'src/utils'
import SearchPanelComponent from 'components/desktop/SearchPanelComponent.vue'
import Splitter12Component from 'components/desktop/Splitter12Component.vue'
import { AlgPwi, AlgPwiElem, AlgPwiElemTuple } from 'src/types/domain/algorithm'

const localStore = useLocalStore()
const codeStore = useCodeStore()

const searchItems = ref()
onMounted(async () => {
  searchItems.value = [
    {
      label: 'Type',
      name: 'C_TYPE',
      style: 'width: 150px;',
      options: (await codeStore.algTsTypes()).map((d) => ({
        label: d.C_CODE,
        value: d.C_CODE,
      })),
    },
    { label: '코드', name: 'C_PWI_ELEM', style: 'width: 150px;' },
    { label: '설명', name: 'N_PWI_ELEM' },
  ]
})

const selectedCode = ref<AlgPwi | null>()
const codeItems = ref<AlgPwi[] | null>([])
const codeData = {
  get columns() {
    return [
      { label: 'C_PWI', name: 'C_PWI', textClass: 'text-left', columnClass: 'text-left' },
      { label: 'N_PWI', name: 'N_PWI', textClass: 'text-left', columnClass: 'text-left', divStyle: 'min-width: 70px;' },
      { label: 'C_PARENT', name: 'C_PARENT', textClass: 'text-left', columnClass: 'text-left' },
      { label: 'C_TYPE', name: 'C_TYPE', textClass: 'text-left', columnClass: 'text-left' },
      { label: 'C_ALIAS', name: 'C_ALIAS', textClass: 'text-left', columnClass: 'text-left', divStyle: 'min-width: 60px;' },
      { label: 'Y_CHILD', name: 'Y_CHILD', textClass: 'text-left', columnClass: 'text-left' },
    ]
  },
  click: (row: any) => {
    selectedCode.value = row
    loadContent()
  },
}

const selectedContent = ref<AlgPwiElemTuple | null>()
const contentItems = ref<AlgPwiElemTuple[] | null>([])
const contentData = {
  get columns() {
    return [
      { label: 'Type', name: 'C_TYPE', textClass: 'text-center', columnClass: 'text-center', style: 'width: 60px;' },
      { label: 'Element CODE', name: 'C_PWI_ELEM', textClass: 'text-center', columnClass: 'text-center', style: 'width: 150px;' },
      { label: '설명', name: 'N_PWI_ELEM', textClass: 'text-left', columnClass: 'text-left' },
    ]
  },
  click: (row: any) => {
    selectedContent.value = row
  },
  edit: (row: any) => {
    editTemplate(row.C_PWI_ELEM)
  },
  delete: (row: any) => {
    dialog.confirmMessage({
      title: '',
      message: '목록에서 제외 하시겠습니까?',
      callback: async (state: boolean) => {
        if (state) {
          const data: AlgPwiElemTuple = Object.assign({}, row)
          let result: number = await DELETE_PWI_ELEMENT_TUPLE_ELEMENT(data)
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

const dataTemplate = ref<AlgPwiElem>(<AlgPwiElem>{ C_TYPE: '', C_PWI_ELEM: '', N_PWI_ELEM: '' })
const selectedTemplate = ref<AlgPwiElem | null>()
let sourceTemplateItems: AlgPwiElem[] | null
const templateItems = ref<AlgPwiElem[] | null>([])
const templateData = {
  get columns() {
    return [
      { label: 'Type', name: 'C_TYPE', textClass: 'text-center', columnClass: 'text-left', style: 'width: 60px;' },
      { label: 'CODE', name: 'C_PWI_ELEM', textClass: 'text-left', columnClass: 'text-left' },
      { label: 'Description', name: 'N_PWI_ELEM', textClass: 'text-left', columnClass: 'text-left' },
      { label: 'C_UI_RESULT', name: 'UI CODE', textClass: 'text-left', columnClass: 'text-left' },
      { label: 'I_SORT', name: 'I_SORT', textClass: 'text-left', columnClass: 'text-left' },
    ]
  },
  click: (row: any) => {
    selectedTemplate.value = row
  },
  edit: (row: any) => {
    editTemplate(row.C_PWI_ELEM)
  },
}
function editTemplate(C_PWI_ELEM: string) {
  SELECT_PWI_ELEMENT(C_PWI_ELEM).then((row) => {
    openTemplate(row)
  })
}
function openTemplate(row?: any) {
  void emitter.emit(EventType.commonDialog, <CommonDialogProps<any>>{
    component: 'src/pages/desktop/algorithm/pwiElement/template.vue',
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
  codeItems.value = await SELECT_PWI_ELEMENT_PWI_LIST()
  selectedCode.value = null
  contentItems.value = null
  selectedContent.value = null
}

const getPWI = () => {
  return selectedCode.value?.C_PWI
}

const loadContent = async () => {
  contentItems.value = await SELECT_PWI_ELEMENT_TUPLE_LIST(getPWI() as string)
  selectedContent.value = null
  filterLoadTemplate()
}

const loadTemplate = async () => {
  sourceTemplateItems = await SELECT_PWI_ELEMENT_LIST(dataTemplate.value)
  filterLoadTemplate()
}

const filterLoadTemplate = () => {
  templateItems.value = (sourceTemplateItems || []).filter((t) => {
    return (contentItems.value || []).find((p) => p.C_PWI_ELEM == t.C_PWI_ELEM) == null
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

  const result = await INSERT_PWI_ELEMENT_TUPLE_ELEMENT(getPWI() as string, selectedTemplate.value)
  await dialog.message({
    message: result != -1 ? $t(i18n.common.BeProcessed) : $t(i18n.common.FailedBeProcessed),
  })
  await loadContent()
  filterLoadTemplate()
}
</script>

<template>
  <q-page>
    <Splitter12Component :offset="{ left: 0, rightTop: 0, rightBottom: 64, width: 560 }">
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
            <div>PWI Element</div>
            <div class="col" />
            <q-btn flat dense round color="deep-purple-3" @click="openTemplate()">
              <span class="material-icons text-v-primary"> add </span>
              <q-tooltip anchor="center left" self="center right"> PWI Element 추가 </q-tooltip>
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
