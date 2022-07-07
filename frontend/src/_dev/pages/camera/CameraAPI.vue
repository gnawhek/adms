<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { usePopupStore } from 'src/store/popup'
import { MenuDevPages } from 'src/types/MenusDev'
import { onMounted, ref } from 'vue'
import { takePicture } from 'src/utils/camera'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()

const imageSrc = ref()
onMounted(() => {
  takePicture(
    '#take-picture',
    (base64) => {
      // console.log(base64)
      imageSrc.value = base64
    },
    (message) => {
      const error = document.querySelector('#error')
      if (error) {
        error.innerHTML = message
      }
    },
  )
})
</script>

<template>
  <q-page>
    <div class="container">
      <h3>Camera API</h3>
      <section class="main-content">
        <p>현재 Android의 Firefox 및 Google Chrome에서 구현된 Camera API의 데모입니다. 장치의 카메라로 사진을 찍도록 선택하면 FileReader 개체를 통해 미리보기가 표시됩니다(로컬 파일도 지원됨).</p>

        <input type="file" id="take-picture" accept="image/*" />

        <h4>미리보기:</h4>
        <img alt="" id="show-picture" :src="imageSrc" style="width: 100%" />

        <p id="error"></p>
      </section>
    </div>
  </q-page>
</template>

<style lang="sass" scoped>
.container
  padding: 10px
</style>
