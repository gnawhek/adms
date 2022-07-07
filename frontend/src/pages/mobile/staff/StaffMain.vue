<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import MainHeader from 'components/mobile/MainHeader.vue'
import { MenuDevPages } from 'src/types/MenusDev'
import { usePopupStore } from 'src/store/popup'
import { MenuPages, ViewPages } from 'src/types'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()

const memberSearch = () => {
  popupStore.newPopup(ViewPages.MemberSearch)
}

const memberRegister = () => {
  popupStore.newPopup(ViewPages.MemberRegister)
}

const myMain = () => {
  popupStore.newPopup(ViewPages.MyMain, true)
}
</script>
<template>
  <q-layout view="hHr lpR fFr">
    <q-header>
      <MainHeader />
    </q-header>

    <q-page-container>
      <q-page style="background: red" class="column">
        <div class="panel column no-wrap col">
          <div class="row col items-center justify-center">
            <div class="login-panel column">
              <q-btn label="회원검색" type="button" flat class="q-my-sm q-py-sm login-button" @click="memberSearch" />
              <q-btn label="회원등록" type="button" flat class="q-my-sm q-py-sm login-button" @click="memberRegister" />
              <q-btn label="나의화면" type="button" flat class="q-my-sm q-py-sm login-button" @click="myMain" />
            </div>
          </div>
        </div>
      </q-page>
    </q-page-container>
  </q-layout>
</template>

<style lang="sass" scoped>
.panel, ::v-deep(.q-header) .q-toolbar
  background: $v-gray9 !important

  .login-button
    color: $v-gray2
    background: $v-white
    height: 52px
    width: 268px
</style>
