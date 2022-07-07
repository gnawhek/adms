<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'CompHabbitResultRate',
  components: {},
  props: {
    resultArray: {
      type: Array,
      default() { return [] }
    }
  }
})
</script>

<template>
  <div class="CompHabbitResultRate flex justify-center full-width q-mt-lg bg-grey-3">
    <div 
      v-for="(result, i) in resultArray" 
      :key="i" 
      :class="[{selected: result.selected}, {lastSelected: resultArray[i].selected && !resultArray[i+1].selected} ]"
      :style="{width: (100/resultArray.length) + '%'}"
    >
      {{result.name}}
    </div>
  </div>
</template>

<style lang="sass" scoped>
div.CompHabbitResultRate
  border-radius: 19px
  height: 30px

  > div
    padding: 6px 0 0 0
    font-size: 12px
    font-weight: 300
    text-align: center
    white-space: nowrap

  div.selected
    background-color: $v-primary
    color: $v-white

  div:first-child
    border-radius: 19px 0 0 19px

  div:last-child,
  div.lastSelected
    border-radius: 0 19px 19px 0
</style>

