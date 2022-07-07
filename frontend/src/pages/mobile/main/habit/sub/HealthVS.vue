<script setup lang="ts">
import { ref } from 'vue'
import { ViewPages } from 'src/types'
import { usePopupStore } from 'src/store/popup'

const popupStore = usePopupStore()

const record = ref(false)

const onOpenPopup = (name: string) => {
   if(!ViewPages[name]) {
      return false
   }
   popupStore.newPopup(ViewPages[name])
}

</script>

<template>
   <div class="HealthVS q-pa-md bg-grey-3">
      <q-card class="q-pa-sm">
         <q-item class="items-center">
            <q-item-section avatar class="menu-title">
               의약품 등록
            </q-item-section>
            <q-item-section class="text-right">
            <q-item-label>
               <q-btn flat size="sm" class="q-pa-none" @click="onOpenPopup('')">
                  <q-chip size="sm" :class="{'bg-amber-5':record, 'bg-grey-5 text-white':!record}" >
                  <span class="text-subtitle2">+50C</span>
                  </q-chip>
                  <q-icon v-show="record" size="sm" name="keyboard_arrow_right" />
                  </q-btn>
            </q-item-label>
            </q-item-section>
         </q-item>
         <q-item>
            <q-item-section  class="items-center" >
               <q-item-label class="add-item q-pa-lg" @click="onOpenPopup('')"><img src="~assets/images/habit/ic-meal-plus.svg"></q-item-label>
               <q-item-label class="column text-grey">
                  <span class="q-mt-sm">현재 복용중인 약물을 추가해보세요.</span>
                  <q-btn rounded class="q-my-md" color="v-primary" label="처방전 스캔" @click="onOpenPopup('')" />
               </q-item-label>
               
            </q-item-section>
            
         </q-item> 
      </q-card>
   </div>
</template>

<style lang="sass" scoped>
.HealthVS
   min-height: inherit
   .q-card
      border-radius: 10px
      box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.04)

      .add-item
         border: dashed 1px #cccccc
         border-radius: 50%

   .point-font
      font-size: 2.3em
      font-weight: 500
   
   .unit-font
      font-size: 1.3em

   .menu-title
      font-size: 18px
      font-weight: bold

   .defult-text
      width: 130px
      color: #999999

   .point-color
      color: $v-primary

   .scale-container
      padding-top: 0px
      margin-bottom: 5px

   
   
</style>
