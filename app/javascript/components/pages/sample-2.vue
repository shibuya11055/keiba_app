<template>
  <div>
    {{ message }}
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  name: 'sample-2',
  data () {
    return {
      message: 'こんにちは2' as string
    }
  },
})
</script>