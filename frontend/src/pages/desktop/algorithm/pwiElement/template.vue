<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { usePopupStore } from 'src/store/popup'
import { CommonDialogProps, i18n } from 'src/types'
import { computed, onMounted, ref } from 'vue'
import { DELETE_PWI_ELEMENT, INSERT_PWI_ELEMENT, SELECT_PWI_ELEMENT_EXISTS, UPDATE_PWI_ELEMENT } from 'src/api/admin-api'
import { useQuasar } from 'quasar'
import dialog from 'src/utils/dialog'
import { $t } from 'src/utils'
import { AlgPwiElem } from 'src/types/domain/algorithm'
import { useCodeStore } from 'src/store/local'
import InputPWIComponent from 'components/desktop/InputPWIComponent.vue'

const $q = useQuasar()
const authStore = useAuthStore()
const popupStore = usePopupStore()
const codeStore = useCodeStore()

const props = defineProps<{ data: CommonDialogProps }>()
const selectedItem = ref<AlgPwiElem>(<AlgPwiElem>{})
let isUpdate = ref(false)
const typeOptions = ref()
const uiTypeOptions = ref()
onMounted(async () => {
  typeOptions.value = (await codeStore.algTsTypes()).map((d) => ({
    label: d.C_CODE,
    value: d.C_CODE,
  }))
  uiTypeOptions.value = (await codeStore.algTsUiTypes()).map((d) => ({
    label: d.C_CODE,
    value: d.C_CODE,
  }))

  isUpdate.value = props.data.params.row != null
  IsConfirmCode.value = isUpdate.value
  if (props.data.params?.row == null) {
    props.data.params = {
      row: {
        Y_UI_RESULT: 'y',
        Y_ALZ_RESULT: 'n',
        C_PWI_ELEM: 'BBBBBBBBBBBB',
        C_TYPE: 'DNA',
        N_PWI_ELEM: '설명',
        C_UI_RESULT: 'BLOOD',
        I_SORT: '1',
      },
    }
  }
  props.data.title = isUpdate.value ? 'PWI Element 수정' : 'PWI Element'
  selectedItem.value = Object.assign(
    {
      Y_UI_RESULT: 'n',
      Y_ALZ_RESULT: 'n',
    },
    props.data.params.row,
  )
})

const IsConfirmCode = ref<boolean>()

async function isCodeCheck(code: string) {
  return await SELECT_PWI_ELEMENT_EXISTS(code)
}

const saveItem = async () => {
  const data: AlgPwiElem = Object.assign({}, selectedItem.value)
  let result: number
  if (isUpdate.value) {
    result = await UPDATE_PWI_ELEMENT(data)
  } else {
    result = await INSERT_PWI_ELEMENT(data)
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
    message: 'PWI Element를 삭제하겠습니까?',
    callback: async (state: boolean) => {
      if (state) {
        const data: AlgPwiElem = Object.assign({}, selectedItem.value)
        let result: number = await DELETE_PWI_ELEMENT(data.C_PWI_ELEM)
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
    (selectedItem.value.C_TYPE || '').length === 0 ||
    (selectedItem.value.N_PWI_ELEM || '').length === 0 ||
    (selectedItem.value.C_UI_RESULT || '').length === 0 ||
    selectedItem.value.I_SORT == null ||
    selectedItem.value.I_SORT.toString().length == 0
  )
})
</script>

<template>
  <div class="q-pt-none column scroll" style="max-height: 80vh">
    <div class="q-pa-lg">
      <div class="column q-mb-md">
        <InputPWIComponent v-model:code="selectedItem.C_PWI_ELEM" v-model:is-update="isUpdate" v-model:confirm-code="IsConfirmCode" :is-code-check="isCodeCheck" />
      </div>
      <q-select clearable outlined square v-model="selectedItem.C_TYPE" :options="typeOptions" :option-value="(item) => (item === null ? '' : item.value)" emit-value :label="'Transaction ID'" />
      <div class="column q-my-md">
        <div class="row">
          <!-- prettier-ignore -->
          <q-input
            spellcheck='false'
            outlined
            autocomplete='N_PWI_ELEM'
            v-model='selectedItem.N_PWI_ELEM'
            label='설명'
            lazy-rules
            :rules="[
                (val) => (val && val.length > 0) || '내용을 입력하지 않았습니다.',
              ]"
            class='full-width'
            maxlength='200'
          />
        </div>
      </div>
      <q-select clearable outlined square v-model="selectedItem.C_UI_RESULT" :options="uiTypeOptions" :option-value="(item) => (item === null ? '' : item.value)" emit-value :label="'UI CODE'" />
      <div class="q-my-md group2">
        <div class="column">
          <q-item tag="label" dense v-ripple>
            <q-item-section>
              <q-item-label>UI 결과 항목</q-item-label>
            </q-item-section>
            <q-item-section avatar>
              <q-toggle v-model="selectedItem.Y_UI_RESULT" checked-icon="check" color="green" unchecked-icon="clear" true-value="y" false-value="n" />
            </q-item-section>
          </q-item>
        </div>
      </div>
      <div class="q-mb-md group2">
        <div class="column">
          <q-item tag="label" dense v-ripple>
            <q-item-section>
              <q-item-label>알고리즘 항목</q-item-label>
            </q-item-section>
            <q-item-section avatar>
              <q-toggle v-model="selectedItem.Y_ALZ_RESULT" checked-icon="check" color="green" unchecked-icon="clear" true-value="y" false-value="n" />
            </q-item-section>
          </q-item>
        </div>
      </div>
      <!-- prettier-ignore -->
      <q-input
        spellcheck='false'
        outlined
        autocomplete='I_SORT'
        v-model='selectedItem.I_SORT'
        lazy-rules
        :rules="[
                (val) => (val && val.length > 0) || '정렬 순서를 입력하지 않았습니다.',
              ]"
        class='col'
        placeholder='정렬 순서를 입력해주세요'
        mask='###'
      />
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
</style>
