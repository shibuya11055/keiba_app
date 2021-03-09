<template>
  <v-app id="app">
    <link href="https://fonts.googleapis.com/earlyaccess/mplus1p.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/@mdi/font@5.x/css/materialdesignicons.min.css" rel="stylesheet">
    <Sidenav class="navmenu" />
    <v-main>
      <v-container>
        <router-view/>
      </v-container>
    </v-main>
  </v-app>
</template>

<script lang='ts'>
// import tenAxios from '../javascript/packs/lib/tenAxios'
import Sidenav from './components/layout/sidenav.vue'
import { defineComponent } from '@vue/composition-api';

export default defineComponent({
  name: 'App',
  components: {
    Sidenav,
  }
})
</script>

<style>
main {
  width: 80% !important;
  margin: 0 0 0 auto;
  padding: 30px !important;
}
.navmenu {
  width: 20% !important;
  background-color: snow !important;
}
h1 {
  margin-bottom: 40px;
}
</style>
