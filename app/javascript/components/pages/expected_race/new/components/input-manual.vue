<template>
  <div class="input-manual">
    <h2>手動登録</h2>
    <v-form>
      <v-menu v-model="isOpenCalender" max-width="290px" min-width="290px">
        <!-- ポップアップを追加する要素にv-on="on" -->
        <template v-slot:activator="{ on }">
          <v-text-field
            slot="activator"
            v-model="raceDate"
            label="日程"
            readonly
            v-on="on"
          />
        </template>
        <!-- ポップアップされる内容-->
        <v-date-picker v-model="raceDate" />
      </v-menu>
      <!-- レース名 -->
      <v-autocomplete
        v-model="selectedTrackId"
        :items="candidateRaces"
        label="レース名"
        item-value="id"
        item-text="name"
      ></v-autocomplete>
      <!-- グレード -->
      <v-radio-group row label="グレード" v-model="selectedGrade">
        <v-radio label="GⅠ" value="g_one" color="blue"></v-radio>
        <v-radio label="GⅡ" value="g_two" color="red"></v-radio>
        <v-radio label="GⅢ" value="g_three" color="green"></v-radio>
      </v-radio-group>
      <!-- 競走馬情報 -->
      <h3>競走馬情報</h3>
      <v-row>
        <v-col cols="12" md="6">
          <v-autocomplete
            v-model="selectedHorseId"
            :items="candidateHorses"
            :search-input.sync="horseName"
            :label="'馬名'"
            item-value="id"
            item-text="name"
          ></v-autocomplete>
        </v-col>
        <v-col cols="12" md="6">
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
      <!-- 削除・追加ボタン -->
      <v-row
        align="center"
        justify="end"
        class="footer-btn-area"
      >
        <v-btn
          v-if="horseInfos.length"
          class="mx-2"
          fab
          large
          color="gray"
          @click="removeHorseInfo"
        >
          <v-icon dark>
            mdi-minus
          </v-icon>
        </v-btn>
        <v-btn
          class="mx-2"
          fab
          large
          color="deep-orange"
          :disabled="!(selectedHorseId && selectedJockeyId)"
          @click="addHorseInfo"
        >
          <v-icon dark>
            mdi-plus
          </v-icon>
        </v-btn>
      </v-row>
    </v-form>
    <!-- 登録候補テーブル -->
    <div v-if="horseInfos.length" class="caindidate-registration">
      <h3>登録候補</h3>
      <v-simple-table dense>
        <template v-slot:default>
          <thead>
            <tr>
              <th class="text-left">
                馬番
              </th>
              <th class="text-left">
                馬名
              </th>
              <th class="text-left">
                騎手
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(horseInfo, index) in horseInfos" :key="horseInfo.horseId">
              <td>{{ index + 1 }}</td>
              <td>{{ horseInfo.selectedHorseName }}</td>
              <td>{{ horseInfo.selectedJockeyName }}</td>
            </tr>
          </tbody>
        </template>
      </v-simple-table>
    </div>
    <!-- クリア・登録ボタン -->
    <div class="submit-area-line"></div>
    <v-row
      align="center"
      justify="end"
      class="submit-area"
    >
      <v-btn depressed @click="clearData">
        クリア
      </v-btn>
      <v-btn depressed color="primary" @click="onSubmit">
        登録
      </v-btn>
    </v-row>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, watch } from '@vue/composition-api';
import { throttle } from 'lodash';

export default defineComponent({
  name: 'InputManual',
  props: {
    candidateRaces: {
      type: Array,
      required: false,
    },
    candidateHorses: {
      type: Array,
      required: false
    },
    candidateJockeys: {
      type: Array,
      required: false,
    },
  },
  emits: ['search-race', 'search-horse', 'search-jockey'],

  setup(props, { emit }) {
    const raceName = ref('')
    const horseName = ref('')
    const jockeyName = ref('')
    const selectedTrackId = ref(0)
    const selectedHorseId = ref(0)
    const selectedJockeyId = ref(0)
    const selectedGrade = ref('')

    const isOpenCalender = ref(false)
    const raceDate = ref('')

    const horseInfos = ref([])

    const addHorseInfo = () => {
      const horseId = selectedHorseId.value
      const selectedHorseName = horseName.value
      const jockeyId = selectedJockeyId.value
      const selectedJockeyName = jockeyName.value
      initializeSearchData()

      const horseInfo = {
        horseId,
        selectedHorseName,
        jockeyId,
        selectedJockeyName
      }
      horseInfos.value.push(horseInfo)
    }

    const initializeSearchData = () => {
      horseName.value = ''
      jockeyName.value = ''
      selectedHorseId.value = 0
      selectedJockeyId.value = 0
    }

    const removeHorseInfo = () => {
      horseInfos.value.pop()
    }

    const searchRaceName = (val: string) => {
      emit('search-race', val)
    }

    const searchHorseName = (val: string) => {
      emit('search-horse', val)
    }

    const searchJockeyName = (val: string) => {
      emit('search-jockey', val)
    }

    const customFilter = (item, queryText, itemText) => {
      const textOne = item.name
      const searchText = queryText

      return textOne.indexOf(searchText) > -1
    }

    // watch(
    //   () => raceName.value,
    //   throttle((name: string) => {
    //     if (props.candidateRaces.length > 0) return
    //     searchRaceName(name)
    //   }, 1000)
    // )

    watch(
      () => horseName.value,
      throttle((name: string) => {
        if (props.candidateHorses.length > 0) return
        searchHorseName(name)
      }, 1000)
    )

    watch(
      () => jockeyName.value,
      throttle((name: string) => {
        if (props.candidateJockeys.length > 0) return
        searchJockeyName(name)
      }, 1000)
    )

    const clearData = () => {
      raceDate.value = ''
      selectedTrackId.value = 0
      selectedGrade.value = ''
      horseInfos.value = []
      initializeSearchData()
    }

    const onSubmit = () => {
      const horseInfoParams = horseInfos.value.map((v, i) => {
        v['horseOrder'] = i + 1
        return v
      })
      const params = {
        eventDate: raceDate.value,
        name: raceName.value.split('：')[0],
        trackId: selectedTrackId.value,
        horseInfo: horseInfoParams,
        grade: selectedGrade.value,
      }

      emit('create-candidate-race', params)
    }

    return {
      raceName,
      selectedTrackId,
      horseName,
      selectedHorseId,
      jockeyName,
      selectedJockeyId,
      selectedGrade,
      addHorseInfo,
      removeHorseInfo,
      horseInfos,
      isOpenCalender,
      raceDate,
      clearData,
      onSubmit,
      customFilter,
    }
  }
})
</script>

<style lang="scss" scoped>
  .input-manual {
    width: 75% !important;
  }
  .footer-btn-area {
    margin-top: 30px;
    button {
      margin-left: 15px;
    }
  }
  .submit-area-line {
    margin-top: 70px;
    border-top: double;
    border-width: 1px;
    border-color: darkgrey;
  }
  .submit-area {
    margin-top: 30px;
    button {
      width: 100px;
      margin-left: 15px;
    }
  }
</style>