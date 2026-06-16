<script setup>
import { reactive, ref } from 'vue'
import glassImage from '../assets/glass.png'

const isSubmitting = ref(false)
const message = ref('')

const form = reactive({
  email: '',
  password: '',
  remember: true,
})

function showMessage(text) {
  message.value = text
}

function handleLogin() {
  isSubmitting.value = true
  showMessage('登入 API 尚未串接。表單資料已先保留在前端。')

  window.setTimeout(() => {
    isSubmitting.value = false
  }, 600)
}

function handleSocialLogin(provider) {
  showMessage(`${provider} 登入尚未串接。之後可接 OAuth redirect 或後端 callback。`)
}

function handleForgotPassword() {
  showMessage('忘記密碼流程尚未串接。之後可接 email reset link。')
}

function handleRegister() {
  showMessage('註冊流程尚未串接。之後可導向註冊頁或開啟註冊表單。')
}
</script>

<template>
  <main class="auth-shell">
    <section class="auth-poster" aria-labelledby="auth-title">
      <div class="auth-hero-copy">
        <p class="brand-kicker">Water Matters</p>
        <h1 id="auth-title">登入</h1>
        <p class="page-description">把每日飲水、提醒與偏好資料收進同一個帳號裡。後端 API 完成前，這裡先保留前端登入入口。</p>
      </div>

      <div class="poster-dashboard" aria-hidden="true">
        <div class="poster-card poster-card-lime">
          <span>hydrate</span>
          <strong>2.1L</strong>
        </div>
        <div class="poster-cup">
          <img class="poster-cup-image" :src="glassImage" alt="半杯水" />
        </div>
        <div class="poster-card poster-card-pink">
          <span>today</span>
          <strong>68%</strong>
        </div>
      </div>
    </section>

    <section class="auth-panel" aria-labelledby="login-heading">
      <div class="panel-heading">
        <div>
          <span class="panel-index">01</span>
          <h2 id="login-heading" class="mb-0">會員登入</h2>
        </div>
        <span class="auth-badge">no api yet</span>
      </div>

      <form class="auth-form" @submit.prevent="handleLogin">
        <div>
          <label class="form-label" for="email">Email</label>
          <input
            id="email"
            v-model="form.email"
            class="form-control"
            type="email"
            autocomplete="email"
            required
            placeholder="name@example.com"
          />
        </div>

        <div>
          <label class="form-label" for="password">密碼</label>
          <input
            id="password"
            v-model="form.password"
            class="form-control"
            type="password"
            autocomplete="current-password"
            required
            minlength="6"
            placeholder="至少 6 個字元"
          />
        </div>

        <div class="auth-options">
          <label class="remember-control" for="remember">
            <input id="remember" v-model="form.remember" type="checkbox" />
            <span>記住我</span>
          </label>
          <button class="text-action" type="button" @click="handleForgotPassword">忘記密碼</button>
        </div>

        <button class="btn btn-primary w-100" type="submit" :disabled="isSubmitting">
          {{ isSubmitting ? '登入中...' : '登入' }}
        </button>
      </form>

      <div class="auth-divider">
        <span>或使用社群帳號</span>
      </div>

      <div class="social-grid" aria-label="社群登入">
        <button class="social-button" type="button" aria-label="使用 Google 登入" @click="handleSocialLogin('Google')">
          <span class="social-mark google-mark">G</span>
        </button>
        <button class="social-button line-button" type="button" aria-label="使用 LINE 登入" @click="handleSocialLogin('LINE')">
          <span class="social-mark line-mark">LINE</span>
        </button>
        <button class="social-button" type="button" aria-label="使用 Facebook 登入" @click="handleSocialLogin('Facebook')">
          <span class="social-mark facebook-mark">f</span>
        </button>
      </div>

      <p class="signup-row">
        還沒有帳號？
        <button class="text-action" type="button" @click="handleRegister">註冊</button>
      </p>

      <p v-if="message" class="auth-message" role="status">{{ message }}</p>
    </section>
  </main>
</template>
