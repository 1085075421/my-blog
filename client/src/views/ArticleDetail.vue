<template>
  <div class="article-detail">
    <div class="container">
      <el-card v-loading="loading">
        <div v-if="article">
          <div class="article-header">
            <h1>{{ article.title }}</h1>
            <div class="article-meta">
              <el-avatar 
                :src="article.author.avatar" 
                :size="40" 
                style="cursor: pointer;"
                @click="$router.push(`/user/${article.author.id}`)"
              />
              <div class="meta-info">
                <div 
                  class="author-name author-link" 
                  @click="$router.push(`/user/${article.author.id}`)"
                >
                  {{ article.author.username }}
                </div>
                <div class="meta-details">
                  <span>{{ formatDate(article.createdAt) }}</span>
                  <span>阅读 {{ article.viewCount }}</span>
                  <span>点赞 {{ article.likeCount }}</span>
                </div>
              </div>
              <div class="article-actions" v-if="user">
                <el-button
                  :type="isLiked ? 'primary' : 'default'"
                  :icon="Pointer"
                  @click="handleLike"
                >
                  {{ isLiked ? '已赞' : '点赞' }}
                </el-button>
                <el-button
                  :type="isFavorited ? 'warning' : 'default'"
                  :icon="Star"
                  @click="handleFavorite"
                >
                  {{ isFavorited ? '已收藏' : '收藏' }}
                </el-button>
                <el-button
                  v-if="user.userId === article.author.id"
                  type="danger"
                  @click="handleEdit"
                >
                  编辑
                </el-button>
              </div>
            </div>
          </div>
          <div class="article-tags">
            <el-tag
              v-if="article.category"
              class="category-tag"
            >
              {{ article.category.name }}
            </el-tag>
            <el-tag
              v-for="tag in article.tags"
              :key="tag.id"
              class="article-tag"
            >
              {{ tag.name }}
            </el-tag>
          </div>
          <div v-if="article.coverImage" class="article-cover-image">
            <el-image
              :src="article.coverImage"
              fit="contain"
              style="width: 100%; max-height: 400px; border-radius: 8px;"
              :preview-src-list="[article.coverImage]"
            />
          </div>
          <div class="article-content markdown-body" v-html="article.htmlContent || article.content"></div>
        </div>
      </el-card>

      <el-card style="margin-top: 20px;">
        <template #header>
          <span>评论 ({{ comments.length }})</span>
        </template>
        <div v-if="user" class="comment-form">
          <el-input
            v-model="commentContent"
            type="textarea"
            :rows="3"
            placeholder="写下你的评论..."
          />
          <el-button type="primary" @click="handleComment" style="margin-top: 10px;">
            发表评论
          </el-button>
        </div>
        <div v-else class="comment-login-tip">
          <el-link type="primary" @click="$router.push('/login')">登录后即可评论</el-link>
        </div>
        <div class="comments">
          <div v-for="comment in comments" :key="comment.id" class="comment-item">
            <el-avatar :src="comment.user.avatar" :size="32" />
            <div class="comment-content">
              <div class="comment-header">
                <span 
                  class="comment-author author-link" 
                  @click="$router.push(`/user/${comment.user.id}`)"
                >
                  {{ comment.user.username }}
                </span>
                <span class="comment-time">{{ formatDate(comment.createdAt) }}</span>
              </div>
              <div class="comment-text">{{ comment.content }}</div>
              <div class="comment-actions">
                <el-link type="primary" @click="replyToComment(comment.id)">回复</el-link>
              </div>
              <!-- 回复 -->
              <div v-if="replyingTo === comment.id" class="reply-form">
                <el-input
                  v-model="replyContent"
                  type="textarea"
                  :rows="2"
                  placeholder="写下你的回复..."
                />
                <div style="margin-top: 8px;">
                  <el-button size="small" @click="cancelReply">取消</el-button>
                  <el-button size="small" type="primary" @click="handleReply(comment.id)">
                    回复
                  </el-button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { Pointer, Star } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import api from '../utils/api'

const route = useRoute()
const router = useRouter()
const loading = ref(false)
const article = ref(null)
const comments = ref([])
const commentContent = ref('')
const replyContent = ref('')
const replyingTo = ref(null)
const isLiked = ref(false)
const isFavorited = ref(false)

const user = computed(() => {
  const userStr = localStorage.getItem('user')
  return userStr ? JSON.parse(userStr) : null
})

const loadArticle = async () => {
  loading.value = true
  try {
    article.value = await api.get(`/articles/${route.params.id}`)
    if (user.value) {
      checkLikeStatus()
      checkFavoriteStatus()
    }
  } catch (error) {
    ElMessage.error('加载文章失败')
  } finally {
    loading.value = false
  }
}

const loadComments = async () => {
  try {
    comments.value = await api.get(`/comments/article/${route.params.id}`)
  } catch (error) {
    console.error('加载评论失败:', error)
  }
}

