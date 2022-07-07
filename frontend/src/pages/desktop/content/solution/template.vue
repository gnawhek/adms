<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { usePopupStore } from 'src/store/popup'
import { CommonDialogProps, GlobalConstants, i18n } from 'src/types'
import { computed, onMounted, ref } from 'vue'
import { DELETE_SOLUTION_TEMPLATE, INSERT_SOLUTION_TEMPLATE, SELECT_SOLUTION_CATEGORY_EXISTS, SELECT_SOLUTION_TEMPLATE_EXISTS, UPDATE_SOLUTION_TEMPLATE } from 'src/api/admin-api'
import { useQuasar } from 'quasar'
import { SolutionTemplate } from 'src/types/domain/solution'
import dialog from 'src/utils/dialog'
import { $t, isURL } from 'src/utils'
import SexualityComponent from 'components/desktop/SexualityComponent.vue'
import AgeComponent from 'components/desktop/AgeComponent.vue'
import PWIComponent from 'components/desktop/PWIComponent.vue'
import InputCodeComponent from 'components/desktop/InputCodeComponent.vue'
import WeeksComponent from 'components/desktop/WeeksComponent.vue'
import { Vue3JsonEditor } from 'vue3-json-editor'

const $q = useQuasar()
const authStore = useAuthStore()
const popupStore = usePopupStore()

const props = defineProps<{ data: CommonDialogProps }>()
const selectedItem = ref<SolutionTemplate>(<SolutionTemplate>{})
let isUpdate = ref(false)
const S_CONTENT = ref('')
onMounted(async () => {
  isUpdate.value = props.data.params.row != null
  IsConfirmCode.value = isUpdate.value
  // if (props.data.params?.row == null) {
  //   props.data.params = {
  //     row: {
  //       Y_WEEK: 'y',
  //       S_WEEK: 'MON;WED',
  //       C_TYPE: 'o',
  //       S_PWI_SEX: 'W',
  //       C_CODE: 'A0001',
  //       S_PWI: 'LIVER;EYE;HORM;HAIR',
  //       S_PWI_AGE: 'A;B;C',
  //       S_TITLE: '솔루션',
  //       S_CONTENT: '{"type":"multiple","content_align":"horizontzl"}',
  //     },
  //   }
  // }
  props.data.title = isUpdate.value ? '맞춤내용 수정' : '맞춤내용'
  selectedItem.value = Object.assign({ Y_WEEK: 'n', S_WEEK: '' }, props.data.params.row)
  if (selectedItem.value.S_CONTENT != null) {
    try {
      S_CONTENT.value = JSON.parse(selectedItem.value.S_CONTENT)
    } catch {}
  }
})

const IsConfirmCode = ref<boolean>()
async function isCodeCheck(code: string) {
  return await SELECT_SOLUTION_TEMPLATE_EXISTS(code)
}

