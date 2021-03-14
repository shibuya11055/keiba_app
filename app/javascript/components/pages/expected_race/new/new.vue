<template>
  <div>
    <h1>予測レース登録</h1>
    <div class="hoge">
      <registration-url />
    </div>
    <input-manual
      :candidate-races="candidateRaces"
      :candidate-horses="candidateHorses"
      :candidate-jockeys="candidateJockeys"
      @search-race="fetchCandidateRace"
      @search-horse="fetchCandidateHorse"
      @search-jockey="fetchCandidateJockey"
      @create-candidate-race="createCandidateRace"
    />

    <v-snackbar
      v-model="snackbar"
      absolute
      bottom
    >
      {{ snackbarMessage }}
    </v-snackbar>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from '@vue/composition-api';
import InputManual from './components/input-manual.vue';
import RegistrationUrl from './components/registration-url.vue';
import tenAxios from 'packs/lib/tenAxios'

const useFetchCandidateRace = () => {
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
}

const useFetchCandidateHorse = () => {
  const candidateHorses = ref([])
  const fetchCandidateHorse = async(name: string) => {
    const res = await tenAxios.get('/expected_races/candidate_horses', { params: { name: name} })
    candidateHorses.value = res.data.candidateHorses
  }

  return {
    candidateHorses,
    fetchCandidateHorse
  }
}

const userFetchCandidateJockey= () => {
  const candidateJockeys = ref([])
  const fetchCandidateJockey = async(name: string) => {
    const res = await tenAxios.get('/expected_races/candidate_jockeys', { params: { name: name} })
    candidateJockeys.value = res.data.candidateJockeys
  }

  return {
    candidateJockeys,
    fetchCandidateJockey
  }
}

export default defineComponent({
  name: 'ExpectedRaceNew',
  components: {
    RegistrationUrl,
    InputManual
  },

  setup() {
    const { candidateRaces, fetchCandidateRace } = useFetchCandidateRace()
    const { candidateHorses, fetchCandidateHorse } = useFetchCandidateHorse()
    const { candidateJockeys, fetchCandidateJockey } = userFetchCandidateJockey()


    const snackbar = ref(false)
    const snackbarMessage = ref('')
    const createCandidateRace = async(createParams) => {
      const res = tenAxios.post('expected_races', { ...createParams })
      // .then(
      //   snackbarMessage.value = 'レース情報を登録しました'
      // ).catch(

      // )
      snackbar.value = true
    }

    return {
      candidateRaces,
      fetchCandidateRace,
      candidateHorses,
      fetchCandidateHorse,
      candidateJockeys,
      fetchCandidateJockey,
      createCandidateRace,
      snackbar
    }
  },
})
</script>