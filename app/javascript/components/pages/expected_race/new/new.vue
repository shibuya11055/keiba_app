<template>
  <div>
    <h1>予測レース登録</h1>
    <registration-url />
  </div>
</template>

<script lang="ts">
import { defineComponent } from '@vue/composition-api';
import RegistrationUrl from './components/registration-url.vue';

export default defineComponent({
  name: 'ExpectedRaceNew',
  components: {
    RegistrationUrl,
  },
  setup() {

  },
})
</script>