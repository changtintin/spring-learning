import { request } from './http'

export function fetchUsers() {
  return request('/users')
}

export function fetchUser(id) {
  return request(`/users/${id}`)
}

export function createUser(user) {
  return request('/users', {
    method: 'POST',
    body: JSON.stringify(user),
  })
}

export function deleteUser(id) {
  return request(`/users/${id}`, {
    method: 'DELETE',
  })
}
