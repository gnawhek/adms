<script lang="ts">
import { defineComponent, onMounted, ref, watch } from 'vue'
import AppMenu from 'components/AppMenu.js'
import LanguageComponent from 'components/LanguageComponent.vue'
import AccountSettings from 'components/user/AccountSettings.vue'
import { useAuthStore } from 'src/store/auth'
import { IResizeObserver, Menus } from 'src/types'
import { useLocalStore } from 'src/store/local'

export default defineComponent({
  name: 'MainLayout',

  components: {
    AccountSettings,
    AppMenu,
    LanguageComponent,
  },

  setup() {
    const leftDrawerOpen = ref(false)

    const wrapper = ref()
    watch(wrapper, (el) => {
      if (el == null) {
        return
      }
      // const rect = el.getBoundingClientRect();
      // console.log('wrapper parent', rect); // works fine!
    })
    const qPopupProxy = ref()
    return {
      miniState: ref(true),
      leftDrawerOpen,
      toggleLeftDrawer() {
        leftDrawerOpen.value = !leftDrawerOpen.value
      },
      settings: ref(false),
      wrapper,
      qPopupProxy,
      closed: () => {
        console.log('closed', qPopupProxy)
        qPopupProxy.value.hide()
      },
      getPopupProxy: () => {
        return qPopupProxy.value
      },
      user: useAuthStore().loginUser,
      profileImage: useAuthStore().profileImage,
      Menus,
      onResize(size: IResizeObserver) {
        useLocalStore().HeaderSize = size
      }
    }
  },
})
</script>

<template>
  <q-layout view="hHh lpR lfr" class="column">
    <q-header reveal bordered class="bg-primary text-white">
      <q-resize-observer @resize="onResize"/>
      <q-toolbar>
        <q-btn flat dense round icon="menu" aria-label="Menu" @click="toggleLeftDrawer" />
        <q-toolbar-title class="row items-center q-gutter-md" style="min-width: 150px">
          <q-avatar>
            <img src="https://cdn.quasar.dev/logo-v2/svg/logo-mono-white.svg" />
          </q-avatar>
          <span> dma </span>
          <LanguageComponent></LanguageComponent>
        </q-toolbar-title>
        <div>
          <q-chip @click="settings = !settings" clickable>
            <q-avatar size="36px" class="q-mt-auto">
              <!--              <img src="https://cdn.quasar.dev/img/boy-avatar.png" />-->
              <img :src="profileImage" style="image-rendering: pixelated" />
            </q-avatar>
            {{ user?.N_NAME }}
            <q-popup-proxy ref="qPopupProxy" persistent transition-show="flip-up" transition-hide="flip-down">
              <account-settings
                :get-ref="
                  (el) => {
                    wrapper = el
                  }
                "
                :popup-closed="closed"
                :get-popup-proxy="getPopupProxy"
                @closed="() => qPopupProxy.hide()"
              />
            </q-popup-proxy>
          </q-chip>
        </div>
      </q-toolbar>
    </q-header>

    <q-drawer v-model="leftDrawerOpen" show-if-above bordered :mini="miniState" @mouseover="miniState = false">
      <q-scroll-area style="height: calc(100% - 70px); margin-bottom: 70px">
        <AppMenu :rootMenu="Menus"></AppMenu>
      </q-scroll-area>

      <!--      <div class='absolute-bottom' style='height: 70px'>-->
      <!--        <img src='https://cdn.quasar.dev/img/material.png' style='height: 70px;width: 100%'>-->
      <!--      </div>-->
      <q-img v-if="leftDrawerOpen && !miniState" class="absolute-bottom" src="https://cdn.quasar.dev/img/material.png" style="height: 70px">
        <template v-slot:loading>
          <div class="text-subtitle1 text-white"></div>
        </template>
        <div class="bg-transparent">
          <div class="text-weight-bold">Copyright (c) LOGSYNK Co.,Ltd All Rights Reserved</div>
        </div>
      </q-img>
    </q-drawer>

    <q-page-container @mouseover="miniState = true">
      <q-page class="column">
        <router-view />
      </q-page>
    </q-page-container>
  </q-layout>
</template>

<style lang="sass" scoped>
//.q-toolbar
//  background: $v-desktop-primary
</style>
