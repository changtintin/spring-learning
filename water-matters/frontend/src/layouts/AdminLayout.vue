<script setup>
defineProps({
  currentPath: {
    type: String,
    default: '/users',
  },
})
</script>

<template>
  <div class="admin-shell">
    <aside class="admin-sidebar" aria-label="後台導覽">
      <a class="admin-brand" href="#/users">
        <span>Water</span>
        <strong>Matters</strong>
      </a>

      <nav class="admin-nav">
        <a :class="{ active: currentPath === '/today' }" href="#/today">今日進度</a>
        <a :class="{ active: currentPath === '/water-records' }" href="#/water-records">喝水紀錄</a>
        <a :class="{ active: currentPath.startsWith('/users') }" href="#/users">使用者管理</a>
        <a :class="{ active: currentPath === '/login' }" href="#/login">登入頁</a>
      </nav>
    </aside>

    <main class="admin-main">
      <slot />
    </main>
  </div>
</template>
