<script setup lang="ts">
import dialog from 'src/utils/dialog'
import { PartnerItem } from 'src/types'
import { useVModel } from '@vueuse/core'

const emit = defineEmits<{
  (name: 'modelValue', v: string): void
  (name: 'setPartner', v: PartnerItem): void
}>()

const props = defineProps({
  modelValue: {
    default: '',
  }
})

const value = useVModel(props, 'modelValue', emit)
function searchPartner() {
  void dialog.partner((result: PartnerItem) => {
    emit('setPartner', result)
  }, value)
}
</script>

<template>
  <div class="searchPartner" @click="searchPartner()" v-ripple:indigo-11>
    <q-input dense v-model="value" placeholder="파트너검색" readonly>
      <template v-slot:append>
        <q-icon name="search" />
      </template>
    </q-input>
  </div>
</template>

<style lang="sass" scoped>
.searchPartner
  cursor: pointer
  position: relative

.searchPartner ::v-deep(.q-field).q-field--standard.q-field--readonly .q-field__control:before
  border-bottom-style: solid
</style>
