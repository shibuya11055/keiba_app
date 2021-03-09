<template>
  <div class="input-url">
    <h2>URLから登録</h2>
    <v-row>
      <v-col cols="12" sm="9">
        <v-text-field
          v-model="message1"
          label="URL"
          clearable
        ></v-text-field>
      </v-col>
      <v-col order="last">
        <v-btn large color="primary">登録する</v-btn>
      </v-col>
    </v-row>
  </div>
</template>

<script lang="ts">
import { defineComponent } from '@vue/composition-api';

export default defineComponent({
  name: 'RegistrationUrl',
  setup() {

  },
})
</script>