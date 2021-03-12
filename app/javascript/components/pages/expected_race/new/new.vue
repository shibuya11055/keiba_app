<template>
  <div>
    <h1>予測レース登録</h1>
    <div class="hoge">
      <registration-url />
    </div>
    <input-manual
      :candidate-races="candidateRaces"
      @search-race="fetchCandidateRace"
     />
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from '@vue/composition-api';
import InputManual from './components/input-manual.vue';
import RegistrationUrl from './components/registration-url.vue';
import tenAxios from 'packs/lib/tenAxios'


export default defineComponent({
  name: 'ExpectedRaceNew',
  components: {
    RegistrationUrl,
    InputManual
  },

  setup() {

    const candidateRaces = ref([])

    const fetchCandidateRace = async(race_name: string) => {
      const res = await tenAxios.get('/expected_races/candidate_races', { params: { name: race_name } })
      const result = res.data.candidateRaces
      const mappedResult = result.map(v => {
        return { name: `${v.name}： ${v.track.name} ${v.track.fieldType} ${v.track.fieldRange}m`, id: v.track.id }
      })
      candidateRaces.value = mappedResult
    }

    return {
      candidateRaces,
      fetchCandidateRace
    }
  },
})
</script>