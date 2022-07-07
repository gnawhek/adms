import { $t, sysCodeToValues } from 'src/utils'
import { Ref, watch } from 'vue'
import { SYS_CODE } from 'src/types'

export function codeWatch(value: Ref<string>, items: Ref<SYS_CODE[]>, selected: Ref<SYS_CODE[]>) {
  watch(selected, () => (value.value = sysCodeToValues(selected.value)))
  watch(items, () => {
    selected.value = items.value?.filter((d) => (value.value + ';').indexOf(d.C_CODE + ';') != -1) || []
  })
}
