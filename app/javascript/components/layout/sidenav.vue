<template>
  <v-navigation-drawer
    app
    src="https://cdn.vuetifyjs.com/images/backgrounds/bg-2.jpg"
  >
    <template v-slot:prepend>
      <v-list-item two-line>
        <v-list-item-avatar>
          <img src="~images/horse_01.jpeg">
        </v-list-item-avatar>

        <v-list-item-content>
          <v-list-item-title class="list-title">TENKEIBA</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </template>

    <v-divider></v-divider>

    <v-list>
      <v-list-item-group
        v-model="selectedItem"
        color="primary"
      >
        <v-list-item
          v-for="item in items"
          :key="item.title"
        >
          <v-list-item-icon>
            <v-icon>mdi-domain</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title class="nav-item" @click="changePath(item.pathName)" v-text="item.title"></v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list-item-group>
    </v-list>
  </v-navigation-drawer>
</template>

<script lang="ts">
import { defineComponent, ref } from '@vue/composition-api';

const items = [
  { title: 'ABOUT', icon: 'mdi-access-point', pathName: '' },
  { title: '着順予測', icon: 'mdi-access-point', pathName: 'ExpectedRaceIndex' },
  { title: 'レース登録', icon: 'mdi-access-point', pathName: 'ExpectedRaceNew' },
  { title: '競走馬一覧', icon: 'mdi-access-point', pathName: 'HorseIndex' },
]

export default defineComponent({
  name: 'Sidenav',
  setup(_, context) {
    const selectedItem = ref(1)
    const router = context.root.$router
    const changePath = (pathName: string) => {
      router.push({ name: pathName })
    }
    return {
      items,
      changePath,
      selectedItem
    }
  }
})
</script>

<style lang="scss" scoped>
.list-title {
  font-size: 25px;
  font-family: "arial black";
  color: #fff;
}
.nav-item {
  font-size: 20px;
  font-family: "arial black";
  color: #fff;
}
// .navmenu {
//   // max-width: 250px;
// }
</style>