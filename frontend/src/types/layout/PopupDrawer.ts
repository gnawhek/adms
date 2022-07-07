import { menuDevToComponent, menuToComponent } from 'src/utils'
import { Menu } from 'src/types'

let popupIndex = 0
export class PopupDrawer {
  index = popupIndex++
  drawerOpen = false
  isActionClose = false
  title = '[Title]'
  closeDrawer: (timeout?: number, callback?: () => void) => void
  constructor(public menu: Menu, public noSwipeClose = false, public params?: any) {
    this.drawerOpen = false
    this.title = menu.name
  }

  setTitle(title: string) {
    this.title = title
  }

  closePopup() {
    this.isActionClose = true
    this.drawerOpen = false
  }

  getComponent() {
    if (this.menu.isDevMenu) {
      return menuDevToComponent(this.menu.component)
    }
    return menuToComponent(this.menu.component)
  }
}
