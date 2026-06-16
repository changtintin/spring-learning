const API_BASE = '/api'

export async function request(path, options = {}) {
  const response = await fetch(`${API_BASE}${path}`, {
    headers: {
      'Content-Type': 'application/json',
      ...options.headers,
    },
    ...options,
  })

  const payload = await response.json().catch(() => null)

  if (!response.ok) {
    const message = payload?.message || '操作失敗，請稍後再試。'
    throw new Error(message)
  }

  return payload?.data ?? null
}
