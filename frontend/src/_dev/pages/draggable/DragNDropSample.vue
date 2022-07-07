<script setup lang="ts">
import DragListComponent from 'components/list/draggable/DragListComponent.vue'
import DragTableComponent from 'components/list/draggable/DragTableComponent.vue'
import TableStickyHeadersComponent from 'components/list/TableStickyHeadersComponent.vue'
import { computed, onMounted, ref } from 'vue'
import { EventType, i18n, PartnerItem, IResizeObserver } from 'src/types'
import { emitter } from 'boot/EventBus'
import dialog from 'src/utils/dialog'
import { useLocalStore } from 'src/store/local'

const localStore = useLocalStore()
const splitterModel = ref(400) // start at 400px
const leftInsideModel = ref(50) // start at 50%
const rightInsideModel = ref(55)

const categoryItems = ref<any[]>([])
const cagegoryData = {
  click: (row: any) => {
    console.log('list', 'click', row)
  },
  edit: (row: any) => {
    console.log('list', 'edit', row)
  },
  checkMove: (evt: any) => {
    //return evt.from == evt.to
    return true
  },
  onChange: (evt: any) => {
    console.log('list', 'onChange', evt)
  },
  onEnd: (evt: any) => {
    console.log('list', 'onEnd', evt)
  },
}

const groupItems = ref<any[]>([])
const groupData = {
  click: (row: any) => {
    console.log('list', 'click', row)
  },
  edit: (row: any) => {
    console.log('list', 'edit', row)
  },
  checkMove: (evt: any) => {
    return evt.from == evt.to
  },
  onChange: (evt: any) => {
    console.log('list', 'onChange', evt)
  },
  onEnd: (evt: any) => {
    console.log('list', 'onEnd', evt)
  },
}

const productItems = ref<any[]>([])
const productData = {
  get columns() {
    return [
      { label: 'Index', name: 'order', textClass: 'text-center', columnClass: 'text-center' },
      { label: 'Dessert', name: 'name', textClass: 'text-left', columnClass: 'text-left' },
      { label: 'Calories', name: 'calories', textClass: 'text-right', columnClass: 'text-right' },
      { label: 'Fat', name: 'fat', textClass: 'text-right', columnClass: 'text-right' },
      { label: 'Carbs', name: 'carbs', textClass: 'text-right', columnClass: 'text-right' },
      { label: 'Protein', name: 'protein', textClass: 'text-right', columnClass: 'text-right' },
      { label: 'Sodium', name: 'sodium', textClass: 'text-right', columnClass: 'text-right' },
      { label: 'Calcium', name: 'calcium', textClass: 'text-right', columnClass: 'text-right' },
    ]
  },
  click: (row: any) => {
    console.log('list', 'click', row)
  },
  edit: (row: any) => {
    console.log('list', 'edit', row)
  },
  delete: (row: any) => {
    console.log('list', 'delete', row)
  },
  checkMove: (evt: any) => {
    return evt.from == evt.to
  },
  onChange: (evt: any) => {
    console.log('list', 'onChange', evt)
  },
  onEnd: (evt: any) => {
    console.log('list', 'onEnd', evt)
  },
}

const templateItems = ref<any[]>([])
const templateData = {
  get columns() {
    return [
      { label: 'Dessert', name: 'name', textClass: 'text-left', columnClass: 'text-left' },
      { label: 'Calories', name: 'calories', textClass: 'text-right', columnClass: 'text-right' },
      { label: 'Fat', name: 'fat', textClass: 'text-right', columnClass: 'text-right' },
      { label: 'Carbs', name: 'carbs', textClass: 'text-right', columnClass: 'text-right' },
      { label: 'Protein', name: 'protein', textClass: 'text-right', columnClass: 'text-right' },
      { label: 'Sodium', name: 'sodium', textClass: 'text-right', columnClass: 'text-right' },
      { label: 'Calcium', name: 'calcium', textClass: 'text-right', columnClass: 'text-right' },
    ]
  },
  click: (row: any) => {
    console.log('list', 'click', row)
  },
  edit: (row: any) => {
    console.log('list', 'edit', row)
  },
  checkMove: (evt: any) => {
    return evt.from == evt.to
  },
  onChange: (evt: any) => {
    console.log('list', 'onChange', evt)
  },
  onEnd: (evt: any) => {
    console.log('list', 'onEnd', evt)
  },
}

