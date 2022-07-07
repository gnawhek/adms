export interface UserRole {
  number: number
  teamSpaceId: string
  teamSpaceName: string
  role: UserRoleType
  registered: string
}

export enum UserRoleType {
  TEAM_SPACE_MANAGER = 'Team Space 책임자',
  INFRA_MANAGER = '인프라 책임자',
  PARTICIPANT = '참여자',
}
