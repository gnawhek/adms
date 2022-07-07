<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { usePopupStore } from 'src/store/popup'
import { CommonDialogProps, i18n } from 'src/types'
import { computed, onMounted, ref } from 'vue'
import { useQuasar } from 'quasar'
import dialog from 'src/utils/dialog'
import { $t } from 'src/utils'
import { AlgPwiElemQna } from 'src/types/domain/algorithm'
import { useCodeStore } from 'src/store/local'
import { DELETE_QNA_ELEMENT_QNA_ELEMENT, INSERT_QNA_ELEMENT_QNA_ELEMENT, SELECT_QNA_ELEMENT_TEMPLATE, UPDATE_QNA_ELEMENT_QNA_ELEMENT } from 'src/api/admin-api'
import InputQNAComponent from 'components/desktop/InputQNAComponent.vue'

const $q = useQuasar()
const authStore = useAuthStore()
const popupStore = usePopupStore()
const codeStore = useCodeStore()

const props = defineProps<{ data: CommonDialogProps }>()
const selectedItem = ref<AlgPwiElemQna>(<AlgPwiElemQna>{})
let isUpdate = ref(false)
const S_ANS = ref<any>({})
onMounted(async () => {
  isUpdate.value = props.data.params.row.S_EXCEPTION != null
  // if (props.data.params?.row == null) {
  //   props.data.params = {
  //     row: {
  //       C_CODE: 'I_SS23',
  //       S_EXCEPTION: '[20,35,0,50,100]',
  //       C_PWI_ELEM: 'ASBDEYY43534',
  //       S_QUESTION: 'single',
  //       order: 2,
  //       template: {
  //         S_PWI_SEX: 'M',
  //         C_CODE: 'I_SS23',
  //         S_ICON_URL: '',
  //         S_ANS:
  //           '{"type":"single","items":[{"anskey":1,"item":"내용1","ico_url":""},{"anskey":2,"item":"내용2","ico_url":""},{"anskey":3,"item":"내용3","ico_url":""},{"anskey":4,"item":"내용4","ico_url":""},{"anskey":5,"item":"내용5","ico_url":""}]}',
  //         S_PWI_AGE: 'E;L',
  //         S_QUESTION: 'single',
  //       },
  //     },
  //   }
  // }
  props.data.title = isUpdate.value ? '문진항목 수정' : '문진항목'

  selectedItem.value = Object.assign({}, props.data.params.row)
  selectedItem.value.template = await SELECT_QNA_ELEMENT_TEMPLATE(props.data.params.row.C_CODE)
  S_ANS.value = JSON.parse(selectedItem.value.template.S_ANS)

  const S_EXCEPTION = props.data.params.row.S_EXCEPTION
  if (S_ANS.value.items != null) {
    const exception = JSON.parse(S_EXCEPTION || '[]')
    S_ANS.value.items.forEach((v: any, k: number) => {
      v.value = exception[k] || 0
    })
  } else {
  }
})

const saveItem = async () => {
  const data: AlgPwiElemQna = Object.assign({}, selectedItem.value)
  let result: number
  if (isUpdate.value) {
    result = await UPDATE_QNA_ELEMENT_QNA_ELEMENT(data)
  } else {
    result = await INSERT_QNA_ELEMENT_QNA_ELEMENT(data)
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
    message: '문징항목을 삭제하겠습니까?',
    callback: async (state: boolean) => {
      if (state) {
        const data: AlgPwiElemQna = Object.assign({}, selectedItem.value)
        let result: number = await DELETE_QNA_ELEMENT_QNA_ELEMENT(data)
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

function updateException(values: any) {
  selectedItem.value.S_EXCEPTION = JSON.stringify(values)
  return values
}

const S_EXCEPTION = computed(() => {
  let values: any = []
  if (S_ANS.value.items != null) {
    S_ANS.value.items.forEach((v: any, k: number) => {
      values.push(v.value)
    })
  }
  return updateException(values)
})

const isValidation = computed(() => {
  return false //(selectedItem.value.S_EXCEPTION || '').length === 0
})
</script>

<template>
  <div class="q-pt-none column scroll" style="max-height: 80vh">
    <div class="q-pa-lg">
      <div class="column q-mb-md">
        <q-input spellcheck="false" outlined autocomplete="C_CODE" v-model="selectedItem.C_CODE" class="col" :readonly="true" label="코드" />
      </div>
      <div class="q-pa-sm q-my-md group">
        <div class="row items-center q-pa-md">
          <div class="qnaLabel">문진:</div>
          <div class="questionLabel q-ml-sm">{{ selectedItem.template?.S_QUESTION }}</div>
        </div>
        <div class="row bg-grey-2 q-my-sm items-center item" v-for="item in S_ANS.items" :key="item">
          <div class="q-mx-md">{{ item.anskey }}</div>
          <div class="col-8">{{ item.item }}</div>
          <div class="col-3" v-if="S_ANS.type !== 'input'"><q-slider name="speed" v-model="item.value" label-always :min="0" :max="100" :step="5" /></div>
        </div>
      </div>
      <div v-if="S_ANS.type !== 'input'">
        <div class="fieldLabel">ANSWER Exceptions</div>
        <div class="q-my-md group">
          {{ S_EXCEPTION }}
        </div>
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
  border: 1px solid $grey-4
  border-radius: 5px
  padding: 15px

.item
  padding: 5px
  min-height: 42px

.qnaLabel
  font-size: 18px
  color: $v-gray4

.questionLabel
  font-size: 18px
  color: $v-gray2
</style>
