import { i18nApi } from 'boot/i18n'

if (process.env.NODE_ENV === 'development') {
  function makeI18nKeys(value: any, parentKey: string | null, result: any) {
    Object.keys(value).forEach((key) => {
      const currentKey = (parentKey == null ? '' : parentKey + '.') + key
      if (typeof value[key] === 'object') {
        result[key] = {}
        makeI18nKeys(value[key], currentKey, result[key])
      } else {
        result[key] = currentKey
      }
    })
  }
  const loadI18n = () => {
    setTimeout(() => {
      if (i18nApi.i18n == null) {
        loadI18n()
        return
      }
      const messages = i18nApi.i18n.global.messages['ko-KR']
      const result = {}
      makeI18nKeys(messages, null, result)
      console.log('i18nKeys', result)
    }, 100)
  }
  loadI18n()
}

export const i18n = {
  failed: 'failed',
  success: 'success',
  common: {
    w: 'common.w',
    m: 'common.m',
    notice: 'common.notice',
    confirm: 'common.confirm',
    save: 'common.save',
    delete: 'common.delete',
    cancel: 'common.cancel',
    BeProcessed: 'common.BeProcessed',
    FailedBeProcessed: 'common.FailedBeProcessed',
  },
  main: {
    success: 'main.success',
  },
  menus: {
    Dashboard: 'menus.Dashboard',
    member: {
      label: 'menus.member.label',
      MemberSearch: 'menus.member.MemberSearch',
      MemberShipRegistration: 'menus.member.MemberShipRegistration',
      ImportExistingMembers: 'menus.member.ImportExistingMembers',
      Forcedwithdrawalmanagement: 'menus.member.Forcedwithdrawalmanagement',
      WithdrawalandRestorationManagement: 'menus.member.WithdrawalandRestorationManagement',
    },
    organization: {
      label: 'menus.organization.label',
      PartnerManagement: 'menus.organization.PartnerManagement',
      Channelmanagement: 'menus.organization.Channelmanagement',
      Employeeaccountmanagement: 'menus.organization.Employeeaccountmanagement',
      Addgeneralmemberstaff: 'menus.organization.Addgeneralmemberstaff',
    },
    content: {
      label: 'menus.content.label',
      ServiceProductManagement: 'menus.content.ServiceProductManagement',
      SolutionManagement: 'menus.content.SolutionManagement',
    },
    algorithm: {
      label: 'menus.algorithm.label',
      QNAManagement: 'menus.algorithm.QNAManagement',
      QNAElementManagement: 'menus.algorithm.QNAElementManagement',
      PWIElementManagement: 'menus.algorithm.PWIElementManagement',
      QNAPWIManagement: 'menus.algorithm.QNAPWIManagement',
      Systemimagemanagement: 'menus.algorithm.Systemimagemanagement',
    },
    habit: {
      label: 'menus.habit.label',
      Habitfunctionsetting: 'menus.habit.Habitfunctionsetting',
      HabitMonthParticipationRate: 'menus.habit.HabitMonthParticipationRate',
      HabitWeekReport: 'menus.habit.HabitWeekReport',
      HealthNotes: 'menus.habit.HealthNotes',
      Healthmissiondetails: 'menus.habit.Healthmissiondetails',
      HabitMonthly: 'menus.habit.HabitMonthly',
      HealthNote: 'menus.habit.HealthNote',
      HealthNoteAdd: 'menus.habit.HealthNoteAdd',
      HealthMission: 'menus.habit.HealthMission',
      HealthVS: 'menus.habit.HealthVS',
      FoodMain: 'menus.habit.FoodMain',
      FoodInfo: 'menus.habit.FoodInfo',
      FoodStatistics: 'menus.habit.FoodStatistics',
      WeightMonthly: 'menus.habit.WeightMonthly',
      WeightInput: 'menus.habit.WeightInput',
      WeightInfo: 'menus.habit.WeightInfo',
      WeightStatistics: 'menus.habit.WeightStatistics',
      BowelMonthly: 'menus.habit.BowelMonthly',
      BowelInfo: 'menus.habit.BowelInfo',
      BowelStatistics: 'menus.habit.BowelStatistics',
      WaterMonthly: 'menus.habit.WaterMonthly',
    },
    cell: {
      label: 'menus.cell.label',
      Basicsetting: 'menus.cell.Basicsetting',
      Cellpolicysetting: 'menus.cell.Cellpolicysetting',
      Cellaccumulationdeductionhistory: 'menus.cell.Cellaccumulationdeductionhistory',
    },
    more: {
      PushPrefence: 'menus.more.PushPrefence',
      Notice: 'menus.more.Notice',
    },
    profile: {
      label: 'menus.profile.label',
      MemberInfomation: 'menus.Profile.MemberInfomation',
      ProfileManagement: 'menus.Profile.ProfileManagement',
      CategoryManagement: 'menus.Profile.CategoryManagement',
    },
    system: {
      label: 'menus.system.label',
      CommonCode: 'menus.system.CommonCode',
      EventNotice: 'menus.system.EventNotice',
      FrequentlyAskedQuestions: 'menus.system.FrequentlyAskedQuestions',
      Inquirymanagement: 'menus.system.Inquirymanagement',
    },
    dev: {
      label: 'menus.dev.label',
      pages: 'menus.dev.pages',
      desktop: 'menus.dev.desktop',
      dev1: 'menus.dev.dev1',
      dev2: 'menus.dev.dev2',
      dev3: 'menus.dev.dev3',
      dev4: 'menus.dev.dev4',
      dev5: 'menus.dev.dev5',
    },
  },
  login: {
    id: {
      label: 'login.id.label',
      hint: 'login.id.hint',
      hint2: 'login.id.hint2',
      rules1: 'login.id.rules1',
      rules2: 'login.id.rules2',
    },
    password: {
      label: 'login.password.label',
      rules1: 'login.password.rules1',
      rules2: 'login.password.rules2',
      rules3: 'login.password.rules3',
    },
    isSave: 'login.isSave',
  },
  'Fat (g)': 'Fat (g)',
  Name: 'Name',
  ID: 'ID',
  Sex: 'Sex',
  Age: 'Age',
  BranchName: 'BranchName',
  DNASN: 'DNASN',
  MICROBSN: 'MICROBSN',
  PhoneNumber: 'PhoneNumber',
  Email: 'Email',
  DateOfRegistration: 'DateOfRegistration',
}
