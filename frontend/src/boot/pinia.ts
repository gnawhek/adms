import { boot } from 'quasar/wrappers'
import { createStore } from 'src/store'

export default boot(({ app }) => {
  // console.log('process.env.NODE_ENV: ', process.env.NODE_ENV === 'development');
  // console.log('process.env.VUE_APP_API: ', process.env.VUE_APP_API);
  // console.log('process.env.DEV', process.env.DEV);
  app.use(createStore())
})