const checkLikeStatus = async () => {
  try {
    const response = await api.get('/likes/check', {
      params: {
        articleId: route.params.id,
        userId: user.value.userId
      }
    })
    isLiked.value = response.isLiked
  } catch (error) {
    console.error('检查点赞状态失败:', error)
  }
}

const checkFavoriteStatus = async () => {
  try {
    const response = await api.get('/favorites/check', {
      params: {
        articleId: route.params.id,
        userId: user.value.userId
      }
    })
    isFavorited.value = response.isFavorited
  } catch (error) {
    console.error('检查收藏状态失败:', error)
  }
}

const handleLike = async () => {
  if (!user.value) {
    ElMessage.warning('请先登录')
    router.push('/login')
    return
  }
  try {
    const response = await api.post('/likes/toggle', {
      articleId: route.params.id,
      userId: user.value.userId
    })
    isLiked.value = response.isLiked
    if (article.value) {
      article.value.likeCount += response.isLiked ? 1 : -1
    }
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

const handleFavorite = async () => {
  if (!user.value) {
    ElMessage.warning('请先登录')
    router.push('/login')
    return
  }
  try {
    const response = await api.post('/favorites/toggle', {
      articleId: route.params.id,
      userId: user.value.userId
    })
    isFavorited.value = response.isFavorited
    ElMessage.success(response.isFavorited ? '收藏成功' : '取消收藏')
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

const handleComment = async () => {
  if (!commentContent.value.trim()) {
    ElMessage.warning('评论内容不能为空')
    return
  }
  try {
    await api.post('/comments', {
      articleId: route.params.id,
      userId: user.value.userId,
      content: commentContent.value
    })
    commentContent.value = ''
    ElMessage.success('评论成功')
    loadComments()
  } catch (error) {
    ElMessage.error('评论失败')
  }
}

const replyToComment = (commentId) => {
  replyingTo.value = commentId
  replyContent.value = ''
}

const cancelReply = () => {
  replyingTo.value = null
  replyContent.value = ''
}

const handleReply = async (parentId) => {
  if (!replyContent.value.trim()) {
    ElMessage.warning('回复内容不能为空')
    return
  }
  try {
    await api.post('/comments', {
      articleId: route.params.id,
      userId: user.value.userId,
      content: replyContent.value,
      parentId: parentId
    })
    cancelReply()
    ElMessage.success('回复成功')
    loadComments()
  } catch (error) {
    ElMessage.error('回复失败')
  }
}

const handleEdit = () => {
  router.push(`/editor/${route.params.id}`)
}

const formatDate = (dateString) => {
  const date = new Date(dateString)
  return date.toLocaleString('zh-CN')
}

onMounted(() => {
  loadArticle()
  loadComments()
})
</script>

<style scoped>
.article-header {
  margin-bottom: 20px;
}

.article-header h1 {
  margin-bottom: 16px;
  color: #333;
}

.article-meta {
  display: flex;
  align-items: center;
  gap: 12px;
}

.meta-info {
  flex: 1;
}

.author-name {
  font-weight: 600;
  margin-bottom: 4px;
}

.author-link {
  cursor: pointer;
  color: #409EFF;
  transition: color 0.3s;
}

.author-link:hover {
  color: #66b1ff;
  text-decoration: underline;
}

.meta-details {
  font-size: 12px;
  color: #999;
}

.meta-details span {
  margin-right: 16px;
}

.article-actions {
  display: flex;
  gap: 8px;
}

.article-tags {
  margin-bottom: 20px;
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.category-tag {
  padding: 6px 16px;
  border-radius: 20px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  font-size: 13px;
  box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
}

.article-tag {
  padding: 6px 14px;
  border-radius: 16px;
  border: 1px solid #e4e7ed;
  background: #f5f7fa;
  color: #606266;
  font-size: 13px;
  transition: all 0.3s;
}

.article-tag:hover {
  background: #409EFF;
  color: white;
  border-color: #409EFF;
}

.article-cover-image {
  margin-bottom: 20px;
}

.article-content {
  margin-top: 20px;
  padding: 20px 0;
}

.comment-form {
  margin-bottom: 20px;
}

.comment-login-tip {
  margin-bottom: 20px;
  text-align: center;
  padding: 20px;
  background: #f5f5f5;
  border-radius: 4px;
}

.comment-item {
  display: flex;
  gap: 12px;
  margin-bottom: 20px;
  padding-bottom: 20px;
  border-bottom: 1px solid #eee;
}

.comment-item:last-child {
  border-bottom: none;
}

.comment-content {
  flex: 1;
}

.comment-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 8px;
}

.comment-author {
  font-weight: 600;
}

.author-link {
  cursor: pointer;
  color: #409EFF;
  transition: color 0.3s;
}

.author-link:hover {
  color: #66b1ff;
  text-decoration: underline;
}

.author-name.author-link {
  display: inline-block;
}

.comment-time {
  font-size: 12px;
  color: #999;
}

.comment-text {
  margin-bottom: 8px;
  line-height: 1.6;
}

.reply-form {
  margin-top: 12px;
  padding: 12px;
  background: #f9f9f9;
  border-radius: 4px;
}
</style>
