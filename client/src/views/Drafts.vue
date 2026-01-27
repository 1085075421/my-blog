<template>
  <div class="drafts">
    <div class="container">
      <el-card>
        <template #header>
          <div class="card-header">
            <h2>草稿箱</h2>
            <el-button type="primary" @click="$router.push('/editor')">新建文章</el-button>
          </div>
        </template>
        
        <el-empty v-if="!loading && drafts.length === 0" description="暂无草稿">
          <el-button type="primary" @click="$router.push('/editor')">立即创建</el-button>
        </el-empty>
        
        <div v-else>
          <el-table :data="drafts" style="width: 100%" v-loading="loading">
            <el-table-column prop="title" label="标题" min-width="200">
              <template #default="{ row }">
                <el-link 
                  type="primary" 
                  @click="$router.push(`/editor/${row.id}`)"
                  :underline="false"
                >
                  {{ row.title || '无标题' }}
                </el-link>
              </template>
            </el-table-column>
            <el-table-column prop="summary" label="摘要" min-width="250" show-overflow-tooltip />
            <el-table-column prop="category" label="分类" width="120">
              <template #default="{ row }">
                <span v-if="row.category">{{ row.category.name }}</span>
                <span v-else style="color: #999;">未分类</span>
              </template>
            </el-table-column>
            <el-table-column prop="updatedAt" label="更新时间" width="180">
              <template #default="{ row }">
                {{ formatDate(row.updatedAt) }}
              </template>
            </el-table-column>
            <el-table-column label="操作" width="200" fixed="right">
              <template #default="{ row }">
                <el-button 
                  type="primary" 
                  size="small" 
                  @click="$router.push(`/editor/${row.id}`)"
                >
                  编辑
                </el-button>
                <el-button 
                  type="success" 
                  size="small" 
                  @click="handlePublish(row)"
                  :loading="publishingId === row.id"
                >
                  发布
                </el-button>
                <el-button 
                  type="danger" 
                  size="small" 
                  @click="handleDelete(row)"
                >
                  删除
                </el-button>
              </template>
            </el-table-column>
          </el-table>
          
          <div class="pagination" v-if="total > pageSize">
            <el-pagination
              v-model:current-page="currentPage"
              v-model:page-size="pageSize"
              :page-sizes="[10, 20, 50]"
              :total="total"
              layout="total, sizes, prev, pager, next, jumper"
              @size-change="loadDrafts"
              @current-change="loadDrafts"
            />
          </div>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import api from '../utils/api'

const router = useRouter()
const drafts = ref([])
const loading = ref(false)
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)
const publishingId = ref(null)

const formatDate = (dateString) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  return date.toLocaleString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit'
  })
}

const loadDrafts = async () => {
  const user = JSON.parse(localStorage.getItem('user') || '{}')
  if (!user.userId) {
    ElMessage.warning('请先登录')
    router.push('/login')
    return
  }
  
  loading.value = true
  try {
    const response = await api.get(`/articles/drafts?userId=${user.userId}&page=${currentPage.value - 1}&size=${pageSize.value}`)
    drafts.value = response.content || []
    total.value = response.totalElements || 0
  } catch (error) {
    console.error('加载草稿失败:', error)
    ElMessage.error('加载草稿失败')
  } finally {
    loading.value = false
  }
}

const handlePublish = async (draft) => {
  try {
    await ElMessageBox.confirm(
      '确定要发布这篇草稿吗？发布后草稿将变为正式文章。',
      '确认发布',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }
    )
    
    publishingId.value = draft.id
    const user = JSON.parse(localStorage.getItem('user') || '{}')
    await api.post(`/articles/drafts/${draft.id}/publish?userId=${user.userId}`)
    ElMessage.success('发布成功')
    await loadDrafts()
  } catch (error) {
    if (error !== 'cancel') {
      console.error('发布失败:', error)
      ElMessage.error('发布失败')
    }
  } finally {
    publishingId.value = null
  }
}

const handleDelete = async (draft) => {
  try {
    await ElMessageBox.confirm(
      '确定要删除这篇草稿吗？删除后无法恢复。',
      '确认删除',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }
    )
    
    const user = JSON.parse(localStorage.getItem('user') || '{}')
    await api.delete(`/articles/${draft.id}?userId=${user.userId}`)
    ElMessage.success('删除成功')
    await loadDrafts()
  } catch (error) {
    if (error !== 'cancel') {
      console.error('删除失败:', error)
      ElMessage.error('删除失败')
    }
  }
}

onMounted(() => {
  loadDrafts()
})
</script>

<style scoped>
.drafts {
  min-height: calc(100vh - 200px);
}

.container {
  max-width: 1200px;
  margin: 0 auto;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-header h2 {
  margin: 0;
  font-size: 20px;
  font-weight: 500;
}

.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}
</style>
