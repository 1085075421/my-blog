<template>
  <div id="app">
    <el-container>
      <el-header>
        <div class="header-content">
          <h1 @click="$router.push('/')" style="cursor: pointer; color: #409EFF;">
            个人博客社区
          </h1>
          <div class="header-actions">
            <template v-if="user">
              <el-button @click="$router.push('/editor')" type="primary" :icon="Edit">
                写文章
              </el-button>
              <el-dropdown>
                <span class="user-info">
                  <el-avatar :size="32" :src="user.avatar" />
                  <span style="margin-left: 8px;">{{ user.username }}</span>
                </span>
                <template #dropdown>
                  <el-dropdown-menu>
                    <el-dropdown-item @click="$router.push(`/user/${user.userId}`)">
                      我的主页
                    </el-dropdown-item>
                    <el-dropdown-item 
                      v-if="isAdmin" 
                      @click="$router.push('/admin/dashboard')"
                    >
                      后台管理
                    </el-dropdown-item>
                    <el-dropdown-item @click="logout">退出登录</el-dropdown-item>
                  </el-dropdown-menu>
                </template>
              </el-dropdown>
            </template>
            <template v-else>
              <el-button @click="$router.push('/login')">登录</el-button>
              <el-button type="primary" @click="$router.push('/register')">注册</el-button>
            </template>
          </div>
        </div>
      </el-header>
      <el-main>
        <router-view />
      </el-main>
    </el-container>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import { Edit } from '@element-plus/icons-vue'
import api from './utils/api'

const router = useRouter()
const user = ref(null)

const isAdmin = computed(() => {
  return user.value?.role === 'ADMIN'
})

const loadUser = async () => {
  const token = localStorage.getItem('token')
  const userInfo = localStorage.getItem('user')
  if (token && userInfo) {
    try {
      user.value = JSON.parse(userInfo)
      // 从服务器获取最新用户信息（包含role）
      try {
        const latestUser = await api.get(`/users/${user.value.userId}`)
        user.value.role = latestUser.role || 'USER'
        localStorage.setItem('user', JSON.stringify(user.value))
      } catch (error) {
        console.error('获取用户信息失败:', error)
        // 如果获取失败，设置默认role
        if (!user.value.role) {
          user.value.role = 'USER'
        }
      }
    } catch (e) {
      console.error('解析用户信息失败:', e)
      localStorage.removeItem('token')
      localStorage.removeItem('user')
    }
  } else {
    user.value = null
  }
}

onMounted(() => {
  loadUser()
  // 监听storage变化，当其他标签页登录/登出时也能同步
  window.addEventListener('storage', loadUser)
})

const logout = () => {
  localStorage.removeItem('token')
  localStorage.removeItem('user')
  user.value = null
  router.push('/')
}
</script>

<style scoped>
.header-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 100%;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

.user-info {
  display: flex;
  align-items: center;
  cursor: pointer;
  padding: 4px 8px;
}

.el-header {
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  padding: 0 20px;
}

.el-main {
  padding: 20px;
  min-height: calc(100vh - 60px);
}

</style>
