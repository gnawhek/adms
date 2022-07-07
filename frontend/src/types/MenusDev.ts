import { Menu, MenuKey, MenuPages, ObjType, PageType, ViewPages } from 'src/types/Menus'
import { i18n } from 'src/types/i18n'

/**
 * 개발 ROOT 하위 메뉴
 */
export const RootDevMenus = [
  new Menu(i18n.menus.dev.label, MenuKey.dev, 'healing', [], true), //기능개발
  new Menu(i18n.menus.dev.pages, MenuKey.devPages, 'healing', [], true), //pages
  new Menu(i18n.menus.dev.desktop, MenuKey.devDesktop, 'healing', [], false), //pages
]

/**
 * Page를 Key로 접근할 수 있는 멤버
 */
export const MenuDevPages: PageType = {
  PopupSample: <Menu>{
    key: MenuKey.dev,
    name: 'Drawer 팝업',
    path: 'PopupSample',
    component: 'popup/PopupSample.vue',
    isDevMenu: true,
  },
  EventEmitter: <Menu>{
    key: MenuKey.dev,
    name: 'EventEmitter',
    path: 'EventEmitter',
    component: 'EventEmitter.vue',
    isDevMenu: true,
  },
  CameraAPI: <Menu>{
    key: MenuKey.dev,
    name: 'Camera API',
    path: 'CameraAPI',
    component: 'camera/CameraAPI.vue',
    isDevMenu: true,
  },
  DragNDropSample: <Menu>{
    key: MenuKey.dev,
    name: 'Drag & Drop 예제',
    path: 'DragNDropSample',
    component: 'draggable/DragNDropSample.vue',
    isDevMenu: true,
  },
  VirtualScrollTableSample: <Menu>{
    key: MenuKey.dev,
    name: 'VirtualScrollTable 예제',
    path: 'VirtualScrollTableSample',
    component: 'table/VirtualScrollTableSample.vue',
    isDevMenu: true,
  },
  // FindId: Object.assign({}, ViewPages.FindId, {key: MenuKey.dev}),
  // FindPassword: Object.assign({}, ViewPages.FindPassword, {key: MenuKey.dev}),
}

Object.values(MenuPages).forEach((menu) => {
  menu.component = `desktop/${menu.name.replace('menus.', '').replace('.', '/')}.vue`
  MenuDevPages[menu.component] = Object.assign({}, menu, { key: MenuKey.devDesktop })
})

Object.values(ViewPages).forEach((menu) => {
  if (menu.path != null || menu.component == null) {
    return
  }
  MenuDevPages[menu.component] = Object.assign({}, menu, { key: MenuKey.devPages })
})

/**
 * Page를 Key 접근할 수 있는 멤버 생성
 */
// @ts-ignore
export const MenuDevObjects: ObjType = <ObjType>Object.fromEntries(RootDevMenus.map((menu) => [menu.path, menu]))

Object.keys(MenuDevPages).forEach((key) => {
  const menu = MenuDevPages[key]
  if (menu.path == null) {
    menu.path = key
  }
})

/**
 * ROOT 하위 메뉴에 자식 Page 연결
 */
Object.values(MenuDevPages).forEach((menu) => {
  MenuDevObjects[menu.key].children?.push(menu)
})

/**
 * 개발 ROOT 메뉴
 */
export const MenusDev: Menu = new Menu('root', '')
MenusDev.items = RootDevMenus

/**
 * 개발용 Popup Page
 */
export const ViewPagesDev: PageType = {}
