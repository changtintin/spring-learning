<script setup>
import { computed, onMounted, ref } from 'vue'
import { fetchUser } from '../api/users'
import UserForm from '../components/users/UserForm.vue'

const props = defineProps({
  userId: {
    type: String,
    required: true,
  },
})

const user = ref(null)
const isLoading = ref(false)
const errorMessage = ref('')

const displayUser = computed(() => user.value || {})

async function loadUser() {
  isLoading.value = true
  errorMessage.value = ''

  try {
    user.value = await fetchUser(props.userId)
  } catch (error) {
    errorMessage.value = error.message
  } finally {
    isLoading.value = false
  }
}

onMounted(loadUser)
</script>

<template>
  <section class="page-panel narrow-panel">
    <a class="back-link" href="#/users">回使用者列表</a>
    <div class="page-header">
      <div>
        <p class="eyebrow">edit</p>
        <h1>編輯使用者</h1>
      </div>
    </div>

    <p class="status-box" v-if="isLoading">正在讀取使用者資料...</p>
    <p class="status-box error-box" v-else-if="errorMessage">{{ errorMessage }}</p>

    <template v-else>
      <p class="status-box">後端目前尚未提供更新使用者 API，所以這個頁面先保留為可讀的編輯頁結構。</p>
      <UserForm :initial-user="displayUser" submit-label="尚未開放更新" disabled />
    </template>
  </section>
</template>
