<template>
  <div class="input-url">
    <h2>URLから登録</h2>
    <v-row>
      <v-col cols="12" sm="7">
        <v-text-field
          v-model="url"
          label="URL"
          clearable
        ></v-text-field>
      </v-col>
      <v-col cols="12" sm="5">
        <v-btn large color="primary">登録する</v-btn>
      </v-col>
    </v-row>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from '@vue/composition-api';

export default defineComponent({
  name: 'RegistrationUrl',
  setup() {
    const url = ref('')

    return {
      url
    }
  },
})
</script>

<style scoped>
.input-url {
  margin-bottom: 40px;
}
</style>