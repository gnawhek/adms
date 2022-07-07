<script setup lang="ts">
// import { useRouter } from 'vue-router'
// import { useQuasar } from 'quasar'
import { useStore } from 'src/store'
import { useAuthStore } from 'src/store/auth'
import { usePopupStore } from 'src/store/popup'
import { useLocalStore } from 'src/store/local'
import { useStaffStore } from 'src/store/staff'
import { emitter } from 'boot/EventBus'
import { EventType, i18n, User, ViewPages } from 'src/types'
import { computed, getCurrentInstance, inject, onMounted, provide, reactive, ref } from 'vue'
import { $t } from 'src/utils'
import { $log } from 'src/utils/logger'
import dialog from 'src/utils/dialog'
import { $q, globalEmitter, router } from 'src/state'

// const $q = useQuasar()
// const router = useRouter()
const $store = useStore()
const authStore = useAuthStore()
const popupStore = usePopupStore()
const staffStroe = useStaffStore()
const localStore = useLocalStore()

/* ref */
const user = ref<User>({} as User)

/* reactive */
const user2 = reactive<User>({} as User)

/* defineProps */
interface Props {
  data?: any
}
const props = defineProps<Props>()

/* computed */
const title = computed(() => {
  return i18n.common.notice
})

/* defineExpose*/
const headerExpose = {
  close: () => {
    $log('close')
    void dialog.message({ message: $t(i18n.common.save) })
  },
}
defineExpose(headerExpose)

/* provide */
// const myVariableThatIWantToProvide = ref(props.currentPopup?.title)
// provide('myVariableThatIWantToProvide', myVariableThatIWantToProvide)

/* inject */
const myVariableThatIWantToProvide = inject('myVariableThatIWantToProvide', undefined)

/* popup */
//popupStore.newPopup(ViewPages.FindPassword)
//popupStore.newPopupParam(ViewPages.FindPassword, user.value?.I_ID)

/* emits */
const emit = defineEmits<{
  (e: 'rowClick', evt: any, row: any, index: number, column: any): void
  (e: 'rowDbclick', evt: any, row: any, index: number): void
}>()
//emit('rowClick', evt, row, index, column)

/* currentInstance */
const currentInstance = getCurrentInstance()
const vm = getCurrentInstance()?.proxy

onMounted(async () => {
  console.log((currentInstance as any).setupState)
})
</script>

<template>
  <div class="column q-pa-md">
    <div class="absolute-center title">{{ title }} {{ $t(myVariableThatIWantToProvide || '') }}</div>
    <!--    <div @rowClick='rowClick' @rowDbclick='rowDbclick'></div>-->
  </div>
</template>

<style lang="sass" scoped></style>
