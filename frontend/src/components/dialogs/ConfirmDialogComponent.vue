<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { usePopupStore } from 'src/store/popup'
import { EventType, i18n, INoticeProps } from 'src/types'
import { onMounted, reactive, ref } from 'vue'
import { emitter } from 'boot/EventBus'
import { $t } from 'src/utils'

const authStore = useAuthStore()
const popupStore = usePopupStore()

const isDialog = ref(false)
const data = reactive<INoticeProps>(<INoticeProps>{})
onMounted(() => {
  emitter.on(EventType.confirm, (evt: INoticeProps) => {
    data.title = evt.title != null && evt.title.length == 0 ? null : $t(evt.title || i18n.common.notice)
    data.message = evt.message
    data.detailMessage = evt.detailMessage
    data.callback = evt.callback
    isDialog.value = true
  })
})
</script>

<template>
  <q-dialog v-model="isDialog" no-backdrop-dismiss>
    <q-card :style="data.detailMessage == null ? {} : { 'min-width': '350px', 'max-width': '80vh' }">
      <q-card-section>
        <div class="text-subtitle1" v-if="data.title != null">{{ data.title }}</div>
      </q-card-section>

      <q-card-section class="q-pb-none">
        {{ data.message }}
      </q-card-section>

      <q-card-section style="max-height: 50vh" class="scroll" v-if="data.detailMessage != null">
        {{ data.detailMessage }}
      </q-card-section>

      <q-card-actions align="right" class="text-primary q-mt-lg">
        <q-btn :label="$t(i18n.common.confirm)" v-close-popup @click="data?.callback?.(true)" color="primary" style="width: 80px" />
        <q-btn flat :label="$t(i18n.common.cancel)" v-close-popup @click="data?.callback?.(false)" />
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<style lang="sass" scoped>
.q-card
  min-width: 350px
  white-space: pre-line
</style>
