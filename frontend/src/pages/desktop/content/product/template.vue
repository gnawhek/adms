<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { usePopupStore } from 'src/store/popup'
import { CommonDialogProps, GlobalConstants, i18n } from 'src/types'
import { computed, onMounted, ref } from 'vue'
import { DELETE_PRODUCT_TEMPLATE, INSERT_PRODUCT_TEMPLATE, SELECT_PRODUCT_TEMPLATE_EXISTS, UPDATE_PRODUCT_TEMPLATE } from 'src/api/admin-api'
import { useQuasar } from 'quasar'
import { ProductTemplate } from 'src/types/domain/product'
import dialog from 'src/utils/dialog'
import { $t, isURL } from 'src/utils'
import { takePicture } from 'src/utils/camera'
import SexualityComponent from 'components/desktop/SexualityComponent.vue'
import AgeComponent from 'components/desktop/AgeComponent.vue'
import PWIComponent from 'components/desktop/PWIComponent.vue'
import InputCodeComponent from 'components/desktop/InputCodeComponent.vue'

const $q = useQuasar()
const authStore = useAuthStore()
const popupStore = usePopupStore()

const props = defineProps<{ data: CommonDialogProps }>()
const selectedItem = ref<ProductTemplate>(<ProductTemplate>{})
let isUpdate = ref(false)
onMounted(async () => {
  isUpdate.value = props.data.params.row != null
  IsConfirmCode.value = isUpdate.value
  // if (props.data.params?.row == null) {
  //   props.data.params = {
  //     row: {
  //       Y_URL: 'y',
  //       Y_ICON: 'y',
  //       N_BRAND_NAME: '브랜드',
  //       C_CODE: 'A0002',
  //       N_PRODUCT_NAME: '제품2',
  //       S_PWI: 'SKIN;BONE;LIVER;EYE;SLEEP;COGNI;BOWEL;DM;DO;SC;SA;OS',
  //       S_ICON: 'https://ipfs.io/ipfs/QmTQo4cxDZ5MoszQAK93JyhFedeMuj7j4x5P7tQnvRi4A5',
  //       S_PWI_SEX: 'W',
  //       S_PWI_AGE: 'C;D;M;N',
  //       S_MEMO: '제품설명입력완료',
  //       S_URL: 'https://ipfs.io/ipfs/QmTQo4cxDZ5MoszQAK93JyhFedeMuj7j4x5P7tQnvRi4A5',
  //       B_ICON: null,
  //     },
  //   }
  // }
  props.data.title = isUpdate.value ? '맞춤제품 수정' : '맞춤제품'
  selectedItem.value = Object.assign({ Y_URL: 'n', Y_ICON: 'n' }, props.data.params.row)
})

const IsConfirmCode = ref<boolean>()
async function isCodeCheck(code: string) {
  return await SELECT_PRODUCT_TEMPLATE_EXISTS(code)
}

