<script lang="ts">
import { defineComponent, reactive, computed } from 'vue'

export default defineComponent({
  name: 'HabitHeader',
  components: {},
  setup() {
    const weekSampleData = reactive([
      {day: 'SUN', data: 30, selected: true},
      {day: 'MON', data: 0, selected: false},
      {day: 'TUE', data: 100, selected: false},
      {day: 'WED', data: 0, selected: false},
      {day: 'THU', data: 70, selected: false},
      {day: 'FIR', data: 30, selected: false},
      {day: 'SAT', data: 0, selected: false},
    ])
    return {
      weekSampleData,
      onClickDay: (day: string) => {
        weekSampleData.forEach((v )=> {
          v.selected = v.day === day ? true : false
        })
      },
      getCenterColor: (selected: boolean, index: number) => {
        if(selected) return 'v-selected'
        else if(new Date().getDay() === index) return 'v-today'
        else return 'v-primary'
      }
    }
  },
})
</script>

<template>
    <div class="week-container row justify-around q-pt-md">
      <div v-for="(item, index) in weekSampleData" :key="index" class="column items-center" @click="onClickDay(item.day)">
        <span class="text-v-primary-sub">{{ item.day }}</span>
        <q-circular-progress
          :value="item.data"
          size="40px"
          :thickness="0.15"
          color="v-white"
          track-color="v-primary-sub"
          :center-color="getCenterColor(item.selected, index)"
          class="q-ma-sm"
          style="position: relative;"
        />
        <div 
          class="text-h6"
          style="position: relative;bottom: 2.2em;"
          :class="{'v-white':index === new Date().getDay(), 'text-v-primary-sub':index !== new Date().getDay()}"
          >{{ index + 1 }}</div>
      </div>
    </div>
</template>

<style lang="sass">
$v-primary-sub : #b0abff
$v-selected : #4E45CC
$v-today : #7970FF

.week-container
  background-color: $v-primary

  .text-v-primary-sub
    color: $v-primary-sub
  .text-v-selected
    color: $v-selected
  .text-v-today
    color: $v-today

</style>
