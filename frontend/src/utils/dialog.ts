import { emitter } from 'boot/EventBus'
import { CommonCode, CommonDialogProps, EventType, INoticeProps, PartnerItem } from 'src/types'
import { globalEmitter } from 'src/state'

class dialog {
  static message<T = INoticeProps>(eventData: T): Promise<void> {
    return emitter.emit(EventType.notice, eventData)
  }

  static async confirmMessage<T = INoticeProps>(eventData: T): Promise<void> {
    return emitter.emit(EventType.confirm, eventData)
  }

  static async partner<T = PartnerItem>(callback: (result: T) => void, params?: any): Promise<void> {
    return globalEmitter.emit(EventType.commonDialog, <CommonDialogProps<T>>{
      component: 'components/desktop/PartnerSelectListComponent.vue',
      callback: callback,
      isBackdropDismiss: true,
      isComponentAction: true,
      params: params,
      style: 'min-width: 800px',
    })
  }

  static async category<T = CommonCode>(callback: (result: T) => void, params?: any): Promise<void> {
    return globalEmitter.emit(EventType.commonDialog, <CommonDialogProps<T>>{
      component: 'components/desktop/CategorySelectListComponent.vue',
      callback: callback,
      isBackdropDismiss: true,
      isComponentAction: true,
      params: params,
      style: 'min-width: 800px',
    })
  }
}

export default dialog
