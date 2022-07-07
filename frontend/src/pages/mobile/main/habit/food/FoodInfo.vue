<script setup lang="ts">
import { useAuthStore } from 'src/store/auth'
import { useRouter } from 'vue-router'
import { useStore } from 'src/store'
import { ref, reactive } from 'vue'
import { PopupDrawer } from 'src/types'
import { emitter } from 'boot/EventBus'
import { EventType, i18n } from 'src/types'
import dialog from 'src/utils/dialog'
import { $t } from 'src/utils'

const $store = useStore()
const authStore = useAuthStore()
const router = useRouter()

const props = defineProps<{ currentPopup?: PopupDrawer | null }>()

const items = reactive([
  {title: '식사 타입', options: [{ code: 'home', label: '집밥' },{ code: 'delivery', label: '배달음식' }, { code: 'eatout', label: '외식' }], model: '', type: 'radio'},
  {title: '식사 이유', options: [
      { code: 'A', label: '배고파서' }, { code: 'B', label: '스트레스' }, { code: 'C', label: '먹방유혹' }, { code: 'D', label: '회식' },
      { code: 'E', label: '입이 심심해서' }, { code: 'F', label: '밥시간이 돼서' } ]
    , model: '', type: 'radio'},
  {title: '음식 종류', options: [
      { code: 'A', label: '패스트푸드' },
      { code: 'B', label: '인스턴트'},
      { code: 'C', label: '한식'},
      { code: 'D', label: '육식'},
      { code: 'E', label: '생선'},
      { code: 'F', label: '야채·과일'},
      { code: 'G', label: '튀김'},
      { code: 'H', label: '디저트'},
      { code: 'I', label: '밀가루'},
      { code: 'J', label: '기타' }
    ], model: [], type: 'checkbox'}, //중복가능
  {title: '식사 시간', options :[{code:'A', label:'5분 이내'},{code:'B', label:'5-10분'}
      ,{code:'C', label:'10-20분'},{code:'D', label:'20-30분'},{code:'E', label:'30분 이상'}], model: '', type: 'radio'},
  {title: '식후 포만감', options :[
      {code: 'A', label: '배고픔'}
      , {code: 'B', label: '딱좋음'}
      , {code: 'C', label: '배부름'}], model: [], type: 'checkbox'}, // 중복가능
])

const memo = ref('')

const mode = reactive({
  title: '식후 기분',
  items: [
    {name: 'happy', selected: false, code: 'A'},
    {name: 'satisfy', selected: false, code: 'B' },
    {name: 'nurveous', selected: false, code: 'C' },
    {name: 'complex', selected: false, code: 'D' },
    {name: 'frustrate', selected: false, code: 'E' },
    {name: 'normal', selected: false, code: 'F' },]
})


const getImgUrl = (name: string , selected: boolean) => {
  const opacity = selected ? 's' : 'n'
  return require(`assets/images/habit/icon/ic_${name}_${opacity}.svg`)
}

const handleClickModeItem = (index: number) => {
  mode.items.map((item, i)=> {
    index === i ? item.selected = true: item.selected = false
  })
}

emitter.on(EventType.notice, (evt) => {
  console.log(EventType.notice, evt)
})
const notice = (evt: { title?: string; message: string }) => {
  void dialog.message(evt)
}

</script>

<template>
  <div class="FoodInfo fit">
    <div>picker</div>
    <div class="img-container full-width">
      <img class="full-width" src="~assets/images/habit/img_default.png" />
      <div class="upload-img text-center">
        <img  src="~assets/images/habit/ic_img.svg" />
        <div class="text-white">사진첨부</div>
      </div>
    </div>
    <div v-for="(item, index) in items" :key="index" class="item-container q-px-md">
      <div class="text-bold q-pb-sm">{{item.title}}</div>
      <div v-if="item.type === 'radio'">
        <q-radio
          color="grey"
          v-model="item.model"
          class="q-ma-xs"
          :class="{'item-selected':item.model === option.code}"
          v-for="(option, index) in item.options"
          :key="index"
          :val="option.code"
          :label="option.label"
        />
      </div>
      <div v-else-if="item.type === 'checkbox'">
        <q-checkbox
          color="grey"
          class="q-ma-xs"
          :class="{'item-selected':item.model.includes(option.code)}"
          v-model="item.model"
          v-for="(option, index) in item.options"
          :val="option.code"
          :key="index"
          :label="option.label"
        />
      </div>
    </div>
    <div class="item-container q-px-md">
      <div class="text-bold q-pb-sm">{{mode.title}}</div>
      <img size="24px"
           v-for="(item, index) in mode.items"
           :key="index"
           :src="getImgUrl(item.name, item.selected)"
           @click="handleClickModeItem(index)"
           class="q-px-sm"
      />
    </div>
    <div class="item-container q-px-md">
      <div class="text-bold q-pb-sm">메모</div>
      <q-input
        filled
        type="textarea"
        v-model="memo"
        placeholder="영양소별로 자세하게 기록해보세요.
예) 탄수화물:고구마 2개 / 단백질:계란"
        :dense="true"
        class="q-pa-sm">
      </q-input>

    </div>
    <q-btn-group spread flat class="process-btn q-ma-md">
      <q-btn outline color="grey"
             :label="$t('common.cancel')"
             @click="currentPopup?.closeDrawer"
      />
      <q-btn  class="save q-mx-sm text-weight-light"
              @click="notice({ title: i18n.common.confirm, message: '셀로그에 공유하면, 500셀 더 드려요.공유하시겠어요?' })"
              text-color="white"
              :label="$t('common.save')"
              ref="save"
      />
    </q-btn-group>
  </div>
</template>

<style lang="sass">
.FoodInfo
  .img-container
    position: relative

    .upload-img
      position: absolute
      left: 50%
      top: 50%
      transform: translate( -50%, -50% )
  .item-container
    .q-radio__inner, .q-checkbox__inner
      display: none

    .q-radio__label, .q-checkbox__label
      color: gray
      padding: 3px 15px
      border-radius: 15px
      border: solid 1px #cccccc

    .item-selected
      .q-radio__label, .q-checkbox__label
        color: $v-primary
        border: solid 1px $v-primary

    .q-textarea.q-field--dense .q-field__native
      height: 135px !important
      padding: 25px 15px
    .q-field--dense .q-field__control
      height: 140px
    .q-field--filled .q-field__control:after
      height: 0px

    .q-textarea.q-field--focused
      .q-field__inner
        border: solid 1px $v-primary
        border-radius: 3px

  .q-btn-group.process-btn
    .save
      background: $v-primary !important
    .q-btn-item:not(:last-child)
      border-top-right-radius: 3px
      border-bottom-right-radius: 3px
    .q-btn-item:not(:first-child)
      border-top-left-radius: 3px
      border-bottom-left-radius: 3px

  div.footer > button
    width: calc(50% - 10px)
    height: 42px
    margin: 0 0 0 8px
    padding: 10px 40px 12px
    border-radius: 3px
    font-family: NotoSansKR
    font-size: 14px
    font-weight: 500
    text-align: center
    color: #fff
</style>
