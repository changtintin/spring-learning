<script setup>
defineProps({
  page: {
    type: Number,
    default: 1,
  },
  totalPages: {
    type: Number,
    default: 1,
  },
})

defineEmits(['previous', 'next'])
</script>

<template>
  <nav class="pagination-bar" aria-label="分頁">
    <button class="btn btn-secondary pagination-button pagination-prev" type="button" :disabled="page <= 1" @click="$emit('previous')">上一頁</button>
    <span>{{ page }} / {{ totalPages }}</span>
    <button class="btn btn-secondary pagination-button pagination-next" type="button" :disabled="page >= totalPages" @click="$emit('next')">下一頁</button>
  </nav>
</template>
