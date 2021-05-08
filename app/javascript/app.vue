<template>
  <v-app id="app">
    <link href="https://fonts.googleapis.com/earlyaccess/mplus1p.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/@mdi/font@5.x/css/materialdesignicons.min.css" rel="stylesheet">
    <Sidenav class="navmenu" />
    <v-main>
      <v-row justify="center">
        <v-col cols="12" sm="10">
          <v-container>
            <router-view/>
          </v-container>
        </v-col>
      </v-row>
    </v-main>
  </v-app>
</template>

<script lang='ts'>
// import tenAxios from '../javascript/packs/lib/tenAxios'
import Sidenav from './components/layout/sidenav.vue'
import { defineComponent, ref } from '@vue/composition-api';

export default defineComponent({
  name: 'App',
  components: {
    Sidenav,
  },
  setup() {
    const drawer = ref(false)
    return {
      drawer
    }
  }
})
</script>

<style>
/* main {
  margin: 10px 30px;
} */
h1 {
  margin-bottom: 40px;
}
</style>
