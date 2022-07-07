<script setup lang="ts">
import { IResizeObserver } from 'src/types'
import { ref } from 'vue'
import { useLocalStore } from 'src/store/local'

const props = defineProps<{
  offset?: { leftTop: number; leftBottom: number; rightTop: number; rightBottom: number; width?: number }
}>()

const offset = props.offset ?? { leftTop: 138, leftBottom: 66, rightTop: 64, rightBottom: 64 }

const localStore = useLocalStore()
const splitterModel = ref(offset.width || 400) // start at 400px
const leftInsideModel = ref(50) // start at 50%
const rightInsideModel = ref(45) // start at 45%

const sizeLeftTop = ref<IResizeObserver>()
function onResizeLeftTop(size: IResizeObserver) {
  sizeLeftTop.value = {
    width: size.width,
    height: size.height - offset.leftTop,
  }
}

const sizeLeftBottom = ref<IResizeObserver>()
function onResizeLeftBottom(size: IResizeObserver) {
  sizeLeftBottom.value = {
    width: size.width,
    height: size.height - offset.leftBottom,
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
      <q-splitter v-model="leftInsideModel" horizontal>
        <template v-slot:before>
          <q-resize-observer @resize="onResizeLeftTop" />
          <slot name="leftTop" :size="sizeLeftTop" />
        </template>

        <template v-slot:after>
          <q-resize-observer @resize="onResizeLeftBottom" />
          <slot name="leftBottom" :size="sizeLeftBottom" />
        </template>
      </q-splitter>
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
