<template>
  <v-navigation-drawer
    absolute
    permanent
    left
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
      <v-list-item
        v-for="item in items"
        :key="item.title"
      >
        <v-list-item-icon>
          <v-icon>mdi-domain</v-icon>
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-title @click="changePath(item.pathName)">{{ item.title }}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script lang="ts">
import { defineComponent } from '@vue/composition-api';

const items = [
  { title: 'TENKEIBAについて', icon: 'mdi-access-point', pathName: '' },
  { title: '着順予測', icon: 'mdi-access-point', pathName: 'ExpectedRaceIndex' },
  { title: 'レース登録', icon: 'mdi-access-point', pathName: 'ExpectedRaceNew' },
  { title: '各種データ', icon: 'mdi-access-point', pathName: '' },
]

export default defineComponent({
  setup(_, context) {
    const router = context.root.$router
    const changePath = (pathName: string) => {
      router.push({ name: pathName })
    }
    return {
      items,
      changePath
    }
  }
})
</script>

<style lang="scss" scoped>
.list-title {
  font-size: 25px;
  font-family: "arial black";
}
</style>