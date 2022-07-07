<script lang="ts">
import { computed, defineComponent, ref } from 'vue'
import CompCalendar from '../components/CompCalendar.vue'


export default defineComponent({
  name: 'HabitAddNote',
  components: {  CompCalendar },
  setup() {

     const helthNoteItem = [
      { title:'식사',code: 'meal', checked: true },
      { title:'체중',code: 'weight', checked: true },
      { title:'수분섭취',code: 'waterIntake', checked: false },
      { title:'배변',code: 'bowelMovement', checked: true },
      { title:'수면',code: 'sleep', checked: false },
      { title:'혈당',code: 'bloodSugar', checked: false },
      { title:'혈압',code: 'bloodPressure', checked: false },
    ]

    return {
      name,
      helthNoteItem,
      selection: ref([ 'meal', 'weight', 'bowelMovement' ])
    }
  },
})
</script>

<template>
  <div class="HealthNoteAdd bg-white">
    <q-page class="add-content justify-around content-start q-pa-md">
      <q-card class="note-add-card q-ma-sm shadow-0" v-for="item in helthNoteItem" :key="item.code">
        <q-item >
          <q-checkbox 
            v-model="selection"
            :val="item.code"
            :label="item.title" 
            color="grey" />
        </q-item>
      </q-card>
    </q-page>
    <div class="text-center">
    <q-btn class="bg-grey q-px-xl text-h6" flat rounded label="저장" />
    </div>
    <!-- <q-footer class="text-center bg-grey-2">
      <q-btn class="bg-grey q-px-xl text-h6" flat rounded label="저장" />
    </q-footer> -->
  </div>
</template>

<style lang="sass">
.HealthNoteAdd
  background-color: white

  .q-page.add-content
    min-height: 600px !important
    display: flex
    flex-wrap: wrap

    .q-card.note-add-card
      width: 43%
      height: 120px
      border-radius: 15px
      border: solid #9999995e
      
      .q-checkbox__bg
        border-radius: 50%

</style>
