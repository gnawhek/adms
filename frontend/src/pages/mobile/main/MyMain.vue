<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { ref } from 'vue'
import { menuToComponent } from 'src/utils'
import { PopupDrawer, ViewPages } from 'src/types'
import { usePopupStore } from 'src/store/popup'
import { MenuDevPages } from 'src/types/MenusDev'
import MainHeader from 'src/components/mobile/MainHeader.vue'
import HabitHeader from 'src/pages/mobile/main/habit/components/HabitHeader.vue'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()
const props = defineProps<{ currentPopup?: PopupDrawer | null }>()

const tab = ref(ViewPages.HomeMain.key)

const items = [ViewPages.HabitMain, ViewPages.CellMain, ViewPages.HomeMain, ViewPages.AnalysisMain, ViewPages.MoreMain]
interface TabType {
  key: string
  name: string
  component: string
  importComponent: any
}
const tabItems: TabType[] = items.map((item) => {
  return Object.assign({}, item, {
    importComponent: menuToComponent(item.component),
  }) as TabType
})

const showChat = () => {
  popupStore.newPopup(MenuDevPages.PopupSample)
}
const isPopupCheck = props.currentPopup != null
</script>

<template>
  <q-header>
    <MainHeader :currentPopup="props.currentPopup" :tab="tab" />
    <HabitHeader v-if="tab === 'habit'" />
  </q-header>

  <q-page-container class="column" :style="isPopupCheck ? { 'padding-top': 0, 'padding-bottom': 0 } : {}">
    <q-page>
      <q-tab-panels v-model="tab" infinite swipeable animated keep-alive>
        <q-tab-panel v-for="item in tabItems" :name="item.key" :key="item.key">
          <component :is="item.importComponent" />
        </q-tab-panel>
      </q-tab-panels>
      <q-page-sticky position="bottom-right" :offset="[18, 18]">
        <q-btn flat round color="deep-purple-3" size="md" @click="showChat">
          <img src="~assets/images/main/btn_chatbot.svg" />
        </q-btn>
      </q-page-sticky>
    </q-page>
  </q-page-container>

  <q-footer>
    <q-tabs v-model="tab" class="bg-grey-1" dense align="justify">
      <!--        <q-tab v-for="item in tabItems" :key="item.key" :name="item.key" :class="{ 'text-orange': true, [item.key]: true }">-->
      <!--          <div><q-icon name="mail" size="sm" /></div>-->
      <!--          <div class="tab__label">{{ item.name }}</div>-->
      <!--        </q-tab>-->
      <q-tab :name="ViewPages.HabitMain.key" :class="{ [ViewPages.HabitMain.key]: true }">
        <div>
          <q-icon size="sm">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path
                d="M18 3h-3.18C14.4 1.84 13.3 1 12 1c-1.3 0-2.4.84-2.82 2H6c-1.1 0-2 .9-2 2v15c0 1.1.9 2 2 2h6.11a6.743 6.743 0 0 1-1.42-2H6V5h2v1c0 1.1.9 2 2 2h4c1.1 0 2-.9 2-2V5h2v5.08c.71.1 1.38.31 2 .6V5c0-1.1-.9-2-2-2zm-6 2c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm5 7c-2.76 0-5 2.24-5 5s2.24 5 5 5 5-2.24 5-5-2.24-5-5-5zm1.29 7-1.65-1.65a.51.51 0 0 1-.15-.35v-2.49c0-.28.22-.5.5-.5s.5.22.5.5v2.29l1.5 1.5a.495.495 0 1 1-.7.7z"
                fill="currentColor"
              />
            </svg>
          </q-icon>
        </div>
        <div class="tab__label">{{ ViewPages.HabitMain.name }}</div>
      </q-tab>
      <q-tab :name="ViewPages.CellMain.key" :class="{ [ViewPages.CellMain.key]: true }">
        <div>
          <q-icon size="sm">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path
                d="M5 11h4c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2H5c-1.1 0-2 .9-2 2v4c0 1.1.9 2 2 2zm0-6h4v4H5V5zM5 21h4c1.1 0 2-.9 2-2v-4c0-1.1-.9-2-2-2H5c-1.1 0-2 .9-2 2v4c0 1.1.9 2 2 2zm0-6h4v4H5v-4zM13 5v4c0 1.1.9 2 2 2h4c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2h-4c-1.1 0-2 .9-2 2zm6 4h-4V5h4v4z"
                fill="currentColor"
              />
              <rect x="13" y="13" width="8" height="2" rx="1" fill="currentColor" />
              <rect x="13" y="16" width="8" height="2" rx="1" fill="currentColor" />
              <rect x="13" y="19" width="8" height="2" rx="1" fill="currentColor" />
            </svg>
          </q-icon>
        </div>
        <div class="tab__label">{{ ViewPages.CellMain.name }}</div>
      </q-tab>
      <q-tab :name="ViewPages.HomeMain.key" :class="{ [ViewPages.HomeMain.key]: true }">
        <div>
          <q-icon size="sm">
            <svg width="24" height="24" viewBox="24 0 24 48" fill="none" xmlns="http://www.w3.org/2000/svg">
              <circle cx="36" cy="24" r="24" fill="currentColor" />
              <g clip-path="url(#a)" fill="#fff">
                <path
                  d="m44.57 21.821-8.333-7.639a.695.695 0 0 0-.953.014l-7.87 7.639a.695.695 0 0 0-.21.498v10.972c0 .384.31.695.694.695h5.787c.383 0 .694-.311.694-.695v-5.092h3.24v5.092c0 .384.312.695.695.695h5.787c.384 0 .695-.31.695-.695V22.333a.694.694 0 0 0-.225-.512zm-1.163 10.79h-4.398v-5.093a.694.694 0 0 0-.695-.694h-4.63a.694.694 0 0 0-.694.694v5.093h-4.398v-9.984l7.19-6.978 7.625 6.99v9.972z"
                />
                <path d="m28.084 22.75 7.5-7.917 8.75 7.917v10.417H38.5V27.75h-4.583v5.417h-5.834V22.75z" />
              </g>
              <defs>
                <clipPath id="a">
                  <path fill="#fff" transform="translate(26 14)" d="M0 0h20v20H0z" />
                </clipPath>
              </defs>
            </svg>
          </q-icon>
        </div>
        <div class="tab__label">{{ ViewPages.HomeMain.name }}</div>
      </q-tab>
      <q-tab :name="ViewPages.AnalysisMain.key" :class="{ [ViewPages.AnalysisMain.key]: true }">
        <div>
          <q-icon size="sm">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path
                d="M11 10c0-.55.45-1 1-1s1 .45 1 1v7h-2v-7zm9 3c-.55 0-1 .45-1 1v5H5V5h5c.55 0 1-.45 1-1s-.45-1-1-1H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2v-5c0-.55-.45-1-1-1zm1-8h-2V3c0-.55-.45-1-1-1s-1 .45-1 1v2h-2c-.55 0-1 .45-1 1s.45 1 1 1h2v2c0 .55.45 1 1 1s1-.45 1-1V7h2c.55 0 1-.45 1-1s-.45-1-1-1zm-5 8c-.55 0-1 .45-1 1v3h2v-3c0-.55-.45-1-1-1zm-9-1v5h2v-5c0-.55-.45-1-1-1s-1 .45-1 1z"
                fill="currentColor"
              />
            </svg>
          </q-icon>
        </div>
        <div class="tab__label">{{ ViewPages.AnalysisMain.name }}</div>
      </q-tab>
      <q-tab :name="ViewPages.MoreMain.key" :class="{ [ViewPages.MoreMain.key]: true }">
        <div>
          <q-icon size="sm">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path
                d="M4 18h16c.55 0 1-.45 1-1s-.45-1-1-1H4c-.55 0-1 .45-1 1s.45 1 1 1zm0-5h16c.55 0 1-.45 1-1s-.45-1-1-1H4c-.55 0-1 .45-1 1s.45 1 1 1zM3 7c0 .55.45 1 1 1h16c.55 0 1-.45 1-1s-.45-1-1-1H4c-.55 0-1 .45-1 1z"
                fill="currentColor"
              />
            </svg>
          </q-icon>
        </div>
        <div class="tab__label">{{ ViewPages.MoreMain.name }}</div>
      </q-tab>
    </q-tabs>
  </q-footer>
</template>

<style lang="sass" scoped>
@import "src/css/title"

.q-tab-panel
  padding: 0

.q-tabs
  color: $v-gray5

.q-tab
  color: $v-gray5 !important

.q-tab[aria-selected=true]
  color: $v-primary !important

.tab__label
  font-size: 12px
  font-weight: normal
  line-height: normal

::v-deep(.q-tabs)
  .q-tabs__content
    overflow: visible

::v-deep(.q-tab)
  &[aria-selected=true]
    .q-tab__content
      justify-content: flex-end
    .q-icon
      font-size: 50px !important
      position: absolute
      transform: translate(-50%, -100%)
    .tab__label
      height: 17px
</style>
