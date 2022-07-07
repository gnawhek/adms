<script setup lang="ts">
import { PropType } from 'vue'

const props = defineProps({
  modelValue: {
    default: '',
  },
  items: {
    type: Array,
  },
  load: {
    type: Function as PropType<() => void>,
  },
})
</script>

<template>
  <div class="row q-mx-md q-mb-md q-gutter-sm">
    <template v-for="item in items" :key="item">
      <q-select
        v-if="item.options != null"
        clearable
        outlined
        dense
        square
        v-model="modelValue[item.name]"
        :options="item.options"
        :option-value="(item) => (item === null ? '' : item.value)"
        emit-value
        :label="item.label"
        :style="item.style"
      />
      <q-input
        v-else
        @keyup.enter="load"
        clearable
        outlined
        dense
        clear-icon="close"
        v-model="modelValue[item.name]"
        :label="item.label"
        :style="item.style"
        :maxlength="item.maxlength > 0 ? item.maxlength : -1"
        spellcheck="false"
      />
    </template>
    <q-btn outline @click="load" color="grey-8" icon="search" label="검색"> </q-btn>
  </div>
</template>

<style lang="sass" scoped></style>