onMounted(() => {
  categoryItems.value = [
    { name: 'category1', partners: 'frist1 / second1' },
    { name: 'category2', partners: 'frist2 / second2' },
    { name: 'category3', partners: 'frist3 / second3' },
    { name: 'category5', partners: 'frist5 / second5' },
    { name: 'category6', partners: 'frist6 / second6' },
    { name: 'category7', partners: 'frist7 / second7' },
    { name: 'category8', partners: 'frist8 / second8' },
    { name: 'category9', partners: 'frist9 / second9' },
  ]
  groupItems.value = [{ name: 'group1' }, { name: 'group2' }]
  // productItems.value = [{ name: 'product1' }, { name: 'product2' }]

  const rows: any[] = [
    {
      name: 'Frozen Yogurt',
      calories: 159,
      fat: 6.0,
      carbs: 24,
      protein: 4.0,
      sodium: 87,
      calcium: '14%',
    },
    {
      name: 'Ice cream sandwich',
      calories: 237,
      fat: 9.0,
      carbs: 37,
      protein: 4.3,
      sodium: 129,
      calcium: '8%',
    },
    {
      name: 'Eclair',
      calories: 262,
      fat: 16.0,
      carbs: 23,
      protein: 6.0,
      sodium: 337,
      calcium: '6%',
    },
    {
      name: 'Cupcake',
      calories: 305,
      fat: 3.7,
      carbs: 67,
      protein: 4.3,
      sodium: 413,
      calcium: '3%',
    },
    {
      name: 'Gingerbread',
      calories: 356,
      fat: 16.0,
      carbs: 49,
      protein: 3.9,
      sodium: 327,
      calcium: '7%',
    },
    {
      name: 'Jelly bean',
      calories: 375,
      fat: 0.0,
      carbs: 94,
      protein: 0.0,
      sodium: 50,
      calcium: '0%',
    },
    {
      name: 'Lollipop',
      calories: 392,
      fat: 0.2,
      carbs: 98,
      protein: 0,
      sodium: 38,
      calcium: '0%',
    },
    {
      name: 'Honeycomb',
      calories: 408,
      fat: 3.2,
      carbs: 87,
      protein: 6.5,
      sodium: 562,
      calcium: '0%',
    },
    {
      name: 'Donut',
      calories: 452,
      fat: 25.0,
      carbs: 51,
      protein: 4.9,
      sodium: 326,
      calcium: '2%',
    },
    {
      name: 'KitKat',
      calories: 518,
      fat: 26.0,
      carbs: 65,
      protein: 7,
      sodium: 54,
      calcium: '12%',
    },
  ]
  const heavyList: any[] = []

  // adding same data multiple times to
  // create a huge list
  for (let i = 0; i < 5; i++) {
    rows.forEach((row) => {
      heavyList.push(Object.assign({}, row))
    })
  }
  productItems.value = heavyList
  templateItems.value = heavyList
})

const sizeProduct = ref<IResizeObserver>()
function onResize(size: IResizeObserver) {
  sizeProduct.value = {
    width: size.width,
    height: size.height - 64,
  }
}

const sizeTemplate = ref<IResizeObserver>()
function onResizeTemplate(size: IResizeObserver) {
  sizeTemplate.value = {
    width: size.width,
    height: size.height - 64,
  }
}

const selectedPartner = ref<PartnerItem>(<PartnerItem>{})
function searchPartner() {
  console.log('파트너검색')
  void dialog.partner((result: PartnerItem) => {
    console.log('searchPartner result', result)
    selectedPartner.value = result
  })
}

function addCategory() {
  console.log('카테고리 추가')
}

