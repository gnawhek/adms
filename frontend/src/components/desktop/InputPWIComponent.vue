<script setup lang="ts">
import { useVModel } from '@vueuse/core'
import { GlobalConstants } from 'src/types'
import { computed, PropType, ref } from 'vue'
import { SELECT_SOLUTION_CATEGORY_EXISTS } from 'src/api/admin-api'
import { useQuasar } from 'quasar'
import tools from 'src/utils/tools'

const $q = useQuasar()
const emit = defineEmits<{
  (name: 'code', v: string): void
  (name: 'isUpdate', v: boolean): void
  (name: 'confirmCode', v: boolean): void
  (name: 'update:confirmCode', v: boolean): void
  (name: 'update', v: boolean): void
}>()

const props = defineProps({
  code: {
    default: '',
  },
  isUpdate: {
    default: false,
  },
  confirmCode: {
    default: false,
  },
  isCodeCheck: {
    type: Function as PropType<(code: string) => Promise<number>>,
  },
})

const code = useVModel(props, 'code', emit)
const isUpdate = useVModel(props, 'isUpdate', emit)
const confirmCode = useVModel(props, 'confirmCode', emit)

const codeCheck = ref<boolean | null>(null)
const currentCode = ref()
const codeConfirm = async () => {
  if (code.value.length < GlobalConstants.maxQNACodeLength) {
    return
  }
  currentCode.value = null
  const result = await props.isCodeCheck?.(code.value)
  codeCheck.value = result === 0
  if (codeCheck.value) {
    currentCode.value = code.value
    $q.notify({
      color: 'green-4',
      textColor: 'white',
      icon: 'cloud_done',
      message: '사용 가능한 코드입니다.',
    })
  } else {
    $q.notify({
      color: 'red-3',
      textColor: 'white',
      icon: 'cloud_done',
      message: '사용할 수 없는 코드입니다.',
    })
  }
}
const IsConfirmCode = computed(() => {
  const value = <boolean>(isUpdate.value || (codeCheck.value && currentCode.value === code.value))
  emit('update:confirmCode', value)
  emit('update', value)
  return value
})
const getCodeHint = computed(() => {
  if (isUpdate.value) {
    return ''
  } else if (IsConfirmCode.value) {
    return '사용 가능한 코드입니다.'
  // } else if (code.value.length < 4) {
  //   return '영문 2자리를 입력해주세요. (HT00)'
  // } else if (code.value.length < GlobalConstants.maxQNACodeLength) {
  //   return '숫자 2자리를 입력해주세요. (HT00)'
  }
  return '코드 중복확인을 해주세요.'
})
const inputRef = ref<any>(null)
</script>

<template>
  <div class="row">
    <!-- prettier-ignore -->
    <q-input
      ref="inputRef"
      @focus="tools.focusReset(inputRef)"
      spellcheck="false"
      outlined
      autocomplete="C_CODE"
      v-model="code"
      :hint="getCodeHint"
      lazy-rules
      :rules="[
                (val) => (val && val.length > 0) || '코드를 입력하지 않았습니다.',
                // (val) => (val && val.length >= GlobalConstants.maxQNACodeLength) || '코드는 6자리입니다.'
              ]"
      class="col"
      maxlength='12'
      placeholder="코드명을 입력해주세요"
      :readonly="isUpdate"
      @keyup.enter="codeConfirm"
    />
    <q-btn v-if="!isUpdate" label="중복확인" flat class="q-ml-xs apply-button" @click="codeConfirm" :disable="code.length < GlobalConstants.maxQNACodeLength" style="margin-bottom: 20px" />
  </div>
</template>

<style lang="sass" scoped>
.apply-button
  color: $login-color2
  background: $login-color1
</style>
