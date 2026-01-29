<template>
  <div class="home">
    <div class="container">
      <el-row :gutter="20">
        <el-col :span="18">
          <div class="article-list">
            <div class="filter-bar">
              <div class="sort-selector">
                <span style="margin-right: 8px; color: #666;">排序方式：</span>
                <el-select
                  v-model="sortBy"
                  placeholder="选择排序方式"
                  style="width: 180px;"
                  @change="handleSortChange"
                >
                  <el-option label="最新发布" value="latest" />
                  <el-option label="点赞最多" value="likes" />
                  <el-option label="阅读最多" value="views" />
                  <el-option label="收藏最多" value="favorites" />
                </el-select>
              </div>
              <el-input
                v-model="searchKeyword"
                placeholder="搜索文章..."
                style="width: 300px; margin-left: auto;"
                @keyup.enter="handleSearch"
              >
                <template #prefix>
                  <el-icon><Search /></el-icon>
                </template>
              </el-input>
            </div>

            <div v-loading="loading" class="articles">
              <!-- 空状态提示 -->
              <el-empty v-if="!loading && articles.length === 0" description="暂无文章，快来发布第一篇文章吧！">
                <el-button type="primary" @click="goToLogin">登录后发布</el-button>
              </el-empty>

              <!-- 文章列表 -->
              <el-card
                v-for="article in articles"
                :key="article.id"
                class="article-card"
                @click="goToArticle(article.id)"
              >
                <div class="article-content-wrapper">
                  <div class="article-main">
                    <div class="article-header">
                      <h3>
                        <el-tag
                          v-if="article.pinned"
                          type="warning"
                          size="small"
                          effect="dark"
                          style="margin-right: 8px; vertical-align: middle;"
                        >
                          置顶
                        </el-tag>
                        {{ article.title }}
                      </h3>
                      <div class="article-meta">
                        <span 
                          class="author-link" 
                          @click.stop="$router.push(`/user/${article.author.id}`)"
                        >
                          {{ article.author.username }}
                        </span>
                        <span>{{ formatDate(article.createdAt) }}</span>
                      </div>
                    </div>
                    <div class="article-summary">{{ article.summary || '暂无摘要' }}</div>
                    <div class="article-footer">
                      <div class="article-tags-footer">
                        <el-tag
                          v-if="article.category"
                          class="category-tag-small"
                        >
                          {{ article.category.name }}
                        </el-tag>
                        <el-tag
                          v-for="tag in article.tags"
                          :key="tag.id"
                          class="article-tag-small"
                        >
                          {{ tag.name }}
                        </el-tag>
                      </div>
                      <div class="article-stats">
                        <span><el-icon><View /></el-icon> {{ article.viewCount }}</span>
                        <span><el-icon><Pointer /></el-icon> {{ article.likeCount }}</span>
                      </div>
                    </div>
                  </div>
                  <div v-if="article.coverImage" class="article-cover">
                    <el-image
                      :src="article.coverImage"
                      fit="cover"
                      style="width: 200px; height: 120px; border-radius: 4px;"
                    />
                  </div>
                </div>
              </el-card>

              <el-pagination
                v-if="articles.length > 0"
                v-model:current-page="currentPage"
                :page-size="pageSize"
                :total="total"
                layout="prev, pager, next"
                @current-change="loadArticles"
                style="margin-top: 20px; justify-content: center;"
              />
            </div>
          </div>
        </el-col>
        <el-col :span="6">
          <el-card>
            <template #header>
              <span>分类</span>
            </template>
            <div v-if="categories.length === 0" style="color: #999; text-align: center; padding: 20px;">
              暂无分类
            </div>
            <div v-else class="category-list">
              <div
                v-for="category in categories"
                :key="category.id"
                class="category-badge"
                @click="filterByCategory(category.id)"
              >
                {{ category.name }}
              </div>
            </div>
          </el-card>
          <el-card style="margin-top: 20px;">
            <template #header>
              <div style="display: flex; justify-content: space-between; align-items: center;">
                <span>热门标签</span>
                <el-button size="small" text @click="showAllTags = !showAllTags">
                  {{ showAllTags ? '显示热门' : '显示全部' }}
                </el-button>
              </div>
            </template>
            <div v-if="displayTags.length === 0" style="color: #999; text-align: center; padding: 20px;">
              暂无标签
            </div>
            <div v-else class="tags-list">
              <el-tag
                v-for="tag in displayTags"
                :key="tag.id"
                class="tag-badge"
                @click="filterByTag(tag.id)"
              >
                {{ tag.name }}
              </el-tag>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import { Search, View, Pointer } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import api from '../utils/api'

const router = useRouter()
const loading = ref(false)
const articles = ref([])
const categories = ref([])
const tags = ref([])
const popularTags = ref([])
const showAllTags = ref(false)
const sortBy = ref('latest')
const searchKeyword = ref('')
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)

const displayTags = computed(() => {
  return showAllTags.value ? tags.value : popularTags.value
})

