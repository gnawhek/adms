import { menuDevToComponent, menuToComponent } from 'src/utils'
import { i18n } from 'src/types/i18n'

export enum MenuKey {
  // home = '',
  login = 'login',
  Dashboard = 'Dashboard',
  member = 'member',
  organization = 'organization',
  content = 'content',
  algorithm = 'algorithm',
  habit = 'habit',
  cell = 'cell',
  profile = 'profile',
  system = 'system',
  devcomponent = 'devcomponent',
  dev = 'dev',
  devPages = 'dev/pages',
  devDesktop = 'dev/desktop',
}

export class Menu {
  items: Menu[] = []
  command: any //() => void = () => {};
  key: string
  isDevMenu = false
  constructor(public name: string, public path: string, public icon?: string, public children?: Menu[], public opened?: boolean, public component?: string) {}
}

export type PageType = {
  [key: string]: Menu
}

export type ObjType = {
  [key: string]: Menu
}

/**
 * 데스크탑 ROOT 하위 메뉴
 */
export const RootMenus = [
  new Menu(i18n.menus.Dashboard, MenuKey.Dashboard, 'view_quilt'), //대쉬보드
  new Menu(i18n.menus.member.label, MenuKey.member, 'people', []), //회원관리
  new Menu(i18n.menus.organization.label, MenuKey.organization, 'assignment_late', []), //조직관리
  new Menu(i18n.menus.content.label, MenuKey.content, 'travel_explore', []), //콘텐츠관리
  new Menu(i18n.menus.algorithm.label, MenuKey.algorithm, 'swap_calls', []), //알고리즘관리
  new Menu(i18n.menus.habit.label, MenuKey.habit, 'favorite', []), //습관관리
  new Menu(i18n.menus.cell.label, MenuKey.cell, 'widgets', []), //셀관리
  new Menu(i18n.menus.system.label, MenuKey.system, 'build', []), //시스템관리
  new Menu(i18n.menus.dev.label, MenuKey.devcomponent, 'healing', [], true), //기능개발
]

/**
 * 데스크탑 Page 전체
 */
