<template>
  <div class="hot-articles">
    <h2>热门文章排行</h2>
    
    <div class="sort-tabs">
      <el-radio-group v-model="sortType" @change="loadHotArticles">
        <el-radio-button label="score">综合排序</el-radio-button>
        <el-radio-button label="likes">按点赞数</el-radio-button>
        <el-radio-button label="views">按阅读数</el-radio-button>
        <el-radio-button label="favorites">按收藏数</el-radio-button>
      </el-radio-group>
    </div>
    
    <el-table :data="articles" v-loading="loading" style="width: 100%; margin-top: 20px;">
      <el-table-column type="index" label="排名" width="80">
        <template #default="{ $index }">
          <span :class="getRankClass($index + 1)">{{ $index + 1 }}</span>
        </template>
      </el-table-column>
      <el-table-column prop="title" label="标题" min-width="250" show-overflow-tooltip>
        <template #default="{ row }">
          <el-link @click="$router.push(`/article/${row.id}`)" type="primary">
            {{ row.title }}
          </el-link>
        </template>
      </el-table-column>
      <el-table-column prop="author.username" label="作者" width="120" />
      <el-table-column label="阅读" width="100" sortable>
        <template #default="{ row }">
          <span><el-icon><View /></el-icon> {{ row.viewCount || 0 }}</span>
        </template>
      </el-table-column>
      <el-table-column label="点赞" width="100" sortable>
        <template #default="{ row }">
          <span><el-icon><Pointer /></el-icon> {{ row.likeCount || 0 }}</span>
        </template>
      </el-table-column>
      <el-table-column label="收藏" width="100">
        <template #default="{ row }">
          <span><el-icon><Star /></el-icon> {{ getFavoriteCount(row) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="综合分数" width="120" v-if="sortType === 'score'">
        <template #default="{ row }">
          <el-tag type="success">{{ calculateScore(row) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="category.name" label="分类" width="120" />
      <el-table-column prop="createdAt" label="发布时间" width="180">
        <template #default="{ row }">
          {{ formatDate(row.createdAt) }}
        </template>
      </el-table-column>
    </el-table>
    
    <el-pagination
      v-model:current-page="currentPage"
      :page-size="pageSize"
      :total="total"
      layout="total, prev, pager, next"
      @current-change="loadHotArticles"
      style="margin-top: 20px; justify-content: center;"
    />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { View, Pointer, Star } from '@element-plus/icons-vue'
import api from '../../utils/api'

const articles = ref([])
const loading = ref(false)
const sortType = ref('score')
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)

const loadHotArticles = async () => {
  loading.value = true
  try {
    const endpoint = `/admin/articles/hot/${sortType.value}`
    const response = await api.get(endpoint, {
      params: {
        page: currentPage.value - 1,
        size: pageSize.value
      }
    })
    articles.value = response.content
    total.value = response.totalElements
  } catch (error) {
    ElMessage.error('加载热门文章失败')
  } finally {
    loading.value = false
  }
}

const getFavoriteCount = (article) => {
  return article.favorites ? article.favorites.length : 0
}

const calculateScore = (article) => {
  const likes = article.likeCount || 0
  const views = article.viewCount || 0
  const favorites = getFavoriteCount(article)
  return likes * 2 + views + favorites * 3
}

const getRankClass = (rank) => {
  if (rank === 1) return 'rank-first'
  if (rank === 2) return 'rank-second'
  if (rank === 3) return 'rank-third'
  return 'rank-normal'
}

const formatDate = (dateString) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  return date.toLocaleString('zh-CN')
}

onMounted(() => {
  loadHotArticles()
})
</script>

<style scoped>
.hot-articles {
  background: white;
  padding: 20px;
  border-radius: 8px;
}

.sort-tabs {
  margin-bottom: 20px;
}

.rank-first {
  color: #FFD700;
  font-weight: bold;
  font-size: 18px;
}

.rank-second {
  color: #C0C0C0;
  font-weight: bold;
  font-size: 16px;
}

.rank-third {
  color: #CD7F32;
  font-weight: bold;
  font-size: 16px;
}

.rank-normal {
  color: #606266;
}
</style>
