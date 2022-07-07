<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { usePopupStore } from 'src/store/popup'
import { useQuasar } from 'quasar'
import { emitter } from 'boot/EventBus'
import { EventType, i18n } from 'src/types'
import dialog from 'src/utils/dialog'

const $q = useQuasar()
const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()

emitter.on(EventType.notice, (evt) => {
  console.log(EventType.notice, evt)
})

const notice = (evt: { title?: string; message: string }) => {
  void dialog.message(evt)
}

const error = (detail: string | null = null) => {
  void emitter.emit(EventType.axiosError, {
    config: {
      url: '서비스 ID',
    },
    response: {
      data: {
        message: 'Data 메세지',
        detailMessage: detail,
      },
    },
    message: 'Error 메세지',
  })
}
</script>

<template>
  <q-page class="q-gutter-lg q-pa-lg">
    <div class="row items-center q-gutter-lg">
      <div class="text-h5">{{ EventType.notice }} 이벤트 타이틀, 메세지 포함</div>
      <q-btn dense label="이벤트" @click="notice({ title: i18n.common.confirm, message: '메세지 내용' })" color="primary" />
    </div>
    <div class="row items-center q-gutter-lg">
      <div class="text-h5">{{ EventType.notice }} 이벤트 메세지 포함</div>
      <q-btn dense label="이벤트" @click="notice({ message: '메세지 내용' })" color="primary" />
    </div>
    <div class="row items-center q-gutter-lg">
      <div class="text-h5">{{ EventType.axiosError }} 이벤트 상세 메세지 포함</div>
      <q-btn dense label="이벤트" @click="error('상세 메세지 내용')" color="primary" />
    </div>
    <div class="row items-center q-gutter-lg">
      <div class="text-h5">{{ EventType.axiosError }} 이벤트</div>
      <q-btn dense label="이벤트" @click="error()" color="primary" />
    </div>
  </q-page>
</template>

<style lang="sass" scoped></style>
