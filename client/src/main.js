import { createApp } from 'vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
import App from './App.vue'
import router from './router'
import './style.css'

// 开发环境下显示运行时错误，避免白屏无提示
if (import.meta.env.DEV) {
  const showError = (message) => {
    const el = document.getElementById('app')
    if (el) {
      el.innerHTML = `<div style="padding:16px;color:#b91c1c;background:#fee2e2;border:1px solid #fecaca;border-radius:6px;font-family:monospace;white-space:pre-wrap;">${message}</div>`
    }
  }

  window.addEventListener('error', (event) => {
    showError(`运行时错误: ${event.message}`)
  })

  window.addEventListener('unhandledrejection', (event) => {
    showError(`未处理的Promise错误: ${event.reason}`)
  })
}

const app = createApp(App)

// 注册所有图标
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component)
}

app.use(ElementPlus)
app.use(router)

// 错误处理
app.config.errorHandler = (err, instance, info) => {
  console.error('Vue错误:', err, info)
}

// 挂载应用
app.mount('#app')
window.__APP_MOUNTED__ = true

console.log('Vue应用已启动')
