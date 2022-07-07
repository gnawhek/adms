export interface MenuManageVo {
  /**
   * 메뉴 id
   */
  id?: number

  /**
   * 상위 메뉴 id
   */
  parentId?: number

  /**
   * 메뉴명
   */
  menuName?: string

  /**
   * 메뉴 경로
   */
  menuPath?: string

  /**
   * 메뉴 설명
   */
  menuExplain?: number

  /**
   * 메뉴 순서
   */
  signNum?: number

  /**
   * 관리자 메뉴 여부, Y or N
   */
  adminYn?: string

  /**
   * 메뉴 사용 여부, Y or N
   */
  useYn?: string
}

export interface CommMenuManage extends MenuManageVo {
  /**
   * 메뉴 생성자
   */
  createdUserId: string

  /**
   * 메뉴 생성일자
   */
  createdDate: string

  /**
   * 메뉴 수정자
   */
  modifiedUserId: string

  /**
   * 메뉴 수정일자
   */
  modifiedDate: string
}

export class CommMenu {
  items: CommMenu[] = []
  command: any //() => void = () => {};
  constructor(public key: string, public label: string, public to?: string) {}
}