const saveItem = async () => {
  const data: SolutionTemplate = Object.assign({}, selectedItem.value)
  let result: number
  if (isUpdate.value) {
    result = await UPDATE_SOLUTION_TEMPLATE(data)
  } else {
    result = await INSERT_SOLUTION_TEMPLATE(data)
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
    message: '맞춤내용을 삭제하겠습니까?',
    callback: async (state: boolean) => {
      if (state) {
        const data: SolutionTemplate = Object.assign({}, selectedItem.value)
        let result: number = await DELETE_SOLUTION_TEMPLATE(data)
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

const isValidation = computed(() => {
  return (
    !IsConfirmCode.value ||
    (selectedItem.value.C_CODE || '').length < GlobalConstants.maxCodeLength ||
    (selectedItem.value.S_TITLE || '').length === 0 ||
    (selectedItem.value.S_PWI_SEX || '').length === 0 ||
    (selectedItem.value.S_PWI_AGE || '').length === 0 ||
    (selectedItem.value.S_PWI || '').length === 0 ||
    (selectedItem.value.Y_WEEK === 'y' && (selectedItem.value.S_WEEK || '').length === 0) ||
    (selectedItem.value.C_TYPE || '').length === 0 ||
    (selectedItem.value.S_CONTENT || '').length === 0
  )
})

function onJsonChange(value: any) {
  selectedItem.value.S_CONTENT = JSON.stringify(value)
  errorMessage.value = ''
}

const errorMessage = ref('')
function onError(error: Error) {
  selectedItem.value.S_CONTENT = ''
  errorMessage.value = error.message
}

function resetJson() {
  let json = ''
  switch (selectedItem.value.C_TYPE) {
    case 'o':
      json = `
        {
          "type": "multiple/single",
          "content_align": "horizontzl/vertical",
          "tabs": [
            {
              "headline": "headline",
              "items": [
                {
                  "title": "title",
                  "content": "content"
                }
              ]
            }
          ]
        }
      `
      break
    case 'v':
      json = `
        {
          "title": "title",
          "url": "url"
        }
      `
      break
  }
  S_CONTENT.value = JSON.parse(json)
  selectedItem.value.S_CONTENT = JSON.stringify(S_CONTENT.value)

}
</script>

<template>
  <div class="q-pt-none column scroll" style="max-height: 80vh">
    <div class="q-pa-lg">
      <div class="column q-mb-md">
        <InputCodeComponent v-model:code="selectedItem.C_CODE" v-model:is-update="isUpdate" v-model:confirm-code="IsConfirmCode" :is-code-check="isCodeCheck" />
      </div>
      <div class="column q-mb-md">
        <div class="row">
          <!-- prettier-ignore -->
          <q-input
            spellcheck="false"
            outlined
            autocomplete="S_TITLE"
            v-model="selectedItem.S_TITLE"
            label="내용명*"
            lazy-rules
            :rules="[
                (val) => (val && val.length > 0) || '내용명을 입력하지 않았습니다.',
              ]"
            class="full-width"
            maxlength="200"
            dense
          />
        </div>
      </div>
      <div class="fieldLabel">성별<span class="required">*</span></div>
      <div class="q-mb-md group">
        <SexualityComponent v-model="selectedItem.S_PWI_SEX" />
      </div>
      <div class="fieldLabel">나이<span class="required">*</span></div>
      <div class="q-mb-md group">
        <AgeComponent v-model="selectedItem.S_PWI_AGE" />
      </div>
      <div class="fieldLabel">PWI Type<span class="required">*</span></div>
      <div class="q-mb-md group">
        <PWIComponent v-model="selectedItem.S_PWI" />
      </div>
      <div class="q-mb-md group2">
        <div class="column">
          <q-item tag="label" dense v-ripple>
            <q-item-section>
              <q-item-label>SEARCH WEEK</q-item-label>
            </q-item-section>
            <q-item-section avatar>
              <q-toggle v-model="selectedItem.Y_WEEK" checked-icon="check" color="green" unchecked-icon="clear" true-value="y" false-value="n" />
            </q-item-section>
          </q-item>
          <div class="q-ma-md" v-if="selectedItem.Y_WEEK === 'y'">
            <WeeksComponent v-model="selectedItem.S_WEEK" />
          </div>
        </div>
      </div>

      <div class="fieldLabel row items-center">
        <div>TYPE:</div>
        <div class="q-gutter-sm q-ml-md">
          <q-radio v-model="selectedItem.C_TYPE" val="o" label="Object" />
          <q-radio v-model="selectedItem.C_TYPE" val="v" label="Video" />
        </div>
        <q-btn outline color="primary" :label="'초기화'" @click="resetJson" class="q-ml-lg" v-if="selectedItem.C_TYPE?.length > 0" />
      </div>
      <div class="column q-mb-xs">
        <div class="error" v-if="errorMessage.length > 0">
          {{ errorMessage }}
        </div>
        <div class="row">
          <!-- prettier-ignore -->
          <Vue3JsonEditor
            class='col json'
            v-model="S_CONTENT"
            :mode="'text'"
            :show-btns="false"
            :expandedOnStart="true"
            @json-change="onJsonChange"
            @has-error="onError"
          />
        </div>
      </div>
    </div>
  </div>

  <q-card-actions align="right" class="text-primary q-pb-md">
    <q-btn color="primary" :label="$t(i18n.common.save)" @click="saveItem" style="width: 150px" :disable="isValidation" />
    <q-btn v-if="isUpdate" color="red" :label="$t(i18n.common.delete)" @click="deleteItem" style="width: 100px" />
    <q-btn flat :label="$t(i18n.common.cancel)" v-close-popup style="width: 100px" />
  </q-card-actions>

    {{ Object.assign({}, selectedItem) }}
</template>

<style lang="sass" scoped>
//$
@import "src/pages/login/register/register"
.group
  border: 1px solid $grey-5
  border-radius: 5px
  padding: 5px

.group2
  border: 1px solid $grey-5
  border-radius: 5px

.error
  padding: 10px
  background: #f1f1f1
  border-radius: 5px
  margin-bottom: 10px
  color: red

::v-deep(.json)
  .jsoneditor-vue .jsoneditor-outer,
  textarea.jsoneditor-text,
  .ace-jsoneditor
    min-height: 500px

  .jsoneditor-poweredBy
    display: none

  div.jsoneditor
    border: 1px solid $primary

  div.jsoneditor-menu
    background-color: $primary
    border-bottom: 1px solid $primary

  table.jsoneditor-search div.jsoneditor-frame
    border-radius: 8px

  div.jsoneditor-contextmenu ul li button.jsoneditor-selected, div.jsoneditor-contextmenu ul li button.jsoneditor-selected:hover, div.jsoneditor-contextmenu ul li button.jsoneditor-selected:focus
    color: white
    background-color: $primary
</style>
