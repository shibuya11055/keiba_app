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
            <th></th>
            <th></th>
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
            <td class="text-end">
              <v-btn class="ma-2" outlined color="indigo" @click="toShowPage(item.id)">詳細</v-btn>
            </td>
            <td>
              <v-btn class="ma-2" outlined color="error" @click="openDialog(item.id)">終了</v-btn>
            </td>
          </tr>
        </tbody>
      </template>
    </v-simple-table>

    <confirm-dialog
      :dialog="dialog"
      :description="'レースを終了とします。よろしいですか？'"
      :submitText="'終了'"
      @submit="remove"
      @cancel="closeDialog"
    />
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref } from '@vue/composition-api';
import tenAxios from 'packs/lib/tenAxios'
import { useTranslateGrade } from '../../../../util/translateType'
import ConfirmDialog from '../../../common/confirmDialog.vue'

const useFetchExpectedRaces = () => {
  const expectedRaces = ref([])
  const fetchExpectedRaces = async() => {
    const res = await tenAxios.get('/expected_races')
    expectedRaces.value = res.data.expectedRaces
  }

  return {
    expectedRaces,
    fetchExpectedRaces,
  }
}

export default defineComponent({
  name: 'ExpectedRaceIndex',
  components: {
    ConfirmDialog
  },
  setup(_, context) {
    const { expectedRaces, fetchExpectedRaces } = useFetchExpectedRaces()
    const { translateGrade } = useTranslateGrade()
    const router = context.root.$router
    const dialog = ref(false)
    const selectedRemoveId = ref<number | null>(null)

    const toShowPage = (val: string) => {
      router.push({ name: 'ExpectedRaceShow', params: {race_id: val} })
    }

    const openDialog = (id: number) => {
      selectedRemoveId.value = id
      dialog.value = true
    }

    const closeDialog = () => {
      dialog.value = false
    }

    const remove = () => {
      console.log(selectedRemoveId.value)
      dialog.value = false
      selectedRemoveId.value = null

    }

    onMounted(() => {
      fetchExpectedRaces()
    })

    return {
      expectedRaces,
      translateGrade,
      toShowPage,
      remove,
      dialog,
      openDialog,
      closeDialog,
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
