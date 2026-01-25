import axios from 'axios'

const api = axios.create({
  baseURL: '/my-blog/api',  // 统一使用 /my-blog/api 路径
  timeout: 10000
})

// 请求拦截器
api.interceptors.request.use(
  config => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  error => {
    return Promise.reject(error)
  }
)

// 响应拦截器
api.interceptors.response.use(
  response => response.data,
  error => {
    // 如果是401错误，需要智能处理
    if (error.response?.status === 401) {
      const url = error.config?.url || ''
      // 排除登录和注册API，这些API返回401是正常的（用户名密码错误等）
      const isAuthApi = url.includes('/auth/login') || url.includes('/auth/register')
      
      if (!isAuthApi) {
        // 获取当前路径
        const currentPath = window.location.pathname
        // 如果当前不在登录或注册页面，才跳转到登录页
        // 这样可以避免用户在注册页面时被强制跳转到登录页
        if (currentPath !== '/my-blog/login' && currentPath !== '/my-blog/register') {
          localStorage.removeItem('token')
          localStorage.removeItem('user')
          // 使用 window.location.href 跳转，会刷新页面
          // 但先检查当前路径，避免循环跳转
          window.location.href = '/my-blog/login'
        }
      }
      // 如果是认证API的401错误，直接返回错误，不跳转
      // 让组件自己处理错误信息（如"用户名或密码错误"）
    }
    return Promise.reject(error)
  }
)

export default api
