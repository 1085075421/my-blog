<template>
  <div class="register-container">
    <el-card class="register-card">
      <template #header>
        <h2>注册</h2>
      </template>
      <el-form :model="form" :rules="rules" ref="formRef" label-width="80px">
        <el-form-item label="账号" prop="account">
          <el-input v-model="form.account" placeholder="请输入账号（英文+数字，3-20个字符）" />
          <div style="font-size: 12px; color: #999; margin-top: 4px;">账号用于登录，注册后不可修改</div>
        </el-form-item>
        <el-form-item label="昵称" prop="username">
          <el-input v-model="form.username" placeholder="请输入昵称（可选）" />
          <div style="font-size: 12px; color: #999; margin-top: 4px;">昵称可以随时修改，不填写则使用账号作为昵称</div>
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="form.email" placeholder="请输入邮箱" />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input
            v-model="form.password"
            type="password"
            placeholder="请输入密码（至少6个字符）"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleRegister" :loading="loading" style="width: 100%;">
            注册
          </el-button>
        </el-form-item>
        <el-form-item>
          <el-link type="primary" @click="$router.push('/login')">
            已有账号？立即登录
          </el-link>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import api from '../utils/api'

const router = useRouter()
const formRef = ref(null)
const loading = ref(false)
const form = ref({
  account: '',
  username: '',
  email: '',
  password: ''
})

const validateAccount = (rule, value, callback) => {
  if (!value) {
    callback(new Error('请输入账号'))
  } else if (value.length < 3 || value.length > 20) {
    callback(new Error('账号长度在3-20个字符之间'))
  } else if (!/^[a-zA-Z0-9]+$/.test(value)) {
    callback(new Error('账号只能包含英文字母和数字'))
  } else {
    callback()
  }
}

const rules = {
  account: [
    { required: true, validator: validateAccount, trigger: 'blur' }
  ],
  username: [
    { max: 20, message: '昵称长度不能超过20个字符', trigger: 'blur' }
  ],
  email: [
    { required: true, message: '请输入邮箱', trigger: 'blur' },
    { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, message: '密码长度至少6个字符', trigger: 'blur' }
  ]
}

const handleRegister = async () => {
  if (!formRef.value) return
  await formRef.value.validate(async (valid) => {
    if (valid) {
      loading.value = true
      try {
        await api.post('/auth/register', form.value)
        ElMessage.success('注册成功，请登录')
        
        // 清空表单
        form.value = {
          account: '',
          username: '',
          email: '',
          password: ''
        }
        
        // 跳转到登录页面
        setTimeout(() => {
          router.push('/login')
        }, 1000)
      } catch (error) {
        console.error('注册失败:', error)
        ElMessage.error(error.response?.data?.message || '注册失败')
      } finally {
        loading.value = false
      }
    }
  })
}
</script>

<style scoped>
.register-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: calc(100vh - 200px);
}

.register-card {
  width: 400px;
}
</style>