const loadArticles = async () => {
  loading.value = true
  try {
    const response = await api.get('/articles', {
      params: {
        page: currentPage.value - 1,
        size: pageSize.value,
        sort: sortBy.value
      }
    })
    articles.value = response.content || []
    total.value = response.totalElements || 0
  } catch (error) {
    console.error('加载文章失败:', error)
    // 不显示错误消息，因为可能是数据库为空
  } finally {
    loading.value = false
  }
}

const loadCategories = async () => {
  try {
    const result = await api.get('/categories')
    categories.value = result || []
  } catch (error) {
    console.error('加载分类失败:', error)
  }
}

const loadTags = async () => {
  try {
    const result = await api.get('/tags')
    tags.value = result || []
  } catch (error) {
    console.error('加载标签失败:', error)
  }
}

const loadPopularTags = async () => {
  try {
    const result = await api.get('/tags', { params: { popular: true } })
    popularTags.value = result || []
  } catch (error) {
    console.error('加载热门标签失败:', error)
  }
}

const handleSortChange = () => {
  currentPage.value = 1
  loadArticles()
}

const handleSearch = async () => {
  if (!searchKeyword.value) {
    loadArticles()
    return
  }
  loading.value = true
  try {
    const response = await api.get('/articles/search', {
      params: {
        keyword: searchKeyword.value,
        page: currentPage.value - 1,
        size: pageSize.value
      }
    })
    articles.value = response.content || []
    total.value = response.totalElements || 0
  } catch (error) {
    console.error('搜索失败:', error)
    ElMessage.error('搜索失败')
  } finally {
    loading.value = false
  }
}

const filterByCategory = async (categoryId) => {
  loading.value = true
  try {
    const response = await api.get(`/articles/category/${categoryId}`, {
      params: {
        page: currentPage.value - 1,
        size: pageSize.value
      }
    })
    articles.value = response.content || []
    total.value = response.totalElements || 0
  } catch (error) {
    console.error('筛选失败:', error)
    ElMessage.error('筛选失败')
  } finally {
    loading.value = false
  }
}

const filterByTag = async (tagId) => {
  loading.value = true
  try {
    const response = await api.get(`/articles/tag/${tagId}`, {
      params: {
        page: currentPage.value - 1,
        size: pageSize.value
      }
    })
    articles.value = response.content || []
    total.value = response.totalElements || 0
  } catch (error) {
    console.error('筛选失败:', error)
    ElMessage.error('筛选失败')
  } finally {
    loading.value = false
  }
}

const goToArticle = (id) => {
  router.push(`/article/${id}`)
}

const formatDate = (dateString) => {
  const date = new Date(dateString)
  return date.toLocaleDateString('zh-CN')
}

onMounted(() => {
  loadArticles()
  loadCategories()
  loadTags()
  loadPopularTags()
})
</script>

<style scoped>
.article-list {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
}

.filter-bar {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
  gap: 16px;
}

.sort-selector {
  display: flex;
  align-items: center;
}

.article-card {
  margin-bottom: 20px;
  cursor: pointer;
  transition: box-shadow 0.3s;
}

.article-card:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.article-content-wrapper {
  display: flex;
  gap: 16px;
}

.article-main {
  flex: 1;
}

.article-cover {
  flex-shrink: 0;
}

.article-header h3 {
  margin-bottom: 8px;
  color: #333;
}

.article-meta {
  font-size: 12px;
  color: #999;
  margin-bottom: 12px;
}

.article-meta span {
  margin-right: 16px;
}

.article-summary {
  color: #666;
  margin-bottom: 12px;
  line-height: 1.6;
}

.article-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 8px;
}

.article-tags-footer {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  flex: 1;
}

.category-tag-small {
  padding: 4px 12px;
  border-radius: 16px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  font-size: 12px;
  box-shadow: 0 2px 6px rgba(102, 126, 234, 0.3);
}

.article-tag-small {
  padding: 4px 10px;
  border-radius: 12px;
  border: 1px solid #e4e7ed;
  background: #f5f7fa;
  color: #606266;
  font-size: 12px;
}

.article-stats {
  display: flex;
  gap: 16px;
  font-size: 12px;
  color: #999;
}

.article-stats span {
  display: flex;
  align-items: center;
  gap: 4px;
}

.category-list {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.category-badge {
  display: inline-block;
  padding: 6px 14px;
  border-radius: 16px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  cursor: pointer;
  transition: all 0.3s;
  font-size: 13px;
  box-shadow: 0 2px 6px rgba(102, 126, 234, 0.3);
  border: none;
}

.category-badge:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
}

.tags-list {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.tag-badge {
  padding: 6px 14px;
  border-radius: 16px;
  cursor: pointer;
  transition: all 0.3s;
  border: 1px solid #e4e7ed;
  background: #f5f7fa;
  color: #606266;
  font-size: 13px;
}

.tag-badge:hover {
  background: #409EFF;
  color: white;
  border-color: #409EFF;
  transform: translateY(-2px);
  box-shadow: 0 2px 8px rgba(64, 158, 255, 0.3);
}
</style>
