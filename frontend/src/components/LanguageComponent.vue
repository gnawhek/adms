<template>
  <div>
    <!-- prettier-ignore -->
    <q-select
      v-model='lang'
      :options='langOptions'
      label='Language'
      dense
      borderless
      emit-value
      map-options
      options-dense
      style='min-width: 100px;'
    />
  </div>
</template>

<script setup lang="ts">
import { useQuasar } from 'quasar'
import languages from 'quasar/lang/index.json'
import { ref, watch } from 'vue'
import { useI18n } from 'vue-i18n'
import { useLocaleStore } from 'src/store/locale'

const i18n = useI18n()
const $q = useQuasar()
const localeStore = useLocaleStore()
const lang = ref(localeStore.getLocale)

// prettier-ignore
const appLanguages = languages.filter(lang =>
  ['ko-KR', 'en-US'].includes(lang.isoName),1
);

const langOptions = appLanguages.map((lang) => ({
  label: lang.nativeName,
  value: lang.isoName,
}))

watch(lang, (newLang) => {
  i18n.locale.value = newLang
  localeStore.setLocale(newLang)
})
</script>

<style lang="sass" scoped>
::v-deep(.q-select) .q-field__native, ::v-deep(.q-select) .q-field__label
  color: #fff
</style>
