import { boot } from 'quasar/wrappers'
import { createdmaComponents } from 'boot/component/dma-component'
// import TestComponent from 'components/TestComponent.vue';

export default boot(({ app }) => {
  //app.component('TestComponent', defineAsyncComponent(() => import('components/TestComponent.vue')));
  //app.component('TestComponent', TestComponent);

  createdmaComponents(app)
})
