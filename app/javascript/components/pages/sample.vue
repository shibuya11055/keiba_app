<template>
  <div>
    {{ message }}
    <div>
      <v-btn elevation="2" @click="changeLocale">画面遷移</v-btn>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  name: 'sample',
  data () {
    return {
      message: 'こんにちは' as string
    }
  },
  methods: {
    changeLocale() {
      this.$router.push({name: 'Sample2'})
    }
  }
})
</script>