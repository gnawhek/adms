<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { usePopupStore } from 'src/store/popup'
import { CommonDialogProps, GlobalConstants, i18n } from 'src/types'
import { computed, onMounted, ref } from 'vue'
import {
  DELETE_QNA_MANAGEMENT_TEMPLATE,
  DELETE_SOLUTION_TEMPLATE,
  INSERT_QNA_MANAGEMENT_TEMPLATE,
  SELECT_SOLUTION_TEMPLATE_EXISTS,
  SELECT_QNA_MANAGEMENT_TEMPLATE_EXISTS,
  UPDATE_QNA_MANAGEMENT_TEMPLATE,
} from 'src/api/admin-api'
import { useQuasar } from 'quasar'
import dialog from 'src/utils/dialog'
import { $t, isURL } from 'src/utils'
import SexualityComponent from 'components/desktop/SexualityComponent.vue'
import AgeComponent from 'components/desktop/AgeComponent.vue'
import PWIComponent from 'components/desktop/PWIComponent.vue'
import InputCodeComponent from 'components/desktop/InputCodeComponent.vue'
import WeeksComponent from 'components/desktop/WeeksComponent.vue'
import { Vue3JsonEditor } from 'vue3-json-editor'
import { AlgQnaTemplate } from 'src/types/domain/algorithm'
import { takePicture } from 'src/utils/camera'
import InputQNAComponent from 'components/desktop/InputQNAComponent.vue'

const $q = useQuasar()
const authStore = useAuthStore()
const popupStore = usePopupStore()

const props = defineProps<{ data: CommonDialogProps }>()
const selectedItem = ref<AlgQnaTemplate>(<AlgQnaTemplate>{})
let isUpdate = ref(false)
const S_ANS = ref('')
onMounted(async () => {
  isUpdate.value = props.data.params.row != null
  IsConfirmCode.value = isUpdate.value
  // if (props.data.params?.row == null) {
  //   props.data.params = {
  //     row: {
  //       S_ICON_URL: 'https://t1.daumcdn.net/cfile/tistory/173DA4364D290CBE1E',
  //       S_PWI_SEX: 'M;W',
  //       C_CODE: 'I_HT01',
  //       S_ANS: 'qna_template.s_ans.I_H01',
  //       S_PWI_AGE: 'A;B;C;D',
  //       S_QUESTION: 'qna_template.s_question.I_H01',
  //     },
  //   }
  // }
  props.data.title = isUpdate.value ? 'QNA Template 수정' : 'QNA Template'
  selectedItem.value = Object.assign(
    {
      S_ICON_URL: '',
    },
    props.data.params.row,
  )
  if (selectedItem.value.S_ANS != null) {
    try {
      S_ANS.value = JSON.parse(selectedItem.value.S_ANS)
    } catch (error: any) {
      errorMessage.value = error.message
      S_ANS.value = selectedItem.value.S_ANS
    }
  }
})

const IsConfirmCode = ref<boolean>()

async function isCodeCheck(code: string) {
  return await SELECT_QNA_MANAGEMENT_TEMPLATE_EXISTS(code)
}

