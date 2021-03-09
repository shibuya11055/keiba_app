<template>
  <v-app id="app">
    <link href="https://cdn.jsdelivr.net/npm/@mdi/font@5.x/css/materialdesignicons.min.css" rel="stylesheet">
    <Header class="navmenu" />
    <v-main>
      <v-container>
        <router-view/>
      </v-container>
    </v-main>
  </v-app>
</template>

<script lang='ts'>
// import tenAxios from '../javascript/packs/lib/tenAxios'
import Header from './components/layout/header.vue'
import { defineComponent } from '@vue/composition-api';

export default defineComponent({
  name: 'App',
  components: {
    Header,
  }
})
</script>

<style>
main {
  width: 80% !important;
  margin: 0 0 0 auto;
}
.navmenu {
  width: 20% !important;
  background-color: snow !important;
}
</style>
