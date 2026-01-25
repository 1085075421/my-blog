<template>
  <div class="user-settings">
    <div class="container">
      <el-card>
        <template #header>
          <h2>个人设置</h2>
        </template>
        
        <el-tabs v-model="activeTab">
          <el-tab-pane label="基本信息" name="profile">
            <el-form :model="profileForm" label-width="100px" style="max-width: 600px;">
              <el-form-item label="账号">
                <el-input v-model="profileForm.account" disabled placeholder="账号不可修改" />
                <div style="font-size: 12px; color: #999; margin-top: 4px;">账号用于登录，注册后不可修改</div>
              </el-form-item>
              <el-form-item label="昵称">
                <el-input v-model="profileForm.username" placeholder="请输入昵称" />
              </el-form-item>
              <el-form-item label="头像URL">
                <div style="display: flex; gap: 12px; align-items: flex-start;">
                  <el-input v-model="profileForm.avatar" placeholder="输入头像图片URL" />
                  <el-image
                    v-if="profileForm.avatar"
                    :src="profileForm.avatar"
                    style="width: 80px; height: 80px; border-radius: 50%;"
                    fit="cover"
                  />
                </div>
              </el-form-item>
              <el-form-item label="个人简介">
                <el-input
                  v-model="profileForm.bio"
                  type="textarea"
                  :rows="3"
                  placeholder="介绍一下自己吧..."
                />
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="handleUpdateProfile" :loading="saving">
                  保存修改
                </el-button>
              </el-form-item>
            </el-form>
          </el-tab-pane>
          
          <el-tab-pane label="修改密码" name="password">
            <el-form :model="passwordForm" :rules="passwordRules" ref="passwordFormRef" label-width="100px" style="max-width: 600px;">
              <el-form-item label="旧密码" prop="oldPassword">
                <el-input
                  v-model="passwordForm.oldPassword"
                  type="password"
                  placeholder="请输入当前密码"
                  show-password
                />
              </el-form-item>
              <el-form-item label="新密码" prop="newPassword">
                <el-input
                  v-model="passwordForm.newPassword"
                  type="password"
                  placeholder="请输入新密码（至少6个字符）"
                  show-password
                />
              </el-form-item>
              <el-form-item label="确认密码" prop="confirmPassword">
                <el-input
                  v-model="passwordForm.confirmPassword"
                  type="password"
                  placeholder="请再次输入新密码"
                  show-password
                />
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="handleChangePassword" :loading="changingPassword">
                  修改密码
                </el-button>
              </el-form-item>
            </el-form>
          </el-tab-pane>
          
          <el-tab-pane label="等级信息" name="level">
            <div class="level-info">
              <div class="level-display">
                <div class="level-badge-large">
                  {{ levelInfo.badge }}
                </div>
                <div class="level-details">
                  <h3>等级 {{ levelInfo.level }}</h3>
                  <p>经验值：{{ levelInfo.experience }} / {{ levelInfo.nextLevelExp }}</p>
                  <p>今日已获得：{{ levelInfo.dailyExperience }} / 100</p>
                  <el-progress
                    :percentage="levelInfo.progress"
                    :color="getProgressColor(levelInfo.level)"
                    :stroke-width="20"
                    style="margin-top: 16px;"
                  />
                </div>
              </div>
              <div class="experience-rules">
                <h4>经验值获取规则</h4>
                <ul>
                  <li>发布文章：+10 经验</li>
                  <li>发表评论：+3 经验</li>
                  <li>点赞文章：+2 经验</li>
                  <li>收藏文章：+2 经验</li>
                  <li>每日经验上限：100 点</li>
                </ul>
              </div>
            </div>
          </el-tab-pane>
        </el-tabs>
      </el-card>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import api from '../utils/api'

const router = useRouter()
const activeTab = ref('profile')
const saving = ref(false)
const changingPassword = ref(false)
const passwordFormRef = ref(null)

const currentUser = computed(() => {
  const userStr = localStorage.getItem('user')
  return userStr ? JSON.parse(userStr) : null
})

const profileForm = ref({
  account: '',
  username: '',
  avatar: '',
  bio: ''
})

