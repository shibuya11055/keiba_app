<template>
  <v-app id="app">
    <v-btn>Vuetifyのボタン</v-btn>
    <div>
      <p>{{ message }}</p>
      <p>{{ panda }}</p>
    </div>
  </v-app>
</template>

<script>
import tenAxios from '../javascript/packs/lib/tenAxios'

export default {
  data: function () {
    return {
      message: "Hello Vue!",
      panda: {}
    }
  },
  mounted() {
    this.fetchPanda()
  },
  methods: {
    async fetchPanda () {
      const result = await tenAxios.get('home')
      this.panda = result
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
