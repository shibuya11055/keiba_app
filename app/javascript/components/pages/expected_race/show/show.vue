<template>
  <div>
    <h1>予測レース登録</h1>
    <v-simple-table>
      <template #default>
        <thead>
          <tr>
            <th>
              馬番
            </th>
            <th>
              馬名
            </th>
            <th>
              予想着順
            </th>
            <th>
              騎手
            </th>
            <th>
              調教師
            </th>
            <th>
              前回レース
            </th>
            <th>
              前回着順
            </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in horseInfo" :key="item.horseOrder">
            <td>{{ item.horseOrder }}</td>
            <td>{{ item.name }}</td>
            <td>{{ item.expectedRanking }}</td>
            <td>{{ item.jockeyName }}</td>
            <td>{{ item.tranerName }}</td>
            <td>{{ item.lastRaceName }}</td>
            <td>{{ item.lastRanking }}</td>
          </tr>
        </tbody>
      </template>
    </v-simple-table>

    詳細ページ{{ race_id }}
    {{ raceDetail }}
    {{ horseInfo }}
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref } from '@vue/composition-api';
import tenAxios from 'packs/lib/tenAxios'

const useFetchExpectedRaceDetail = () => {
  const raceDetail = ref({})
  const horseInfo = ref([])
  const fetchExpectedRaceDetail = async(raceId: string) => {
    const res = await tenAxios.get(`/expected_races/${raceId}`)
    raceDetail.value = res.data.raceDetail
    horseInfo.value = res.data.horseInfo
  }

  return {
    raceDetail,
    horseInfo,
    fetchExpectedRaceDetail
  }
}

export default defineComponent({
  name: 'ExpectedRaceShow',
  props: {
    race_id: {
      type: String,
      required: true
    }
  },
  setup(props) {
    const { fetchExpectedRaceDetail, raceDetail, horseInfo } = useFetchExpectedRaceDetail()

    onMounted(() => {
      fetchExpectedRaceDetail(props.race_id)
    })

    return {
      raceDetail,
      horseInfo
    }
  },
})
</script>
