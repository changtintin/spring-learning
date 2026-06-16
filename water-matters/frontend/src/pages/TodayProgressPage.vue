<script setup>
import { computed, ref } from 'vue'
import BaseButton from '../components/common/BaseButton.vue'
import BaseModal from '../components/common/BaseModal.vue'
import BaseTable from '../components/common/BaseTable.vue'
import { dailyHydration, loadHydrationState, saveHydrationState, WATER_RECORDS_STORAGE_KEY } from '../data/waterRecords'

const initialState = loadHydrationState()

const totalMl = ref(initialState.totalMl)
const records = ref(initialState.records)
const newRecord = ref({
  item: '白開水',
  amountMl: 250,
  calories: 0,
  time: currentTime(),
})
const lastAddedMl = ref(0)
const formError = ref('')
const showAddModal = ref(false)

const progressPercent = computed(() => Math.min(100, Math.round((totalMl.value / dailyHydration.goalMl) * 100)))
const visibleRecords = computed(() => records.value.slice(0, 5))

// 杯子梯形：頂邊 x=[42,278] y=44，底邊 x=[74,246] y=390
const waterLevel = computed(() => {
  const topY = 44
  const botY = 390
  return botY - (botY - topY) * (progressPercent.value / 100)
})

function currentTime() {
  return new Date().toLocaleTimeString('zh-TW', { hour: '2-digit', minute: '2-digit', hour12: false })
}

function formatAmount(amountMl) {
  return `${amountMl} ml / ${(amountMl / 29.5735).toFixed(1)} oz`
}

function addWaterRecord() {
  const amountMl = Number(newRecord.value.amountMl)
  const calories = Number(newRecord.value.calories) || 0
  const item = newRecord.value.item.trim()

  if (!item || !amountMl || amountMl <= 0) {
    formError.value = '請輸入品項與有效 ml 數'
    return
  }

  const nextRecord = {
    id: Date.now(),
    item,
    calories,
    amount: formatAmount(amountMl),
    time: newRecord.value.time || currentTime(),
  }

  formError.value = ''
  lastAddedMl.value = amountMl
  records.value = [nextRecord, ...records.value]
  totalMl.value = Math.min(dailyHydration.goalMl, totalMl.value + amountMl)

  saveHydrationState({
    totalMl: totalMl.value,
    records: records.value,
  })

  newRecord.value = {
    item: '白開水',
    amountMl: 250,
    calories: 0,
    time: currentTime(),
  }

  showAddModal.value = false
}

function resetDemoRecords() {
  window.localStorage.removeItem(WATER_RECORDS_STORAGE_KEY)
  const resetState = loadHydrationState()
  totalMl.value = resetState.totalMl
  records.value = resetState.records
  lastAddedMl.value = 0
  formError.value = ''
}

function goToAllRecords() {
  window.location.hash = '#/water-records'
}
</script>

<template>
  <section class="page-panel today-page">
    <div class="today-hero-board">
      <div class="today-copy">
        <p class="eyebrow">water matters</p>
        <h1>今日進度</h1>

        <div class="today-date-row">
          <div class="today-date-card" aria-label="今日日期">
            <span>today</span>
            <strong>{{ dailyHydration.date }}</strong>
            <small>{{ dailyHydration.weekday }}</small>
          </div>
          <div class="today-date-actions">
            <span v-if="lastAddedMl" class="water-added-badge">+{{ lastAddedMl }} ml</span>
            <button class="add-plus-btn" type="button" @click="showAddModal = true">+</button>
          </div>
        </div>
      </div>

      <div class="today-meter-wrap">
        <svg
          class="today-water-meter"
          viewBox="0 0 320 420"
          role="progressbar"
          :aria-valuenow="progressPercent"
          aria-valuemin="0"
          aria-valuemax="100"
          aria-label="今日喝水目標達成率"
        >
          <defs>
            <clipPath id="today-water-cup-clip">
              <path d="M42 44 H278 L246 390 H74 Z" />
            </clipPath>
          </defs>

          <g clip-path="url(#today-water-cup-clip)">
            <!-- 波浪從水面中線開始，往上是波峰、往下填滿到杯底 -->
            <path
              class="today-wave-path"
              :d="`M-320 ${waterLevel} c20,-22 40,22 60,0 c20,-22 40,22 60,0 c20,-22 40,22 60,0 c20,-22 40,22 60,0 c20,-22 40,22 60,0 c20,-22 40,22 60,0 c20,-22 40,22 60,0 c20,-22 40,22 60,0 c20,-22 40,22 60,0 c20,-22 40,22 60,0 V390 H-320 Z`"
            />
          </g>
          <path class="today-cup-outline" d="M42 44 H278 L246 390 H74 Z" />
          <path class="today-cup-rim" d="M48 50 H272" />
        </svg>
        <span class="sr-only">{{ progressPercent }}%</span>

        <BaseModal title="新增喝水紀錄" :open="showAddModal" @close="showAddModal = false">
          <form class="add-water-form add-water-form--modal" @submit.prevent>
            <label class="field-group">
              <span class="form-label">品項</span>
              <input v-model="newRecord.item" class="form-control" type="text" />
            </label>
            <label class="field-group">
              <span class="form-label">ml</span>
              <input v-model.number="newRecord.amountMl" class="form-control" type="number" min="1" step="10" />
            </label>
            <label class="field-group">
              <span class="form-label">熱量</span>
              <input v-model.number="newRecord.calories" class="form-control" type="number" min="0" step="1" />
            </label>
            <label class="field-group">
              <span class="form-label">時間</span>
              <input v-model="newRecord.time" class="form-control" type="time" />
            </label>
            <BaseButton type="button" @click="addWaterRecord">新增紀錄</BaseButton>
            <button class="text-action" type="button" @click="resetDemoRecords">重置 demo</button>
          </form>
          <p v-if="formError" class="add-water-error">{{ formError }}</p>
        </BaseModal>
      </div>

      <div class="today-stat-grid">
        <article class="today-stat-card today-stat-lime">
          <span>目標達成率</span>
          <strong>{{ progressPercent }}%</strong>
        </article>
        <article class="today-stat-card today-stat-pink">
          <span>今日飲水量</span>
          <strong>{{ totalMl }} / {{ dailyHydration.goalMl }}</strong>
          <small>ml</small>
        </article>
      </div>
    </div>


    <section class="records-panel" aria-labelledby="records-title">
      <div class="records-heading">
        <div>
          <p class="eyebrow">last five</p>
          <h2 id="records-title">喝水紀錄</h2>
        </div>
        <BaseButton variant="secondary" @click="goToAllRecords">看更多</BaseButton>
      </div>

      <BaseTable>
        <thead>
          <tr>
            <th>品項</th>
            <th>總熱量</th>
            <th>ml / oz</th>
            <th>時間</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="record in visibleRecords" :key="record.id">
            <td>{{ record.item }}</td>
            <td>{{ record.calories }} kcal</td>
            <td>{{ record.amount }}</td>
            <td>{{ record.time }}</td>
          </tr>
        </tbody>
      </BaseTable>
    </section>
  </section>
</template>
