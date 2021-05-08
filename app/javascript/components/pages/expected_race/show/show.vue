<template>
  <div>
    <h1>予測レース詳細</h1>
    <div class="columns">
      <div class="column ">
        <span :class="['grade-area', race.grade]">{{ translateGrade(race.grade) }}</span>
      </div>
      <div class="column">
        <h2>{{ race.name }}</h2>
      </div>
    </div>
    <div class="course">
      <p>{{ track.name }} {{ translateField(track.fieldType) }}・{{ track.fieldRange }}m</p>
    </div>
    <v-simple-table
      fixed-header
      height="520px"
    >
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
            <td><span :class="['horse-order', `order-${item.horseOrder}`]">{{ item.horseOrder }}</span></td>
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
  </div>
</template>

<script lang="ts">
import { computed, defineComponent, onMounted, ref } from '@vue/composition-api';
import tenAxios from 'packs/lib/tenAxios'
import { useTranslateGrade, useTranslateField } from '../../../../util/translateType'

const useFetchExpectedRaceDetail = () => {
  const race = ref()
  const track = ref()
  const horseInfo = ref([])
  const fetchExpectedRaceDetail = async(raceId: string) => {
    const res = await tenAxios.get(`/expected_races/${raceId}`)
    race.value = res.data.raceDetail.race
    track.value = res.data.raceDetail.track
    horseInfo.value = res.data.horseInfo
  }

  return {
    race,
    track,
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
    const { fetchExpectedRaceDetail, race, track, horseInfo } = useFetchExpectedRaceDetail()
    const { translateGrade } = useTranslateGrade()
    const { translateField } = useTranslateField()

    onMounted(() => {
      fetchExpectedRaceDetail(props.race_id)
    })

    return {
      race: computed(() => race.value || {}),
      track: computed(() => track.value || {}),
      horseInfo,
      translateGrade,
      translateField,
    }
  },
})
</script>

<style lang="scss" scoped>
.columns {
  display: flex;
}
.column {
  padding-right: 10px;
}
.grade-area {
  color: #fff;
  padding: 5px 10px;
  border-radius: 10px 10px 10px 10px;
  font-weight: bold;
  display: grid;
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

.horse-order {
  border: solid 0.5px;
  border-color: #fafafa;
  padding: 10px;
  width: 40px;
  display: inline-block;
  text-align: center;
}

// オーダー色付け
.order-1, .order-2{
  background: white;
}
.order-3, .order-4 {
  background: black;
  color: white;
}
.order-5, .order-6 {
  background: red;
  color: white;
}
.order-7, .order-8 {
  background: blue;
  color: white;
}
.order-9, .order-10 {
  background: yellow;
}
.order-11, .order-12 {
  background: green;
  color: white;
}
.order-13, .order-14 {
  background: orange;
}
.order-15, .order-16, .order-17, .order-18{
  background: palevioletred;
}
</style>
