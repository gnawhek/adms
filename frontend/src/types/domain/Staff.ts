export interface Staff {
  isStaff: boolean
  authority: AuthCode
  isSuper: boolean
  isOperator: boolean
  isMaster: boolean
  isManager: boolean
  isCustomer: boolean
}

interface AuthCode {
  code: string
  value: string
  grade: number
}

export const AuthType: { [key: string]: AuthCode } = {
  super: { code: 'u', value: 'super', grade: 4 },
  operator: { code: 'o', value: 'operator', grade: 3 },
  master: { code: 'm', value: 'master', grade: 2 },
  manager: { code: 'n', value: 'manager', grade: 1 },
  customer: { code: 'c', value: 'customer', grade: 0 },
}
export const AuthList: AuthCode[] = [AuthType.manager, AuthType.master, AuthType.operator, AuthType.super]
