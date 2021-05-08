<template>
  <div>
    <h1>競走馬登録</h1>
    <div class="input-area">
    <v-container class="grey lighten-5">
      <!-- 名前 -->
      <v-row justify="center">
        <v-col cols="12" sm="9">
          <v-text-field
            v-model="horseName"
            label="馬名"
            :counter="9"
            required
          />
        </v-col>
      </v-row>
      <!-- 性別 -->
      <v-row justify="center">
        <v-col cols="12" sm="9">
          <v-radio-group row label="性別" v-model="selectedGender">
            <v-radio label="牡馬" value="male" color="blue"></v-radio>
            <v-radio label="牝馬" value="female" color="red"></v-radio>
          </v-radio-group>
        </v-col>
      </v-row>
      <!-- 騎手 -->
      <v-row justify="center">
        <v-col cols="12" sm="9">
          <v-autocomplete
            v-model="selectedJockeyId"
            :items="candidateJockeys"
            :search-input.sync="jockeyName"
            :label="'騎手'"
            item-value="id"
            item-text="name"
          ></v-autocomplete>
        </v-col>
      </v-row>
      <!-- ボタン -->
      <v-row
        class="submit-area"
        justify="end"
      >
          <v-btn depressed @click="dialog = true">
            キャンセル
          </v-btn>
          <v-btn depressed color="primary" @click="onSubmit">
            登録
          </v-btn>
      </v-row>
    </v-container>
    </div>

    <confirm-dialog
      :dialog="dialog"
      :description="'一覧画面に戻ります。よろしいですか？'"
      :submitText="'はい'"
      @submit="gotoIndexPage"
      @cancel="dialog = false"
    />
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, watch } from '@vue/composition-api'
import { throttle } from 'lodash';
import tenAxios from 'packs/lib/tenAxios'
import ConfirmDialog from 'components/common/confirmDialog.vue'

const useFetchCandidateJockey= () => {
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
  name: 'HorseNew',
  components: {
    ConfirmDialog,
  },
  setup(_, { root }) {
    const router = root.$router
    const { candidateJockeys, fetchCandidateJockey } = useFetchCandidateJockey()
    const dialog = ref(false)
    const horseName = ref('')
    const selectedGender = ref('')

    const selectedJockeyId = ref(0)
    const jockeyName = ref('')

    const onSubmit = () => {
      console.log('ok')
    }

    const gotoIndexPage = () => {
      dialog.value = false
      router.push({ name: 'HorseIndex' })
    }

    watch(
      () => jockeyName.value,
      throttle((name: string) => {
        if (candidateJockeys.value.length > 0) return
        fetchCandidateJockey(name)
      }, 1000)
    )

    return {
      horseName,
      selectedGender,
      selectedJockeyId,
      candidateJockeys,
      jockeyName,
      onSubmit,
      gotoIndexPage,
      dialog
    }
  },
})
</script>

<style lang="scss" scoped>
  .submit-area {
    margin-top: 30px;
    button {
      width: 100px;
      margin-right: 20px;
    }
  }
</style>