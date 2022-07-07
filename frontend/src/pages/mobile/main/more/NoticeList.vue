<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { reactive, ref} from 'vue'
import { usePopupStore } from 'src/store/popup'
import { ViewPages } from 'src/types'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()

const searchOptions = ['전체', '공지', '안내']
const search = ref('전체')
const noticeSampleList = [
  {title: '건강노트 기능 안내', date: '2021.07.23', type: '공지'},
  {title: '새로워진 셀시스 앱 이용팁', date: '2021.07.23', type: '공지'},
  {title: '신규 회가가입 서비스 안내', date: '2021.07.23', type: '안내'},
  {title: '건강노트 기능 안내', date: '2021.07.23', type: '공지'},
  {title: '새로워진 셀시스 앱 이용팁', date: '2021.07.23', type: '공지'},
  {title: '신규 회가가입 서비스 안내', date: '2021.07.23', type: '안내'},
]
const openPopUp = (name: string, params: any) => {
  popupStore.newPopupParam(ViewPages[name], params)
}
</script>

<template>
  <div class="NoticeList q-pa-md">
      <q-select 
        class="q-py-md"
        style="font-size: 1.4em;"
        outlined 
        v-model="search" 
        :options="searchOptions" />
    <q-list>
      <div v-for="(item, index) in noticeSampleList" :key="item">
      <q-item>
        <q-item-section>
          <q-item-label class="notice-title">{{`[${item.type}] ${item.title}`}}</q-item-label>
          <q-item-label class="q-py-sm notice-date" caption>{{item.date}}</q-item-label>
          
        </q-item-section>

        <q-item-section side>
          <q-icon @click="openPopUp('Notice', item.title)">
            <img src="~assets/images/login/ic_arrow_r_mm.png" />
          </q-icon>
        </q-item-section>
      </q-item>
      <q-separator v-show="index !== noticeSampleList.length - 1" spaced></q-separator>
      </div>
    </q-list>
    <div class="text-v-gray5 text-h6 text-center q-mt-xl" style="font-weight: 400;">
      <U>더 보기</U>
    </div>
          
  </div>
</template>

<style lang="sass">
.NoticeList
  .q-field__native
    font-weight: 500
  .notice-title
    font-size: 1.3em
    font-weight: 400
  .notice-date 
    font-size: 1em
    color: $v-gray5
</style>
