<script setup>
import BaseTable from '../common/BaseTable.vue'

defineProps({
  users: {
    type: Array,
    default: () => [],
  },
})

defineEmits(['edit', 'delete'])
</script>

<template>
  <BaseTable>
    <thead>
      <tr>
        <th>ID</th>
        <th>Email</th>
        <th>時區</th>
        <th>單位</th>
        <th>操作</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="user in users" :key="user.id">
        <td>{{ user.id }}</td>
        <td>{{ user.email }}</td>
        <td>{{ user.timezone || '-' }}</td>
        <td>{{ user.preferred_volume_unit || '-' }}</td>
        <td class="table-actions">
          <button class="text-action" type="button" @click="$emit('edit', user)">編輯</button>
          <button class="text-action danger-action" type="button" @click="$emit('delete', user)">刪除</button>
        </td>
      </tr>
    </tbody>
  </BaseTable>
</template>