const passwordForm = ref({
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
})

const levelInfo = ref({
  level: 1,
  experience: 0,
  dailyExperience: 0,
  badge: '🌱',
  nextLevelExp: 10,
  progress: 0
})

const passwordRules = {
  oldPassword: [{ required: true, message: '请输入旧密码', trigger: 'blur' }],
  newPassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { min: 6, message: '密码长度至少6个字符', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认新密码', trigger: 'blur' },
    {
      validator: (rule, value, callback) => {
        if (value !== passwordForm.value.newPassword) {
          callback(new Error('两次输入的密码不一致'))
        } else {
          callback()
        }
      },
      trigger: 'blur'
    }
  ]
}

const loadUserProfile = async () => {
  if (!currentUser.value) {
    router.push('/login')
    return
  }
  try {
    const user = await api.get(`/users/${currentUser.value.userId}`)
    profileForm.value = {
      account: user.account || currentUser.value.account || '',
      username: user.username || '',
      avatar: user.avatar || '',
      bio: user.bio || ''
    }
  } catch (error) {
    ElMessage.error('加载用户信息失败')
  }
}

const loadLevelInfo = async () => {
  if (!currentUser.value) return
  try {
    const info = await api.get(`/users/${currentUser.value.userId}/level-info`)
    levelInfo.value = info
  } catch (error) {
    console.error('加载等级信息失败:', error)
  }
}

const handleUpdateProfile = async () => {
  if (!currentUser.value) return
  saving.value = true
  try {
    const updated = await api.put(`/users/${currentUser.value.userId}/profile`, profileForm.value)
    // 更新本地存储的用户信息
    const userStr = localStorage.getItem('user')
    if (userStr) {
      const user = JSON.parse(userStr)
      user.username = updated.username
      user.avatar = updated.avatar
      user.account = updated.account
      localStorage.setItem('user', JSON.stringify(user))
    }
    ElMessage.success('修改成功')
  } catch (error) {
    ElMessage.error(error.response?.data?.message || '修改失败')
  } finally {
    saving.value = false
  }
}

const handleChangePassword = async () => {
  if (!passwordFormRef.value) return
  await passwordFormRef.value.validate(async (valid) => {
    if (valid) {
      changingPassword.value = true
      try {
        await api.put(`/users/${currentUser.value.userId}/password`, {
          oldPassword: passwordForm.value.oldPassword,
          newPassword: passwordForm.value.newPassword
        })
        ElMessage.success('密码修改成功')
        passwordForm.value = {
          oldPassword: '',
          newPassword: '',
          confirmPassword: ''
        }
      } catch (error) {
        ElMessage.error(error.response?.data?.message || '密码修改失败')
      } finally {
        changingPassword.value = false
      }
    }
  })
}

const getProgressColor = (level) => {
  const colors = [
    '#67C23A', '#E6A23C', '#F56C6C', '#409EFF', '#909399',
    '#67C23A', '#E6A23C', '#F56C6C', '#409EFF', '#FFD700'
  ]
  return colors[level - 1] || '#409EFF'
}

onMounted(() => {
  loadUserProfile()
  loadLevelInfo()
})
</script>

<style scoped>
.user-settings {
  min-height: calc(100vh - 200px);
}

.level-info {
  max-width: 600px;
}

.level-display {
  display: flex;
  gap: 24px;
  align-items: center;
  padding: 24px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 12px;
  color: white;
  margin-bottom: 24px;
}

.level-badge-large {
  font-size: 64px;
  line-height: 1;
}

.level-details h3 {
  margin-bottom: 8px;
  font-size: 24px;
}

.level-details p {
  margin: 4px 0;
  opacity: 0.9;
}

.experience-rules {
  background: #f5f7fa;
  padding: 20px;
  border-radius: 8px;
}

.experience-rules h4 {
  margin-bottom: 12px;
  color: #333;
}

.experience-rules ul {
  list-style: none;
  padding: 0;
}

.experience-rules li {
  padding: 8px 0;
  color: #666;
  border-bottom: 1px solid #e4e7ed;
}

.experience-rules li:last-child {
  border-bottom: none;
}
</style>
