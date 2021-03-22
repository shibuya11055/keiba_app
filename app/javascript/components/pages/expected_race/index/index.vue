<template>
  <div>
    <h1>予測レース一覧</h1>
    <v-simple-table>
      <template v-slot:default>
        <thead>
          <tr>
            <th class="text-left">
              日程
            </th>
            <th class="text-left">
              グレード
            </th>
            <th class="text-left">
              レース名称
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="item in expectedRaces"
            :key="item.name"
            class="index-tr"
          >
            <td><span>{{ item.eventDate }}</span></td>
            <td><span class="grade-area" :class="item.grade">{{ translateGrade(item.grade) }}</span></td>
            <td>{{ item.name }}</td>
          </tr>
        </tbody>
      </template>
    </v-simple-table>
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref } from '@vue/composition-api';
import tenAxios from 'packs/lib/tenAxios'
import { useTranslateGrade } from '../../../../util/translate_grade'

const useFetchExpectedRaces = () => {
  const expectedRaces = ref([])
  const fetchExpectedRaces = async() => {
    const res = await tenAxios.get('/expected_races')
    console.log(res)
    expectedRaces.value = res.data.expectedRaces
  }

  return {
    expectedRaces,
    fetchExpectedRaces,
  }
}

export default defineComponent({
  name: 'ExpectedRaceIndex',
  setup() {
    const { expectedRaces, fetchExpectedRaces } = useFetchExpectedRaces()
    const { translateGrade } = useTranslateGrade()

    onMounted(() => {
      fetchExpectedRaces()
    })

    return {
      expectedRaces,
      translateGrade
    }
  },
})
</script>

<style lang="scss" scoped>
.grade-area {
  color: #fff;
  padding: 5px 10px;
  border-radius: 10px 10px 10px 10px;
  font-weight: bold;
}
.g_one {
  background: #1976D2;
}
.g_two {
  background: #d71a1a;
}
.g_three {
  background: #268300;
}
</style>
