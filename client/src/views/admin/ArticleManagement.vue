<template>
  <div class="article-management">
    <div class="header">
      <h2>文章管理</h2>
      <el-input
        v-model="keyword"
        placeholder="搜索文章（标题/内容）"
        style="width: 300px;"
        clearable
        @clear="loadArticles"
        @keyup.enter="loadArticles"
      >
        <template #prefix>
          <el-icon><Search /></el-icon>
        </template>
      </el-input>
    </div>
    
    <el-table :data="articles" v-loading="loading" style="width: 100%">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="title" label="标题" min-width="200" show-overflow-tooltip />
      <el-table-column prop="author.username" label="作者" width="120" />
      <el-table-column prop="viewCount" label="阅读" width="80" />
      <el-table-column prop="likeCount" label="点赞" width="80" />
      <el-table-column prop="category.name" label="分类" width="120" />
      <el-table-column prop="createdAt" label="发布时间" width="180">
        <template #default="{ row }">
          {{ formatDate(row.createdAt) }}
        </template>
      </el-table-column>
      <el-table-column label="置顶" width="80" align="center">
        <template #default="{ row }">
          <el-tag v-if="row.pinned" type="warning" size="small">置顶</el-tag>
          <span v-else style="color: #999;">-</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="250" fixed="right">
        <template #default="{ row }">
          <el-button
            size="small"
            type="primary"
            @click="$router.push(`/article/${row.id}`)"
          >
            查看
          </el-button>
          <el-button
            size="small"
            :type="row.pinned ? 'warning' : 'success'"
            @click="handleTogglePin(row)"
          >
            {{ row.pinned ? '取消置顶' : '置顶' }}
          </el-button>
          <el-button
            size="small"
            type="danger"
            @click="handleDelete(row)"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <el-pagination
      v-model:current-page="currentPage"
      :page-size="pageSize"
      :total="total"
      layout="total, prev, pager, next"
      @current-change="loadArticles"
      style="margin-top: 20px; justify-content: center;"
    />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Search } from '@element-plus/icons-vue'
import api from '../../utils/api'

const articles = ref([])
const loading = ref(false)
const keyword = ref('')
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)

const loadArticles = async () => {
  loading.value = true
  try {
    const response = await api.get('/admin/articles', {
      params: {
        page: currentPage.value - 1,
        size: pageSize.value,
        keyword: keyword.value || undefined
      }
    })
    articles.value = response.content
    total.value = response.totalElements
  } catch (error) {
    console.error('加载文章列表失败:', error)
    const errorMsg = error.response?.data?.error || error.message || '加载文章列表失败'
    ElMessage.error(errorMsg)
    // 如果是403错误，可能是权限问题
    if (error.response?.status === 403) {
      ElMessage.error('您没有权限访问此功能，请确认您已登录管理员账号')
    }
  } finally {
    loading.value = false
  }
}

const handleDelete = async (article) => {
  try {
    await ElMessageBox.confirm(
      `确定要删除文章 "${article.title}" 吗？此操作不可恢复！`,
      '警告',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }
    )
    await api.delete(`/admin/articles/${article.id}`)
    ElMessage.success('删除成功')
    loadArticles()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('删除失败')
    }
  }
}

const handleTogglePin = async (article) => {
  try {
    await api.put(`/articles/${article.id}/pin`)
    ElMessage.success(article.pinned ? '已取消置顶' : '已置顶')
    loadArticles()
  } catch (error) {
    console.error('置顶操作失败:', error)
    const errorMsg = error.response?.data?.error || error.message || '操作失败'
    if (error.response?.status === 403) {
      ElMessage.error('只有管理员可以置顶文章')
    } else {
      ElMessage.error(errorMsg)
    }
  }
}

const formatDate = (dateString) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  return date.toLocaleString('zh-CN')
}

onMounted(() => {
  loadArticles()
})
</script>

<style scoped>
.article-management {
  background: white;
  padding: 20px;
  border-radius: 8px;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.header h2 {
  margin: 0;
}
</style>
