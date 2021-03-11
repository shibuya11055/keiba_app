<template>
  <div>
    <h1>予測レース登録</h1>
    <div class="hoge">
      <registration-url />
    </div>
    <input-manual />
  </div>
</template>

<script lang="ts">
import { defineComponent } from '@vue/composition-api';
import InputManual from './components/input-manual.vue';
import RegistrationUrl from './components/registration-url.vue';

export default defineComponent({
  name: 'ExpectedRaceNew',
  components: {
    RegistrationUrl,
    InputManual
  },

    InputManualsetup() {

  },
})
</script>