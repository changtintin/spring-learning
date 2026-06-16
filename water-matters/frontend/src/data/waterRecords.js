export const dailyHydration = {
  date: '2026/06/16',
  weekday: 'Tuesday',
  goalMl: 2200,
  totalMl: 580,
}

export const defaultIntakeRecords = [
  {
    id: 1,
    item: '溫開水',
    calories: 0,
    amount: '80 ml / 2.7 oz',
    time: '08:20',
  },
  {
    id: 2,
    item: '無糖綠茶',
    calories: 1,
    amount: '90 ml / 3.0 oz',
    time: '10:05',
  },
  {
    id: 3,
    item: '氣泡水',
    calories: 0,
    amount: '100 ml / 3.4 oz',
    time: '13:42',
  },
  {
    id: 4,
    item: '黑咖啡',
    calories: 2,
    amount: '70 ml / 2.4 oz',
    time: '15:10',
  },
  {
    id: 5,
    item: '檸檬水',
    calories: 3,
    amount: '85 ml / 2.9 oz',
    time: '16:30',
  },
  {
    id: 6,
    item: '白開水',
    calories: 0,
    amount: '95 ml / 3.2 oz',
    time: '18:15',
  },
  {
    id: 7,
    item: '薄荷水',
    calories: 1,
    amount: '60 ml / 2.0 oz',
    time: '20:40',
  },
]

export const WATER_RECORDS_STORAGE_KEY = 'water-matters.today-records'

export function loadHydrationState() {
  const fallback = {
    totalMl: dailyHydration.totalMl,
    records: defaultIntakeRecords,
  }

  try {
    const savedState = window.localStorage.getItem(WATER_RECORDS_STORAGE_KEY)

    if (!savedState) return fallback

    const parsedState = JSON.parse(savedState)

    return {
      totalMl: Number(parsedState.totalMl) || fallback.totalMl,
      records: Array.isArray(parsedState.records) ? parsedState.records : fallback.records,
    }
  } catch {
    return fallback
  }
}

export function saveHydrationState(state) {
  window.localStorage.setItem(WATER_RECORDS_STORAGE_KEY, JSON.stringify(state))
}

export const intakeRecords = defaultIntakeRecords
