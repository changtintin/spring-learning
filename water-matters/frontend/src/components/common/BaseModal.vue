<script setup>
defineProps({
  open: {
    type: Boolean,
    default: false,
  },
  title: {
    type: String,
    required: true,
  },
})

defineEmits(['close'])
</script>

<template>
  <Teleport to="body">
    <div v-if="open" class="modal-backdrop" @click.self="$emit('close')">
      <section class="modal-panel" role="dialog" aria-modal="true" :aria-labelledby="`${title}-modal-title`">
        <div class="modal-heading">
          <h2 :id="`${title}-modal-title`">{{ title }}</h2>
          <button class="icon-button" type="button" aria-label="關閉" @click="$emit('close')">x</button>
        </div>
        <slot />
      </section>
    </div>
  </Teleport>
</template>
