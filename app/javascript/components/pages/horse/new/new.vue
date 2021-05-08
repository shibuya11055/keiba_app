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
            v-model="selectedTranerId"
            :items="candidateTraners"
            :search-input.sync="TranerName"
            :label="'調教師'"
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

const useFetchCandidateTraner= () => {
  const candidateTraners = ref([])
  const fetchCandidateTraner = async(name: string) => {
    const res = await tenAxios.get('/expected_races/candidate_traners', { params: { name: name} })
    candidateTraners.value = res.data.candidateTraners
  }

  return {
    candidateTraners,
    fetchCandidateTraner
  }
}

export default defineComponent({
  name: 'HorseNew',
  components: {
    ConfirmDialog,
  },
  setup(_, { root }) {
    const router = root.$router
    const { candidateTraners, fetchCandidateTraner } = useFetchCandidateTraner()
    const dialog = ref(false)
    const horseName = ref('')
    const selectedGender = ref('')

    const selectedTranerId = ref(0)
    const TranerName = ref('')

    const onSubmit = () => {
      console.log('ok')
    }

    const gotoIndexPage = () => {
      dialog.value = false
      router.push({ name: 'HorseIndex' })
    }

    watch(
      () => TranerName.value,
      throttle((name: string) => {
        if (candidateTraners.value.length > 0) return
        fetchCandidateTraner(name)
      }, 1000)
    )

    return {
      horseName,
      selectedGender,
      selectedTranerId,
      candidateTraners,
      TranerName,
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