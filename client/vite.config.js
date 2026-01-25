import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  base: '/my-blog/',  // 统一使用 /my-blog/ 路径，本地和生产环境一致
  server: {
    port: 3000,
    proxy: {
      '/my-blog/api': {  // 本地开发时也使用 /my-blog/api，通过proxy转发到后端
        target: 'http://localhost:8080',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/my-blog\/api/, '/api')  // 将 /my-blog/api 重写为 /api 转发给后端
      }
    }
  },
  build: {
    outDir: 'dist',
    assetsDir: 'assets'
  }
})
