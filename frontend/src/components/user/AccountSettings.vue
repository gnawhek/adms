<script setup lang="ts">
import { computed, onMounted, reactive, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuthStore } from 'src/store/auth'
import { UserInfo } from 'src/types/domain/UserInfo'

const props = defineProps({
  getRef: {
    type: Function,
  },
  popupClosed: {
    type: Function,
  },
  getPopupProxy: {
    type: Function,
    required: true,
  },
})

interface Emits {
  (e: 'closed'): void
}

//const emit = defineEmits<{ (e: 'change', id: number): void, (e: 'update', value: string): void }>();
/*const emit = defineEmits<{
  (e: 'change', id: number): void
  (e: 'update', value: string): void
}>()*/
//const emit = defineEmits(['closed', 'change', 'update'])
//const emit = defineEmits<{ (e: 'closed'): void }>();
const emit = defineEmits<Emits>()

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()
const $refEl = ref()
const logout = () => {
  authStore.logout()
  router.push({ path: '/login' })
}
const user = useAuthStore().loginUser
const userInfo = reactive<UserInfo>({
  id: '',
  name: '',
})

const save = () => {
  console.log(props.getPopupProxy())
  console.log($refEl.value)
  console.log(Object.assign({}, userInfo))

  //Popup Proxy 닫는 방법
  {
    //방법1
    //props.popupClosed();
    //방법2
    //props.getPopupProxy().hide();
    //방법3
    emit('closed')
  }
}
const wrapper = ref()
onMounted(() => {
  // const rect = wrapper.value.getBoundingClientRect();
  // console.log('$refEl child', $refEl); // works fine!
  // console.log('wrapper child', rect); // works fine!
})
</script>

<template>
  <q-form>
    <div class="row no-wrap q-pa-md" ref="$refEl">
      <div
        class="column"
        :ref="
          (el) => {
            wrapper = el
            getRef(el)
          }
        "
      >
        <div class="text-h6 q-mb-md">나의 정보 수정</div>
        <q-item class="q-pa-none row items-center">
          <div class="myLabel text-weight-medium">지점:</div>
          <div class="myValue text-weight-light">로그싱크</div>
        </q-item>
        <q-item class="q-pa-none">
          <div class="myLabel text-weight-medium">권한:</div>
          <div class="myValue text-weight-light">super</div>
        </q-item>
        <q-item class="q-pa-none">
          <div class="myLabel text-weight-medium">아이디:</div>
          <div class="myValue text-weight-light">super</div>
        </q-item>
        <q-item class="q-pl-none">
          <q-item-section>
            <q-input v-model="userInfo.name" label="성명" autocomplete="username" outlined dense />
          </q-item-section>
        </q-item>
        <q-item class="q-pl-none">
          <q-item-section>
            <q-input v-model="userInfo.currentPassword" label="현재 비밀번호" type="password" autocomplete="current-password" outlined dense />
          </q-item-section>
        </q-item>
        <q-item class="q-pl-none q-gutter-x-sm">
          <q-item-section>
            <q-input v-model="userInfo.newPassword1" label="변경 비밀번호" type="password" autocomplete="new-password" outlined dense />
          </q-item-section>
          <q-item-section>
            <q-input v-model="userInfo.newPassword2" label="비밀번호 확인" type="password" autocomplete="new-password" outlined dense />
          </q-item-section>
        </q-item>

        <q-item>
          <q-space />
          <q-btn flat color="primary" label="저장" @click="save" />
          <q-btn v-close-popup flat color="primary" label="취소" ref="close" />
        </q-item>
      </div>

      <q-separator vertical inset class="q-mx-lg" />

      <div class="column items-center">
        <q-avatar size="72px">
          <!--          <img src="https://cdn.quasar.dev/img/boy-avatar.png" />-->
          <img :src="authStore.profileImage" style="image-rendering: pixelated" />
        </q-avatar>

        <div class="text-subtitle1 q-mt-md q-mb-xs">{{ user?.N_NAME }}</div>

        <q-btn color="primary" label="Logout" push size="sm" v-close-popup @click="logout" />
      </div>
    </div>
  </q-form>
</template>

<style lang="sass" scoped>
.q-item
  min-height: 30px

.myLabel
  width: 50px
  text-align: right

.myValue
  margin-left: 10px
</style>