function addGroup() {
  console.log('그룹 추가')
}

function addProduct() {
  console.log('제품 추가')
}

function addTemplate() {
  console.log('템플릿 추가')
}
</script>

<template>
  <q-page>
    <!--    <q-btn flat dense color="deep-purple-3" @click.stop="updateData"> updateData </q-btn>-->
    <!--    <q-btn flat dense color="deep-purple-3" @click.stop="updateData2"> updateData2 </q-btn>-->
    <q-splitter v-model="splitterModel" unit="px" :limits="[300, 600]" :style="`height: calc(100vh - ${localStore.HeaderSize.height}px`">
      <template v-slot:before>
        <q-splitter v-model="leftInsideModel" horizontal>
          <template v-slot:before>
            <div class="q-pa-md column">
              <div class="q-pb-md row">
                <div class="searchPartner col-6" @click="searchPartner()" v-ripple:indigo-11>
                  <q-input dense v-model="selectedPartner.N_PARTNER" placeholder="파트너검색" readonly>
                    <template v-slot:append>
                      <q-icon name="search" />
                    </template>
                  </q-input>
                </div>
              </div>
              <div class="text-h6 q-mb-md row">
                <div>Category</div>
                <div class="col" />
                <q-btn flat dense round color="deep-purple-3" @click="addCategory()">
                  <span class="material-icons text-v-primary"> add </span>
                  <q-tooltip anchor="center right" self="center left"> 카테고리 추가 </q-tooltip>
                </q-btn>
              </div>
              <div class="q-my-md">
                <DragListComponent :data="cagegoryData" :items="categoryItems" :debug="false" />
              </div>
            </div>
          </template>

          <template v-slot:after>
            <div class="q-pa-md">
              <div class="text-h6 q-mb-md row">
                <div>Group</div>
                <div class="col" />
                <q-btn flat dense round color="deep-purple-3" @click="addGroup()">
                  <span class="material-icons text-v-primary"> add </span>
                  <q-tooltip anchor="center right" self="center left"> 그룹 추가 </q-tooltip>
                </q-btn>
              </div>
              <div class="q-my-md">
                <DragListComponent :data="groupData" :items="groupItems" :debug="false" />
              </div>
            </div>
          </template>
        </q-splitter>
      </template>

      <template v-slot:after>
        <q-splitter v-model="rightInsideModel" :limits="[20, 80]" horizontal class="Template">
          <template v-slot:before>
            <q-resize-observer @resize="onResize" />
            <div>
              <div class="text-h6 q-ma-md">Product</div>
              <div>
                <DragTableComponent :data="productData" :items="productItems" :size="sizeProduct" :debug="false" />
              </div>
            </div>
          </template>

          <template v-slot:after>
            <q-resize-observer @resize="onResizeTemplate" />
            <div>
              <div class="q-ma-md row justify-center">
                <q-btn outline color="deep-purple-13" @click="addProduct()" icon="arrow_upward" label="제품 추가"> </q-btn>
              </div>
              <div class="text-h6 q-ma-md row">
                <div>Template</div>
                <div class="col" />
                <q-btn flat dense round color="deep-purple-3" @click="addTemplate()">
                  <span class="material-icons text-v-primary"> add </span>
                  <q-tooltip anchor="center left" self="center right"> 템플릿 추가 </q-tooltip>
                </q-btn>
              </div>
              <div>
                <TableStickyHeadersComponent :data="templateData" :items="templateItems" :size="sizeTemplate" :debug="false" />
              </div>
            </div>
          </template>
        </q-splitter>
      </template>
    </q-splitter>
  </q-page>
</template>

<style lang="sass" scoped>
::v-deep(.q-splitter).Template
  .q-splitter__before, .q-splitter__after
    overflow-y: hidden
    overflow-x: auto

.material-icons
  font-size: 33px

.searchPartner
  cursor: pointer
  position: relative

.searchPartner ::v-deep(.q-field).q-field--standard.q-field--readonly .q-field__control:before
  border-bottom-style: solid
</style>
