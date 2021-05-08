import { ref } from "@vue/composition-api"

type SnackbarColor = 'primary' | 'error'

const defaultMessage = '処理が完了しました'

export const useSnackbar = () => {
  const isOpenSnackbar = ref(false)
  const snackbarMessage = ref(defaultMessage)
  const snackbarColor = ref<SnackbarColor>('primary')

  return {
    isOpenSnackbar,
    snackbarMessage,
    snackbarColor
  }
}