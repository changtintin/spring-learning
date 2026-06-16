<script setup>
import { computed, onMounted, onUnmounted, ref } from 'vue'
import AdminLayout from './layouts/AdminLayout.vue'
import LoginPage from './pages/LoginPage.vue'
import TodayProgressPage from './pages/TodayProgressPage.vue'
import UserCreatePage from './pages/UserCreatePage.vue'
import UserEditPage from './pages/UserEditPage.vue'
import UserListPage from './pages/UserListPage.vue'
import WaterRecordsPage from './pages/WaterRecordsPage.vue'

const currentPath = ref(getPathFromHash())

const editMatch = computed(() => currentPath.value.match(/^\/users\/(\d+)\/edit$/))
const currentPage = computed(() => {
  if (currentPath.value === '/login') return LoginPage
  if (currentPath.value === '/today') return TodayProgressPage
  if (currentPath.value === '/water-records') return WaterRecordsPage
  if (currentPath.value === '/users/new') return UserCreatePage
  if (editMatch.value) return UserEditPage
  return UserListPage
})

const currentProps = computed(() => {
  if (editMatch.value) {
    return { userId: editMatch.value[1] }
  }

  return {}
})

function getPathFromHash() {
  return window.location.hash.replace(/^#/, '') || '/users'
}

function handleHashChange() {
  currentPath.value = getPathFromHash()
}

onMounted(() => {
  window.addEventListener('hashchange', handleHashChange)
})

onUnmounted(() => {
  window.removeEventListener('hashchange', handleHashChange)
})
</script>

<template>
  <LoginPage v-if="currentPath === '/login'" />
  <AdminLayout v-else :current-path="currentPath">
    <component :is="currentPage" v-bind="currentProps" />
  </AdminLayout>
</template>
