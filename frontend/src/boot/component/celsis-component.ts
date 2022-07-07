import { App, defineAsyncComponent } from 'vue'

// prettier-ignore
export const createdmaComponents = (app: App) => {
  app.component('TestComponent', defineAsyncComponent(() => import('components/TestComponent.vue')))
  // app.component('MemberSearch', defineAsyncComponent(() => import('pages/mobile/member/MemberSearch.vue')))
  app.component('PopupHeader', defineAsyncComponent(() => import('components/common/PopupHeader.vue')))
}
