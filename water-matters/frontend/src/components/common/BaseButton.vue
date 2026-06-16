<script setup>
defineProps({
  type: {
    type: String,
    default: 'button',
  },
  variant: {
    type: String,
    default: 'primary',
  },
  disabled: {
    type: Boolean,
    default: false,
  },
})
</script>

<template>
  <button class="btn" :class="`btn-${variant}`" :type="type" :disabled="disabled">
    <slot />
  </button>
</template>
