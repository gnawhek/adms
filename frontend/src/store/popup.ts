import { defineStore } from 'pinia'
import { defineAsyncComponent, defineComponent, ref } from 'vue'
import { Menu, PopupDrawer } from 'src/types'
import tools from 'src/utils/tools'

export const usePopupStore = defineStore(
  'popup-store',
  () => {
    const drawers = ref<PopupDrawer[]>([])
    const pushPopup = (menu: Menu, noSwipeClose = false, params?: any) => {
      drawers.value.push(new PopupDrawer(menu, noSwipeClose, params))
    }
    return {
      drawers,
      newPopup(menu: Menu, noSwipeClose?: boolean) {
        pushPopup(menu, noSwipeClose);
      },
      newPopupParam(menu: Menu, params: any, noSwipeClose?: boolean) {
        pushPopup(menu, noSwipeClose, params);
      },
      removePopup() {
        //drawers.value.pop()
        drawers.value = drawers.value.filter(item => item.drawerOpen || !item.isActionClose)
      },
      contains(popup: PopupDrawer) {
        return drawers.value.indexOf(popup) != -1
      },
      async allCloseDelay(timeToDelay = 100) {
        while (drawers.value.length > 0) {
          const d = drawers.value[drawers.value.length - 1]
          d.closePopup()
          await tools.wait(timeToDelay)
          drawers.value.pop()
        }
      },
      async allClose(timeToDelay = 100) {
        drawers.value.forEach((d) => {
          d.closePopup()
        })
        await tools.wait(timeToDelay)
        drawers.value = []
      },
    }
  },
  {
    persistedState: {
      persist: false,
    },
  },
)
