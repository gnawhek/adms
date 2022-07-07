import { breakpointsTailwind, isClient, useActiveElement, useBreakpoints, useFullscreen, useMagicKeys, useStorage, useToggle, useWindowSize } from '@vueuse/core'
import { computed, ref } from 'vue'
import { useQuasar } from 'quasar'
import { useRouter } from 'vue-router'
import { emitter } from 'boot/EventBus'

export const shortcutsEnabled = ref(true)
export const breakpoints = useBreakpoints({
  xs: 460,
  ...breakpointsTailwind,
})
export const windowSize = useWindowSize()
export const magicKeys = useMagicKeys()
export const fullscreen = useFullscreen(isClient ? document.body : null)

export const activeElement = useActiveElement()
export const isInputting = computed(() => ['INPUT', 'TEXTAREA'].includes(activeElement.value?.tagName || '') || activeElement.value?.classList.contains('CodeMirror-code'))
export const isOnFocus = computed(() => ['BUTTON', 'A'].includes(activeElement.value?.tagName || ''))

// export const showOverview = useStorage('dma-show-overview', false)
// export const editorWidth = useStorage('dma-editor-width', isClient ? window.innerWidth * 0.4 : 100)
// export const toggleOverview = useToggle(showOverview)

export const globalEmitter = emitter
export const router = useRouter()
export const $q = useQuasar()

