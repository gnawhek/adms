import { boot } from 'quasar/wrappers'
import { useAuthStore } from 'src/store/auth'
import { useLocalStore } from 'src/store/local'
// import { pinia } from 'boot/store';

export default boot(({ router }) => {
  router.beforeEach((to, from, next) => {
    // Now you need to add your authentication logic here, like calling an API endpoint
    const { getAccessToken: accessToken } = useAuthStore()
    if (to.path.startsWith('/dev')) {
    } else if (accessToken() != null && to.path == '/login') {
      next('/')
      return
    } else if (accessToken() == null && to.path != '/login') {
      next({ path: '/login' })
      return
    }
    next()
  })
})
