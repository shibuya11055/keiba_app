<template>
  <div>
    詳細ページ{{ race_id }}
    {{ raceDetail }}
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref } from '@vue/composition-api';
import tenAxios from 'packs/lib/tenAxios'

const useFetchExpectedRaceDetail = () => {
  const raceDetail = ref({})
  const fetchExpectedRaceDetail = async(raceId: string) => {
    const res = await tenAxios.get(`/expected_races/${raceId}`)
    raceDetail.value = res.data.raceDetail
  }

  return {
    raceDetail,
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
    const { fetchExpectedRaceDetail, raceDetail } = useFetchExpectedRaceDetail()

    onMounted(() => {
      fetchExpectedRaceDetail(props.race_id)
    })

    return {
      raceDetail
    }
  },
})
</script>