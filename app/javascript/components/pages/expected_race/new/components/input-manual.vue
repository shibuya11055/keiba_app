<template>
  <div class="input-manual">
    <h2>手動登録</h2>
    <v-form>
      <v-menu v-model="menu" max-width="290px" min-width="290px">
        <!-- ポップアップを追加する要素にv-on="on" -->
        <template v-slot:activator="{ on }">
          <v-text-field
            slot="activator"
            v-model="fromDate"
            label="日程"
            readonly
            v-on="on"
          />
        </template>
        <!-- ポップアップされる内容-->
        <v-date-picker v-model="fromDate" />
      </v-menu>
      <!-- レース名 -->
      <v-autocomplete
        v-model="selectedRace"
        :items="candidateRaces"
        :search-input.sync="raceName"
        label="レース名"
        item-value="id"
        item-text="name"
      ></v-autocomplete>
      <!-- グレード -->
      <v-radio-group row label="グレード">
        <v-radio label="GⅠ" value="one" color="blue"></v-radio>
        <v-radio label="GⅡ" value="two" color="red"></v-radio>
        <v-radio label="GⅢ" value="three" color="green"></v-radio>
      </v-radio-group>
      <!-- 競走馬情報 -->
      <h3>競走馬情報</h3>
      <v-row v-for="(horseInfo, index) in horseInfos" :key="horseInfo.name">
        <v-col cols="12" md="6">
          <v-text-field
            v-model="horseInfo.name"
            :counter="9"
            :label="`馬名（馬番: ${index + 1})`"
            required
          ></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
          <v-text-field
            v-model="horseInfo.jockeyName"
            label="騎手"
            required
          ></v-text-field>
        </v-col>
      </v-row>
      <!-- 削除・追加ボタン -->
      <v-row
        align="center"
        justify="end"
        class="footer-btn-area"
      >
        <v-btn
          v-if="horseInfos.length > 1"
          class="mx-2"
          fab
          dark
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
          dark
          large
          color="deep-orange"
          @click="addHorseInfo"
        >
          <v-icon dark>
            mdi-plus
          </v-icon>
        </v-btn>
      </v-row>
    </v-form>
    <!-- クリア・登録ボタン -->
    <div class="submit-area-line"></div>
    <v-row
      align="center"
      justify="end"
      class="submit-area"
    >
      <v-btn depressed>
        クリア
      </v-btn>
      <v-btn depressed color="primary">
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
    }
  },
  setup(props, { emit }) {
    const name = ref('')
    const raceName = ref('')
    const menu = ref('')
    const fromDate = ref('')
    const selectedRace = ref('')

    const horseInfo = {
      horseName: '',
      jockeyName: '',
      tranerName: '',
    }

    const horseInfos = ref([horseInfo])

    const addHorseInfo = () => {
      horseInfos.value.push(horseInfo)
    }

    const removeHorseInfo = () => {
      horseInfos.value.pop()
    }

    const searchRaceName = (val: string) => {
      emit('search-race', val)
    }

    watch(
      () => raceName.value,
      throttle((name: string) => {
        if (props.candidateRaces.length > 0) return
        searchRaceName(name)
      }, 1000)
    )

    return {
      selectedRace,
      searchRaceName,
      addHorseInfo,
      removeHorseInfo,
      horseInfos,
      name,
      raceName,
      menu,
      fromDate,
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