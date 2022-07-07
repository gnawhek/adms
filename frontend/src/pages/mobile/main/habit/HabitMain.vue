<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { onMounted, onUnmounted, ref, reactive } from 'vue';
import { menuToComponent } from 'src/utils'
import { usePopupStore } from 'src/store/popup'
import { ViewPages } from 'src/types'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()
const popupStore = usePopupStore()

const tab = ref(ViewPages.HealthNote.key)

const check = { achieve:25, cell: '51,000' }

const items = [ViewPages.HealthNote, ViewPages.HealthMission, ViewPages.HealthVS]
const itemsNotice = reactive([true, true, true])

interface TabType {
  key: string
  name: string
  component: string
  importComponent: any
}
const tabItems: TabType[] = items.map((item) => {
  return Object.assign({}, item, {
    importComponent: menuToComponent(item.component)
  }) as TabType
})

onMounted(() => {
  console.log('onMounted')
})

onUnmounted(() => {
  console.log('onUnmounted')
})
const showHabitMonthly = () => {
  popupStore.newPopup(ViewPages.HabitMonthly)
}
const getNotice = (isNotice: boolean) => {
  return isNotice ? 1 : 0
}
</script>

<template>
  <div class="HabitMain">
    <!-- <div class="col"> -->
      <div class=" q-pa-md bg-white">
        <q-btn-group spread class="shadow-0 q-mx-md" style="border: solid 1px #cccccc;">
          <q-btn class="q-py-sm text-grey-8" :label="$t('menus.habit.HabitMonthly')" @click="showHabitMonthly">
            &nbsp;{{check.achieve + '%'}}
            <q-icon color="grey-4" name="keyboard_arrow_right" />
          </q-btn>
           <q-separator vertical inset class="q-mx-sm" />
          <q-btn  class="q-py-sm text-grey-8" label="마이 셀">
            &nbsp;<img src="~assets/images/habit/ic_cel.svg">&nbsp;
            {{check.cell}}
            <q-icon color="grey-4" name="keyboard_arrow_right" />
          </q-btn>
        </q-btn-group>
      </div>
      
      <q-tabs
          v-model="tab"
          dense
          class="text-v-primary"
          align="justify"
        >
        <q-tab v-for="(tab, index) in items" :key="tab.key" :name="tab.key" :label="$t(tab.name)" @click="itemsNotice[index] = !itemsNotice[index]" >
          <svg width="12" height="20" viewBox="0 0 12 20" fill="none" xmlns="http://www.w3.org/2000/svg">
            <ellipse  cx="5" cy="2.784" rx="2.5" ry="2.529" fill="red" :opacity="getNotice(itemsNotice[index])" />
          </svg>
        </q-tab>
      </q-tabs>
      <q-tab-panels v-model="tab" infinite swipeable animated keep-alive class="bg-grey-3" >
        <q-tab-panel v-for="item in tabItems" :name="item.key" :key="item.key" class="q-pa-none">
          <component :is="item.importComponent" />
        </q-tab-panel>
      </q-tab-panels>
    </div>
  <!-- </div> -->
</template>

<style lang="sass">
.HabitMain
  width: 100vw
  .q-tab
    padding: 10px 16px
    padding-right: 5px
  .q-tab__content
    display: contents
  .q-tab__label
    font-size: 1.3em
</style>
