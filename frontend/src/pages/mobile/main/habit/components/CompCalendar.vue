<script setup lang="ts">
import { defineComponent, computed, ref } from 'vue'
import { formatDateTimeToString } from 'src/utils'

const props = defineProps({
  viewName: {
      type: String
    }
  })
  const week = ['일', '월', '화', '수', '목', '금', '토']
  const today = formatDateTimeToString(new Date().getTime(), 'YYYY/MM/DD')
  const chekedDate = ref(new Date().getDate())
  let chekedDayLabel = week[new Date(today).getDay()]
  const participation= ref(25)

  interface detailsType {
    day:number
    month: number
    year: number
  }
    
  const date = ref(today)
  const contentTitle = computed(() => {
    if(props.viewName ==='habitMonthily') {
      return `${new Date().getMonth()+ 1}월 평균 참여도 : ${participation.value}%` 
    } else {
      return `${chekedDate.value}일(${chekedDayLabel})`
    }
  })
  const handleClickDatePicker = (value: string, reason: string, details: detailsType) => {
    chekedDate.value = details.day
    chekedDayLabel = week[new Date(value).getDay()]
  }
  const optionsFn = (date: string) => {
    return date >= today
  }
</script>

<template>
  <div class="CompCalendar column fit" :class="{'habit-check':props.viewName ==='habitMonthily'}">
    <q-date
      v-model="date" 
      minimal
      :options="props.viewName !=='habitMonthily' ? optionsFn : none"
      @update:model-value="handleClickDatePicker"
      color="v-gray5"
      class="col-5 full-width"
      style="height: 550px;"
    ></q-date>
    <!-- <q-separator inset></q-separator> -->
    <div class="col-auto calender-content q-pa-lg bg-grey-2" style="height: calc(100vh - 601px);">
    <q-scroll-area class="fit column" :visible="false"> 
      <div class="full-width title q-px-md text-weight-medium"  style="max-height: 30px;">
        {{contentTitle}}
      </div>
      <slot name="calenderContent" />
    </q-scroll-area>
    </div>
  </div>
  
 <!-- -->
</template>

<style lang="sass">
.CompCalendar
  .q-date__calendar-item button
    width: 40px
    height: 40px
  .q-date__today
    background: $v-primary !important
    color: $v-white
  .calender-content
    .title
      font-size: 1.4em
      color: $v-primary
  .q-scrollarea__thumb--v
    width: 3px

  .q-scrollarea__content
    display: grid
    height: 100%
  
.habit-check
  .q-date__calendar-item button
    border: solid 3px $v-gray8
</style>
