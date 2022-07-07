<template>
  <q-page class="row items-center justify-evenly">
    <example-component :meta="meta" :todos="todos" active title="Example component"></example-component>
    <div>{{ $t('success') }}</div>
    <TestComponent></TestComponent>
    <div class="q-pa-md q-gutter-sm">
      <q-btn color="primary" label="logout" @click="authStore.setAccessToken(null)" :to="{ path: '/login' }" />
    </div>
  </q-page>
</template>

<script lang="ts">
import { Todo, Meta } from 'src/components/models'
import ExampleComponent from 'components/CompositionComponent.vue'
import { defineComponent, ref, onMounted, nextTick } from 'vue'
import { useI18n } from 'vue-i18n'
import { useQuasar } from 'quasar'
import { axiosApi } from 'src/boot/axios'
import languages from 'quasar/lang/index.json'
import { useAuthStore } from 'src/store/auth'
import { storeToRefs } from 'pinia'

export default defineComponent({
  name: 'PageIndex',
  components: { ExampleComponent },
  setup() {
    const todos = ref<Todo[]>([
      {
        id: 1,
        content: 'ct1',
      },
      {
        id: 2,
        content: 'ct2',
      },
      {
        id: 3,
        content: 'ct3',
      },
      {
        id: 4,
        content: 'ct4',
      },
      {
        id: 5,
        content: 'ct5',
      },
    ])
    const meta = ref<Meta>({
      totalCount: 1200,
    })
    console.log('sssss')

    //let test = todos;
    console.log(todos)
    //const win = window as any;

    const i18n = useI18n() as any
    //win['$t'] = i18n.t;

    const $q = useQuasar()
    //win['$q'] = $q;
    //win.axiosApi = axiosApi;

    i18n.locale.value = 'en-US'

    console.log(i18n.messages.value[i18n.locale.value].success)

    const authStore = useAuthStore()
    //win.authStore = authStore;
    onMounted(() => {
      authStore.increment()
      nextTick(() => {
        console.log('onMounted', 'nextTick', axiosApi)
        // setTimeout(() => {
        i18n.locale.value = 'ko-KR'
        console.log(i18n.messages.value[i18n.locale.value].success)
        // }, 500);

        //languages.forEach(language => console.log(language));

        console.log('useAuthStore.count', authStore.count)
        console.log('useAuthStore.doubleCount', authStore.doubleCount())
      })
      console.log('onMounted', 'pass')
    })

    axiosApi.get('data?action=SERVICE_DATA').then((resp: any) => {
      console.log(resp)
    })

    console.log('process.env.NODE_ENV: ', process.env.NODE_ENV === 'development')
    console.log('process.env.VUE_APP_API: ', process.env.VUE_APP_API)

    return {
      todos,
      meta,
      authStore,
    }
  },
})
</script>
