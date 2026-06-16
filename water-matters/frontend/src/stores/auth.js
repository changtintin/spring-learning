import { reactive } from 'vue'

export const authStore = reactive({
  user: null,
  token: '',
})

export function setAuth({ user, token }) {
  authStore.user = user
  authStore.token = token
}

export function clearAuth() {
  authStore.user = null
  authStore.token = ''
}
