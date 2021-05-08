<template>
  <div>
    <h1>競走馬一覧</h1>
    <div class="text-end">
    <v-btn @click="gotoNewPage" color="primary">競走馬を追加</v-btn>
    </div>
    <v-data-table
      :headers="headers"
      :items="horses"
      item-key="name"
      class="elevation-1"
      :search="search"
      :custom-filter="filterOnlyCapsText"
    >
      <template #top>
        <v-text-field
          v-model="search"
          label="馬名検索"
          class="mx-4"
        ></v-text-field>
      </template>
      <template #[`item.gender`]="{ item }">
        {{ translateGender(item.gender) }}
      </template>
    </v-data-table>
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref } from '@vue/composition-api'
import tenAxios from 'packs/lib/tenAxios'
import { useTranslateGender } from 'util/translateType'

const useFetchHorses = () => {
  const horses = ref([])
  const fetchHorses = async() => {
    const res = await tenAxios.get('/horses')
    horses.value = res.data.horses
  }

  return {
    horses,
    fetchHorses,
  }
}

export default defineComponent({
  name: 'HorseIndex',
  setup(_, context) {
    const { horses, fetchHorses } = useFetchHorses()
    const { translateGender } = useTranslateGender()
    const search = ref('')
    const router = context.root.$router
    const gotoNewPage = () => {
      router.push({ name: 'HorseNew' })
    }

    onMounted(() => {
      fetchHorses()
    })

    const headers = [
      { text: '馬名', align: 'start', value: 'name' },
      { text: '性別', value: 'gender' }
    ]

    const filterOnlyCapsText = (value, search, item) => {
      return value != null &&
        search != null &&
        typeof value === 'string' &&
        value.toString().toLocaleUpperCase().indexOf(search) !== -1
    }

    return {
      gotoNewPage,
      horses,
      headers,
      filterOnlyCapsText,
      search,
      translateGender,
    }
  },
})
</script>

<style lang="scss" scoped>
.elevation-1 {
  margin-top: 20px;
}
</style>
