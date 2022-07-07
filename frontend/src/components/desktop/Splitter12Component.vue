<script setup lang="ts">
import { IResizeObserver } from 'src/types'
import { PropType, ref } from 'vue'
import { useLocalStore } from 'src/store/local'

const props = defineProps<{
  offset?: { left: number; rightTop: number; rightBottom: number; width?: number }
}>()

const offset = props.offset ?? { left: 138, rightTop: 64, rightBottom: 64 }

const localStore = useLocalStore()
const splitterModel = ref(offset.width || 400) // start at 400px
const rightInsideModel = ref(45) // start at 45%

const sizeLeft = ref<IResizeObserver>()
function onResizeLeft(size: IResizeObserver) {
  sizeLeft.value = {
    width: size.width,
    height: size.height - offset.left,
  }
}

const sizeRightTop = ref<IResizeObserver>()
function onResizeRightTop(size: IResizeObserver) {
  sizeRightTop.value = {
    width: size.width,
    height: size.height - offset.rightTop,
  }
}

const sizeRightBottom = ref<IResizeObserver>()
function onResizeRightBottom(size: IResizeObserver) {
  sizeRightBottom.value = {
    width: size.width,
    height: size.height - offset.rightBottom,
  }
}
</script>

<template>
  <q-splitter v-model="splitterModel" unit="px" :limits="[300, 800]" :style="`height: calc(100vh - ${localStore.HeaderSize.height}px`">
    <template v-slot:before>
      <q-resize-observer @resize="onResizeLeft" />
      <slot name="left" :size="sizeLeft" />
    </template>

    <template v-slot:after>
      <q-splitter v-model="rightInsideModel" :limits="[20, 80]" horizontal class="Template">
        <template v-slot:before>
          <q-resize-observer @resize="onResizeRightTop" />
          <slot name="rightTop" :size="sizeRightTop" />
        </template>

        <template v-slot:after>
          <q-resize-observer @resize="onResizeRightBottom" />
          <slot name="rightBottom" :size="sizeRightBottom" />
        </template>
      </q-splitter>
    </template>
  </q-splitter>
</template>

<style lang="sass" scoped>
::v-deep(.q-splitter).Template
  .q-splitter__before, .q-splitter__after
    overflow-y: hidden
    overflow-x: auto
</style>