export const MenuPages: PageType = {
  MemberSearch: <Menu>{
    key: MenuKey.member,
    name: i18n.menus.member.MemberSearch, //회원검색
    path: 'MemberSearch',
    component: 'desktop/member/MemberSearch.vue',
  },
  MemberShipRegistration: <Menu>{
    key: MenuKey.member,
    name: i18n.menus.member.MemberShipRegistration, //회원등록
    path: 'MemberShipRegistration',
  },
  ImportExistingMembers: <Menu>{
    key: MenuKey.member,
    name: i18n.menus.member.ImportExistingMembers, //기존회원불러오기
    path: 'ImportExistingMembers',
  },
  Forcedwithdrawalmanagement: <Menu>{
    key: MenuKey.member,
    name: i18n.menus.member.Forcedwithdrawalmanagement, //강제탈퇴관리
    path: 'Forcedwithdrawalmanagement',
  },
  WithdrawalandRestorationManagement: <Menu>{
    key: MenuKey.member,
    name: i18n.menus.member.WithdrawalandRestorationManagement, //탈퇴복원관리
    path: 'WithdrawalandRestorationManagement',
  },
  PartnerManagement: <Menu>{
    key: MenuKey.organization,
    name: i18n.menus.organization.PartnerManagement, //파트너관리
    path: 'PartnerManagement',
  },
  Channelmanagement: <Menu>{
    key: MenuKey.organization,
    name: i18n.menus.organization.Channelmanagement, //채널관리
    path: 'Channelmanagement',
  },
  Employeeaccountmanagement: <Menu>{
    key: MenuKey.organization,
    name: i18n.menus.organization.Employeeaccountmanagement, //직원계정관리
    path: 'Employeeaccountmanagement',
  },
  Addgeneralmemberstaff: <Menu>{
    key: MenuKey.organization,
    name: i18n.menus.organization.Addgeneralmemberstaff, //일반회원직원추가
    path: 'Addgeneralmemberstaff',
  },
  ServiceProductManagement: <Menu>{
    key: MenuKey.content,
    name: i18n.menus.content.ServiceProductManagement, //서비스/제품관리
    path: 'ServiceProductManagement',
  },
  SolutionManagement: <Menu>{
    key: MenuKey.content,
    name: i18n.menus.content.SolutionManagement, //솔루션관리
    path: 'SolutionManagement',
  },
  QNAManagement: <Menu>{
    key: MenuKey.algorithm,
    name: i18n.menus.algorithm.QNAManagement, //문진관리
    path: 'QNAManagement',
  },
  QNAElementManagement: <Menu>{
    key: MenuKey.algorithm,
    name: i18n.menus.algorithm.QNAElementManagement, //QNA Element 관리
    path: 'QNAElementManagement',
  },
  PWIElementManagement: <Menu>{
    key: MenuKey.algorithm,
    name: i18n.menus.algorithm.PWIElementManagement, //PWI Element 관리
    path: 'PWIElementManagement',
  },
  QNAPWIManagement: <Menu>{
    key: MenuKey.algorithm,
    name: i18n.menus.algorithm.QNAPWIManagement, //QNA PWI 관리
    path: 'QNAPWIManagement',
  },
  Systemimagemanagement: <Menu>{
    key: MenuKey.algorithm,
    name: 'menus.algorithm.Systemimagemanagement', //시스템이미지관리
    path: 'Systemimagemanagement',
  },
  Habitfunctionsetting: <Menu>{
    key: MenuKey.habit,
    name: i18n.menus.habit.Habitfunctionsetting, //습관기능설정
    path: 'Habitfunctionsetting',
  },
  HabitMonthParticipationRate: <Menu>{
    key: MenuKey.habit,
    name: i18n.menus.habit.HabitMonthParticipationRate, //습관월참여율
    path: 'HabitMonthParticipationRate',
  },
  HealthNotes: <Menu>{
    key: MenuKey.habit,
    name: i18n.menus.habit.HealthNotes, //건강노트내역
    path: 'HealthNotes',
  },
  Healthmissiondetails: <Menu>{
    key: MenuKey.habit,
    name: i18n.menus.habit.Healthmissiondetails, //건강미션내역
    path: 'Healthmissiondetails',
  },
  Basicsetting: <Menu>{
    key: MenuKey.cell,
    name: i18n.menus.cell.Basicsetting, //기본설정
    path: 'Basicsetting',
  },
  Cellpolicysetting: <Menu>{
    key: MenuKey.cell,
    name: i18n.menus.cell.Cellpolicysetting, //셀정책설정
    path: 'Cellpolicysetting',
  },
  Cellaccumulationdeductionhistory: <Menu>{
    key: MenuKey.cell,
    name: i18n.menus.cell.Cellaccumulationdeductionhistory, //셀적립/차감내역
    path: 'Cellaccumulationdeductionhistory',
  },
  CommonCode: <Menu>{
    key: MenuKey.system,
    name: i18n.menus.system.CommonCode, ///공지사항
    path: 'CommonCode',
  },
  EventNotice: <Menu>{
    key: MenuKey.system,
    name: i18n.menus.system.EventNotice, //이벤트/공지사항
    path: 'EventNotice',
  },
  FrequentlyAskedQuestions: <Menu>{
    key: MenuKey.system,
    name: i18n.menus.system.FrequentlyAskedQuestions, //자주묻는 질문관리
    path: 'FrequentlyAskedQuestions',
  },
  Inquirymanagement: <Menu>{
    key: MenuKey.system,
    name: i18n.menus.system.Inquirymanagement, //문의관리
    path: 'Inquirymanagement',
  },
  dev1: <Menu>{
    key: MenuKey.devcomponent,
    name: i18n.menus.dev.dev1,
    path: 'dev1',
  },
  dev2: <Menu>{
    key: MenuKey.devcomponent,
    name: i18n.menus.dev.dev2,
    path: 'dev2',
  },
  dev3: <Menu>{
    key: MenuKey.devcomponent,
    name: i18n.menus.dev.dev3,
    path: 'dev3',
  },
  dev4: <Menu>{
    key: MenuKey.devcomponent,
    name: i18n.menus.dev.dev4,
    path: 'dev4',
  },
  dev5: <Menu>{
    key: MenuKey.devcomponent,
    name: 'menus.dev.dev5',
    path: 'dev5',
  },
}

