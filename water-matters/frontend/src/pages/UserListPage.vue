<script setup>
import { computed, onMounted, ref } from 'vue'
import { deleteUser, fetchUsers } from '../api/users'
import BaseButton from '../components/common/BaseButton.vue'
import BasePagination from '../components/common/BasePagination.vue'
import UserDeleteModal from '../components/users/UserDeleteModal.vue'
import UserTable from '../components/users/UserTable.vue'

const users = ref([])
const isLoading = ref(false)
const errorMessage = ref('')
const page = ref(1)
const pageSize = 8
const deletingUser = ref(null)
const isDeleting = ref(false)

const totalPages = computed(() => Math.max(1, Math.ceil(users.value.length / pageSize)))
const pagedUsers = computed(() => {
  const start = (page.value - 1) * pageSize
  return users.value.slice(start, start + pageSize)
})

async function loadUsers() {
  isLoading.value = true
  errorMessage.value = ''

  try {
    users.value = await fetchUsers()
  } catch (error) {
    errorMessage.value = error.message
  } finally {
    isLoading.value = false
  }
}

function goCreate() {
  window.location.hash = '#/users/new'
}

function goEdit(user) {
  window.location.hash = `#/users/${user.id}/edit`
}

function openDeleteModal(user) {
  deletingUser.value = user
}

async function confirmDelete() {
  if (!deletingUser.value) return

  isDeleting.value = true
  errorMessage.value = ''

  try {
    await deleteUser(deletingUser.value.id)
    deletingUser.value = null
    await loadUsers()
  } catch (error) {
    errorMessage.value = error.message
  } finally {
    isDeleting.value = false
  }
}

onMounted(loadUsers)
</script>

<template>
  <section class="page-panel">
    <div class="page-header">
      <div>
        <p class="eyebrow">users</p>
        <h1>使用者管理</h1>
      </div>
      <BaseButton @click="goCreate">新增使用者</BaseButton>
    </div>

    <p class="status-box" v-if="isLoading">正在讀取使用者資料...</p>
    <p class="status-box error-box" v-else-if="errorMessage">{{ errorMessage }}</p>

    <div v-else-if="users.length === 0" class="empty-state">
      <p>目前還沒有使用者資料。</p>
      <BaseButton @click="goCreate">建立第一位使用者</BaseButton>
    </div>

    <template v-else>
      <UserTable :users="pagedUsers" @edit="goEdit" @delete="openDeleteModal" />
      <BasePagination
        :page="page"
        :total-pages="totalPages"
        @previous="page = Math.max(1, page - 1)"
        @next="page = Math.min(totalPages, page + 1)"
      />
    </template>

    <UserDeleteModal
      :open="Boolean(deletingUser)"
      :user="deletingUser"
      :is-deleting="isDeleting"
      @close="deletingUser = null"
      @confirm="confirmDelete"
    />
  </section>
</template>
