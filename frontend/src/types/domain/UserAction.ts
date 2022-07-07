/**
 * 사용자 이력 현황 엔티티
 */
export interface UserAction {
  /**
   * 로그인이력 시퀀스 넘버
   */
  id?: number
  /**
   * 사용자 아이디
   */
  actionUserid: string
  /**
   * 사용자명
   */
  userName: string
  /**
   * actionCode
   */
  actionCode: string
  /**
   * action
   */
  actionSubjValueTxt: string
  /**
   * actionStatusCode
   */
  actionStatusCode: string
  /**
   * 접속 IP
   */
  connIp?: string
  /**
   * 엑션 일자
   */
  createdDate?: string
}
