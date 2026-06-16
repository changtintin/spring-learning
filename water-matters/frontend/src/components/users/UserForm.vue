<script setup>
import { reactive, watch } from 'vue'
import BaseButton from '../common/BaseButton.vue'
import BaseInput from '../common/BaseInput.vue'

const props = defineProps({
  initialUser: {
    type: Object,
    default: () => ({
      email: '',
      timezone: 'Asia/Taipei',
      preferred_volume_unit: 'ml',
    }),
  },
  submitLabel: {
    type: String,
    default: '儲存',
  },
  isSubmitting: {
    type: Boolean,
    default: false,
  },
  disabled: {
    type: Boolean,
    default: false,
  },
})

const emit = defineEmits(['submit'])

const form = reactive({
  email: '',
  timezone: '',
  preferred_volume_unit: 'ml',
})

watch(
  () => props.initialUser,
  (user) => {
    form.email = user?.email || ''
    form.timezone = user?.timezone || 'Asia/Taipei'
    form.preferred_volume_unit = user?.preferred_volume_unit || 'ml'
  },
  { immediate: true },
)

function handleSubmit() {
  emit('submit', { ...form })
}
</script>

<template>
  <form class="user-form" @submit.prevent="handleSubmit">
    <BaseInput
      id="user-email"
      v-model="form.email"
      label="Email"
      type="email"
      placeholder="name@example.com"
      required
      :disabled="disabled || isSubmitting"
    />

    <BaseInput
      id="user-timezone"
      v-model="form.timezone"
      label="時區"
      placeholder="Asia/Taipei"
      :disabled="disabled || isSubmitting"
    />

    <div class="field-group">
      <label class="form-label" for="preferred-volume-unit">偏好容量單位</label>
      <select
        id="preferred-volume-unit"
        v-model="form.preferred_volume_unit"
        class="form-control"
        :disabled="disabled || isSubmitting"
      >
        <option value="ml">ml</option>
        <option value="oz">oz</option>
      </select>
    </div>

    <BaseButton type="submit" :disabled="disabled || isSubmitting">
      {{ isSubmitting ? '儲存中...' : submitLabel }}
    </BaseButton>
  </form>
</template>