const saveItem = async () => {
  const data: ProductTemplate = Object.assign({}, selectedItem.value)
  let result: number
  if (isUpdate.value) {
    result = await UPDATE_PRODUCT_TEMPLATE(data)
  } else {
    result = await INSERT_PRODUCT_TEMPLATE(data)
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
    message: '맞춤제품을 삭제하겠습니까?',
    callback: async (state: boolean) => {
      if (state) {
        const data: ProductTemplate = Object.assign({}, selectedItem.value)
        let result: number = await DELETE_PRODUCT_TEMPLATE(data)
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

const profileImage = computed(() => {
  return selectedItem.value.B_ICON || selectedItem.value.S_ICON || require('assets/images/login/img_profile_square.png')
})

const $refFile = ref()
const selectedProfile = () => {
  takePicture('#take-picture', (base64) => {
    // console.log(base64)
    selectedItem.value.B_ICON = base64 as string
  })
  $refFile.value.click()
}

const isValidation = computed(() => {
  return (
    !IsConfirmCode.value ||
    (selectedItem.value.C_CODE || '').length < GlobalConstants.maxCodeLength ||
    (selectedItem.value.N_BRAND_NAME || '').length === 0 ||
    (selectedItem.value.N_PRODUCT_NAME || '').length === 0 ||
    (selectedItem.value.S_PWI_SEX || '').length === 0 ||
    (selectedItem.value.S_PWI_AGE || '').length === 0 ||
    (selectedItem.value.S_PWI || '').length === 0 ||
    (selectedItem.value.S_MEMO || '').length === 0 ||
    (selectedItem.value.Y_URL === 'y' && !isURL(selectedItem.value.S_URL)) ||
    (selectedItem.value.Y_ICON === 'y' && !isURL(selectedItem.value.S_ICON))
  )
})
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
            autocomplete="N_BRAND_NAME"
            v-model="selectedItem.N_BRAND_NAME"
            label="브랜드명*"
            lazy-rules
            :rules="[
                (val) => (val && val.length > 0) || '브랜드명을 입력하지 않았습니다.',
              ]"
            class="full-width"
            maxlength="50"
            dense
          />
        </div>
      </div>
      <div class="column q-mb-md">
        <div class="row">
          <!-- prettier-ignore -->
          <q-input
            spellcheck="false"
            outlined
            autocomplete="N_PRODUCT_NAME"
            v-model="selectedItem.N_PRODUCT_NAME"
            label="상품명*"
            lazy-rules
            :rules="[
                (val) => (val && val.length > 0) || '상품명을 입력하지 않았습니다.',
              ]"
            class="full-width"
            maxlength="50"
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
      <div class="column q-mb-xs">
        <div class="row">
          <!-- prettier-ignore -->
          <q-input
            spellcheck="false"
            outlined
            autocomplete="S_MEMO"
            v-model="selectedItem.S_MEMO"
            label="제품설명*"
            lazy-rules
            :rules="[
                (val) => (val && val.length > 0) || '제품설명을 입력하지 않았습니다.',
              ]"
            class="full-width"
            maxlength="5000"
            dense
            type="textarea"
            rows="4"
          />
        </div>
      </div>
      <div class="q-mb-md group2">
        <div class="column">
          <q-item tag="label" dense v-ripple>
            <q-item-section>
              <q-item-label>URL 사용여부</q-item-label>
            </q-item-section>
            <q-item-section avatar>
              <q-toggle v-model="selectedItem.Y_URL" checked-icon="check" color="green" unchecked-icon="clear" true-value="y" false-value="n" />
            </q-item-section>
          </q-item>
          <div class="q-ma-md" v-if="selectedItem.Y_URL === 'y'">
            <!-- prettier-ignore -->
            <q-input
              spellcheck="false"
              filled
              autocomplete="S_URL"
              v-model="selectedItem.S_URL"
              label="URL*"
              lazy-rules
              :rules="[
                (val) => (val && val.length > 0) || '사이트 주소를 입력하지 않았습니다.',
                (val) => isURL(val) || '사이트 주소가 유효하지 않았습니다.'
              ]"
              class="full-width"
              maxlength="250"
              type="url"
            />
          </div>
        </div>
      </div>
      <div class="q-mb-md group2">
        <div class="column">
          <q-item tag="label" dense v-ripple>
            <q-item-section>
              <q-item-label>Image 사용여부</q-item-label>
            </q-item-section>
            <q-item-section avatar>
              <q-toggle v-model="selectedItem.Y_ICON" checked-icon="check" color="green" unchecked-icon="clear" true-value="y" false-value="n" />
            </q-item-section>
          </q-item>
          <div class="q-ma-md row" v-if="selectedItem.Y_ICON === 'y'">
            <!-- prettier-ignore -->
            <q-input
              spellcheck="false"
              filled
              autocomplete="S_ICON"
              v-model="selectedItem.S_ICON"
              label="IMAGE CODE*"
              lazy-rules
              :rules="[
                (val) => (val && val.length > 0) || '이미지 주소를 입력하지 않았습니다.',
                (val) => isURL(val) || '이미지 주소가 유효하지 않았습니다.'
              ]"
              class="col"
              maxlength="250"
              type="url"
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
    </div>
  </div>

  <q-separator />

  <q-card-actions align="right" class="text-primary">
    <q-btn color="primary" :label="$t(i18n.common.save)" @click="saveItem" style="width: 150px" :disable="isValidation" />
    <q-btn v-if="isUpdate" color="red" :label="$t(i18n.common.delete)" @click="deleteItem" style="width: 100px" />
    <q-btn flat :label="$t(i18n.common.cancel)" v-close-popup style="width: 100px" />
  </q-card-actions>

  <!--  {{ Object.assign({}, selectedItem, { B_ICON: selectedItem.B_ICON?.length > 0 ? 'base64' : null }) }}-->
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
