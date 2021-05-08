<template>
  <v-dialog
    :value="dialog"
    width="500"
  >
    <v-card>
      <v-card-title class="headline lighten-2">
        {{ titleText }}
      </v-card-title>

      <v-card-text>
        {{ description }}
      </v-card-text>

      <v-divider></v-divider>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn
          color="normal"
          text
          @click="onCancel"
        >
          {{ cancelText }}
        </v-btn>
        <v-btn
          :color="btnColor"
          @click="onSubmit"
        >
          {{ submitText }}
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script lang="ts">
import { defineComponent } from '@vue/composition-api'

export default defineComponent({
  name: 'ConfirmDialog',
  props: {
    dialog: {
      type: Boolean,
      default: false,
    },
    titleText: {
      type: String,
      default: '確認',
    },
    description: {
      type: String,
      default: '実行します。よろしいですか？',
    },
    cancelText: {
      type: String,
      default: 'キャンセル'
    },
    submitText: {
      type: String,
      defalut: 'OK'
    },
    btnColor: {
      type: String,
      default: 'primary'
    }
  },
  emits: ['submit', 'cancel'],
  setup(_, { emit }) {
    const onSubmit = () => {
      emit('submit')
    }

    const onCancel = () => {
      emit('cancel')
    }

    return {
      onSubmit,
      onCancel,
    }
  },
})
</script>
