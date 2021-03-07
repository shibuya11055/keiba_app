<template>
  <v-app id="app">
    <router-view/>
  </v-app>
</template>

<script lang='ts'>
import tenAxios from '../javascript/packs/lib/tenAxios'

export default {
  name: 'App'
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
