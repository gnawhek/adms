<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { usePopupStore } from 'src/store/popup'
import { CommonDialogProps, EventType, i18n } from 'src/types'
import { computed, onMounted, reactive, ref } from 'vue'
import { emitter } from 'boot/EventBus'
import { $t, menuToComponent } from 'src/utils'

const authStore = useAuthStore()
const popupStore = usePopupStore()

const title = computed(() => {
  return data.value.title != null && data.value.title.length == 0 ? null : (data.value.title == null ? '' : $t(data.value.title /*|| i18n.common.notice*/))
})
const component = ref()
const data = ref<CommonDialogProps>(<CommonDialogProps>{})
onMounted(() => {
  emitter.on(EventType.commonDialog, (evt: CommonDialogProps) => {
    data.value.title = ''

    component.value = menuToComponent(evt.component)

    data.value = evt
    data.value.isShow = true
  })
})
</script>

<template>
  <q-dialog v-model="data.isShow" :no-backdrop-dismiss="!data.isBackdropDismiss">
    <q-card :style="data.style" :class="{ 'no-scroll': !data.isComponentScrollable }">
      <q-card-section class="row items-center">
        <div class="text-subtitle1" v-if="title != null">{{ title }}</div>
        <div class="col"></div>
        <q-btn flat dense round icon="close" aria-label="Close" @click="data.isShow = false" />
      </q-card-section>

      <q-card-section class="q-pa-none" :class="{ scroll: !data.isComponentScrollable }" :style="{ 'max-height': !data.isComponentScrollable ? '80vh' : '' }">
        <component :is="component" :data="data"></component>
      </q-card-section>

      <q-separator v-if="!data.isComponentAction" />
      <q-card-actions align="right" class="text-primary" v-if="!data.isComponentAction">
        <q-btn flat :label="$t(i18n.common.confirm)" v-close-popup @click="data?.callback?.()" />
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<style lang="sass" scoped>
.q-card
  min-width: 350px
</style>
