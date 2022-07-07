import { boot } from 'quasar/wrappers'
import { GetServerConfig } from 'src/api/common-api'
import { ServerConfig } from 'src/types/domain/ServerConfig'
import { $log } from 'src/utils/logger'
import { useLocalStore } from 'src/store/local'

const serverConfig: ServerConfig = <ServerConfig>{}

export default boot(async ({ app }) => {
  const localStore = useLocalStore()
  await GetServerConfig()
    .then((config) => {
      Object.assign(serverConfig, config)
    })
    .catch((error) => {
      $log(error)
      if (localStore.isDevelopmentMode) {
        Object.assign(serverConfig, {
          encrypt: false,
          devProfile: true,
        })
      } else {
        Object.assign(serverConfig, {
          encrypt: true,
          devProfile: false,
        })
      }
    })
  app.config.globalProperties.$serverConfig = serverConfig
})

export { serverConfig }
