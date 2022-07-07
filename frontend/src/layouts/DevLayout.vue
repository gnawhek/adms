<script lang="ts">
import { computed, defineComponent, onMounted, ref, watch } from 'vue'
import AppMenu from 'components/AppMenu.js'
import LanguageComponent from 'components/LanguageComponent.vue'
import AccountSettings from 'components/user/AccountSettings.vue'
import { useAuthStore } from 'src/store/auth'
import DrawersComponent from 'components/drawers/DrawersComponent.vue'
import { MenusDev } from 'src/types/MenusDev'
import { IResizeObserver } from 'src/types'
import { useLocalStore } from 'src/store/local'

export default defineComponent({
  name: 'MainLayout',

  components: {
    AccountSettings,
    AppMenu,
    LanguageComponent,
    DrawersComponent,
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

    onMounted(() => {
      leftDrawerOpen.value = false
    })

    const user = useAuthStore().loginUser;

    return {
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
      MenusDev,
      onResize(size: IResizeObserver) {
        useLocalStore().HeaderSize = size
      }
    }
  },
})
</script>

<template>
  <q-layout view="lhr lpR lfr" class="column">
    <q-header reveal bordered class="bg-grey-14 text-white">
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
        <!--        <q-tabs align='left'>-->
        <!--          <q-route-tab to='/page1' label='Page One' />-->
        <!--          <q-route-tab to='/page2' label='Page Two' />-->
        <!--          <q-route-tab to='/page3' label='Page Three' />-->
        <!--        </q-tabs>-->
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

    <q-drawer v-model="leftDrawerOpen" show-if-above bordered>
      <q-scroll-area style="height: calc(100% - 70px); margin-bottom: 70px">
        <AppMenu :rootMenu="MenusDev"></AppMenu>
      </q-scroll-area>

      <!--      <div class='absolute-bottom' style='height: 70px'>-->
      <!--        <img src='https://cdn.quasar.dev/img/material.png' style='height: 70px;width: 100%'>-->
      <!--      </div>-->
      <q-img class="absolute-bottom" src="https://cdn.quasar.dev/img/material.png" style="height: 70px">
        <template v-slot:loading>
          <div class="text-subtitle1 text-white"></div>
        </template>
        <div class="absolute-bottom bg-transparent">
          <div class="text-weight-bold">Copyright (c) LOGSYNK Co.,Ltd All Rights Reserved</div>
        </div>
      </q-img>
    </q-drawer>

    <q-page-container>
      <q-page class="column">
        <router-view />
      </q-page>
    </q-page-container>

    <DrawersComponent />
  </q-layout>
</template>

<style lang="sass" scoped>
.q-page-container
  //padding-top: 0 !important
</style>
