import { createRouter, createWebHistory } from 'vue-router'
import { ElMessage } from 'element-plus'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Register from '../views/Register.vue'
import ArticleDetail from '../views/ArticleDetail.vue'
import Editor from '../views/Editor.vue'
import UserProfile from '../views/UserProfile.vue'
import NotFound from '../views/NotFound.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/register',
    name: 'Register',
    component: Register
  },
  {
    path: '/article/:id',
    name: 'ArticleDetail',
    component: ArticleDetail
  },
  {
    path: '/editor',
    name: 'Editor',
    component: Editor
  },
  {
    path: '/editor/:id',
    name: 'EditArticle',
    component: Editor
  },
  {
    path: '/user/:id',
    name: 'UserProfile',
    component: UserProfile
  },
  {
    path: '/settings',
    name: 'UserSettings',
    component: () => import('../views/UserSettings.vue')
  },
  {
    path: '/admin',
    component: () => import('../views/admin/AdminLayout.vue'),
    meta: { requiresAuth: true, requiresAdmin: true },
    children: [
      {
        path: 'dashboard',
        name: 'AdminDashboard',
        component: () => import('../views/admin/AdminDashboard.vue')
      },
      {
        path: 'users',
        name: 'UserManagement',
        component: () => import('../views/admin/UserManagement.vue')
      },
      {
        path: 'articles',
        name: 'ArticleManagement',
        component: () => import('../views/admin/ArticleManagement.vue')
      },
      {
        path: 'hot-articles',
        name: 'HotArticles',
        component: () => import('../views/admin/HotArticles.vue')
      }
    ]
  },
  {
    path: '/:pathMatch(.*)*',
    name: 'NotFound',
    component: NotFound
  }
]

const router = createRouter({
  history: createWebHistory('/my-blog'),  // 统一使用 /my-blog 路径
  routes
})

// 路由守卫：检查管理员权限
router.beforeEach((to, from, next) => {
  // 如果是后台管理路由，需要检查权限
  if (to.path.startsWith('/admin')) {
    const token = localStorage.getItem('token')
    const userInfo = localStorage.getItem('user')
    
    if (!token || !userInfo) {
      // 未登录，跳转到登录页
      next('/login')
      return
    }
    
    try {
      const user = JSON.parse(userInfo)
      if (user.role !== 'ADMIN') {
        // 不是管理员，跳转到首页并提示
        ElMessage.error('您没有权限访问后台管理')
        next('/')
        return
      }
    } catch (e) {
      // 解析失败，跳转到登录页
      next('/login')
      return
    }
  }
  
  next()
})

// 路由错误处理
router.onError((error) => {
  console.error('路由错误:', error)
})

export default router
