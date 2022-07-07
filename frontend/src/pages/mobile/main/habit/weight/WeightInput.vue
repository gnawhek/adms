<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { PopupDrawer } from 'src/types'
import { onMounted, onUnmounted } from 'vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const props = defineProps<{ currentPopup?: PopupDrawer | null }>()
</script>

<template>
  <div class="WeightInput panel fit row flex-center">
    <div class="row full-height justify-center">
      <div class="weight_title fit">오늘 체중을 입력해 주세요.</div>
      <div>
        <q-input
          filled
          v-model="price"
          mask="###.#"
          fill-mask="0"
          reverse-fill-mask
          input-class="text-center"
          suffix="kg"
        />
      </div>
      <div class="full-width" style="height: 80px;" />
    </div>
    <div class="footer full-width q-pa-lg absolute-bottom">
      <q-btn outline color="grey" label="취소" @click="currentPopup?.closeDrawer" />
      <q-btn style="background-color: #6257ff !important;" color="primary" label="저장" />
    </div>
  </div>
</template>

<style lang="sass" scoped>
div.WeightInput
  min-height: inherit

  div.weight_title
    margin: 0 0 30px
    font-family: NotoSansCJKkr
    font-size: 20px
    font-weight: 600
    line-height: 1.5
    text-align: center
    color: $v-gray1

  ::v-deep(.q-field__control:before),
  ::v-deep(.q-field__control)
    background: $v-white !important
    border-bottom: 1px solid $v-gray8 !important

  ::v-deep(.q-field__native)
    font-size: 40px
    width: 120px

  ::v-deep(.q-field__suffix)
    margin-top: 18px

  ::v-deep(.q-field__control-container > *)
    color: $v-gray5

  div.footer > button
    width: calc(50% - 10px)
    height: 42px
    margin: 0 0 0 8px
    padding: 10px 40px 12px
    border-radius: 3px
    font-family: NotoSansKR
    font-size: 14px
    font-weight: 500
    text-align: center
    color: #fff
</style>