/**
 * Page를 Key로 접근할 수 있는 멤버
 */
// @ts-ignore
export const MenuObjects: ObjType = <ObjType>Object.fromEntries(RootMenus.map((menu) => [menu.path, menu]))

// const win = window as any
// win.RootMenus = RootMenus as any
// win.MenuPages = MenuPages as any
// win.MenuObjects = MenuObjects as any

/**
 * ROOT 하위 메뉴에 자식 Page 연결
 */
Object.values(MenuPages).forEach((menu) => MenuObjects[menu.key].children?.push(menu))

/**
 * 데스크탑 ROOT 메뉴
 */
export const Menus: Menu = new Menu('root', '')
Menus.items = RootMenus

/**
 * 데스크탑 Popup Page
 */
export const ViewPagesDesktop: PageType = {
  MemberSearch: <Menu>{
    name: 'menus.member.MemberSearch',
    component: 'desktop/member/MemberSearch.vue',
  },
}

/**
 * 모바일 Popup Page
 */
export const ViewPagesMobile: PageType = {
  MyMain: <Menu>{
    name: '메인홈',
    component: 'mobile/main/MyMain.vue',
  },
  HabitMain: <Menu>{
    key: 'habit',
    name: '습관',
    component: 'mobile/main/habit/HabitMain.vue',
  },
  HabitMonthly: <Menu>{
    key: 'HabitMonthly',
    name: i18n.menus.habit.HabitMonthly, // 습관체크
    component: 'mobile/main/habit/HabitMonthly.vue',
  },
  HabitWeekReport: <Menu>{
    key: 'HabitWeekReport',
    name: i18n.menus.habit.HabitWeekReport, // 주관습관리포트
    component: 'mobile/main/habit/HabitWeekReport.vue',
  },
  FoodMain: <Menu>{
    key: 'FoodMain',
    name: i18n.menus.habit.FoodMain, // 식사기록
    component: 'mobile/main/habit/food/FoodMain.vue',
  },
  FoodInfo: <Menu>{
    key: 'FoodInfo',
    name: i18n.menus.habit.FoodInfo, // 식사 상세기록
    component: 'mobile/main/habit/food/FoodInfo.vue',
  },
  FoodStatistics: <Menu>{
    key: 'FoodStatistics',
    name: i18n.menus.habit.FoodStatistics, // 식사기록통계
    component: 'mobile/main/habit/food/FoodStatistics.vue',
  },
  HealthNoteAdd: <Menu>{
    key: 'HealthNoteAdd',
    name: '노트추가',
    component: 'mobile/main/habit/sub/HealthNoteAdd.vue',
  },

  HealthNote: <Menu>{
    key: 'healthNote',
    name: i18n.menus.habit.HealthNote, //건강노트
    component: 'mobile/main/habit/sub/HealthNote.vue',
  },
  HealthMission: <Menu>{
    key: 'healthMission',
    name: i18n.menus.habit.HealthMission, //건강미션
    component: 'mobile/main/habit/sub/HealthMission.vue',
  },
  HealthVS: <Menu>{
    key: 'healthVS',
    name: i18n.menus.habit.HealthVS, // 복약VS영양?
    component: 'mobile/main/habit/sub/HealthVS.vue',
  },
  WeightMonthly: <Menu>{
    key: 'WeightMonthly',
    name: i18n.menus.habit.WeightMonthly, // 체중관리
    component: 'mobile/main/habit/weight/WeightMonthly.vue',
  },

  WeightInput: <Menu>{
    key: 'weightInput',
    name: i18n.menus.habit.WeightInput, // 체중 상세기록
    component: 'mobile/main/habit/weight/WeightInput.vue',
  },

  WeightInfo: <Menu>{
    key: 'WeightInfo',
    name: i18n.menus.habit.WeightInfo, // 체중계측정상세결과
    component: 'mobile/main/habit/weight/WeightInfo.vue',
  },
  WeightStatistics: <Menu>{
    key: 'WeightStatistics',
    name: i18n.menus.habit.WeightStatistics, // 체중기록 통계
    component: 'mobile/main/habit/weight/WeightStatistics.vue',
  },
  BowelMonthly: <Menu>{
    key: 'BowelMonthly',
    name: i18n.menus.habit.BowelMonthly, // 배변기록
    component: 'mobile/main/habit/bowel/BowelMonthly.vue',
  },
  BowelInfo: <Menu>{
    key: 'BowelInfo',
    name: i18n.menus.habit.BowelInfo, // 배변 상세기록
    component: 'mobile/main/habit/bowel/BowelInfo.vue',
  },
  BowelStatistics: <Menu>{
    key: 'BowelStatistics',
    name: i18n.menus.habit.BowelStatistics, //  배변기록 통계
    component: 'mobile/main/habit/bowel/BowelStatistics.vue',
  },
  WaterMonthly: <Menu>{
    key: 'WaterMonthly',
    name: i18n.menus.habit.WaterMonthly, //  수분섭취기록
    component: 'mobile/main/habit/water/WaterMonthly.vue',
  },
  CellMain: <Menu>{
    key: 'cell',
    name: '셀로그',
    component: 'mobile/main/cell/CellMain.vue',
  },
  HomeMain: <Menu>{
    key: 'home',
    name: '홈',
    component: 'mobile/main/home/HomeMain.vue',
  },
  AnalysisMain: <Menu>{
    key: 'analysis',
    name: '분석',
    component: 'mobile/main/analysis/AnalysisMain.vue',
  },
  MoreMain: <Menu>{
    key: 'more',
    name: '더보기',
    component: 'mobile/main/more/MoreMain.vue',
  },
  PushPrefence: <Menu>{
    key: 'push',
    name: i18n.menus.more.PushPrefence, // 푸시알림
    component: 'mobile/main/more/PushPrefence.vue',
  },
  NoticeList: <Menu>{
    key: 'NoticeList',
    name: i18n.menus.more.Notice, //공지사항 리스트
    component: 'mobile/main/more/NoticeList.vue',
  },
  Notice: <Menu>{
    key: 'Notice',
    name: i18n.menus.more.Notice, //공지사항
    component: 'mobile/main/more/Notice.vue',
  },
  MemberSearch: <Menu>{
    name: 'menus.member.MemberSearch',
    component: 'mobile/member/MemberSearch.vue',
  },
  MemberRegister: <Menu>{
    name: 'menus.member.MemberRegister',
    component: 'mobile/member/MemberRegister.vue',
  },
}

export const ViewPages: PageType = Object.assign({}, ViewPagesDesktop, ViewPagesMobile, {
  Login: <Menu>{
    name: '로그인',
    component: 'login/Login.vue',
  },
  FindId: <Menu>{
    name: '아이디 찾기',
    component: 'login/FindId.vue',
  },
  FindPassword: <Menu>{
    name: '비밀번호 찾기',
    component: 'login/FindPassword.vue',
  },
  LoginMemberRegister: <Menu>{
    name: '회원가입',
    component: 'login/LoginMemberRegister.vue',
  },
  TermsConditions: <Menu>{
    name: '이용약관',
    component: 'login/register/TermsConditions.vue',
  },
})
