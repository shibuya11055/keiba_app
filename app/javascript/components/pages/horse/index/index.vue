<template>
  <div>
    馬一覧
    <v-btn @click="gotoNewPage" color="primary">競走馬を追加</v-btn>
  </div>
</template>

<script lang="ts">
import { defineComponent } from '@vue/composition-api'

export default defineComponent({
  name: 'HorseIndex',
  setup(_, context) {
    const router = context.root.$router
    const gotoNewPage = () => {
      router.push({ name: 'HorseNew' })
    }

    return {
      gotoNewPage
    }
  },
})
</script>