const saveItem = async () => {
  const data: AlgQnaTemplate = Object.assign({}, selectedItem.value)
  let result: number
  if (isUpdate.value) {
    result = await UPDATE_QNA_MANAGEMENT_TEMPLATE(data)
  } else {
    result = await INSERT_QNA_MANAGEMENT_TEMPLATE(data)
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
    message: 'QNA Template을 삭제하겠습니까?',
    callback: async (state: boolean) => {
      if (state) {
        const data: AlgQnaTemplate = Object.assign({}, selectedItem.value)
        let result: number = await DELETE_QNA_MANAGEMENT_TEMPLATE(data.C_CODE)
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
    (selectedItem.value.S_PWI_SEX || '').length === 0 ||
    (selectedItem.value.S_PWI_AGE || '').length === 0 ||
    (selectedItem.value.S_QUESTION || '').length === 0 ||
    (selectedItem.value.S_ANS || '').length === 0 ||
    !isURL(selectedItem.value.S_ICON_URL)
  )
})

function onJsonChange(value: any) {
  selectedItem.value.S_ANS = JSON.stringify(value)
  errorMessage.value = ''
}

const errorMessage = ref('')

function onError(error: Error) {
  selectedItem.value.S_ANS = ''
  errorMessage.value = error.message
}

function resetJson(type: string) {
  let json = '';
  switch (type) {
    case 'number':
      json = `
        {
          "type": "input",
          "items":[
              {"anskey":"1","item":["키","cm"],"type":"number"}
          ]
        }
      `
      break
    case 'double':
      json = `
        {
          "type": "input",
          "parent": "I_HT01",
          "items":[
            {"anskey":"1","item":["몸무게","kg"],"type":"double"}
          ]
        }
      `
      break
    case 'single':
      json = `
        {
          "type": "single",
          "items": [
            { "anskey": 1, "item": "내용1", "ico_url": "" },
            { "anskey": 2, "item": "내용2", "ico_url": "" },
            { "anskey": 3, "item": "내용3", "ico_url": "" },
            { "anskey": 4, "item": "내용4", "ico_url": "" },
            { "anskey": 5, "item": "내용5", "ico_url": "" }
          ]
        }
      `
      break
    case 'multiple':
      json = `
        {
          "type": "multiple",
          "items": [
            { "anskey": 1, "item": "내용1", "ico_url": "" },
            { "anskey": 2, "item": "내용2", "ico_url": "" },
            { "anskey": 3, "item": "내용3", "ico_url": "" },
            { "anskey": 4, "item": "내용4", "ico_url": "" },
            { "anskey": 5, "item": "내용5", "ico_url": "" }
          ]
        }
      `
      break
  }
  S_ANS.value = JSON.parse(json)
  selectedItem.value.S_ANS = JSON.stringify(S_ANS.value)
}

const profileImage = computed(() => {
  return selectedItem.value.B_ICON || selectedItem.value.S_ICON_URL || require('assets/images/login/img_profile_square.png')
})

const $refFile = ref()
const selectedProfile = () => {
  takePicture('#take-picture', (base64) => {
    // console.log(base64)
    selectedItem.value.B_ICON = base64 as string
  })
  $refFile.value.click()
}
</script>

<template>
  <div class="q-pt-none column scroll" style="max-height: 80vh">
    <div class="q-pa-lg">
      <div class="column q-mb-md">
        <InputQNAComponent v-model:code="selectedItem.C_CODE" v-model:is-update="isUpdate" v-model:confirm-code="IsConfirmCode" :is-code-check="isCodeCheck" />
      </div>
      <div class="fieldLabel">성별<span class="required">*</span></div>
      <div class="q-mb-md group">
        <SexualityComponent v-model="selectedItem.S_PWI_SEX" />
      </div>
      <div class="fieldLabel">나이<span class="required">*</span></div>
      <div class="q-mb-md group">
        <AgeComponent v-model="selectedItem.S_PWI_AGE" />
      </div>
      <div class="q-mb-md group2">
        <div class="column">
          <q-item tag="label">
            <q-item-section>
              <q-item-label>Image 사용여부</q-item-label>
            </q-item-section>
          </q-item>
          <div class="q-ma-md row">
            <!-- prettier-ignore -->
            <q-input
              spellcheck='false'
              filled
              autocomplete='S_ICON_URL'
              v-model='selectedItem.S_ICON_URL'
              label='이미지 주소*'
              lazy-rules
              :rules="[
                (val) => (val && val.length > 0) || '이미지 주소를 입력하지 않았습니다.',
                (val) => isURL(val) || '이미지 주소가 유효하지 않았습니다.'
              ]"
              class='col'
              maxlength='250'
              type='url'
            />
            <div class="column q-ml-lg">
              <div class="relative-position">
                <q-btn type="button" flat @click="selectedProfile" class="q-pa-none" style="border-radius: 5px">
                  <img :src="profileImage" style="width: 90px; height: 90px; object-fit: contain; border-radius: 5px" />
                </q-btn>
                <img src="~/assets/images/login/btn_camera.png" class="absolute-bottom-right no-pointer-events" />
              </div>
              <input type="file" id="take-picture" accept="image/*" ref="$refFile" v-show="false" />
            </div>
          </div>
        </div>
      </div>
      <div class="column q-mb-md">
        <div class="row">
          <!-- prettier-ignore -->
          <q-input
            spellcheck='false'
            outlined
            autocomplete='S_QUESTION'
            v-model='selectedItem.S_QUESTION'
            label='Question*'
            lazy-rules
            :rules="[
                (val) => (val && val.length > 0) || '내용을 입력하지 않았습니다.',
              ]"
            class='full-width'
            maxlength='200'
          />
        </div>
      </div>
      <div class="fieldLabel">Answer<span class="required">*</span></div>
      <div class="column q-mb-xs">
        <div class="error" v-if="errorMessage.length > 0">
          {{ errorMessage }}
        </div>
        <div class="row">
          <!-- prettier-ignore -->
          <Vue3JsonEditor
            class='col json'
            v-model='S_ANS'
            :mode="'text'"
            :show-btns='false'
            :expandedOnStart='true'
            @json-change='onJsonChange'
            @has-error='onError'
          />
        </div>
      </div>
      <div class="fieldLabel row items-center">
        <div>초기화:</div>
        <q-btn flat color="primary" :label="'number'" @click="resetJson('number')" class="q-ml-lg" />
        <q-btn flat color="primary" :label="'double'" @click="resetJson('double')" class="q-ml-lg" />
        <q-btn flat color="primary" :label="'single'" @click="resetJson('single')" class="q-ml-lg" />
        <q-btn flat color="primary" :label="'multiple'" @click="resetJson('multiple')" class="q-ml-lg" />
      </div>
    </div>
  </div>

  <q-card-actions align="right" class="text-primary q-pb-md">
    <q-btn color="primary" :label="$t(i18n.common.save)" @click="saveItem" style="width: 150px" :disable="isValidation" />
    <q-btn v-if="isUpdate" color="red" :label="$t(i18n.common.delete)" @click="deleteItem" style="width: 100px" />
    <q-btn flat :label="$t(i18n.common.cancel)" v-close-popup style="width: 100px" />
  </q-card-actions>

<!--  {{ Object.assign({}, selectedItem) }}-->
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
