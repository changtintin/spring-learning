<script setup>
import BaseTable from '../components/common/BaseTable.vue'
import { dailyHydration, loadHydrationState } from '../data/waterRecords'

const { records: intakeRecords } = loadHydrationState()

function goBackToday() {
  window.location.hash = '#/today'
}
</script>

<template>
  <section class="page-panel records-page">
    <header class="page-header">
      <div>
        <p class="eyebrow">water log</p>
        <h1>完整喝水紀錄</h1>
        <p class="records-date">{{ dailyHydration.date }}</p>
      </div>

      <button class="text-action records-back" type="button" @click="goBackToday">回今日進度</button>
    </header>

    <section class="records-panel" aria-labelledby="all-records-title">
      <div class="records-heading">
        <h2 id="all-records-title">今日全部紀錄</h2>
        <span>{{ intakeRecords.length }} 筆</span>
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
          <tr v-for="record in intakeRecords" :key="record.id">
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
