<script setup>
import { computed, onMounted, reactive, ref } from 'vue'
import { createUser, deleteUser, fetchUsers } from './api/users'

const users = ref([])
const isLoading = ref(false)
const isSubmitting = ref(false)
const errorMessage = ref('')
const successMessage = ref('')

const form = reactive({
  email: '',
  timezone: 'Asia/Taipei',
  preferred_volume_unit: 'ml',
})

const sortedUsers = computed(() =>
  [...users.value].sort((a, b) => Number(b.id) - Number(a.id)),
)

function showSuccess(message) {
  successMessage.value = message
  window.setTimeout(() => {
    if (successMessage.value === message) {
      successMessage.value = ''
    }
  }, 2400)
}

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

async function handleCreateUser() {
  isSubmitting.value = true
  errorMessage.value = ''

  try {
    const createdUser = await createUser({
      email: form.email.trim(),
      timezone: form.timezone.trim() || null,
      preferred_volume_unit: form.preferred_volume_unit,
    })

    users.value = [createdUser, ...users.value]
    form.email = ''
    showSuccess('使用者已新增。')
  } catch (error) {
    errorMessage.value = error.message
  } finally {
    isSubmitting.value = false
  }
}

async function handleDeleteUser(user) {
  errorMessage.value = ''

  try {
    await deleteUser(user.id)
    users.value = users.value.filter((item) => item.id !== user.id)
    showSuccess(`已刪除 ${user.email}。`)
  } catch (error) {
    errorMessage.value = error.message
  }
}

onMounted(loadUsers)
</script>

<template>
  <main class="app-shell">
    <section class="page-heading">
      <div>
        <p class="brand-kicker mb-2">Water Matters</p>
        <h1 class="mb-2">使用者管理</h1>
        <p class="page-description mb-0">先把會員資料流程接起來，後面再延伸飲水紀錄、提醒與商品訂閱。</p>
      </div>
      <button class="btn btn-refresh" type="button" :disabled="isLoading" @click="loadUsers">
        重新整理
      </button>
    </section>

    <div v-if="errorMessage" class="alert alert-danger" role="alert">
      {{ errorMessage }}
    </div>

    <div v-if="successMessage" class="alert alert-success" role="status">
      {{ successMessage }}
    </div>

    <div class="content-grid">
      <section class="panel create-panel">
        <div class="panel-heading">
          <span class="panel-index">01</span>
          <h2 class="mb-0">新增使用者</h2>
        </div>
        <form class="vstack gap-3" @submit.prevent="handleCreateUser">
          <div>
            <label class="form-label" for="email">Email</label>
            <input
              id="email"
              v-model="form.email"
              class="form-control"
              type="email"
              maxlength="255"
              autocomplete="email"
              required
              placeholder="name@example.com"
            />
          </div>

          <div>
            <label class="form-label" for="timezone">時區</label>
            <input
              id="timezone"
              v-model="form.timezone"
              class="form-control"
              type="text"
              maxlength="50"
              placeholder="Asia/Taipei"
            />
          </div>

          <div>
            <label class="form-label" for="unit">偏好容量單位</label>
            <select id="unit" v-model="form.preferred_volume_unit" class="form-select">
              <option value="ml">ml</option>
              <option value="oz">oz</option>
            </select>
          </div>

          <button class="btn btn-primary w-100" type="submit" :disabled="isSubmitting">
            {{ isSubmitting ? '新增中...' : '新增使用者' }}
          </button>
        </form>
      </section>

      <section class="panel users-panel">
        <div class="panel-heading users-heading">
          <div>
            <span class="panel-index">02</span>
            <h2 class="mb-0">使用者列表</h2>
          </div>
          <span class="user-count">{{ users.length }} 筆</span>
        </div>

        <div v-if="isLoading" class="loading-state" role="status" aria-live="polite">
          <p>LOADING</p>
          <div class="loading-cup" aria-hidden="true">
            <div class="loading-water"></div>
          </div>
        </div>

        <div v-else-if="sortedUsers.length === 0" class="empty-state">
          <span>目前還沒有使用者。</span>
          <small>新增第一筆會員後，列表會出現在這裡。</small>
        </div>

        <div v-else class="table-responsive">
          <table class="table users-table align-middle">
            <thead>
              <tr>
                <th scope="col">ID</th>
                <th scope="col">Email</th>
                <th scope="col">時區</th>
                <th scope="col">單位</th>
                <th class="text-end" scope="col">操作</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="user in sortedUsers" :key="user.id">
                <td class="text-secondary">{{ user.id }}</td>
                <td class="fw-semibold">{{ user.email }}</td>
                <td>{{ user.timezone || '-' }}</td>
                <td>{{ user.preferred_volume_unit || '-' }}</td>
                <td class="text-end">
                  <button class="btn btn-sm btn-outline-danger" type="button" @click="handleDeleteUser(user)">
                    刪除
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>
    </div>
  </main>
</template>
