import { RouteRecordRaw } from 'vue-router'
import { Menu, Menus } from 'src/types'
import { MenusDev } from 'src/types/MenusDev'
import { menuDevToImportVue, menuToImportVue } from 'src/utils'

const menuToVue = (menu: Menu) => {
  return import(`pages/desktop/${menu.name.replace('menus.', '').replace('.', '/')}.vue`)
}

const routes: RouteRecordRaw[] = [
  {
    path: '/login',
    component: () => import('layouts/LoginLayout.vue'),
    children: [{ path: '', component: () => import('pages/login/Login.vue') }],
    //children: [{ path: '', component: () => import('pages/login.vue') }],
  },
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      { path: '', component: () => import('pages/Index.vue') },
      { path: 'page1', component: () => import('pages/page1.vue') },
      { path: 'page2', component: () => import('pages/page2.vue') },
      { path: 'page3', component: () => import('pages/page3.vue') },
      {
        path: '/loginTest',
        component: () => import('layouts/LoginLayout.vue'),
        children: [{ path: '', component: () => import('pages/login.vue') }],
      },
    ],
  },
  ...Menus.items.map((d) => ({
    path: '/' + (d.children == null || d.children.length == 0 ? '' : d.path),
    component: () => import('layouts/MainLayout.vue'),
    children:
      d.children == null || d.children.length == 0
        ? [{ path: d.path, component: () => menuToVue(d) }]
        : d.children?.map((c) => ({ path: c.path, component: () => menuToVue(c) })),
  })),
  // {
  //   path: '/member',
  //   component: () => import('layouts/MainLayout.vue'),
  //   children: [
  //     { path: 'MemberSearch', component: () => import('pages/desktop/member/MemberSearch.vue') },//회원검색
  //     { path: 'MemberShipRegistration', component: () => import('pages/desktop/member/MemberShipRegistration.vue') },//회원등록
  //     { path: 'ImportExistingMembers', component: () => import('pages/desktop/member/ImportExistingMembers.vue') },//기존회원불러오기
  //     { path: 'Forcedwithdrawalmanagement', component: () => import('pages/desktop/member/Forcedwithdrawalmanagement.vue') },//강제탈퇴관리
  //     { path: 'WithdrawalandRestorationManagement', component: () => import('pages/desktop/member/WithdrawalandRestorationManagement.vue') },//탈퇴복원관리
  //   ],
  // },
  // {
  //   path: '/organization',
  //   component: () => import('layouts/MainLayout.vue'),
  //   children: [
  //     { path: 'PartnerManagement', component: () => import('pages/desktop/organization/PartnerManagement.vue') },//파트너관리
  //     { path: 'Channelmanagement', component: () => import('pages/desktop/organization/Channelmanagement.vue') },//채널관리
  //     { path: 'Employeeaccountmanagement', component: () => import('pages/desktop/organization/Employeeaccountmanagement.vue') },//직원계정관리
  //     { path: 'Addgeneralmemberstaff', component: () => import('pages/desktop/organization/Addgeneralmemberstaff.vue') },//일반회원직원추가
  //   ],
  // },
  // {
  //   path: '/content',
  //   component: () => import('layouts/MainLayout.vue'),
  //   children: [
  //     { path: 'ServiceProductManagement', component: () => import('pages/desktop/content/ServiceProductManagement.vue') },//서비스/제품관리
  //     { path: 'SolutionManagement', component: () => import('pages/desktop/content/SolutionManagement.vue') },//솔루션관리
  //   ],
  // },
  // {
  //   path: '/algorithm',
  //   component: () => import('layouts/MainLayout.vue'),
  //   children: [
  //     { path: 'QNAManagement', component: () => import('pages/desktop/algorithm/QNAManagement.vue') },//문진관리
  //     { path: 'QNAElementManagement', component: () => import('pages/desktop/algorithm/QNAElementManagement.vue') },//QNA Element 관리
  //     { path: 'PWIElementManagement', component: () => import('pages/desktop/algorithm/PWIElementManagement.vue') },//PWI Element 관리
  //     { path: 'QNAPWIManagement', component: () => import('pages/desktop/algorithm/QNAPWIManagement.vue') },//QNA PWI 관리
  //     { path: 'Systemimagemanagement', component: () => import('pages/desktop/algorithm/Systemimagemanagement.vue') },//시스템이미지관리
  //   ],
  // },
  // {
  //   path: '/habit',
  //   component: () => import('layouts/MainLayout.vue'),
  //   children: [
  //     { path: 'Habitfunctionsetting', component: () => import('pages/desktop/habit/Habitfunctionsetting.vue') },//습관기능설정
  //     { path: 'HabitMonthParticipationRate', component: () => import('pages/desktop/habit/HabitMonthParticipationRate.vue') },//습관월참여율
  //     { path: 'HealthNotes', component: () => import('pages/desktop/habit/HealthNotes.vue') },//건강노트내역
  //     { path: 'Healthmissiondetails', component: () => import('pages/desktop/habit/Healthmissiondetails.vue') },//건강미션내역
  //   ],
  // },
  // {
  //   path: '/cell',
  //   component: () => import('layouts/MainLayout.vue'),
  //   children: [
  //     { path: 'Basicsetting', component: () => import('pages/desktop/cell/Basicsetting.vue') },//기본설정
  //     { path: 'Cellpolicysetting', component: () => import('pages/desktop/cell/Cellpolicysetting.vue') },//셀정책설정
  //     { path: 'Cellaccumulationdeductionhistory', component: () => import('pages/desktop/cell/Cellaccumulationdeductionhistory.vue') },//셀적립/차감내역
  //   ],
  // },
  // {
  //   path: '/system',
  //   component: () => import('layouts/MainLayout.vue'),
  //   children: [
  //     { path: 'EventNotice', component: () => import('pages/desktop/system/EventNotice.vue') },//이벤트/공지사항
  //     { path: 'FrequentlyAskedQuestions', component: () => import('pages/desktop/system/FrequentlyAskedQuestions.vue') },//자주묻는 질문관리
  //     { path: 'Inquirymanagement', component: () => import('pages/desktop/system/Inquirymanagement.vue') },//문의관리
  //   ],
  // },
]

if(process.env.NODE_ENV === 'development') {
  const devMenus = [...MenusDev.items.map((d) => ({
    path: '/' + (d.children == null || d.children.length == 0 ? '' : d.path),
    component: () => import('layouts/DevLayout.vue'),
    children:
      [
        { path: '', component: () => import('src/_dev/Index.vue') },
      ].concat(
        d.children == null || d.children.length == 0
          ? [{ path: d.path, component: () => menuToVue(d) }]
          : d.children?.map((c) => ({ path: c.path, component: () => c.isDevMenu ? menuDevToImportVue(c.component as string) :  menuToImportVue(c.component as string) }))),
  }))]
  routes.push(...devMenus)
  // console.log(devMenus)
}

// Always leave this as last one,
// but you can also remove it
routes.push({
  path: '/:catchAll(.*)*',
  component: () => import('pages/Error404.vue'),
})

export default routes
