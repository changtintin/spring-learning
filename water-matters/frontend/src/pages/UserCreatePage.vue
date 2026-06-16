<script setup>
import { ref } from 'vue'
import { createUser } from '../api/users'
import UserForm from '../components/users/UserForm.vue'

const isSubmitting = ref(false)
const errorMessage = ref('')

async function handleCreate(form) {
  isSubmitting.value = true
  errorMessage.value = ''

  try {
    await createUser(form)
    window.location.hash = '#/users'
  } catch (error) {
    errorMessage.value = error.message
  } finally {
    isSubmitting.value = false
  }
}
</script>

<template>
  <section class="page-panel narrow-panel">
    <a class="back-link" href="#/users">回使用者列表</a>
    <div class="page-header">
      <div>
        <p class="eyebrow">create</p>
        <h1>新增使用者</h1>
      </div>
    </div>

    <p v-if="errorMessage" class="status-box error-box">{{ errorMessage }}</p>
    <UserForm :is-submitting="isSubmitting" submit-label="建立使用者" @submit="handleCreate" />
  </section>
</template>
