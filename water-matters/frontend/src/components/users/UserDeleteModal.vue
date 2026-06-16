<script setup>
import BaseButton from '../common/BaseButton.vue'
import BaseModal from '../common/BaseModal.vue'

defineProps({
  open: {
    type: Boolean,
    default: false,
  },
  user: {
    type: Object,
    default: null,
  },
  isDeleting: {
    type: Boolean,
    default: false,
  },
})

defineEmits(['close', 'confirm'])
</script>

<template>
  <BaseModal title="刪除使用者" :open="open" @close="$emit('close')">
    <p class="modal-copy">
      確定要刪除
      <strong>{{ user?.email }}</strong>
      嗎？這個動作送出後就會呼叫後端刪除 API。
    </p>
    <div class="modal-actions">
      <BaseButton variant="secondary" :disabled="isDeleting" @click="$emit('close')">取消</BaseButton>
      <BaseButton variant="danger" :disabled="isDeleting" @click="$emit('confirm')">
        {{ isDeleting ? '刪除中...' : '確認刪除' }}
      </BaseButton>
    </div>
  </BaseModal>
</template>
