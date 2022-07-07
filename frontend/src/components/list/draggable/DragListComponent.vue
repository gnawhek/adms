<script setup lang="ts">
import draggable from 'vuedraggable'
import { computed, Ref, ref, watch, watchEffect } from 'vue'

interface Item {
  name: string
  order: number
  data: any
}
interface DragEvent {
  click: (element: any, index: number) => void
  edit: (element: any) => void
  checkMove: (evt: any) => void
  onChange: (evt: any, list: any[]) => void
  onEnd: (evt: any) => void
}
interface DragData {
  data: DragEvent
  debug: boolean
  items: Item[]
  dragDisabled: boolean
}
const props = withDefaults(defineProps<DragData>(), {
  data: <any>{
    click: (element: any, index: number) => {
      console.log(element)
      element.fixed = !element.fixed
    },
    edit: (element: any) => {
      console.log('edit', element)
    },
    checkMove: (evt: any) => {
      return evt.from == evt.to
    },
    onChange: (evt: any, list: any[]) => {
      console.log('onChange', evt, list)
    },
    onEnd: (evt: any) => {
      console.log('onEnd', evt)
    },
  },
  items: () => <Item[]>[],
  debug: false,
})

let list = ref<Item[]>()
watch(
  () => props.items,
  (items) => {
    selectedRow.value = null
    list.value = items?.map((item: Item, index) => {
      item.order = index + 1
      return item
    })
  },
)

function sort() {
  list.value = (list.value as any).sort((a: any, b: any) => a.order - b.order)
}

const drag = ref<boolean>(false)
const dragDisabled = ref<boolean>(true)
const disabled = computed(() => {
  return props.dragDisabled || dragDisabled.value
})
const dragOptions = computed(() => ({
  animation: 200,
  group: 'listgroup',
  disabled: disabled.value,
  ghostClass: 'ghost',
  direction: 'vertical',
  delay: 200,
  delayOnTouchOnly: true,
  onChange: (evt: any) => {
    props.data.onChange(evt, list.value as any[])
  },
  // 요소 드래그 종료 시
  onEnd: props.data.onEnd,
}))

const selectedRow = ref<{ row: any; index: number } | null>()
const clickRow = (row: any, index: number) => {
  selectedRow.value = {
    row,
    index,
  }
  props.data.click && props.data.click(row, index)
}
</script>

<template>
  <div class="column">
    <draggable
      class="list-group"
      tag="transition-group"
      :component-data="{
        tag: 'ul',
        type: 'transition-group',
        name: !drag ? 'flip-list' : null,
      }"
      v-model="list"
      v-bind="dragOptions"
      @start="drag = true"
      @end="drag = false"
      item-key="order"
      :move="props.data.checkMove"
    >
      <template #item="{ element, index }">
        <li v-ripple:indigo-11 class="list-group-item" :class="{ selected: selectedRow?.index === index }">
          <div class="row">
            <div class="label col" @click="clickRow(element, index)" @mouseenter="dragDisabled = true">{{ element.name }}</div>
            <q-btn flat dense color="deep-purple-3" class="move" @mouseenter="dragDisabled = false" v-if="!props.dragDisabled">
              <span class="material-icons text-v-primary" title="이동"> dehaze </span>
            </q-btn>
            <q-btn flat dense round color="deep-purple-3" v-if="props.data.edit != null" @click.stop="props.data.edit(element)">
              <span class="material-icons text-v-primary"> edit </span>
            </q-btn>
          </div>
        </li>
      </template>
    </draggable>
  </div>
  <div v-if="debug">
    <button class="btn btn-secondary button" @click="sort">To original order</button>
  </div>
  <pre v-if="debug">{{ list }}</pre>
</template>

<style lang="sass" scoped>
.label
  line-height: 33px

.button
  margin-top: 35px

.flip-list-move
  transition: transform 0.5s

.no-move
  transition: transform 0s

.ghost
  opacity: 0.5
  background: #c8ebfb

.material-icons
  font-size: 19px

.list-group
  min-height: 20px
  margin: 0
  //user-select: none

.list-group-item
  color: $v-gray3
  position: relative
  display: block
  padding: 0.25rem 0.5rem 0.25rem 1rem
  background-color: #fff
  border: 1px solid rgba(0, 0, 0, 0.125)

.list-group-item:hover
  background: $v-gray10

.list-group-item .move
  cursor: move

.list-group-item + .list-group-item
  border-top-width: 0

.list-group
  display: -ms-flexbox
  display: -webkit-box
  display: flex
  -ms-flex-direction: column
  -webkit-box-orient: vertical
  -webkit-box-direction: normal
  flex-direction: column
  padding-left: 0
  margin-bottom: 0
  border-radius: 0.25rem

.list-group-item:first-child
  border-top-left-radius: inherit
  border-top-right-radius: inherit

.selected
  background: $v-gray8
</style>
