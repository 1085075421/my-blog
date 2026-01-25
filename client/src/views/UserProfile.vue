<template>
  <div class="user-profile">
    <div class="container">
      <el-card v-loading="loading">
        <div v-if="profileUser" class="profile-header">
          <el-avatar :size="80" :src="profileUser.avatar" />
          <div class="profile-info">
            <div class="username-row">
              <h2>
                <span class="level-badge">{{ levelBadge }}</span>
                {{ profileUser.username }}
              </h2>
              <el-button
                v-if="isOwnProfile"
                size="small"
                @click="$router.push('/settings')"
              >
                设置
              </el-button>
            </div>
            <p v-if="profileUser.bio">{{ profileUser.bio }}</p>
            <div class="level-progress" v-if="levelInfo">
              <div class="level-text">
                <span>等级 {{ profileUser.level || 1 }}</span>
                <span style="margin-left: 16px;">经验值 {{ profileUser.experience || 0 }}</span>
              </div>
              <el-progress
                :percentage="levelInfo.progress || 0"
                :color="getProgressColor(profileUser.level || 1)"
                :stroke-width="8"
                style="margin-top: 8px;"
              />
            </div>
            <div class="profile-stats">
              <span @click="activeTab = 'articles'" style="cursor: pointer;">
                文章 {{ articleCount }}
              </span>
              <span @click="activeTab = 'following'" style="cursor: pointer;">
                关注 {{ followingCount }}
              </span>
              <span @click="activeTab = 'followers'" style="cursor: pointer;">
                粉丝 {{ followersCount }}
              </span>
              <span v-if="isOwnProfile" @click="activeTab = 'favorites'" style="cursor: pointer;">
                收藏 {{ favoriteCount }}
              </span>
            </div>
            <div v-if="currentUser && currentUser.userId !== profileUser.id" class="follow-btn">
              <el-button
                :type="isFollowing ? 'default' : 'primary'"
                @click="handleFollow"
              >
                {{ isFollowing ? '已关注' : '关注' }}
              </el-button>
            </div>
          </div>
        </div>
      </el-card>

      <el-card style="margin-top: 20px;">
        <el-tabs v-model="activeTab" @tab-change="handleTabChange">
          <el-tab-pane label="文章" name="articles">
            <div v-loading="articlesLoading">
              <el-card
                v-for="article in articles"
                :key="article.id"
                class="article-card"
                @click="$router.push(`/article/${article.id}`)"
              >
                <div class="article-content-wrapper">
                  <div class="article-main">
                    <h3>{{ article.title }}</h3>
                    <div class="article-meta">
                      <span>{{ formatDate(article.createdAt) }}</span>
                      <span>阅读 {{ article.viewCount }}</span>
                      <span>点赞 {{ article.likeCount }}</span>
                    </div>
                  </div>
                  <div v-if="article.coverImage" class="article-cover">
                    <el-image
                      :src="article.coverImage"
                      fit="cover"
                      style="width: 120px; height: 80px; border-radius: 4px;"
                    />
                  </div>
                </div>
              </el-card>
              <el-empty v-if="!articlesLoading && articles.length === 0" description="暂无文章" />
            </div>
          </el-tab-pane>
          
          <el-tab-pane label="关注" name="following">
            <div v-loading="followingLoading">
              <div v-if="following.length === 0" class="empty-state">
                <el-empty description="暂无关注" />
              </div>
              <div v-else class="user-list">
                <el-card
                  v-for="user in following"
                  :key="user.id"
                  class="user-card"
                  @click="$router.push(`/user/${user.id}`)"
                >
                  <el-avatar :src="user.avatar" :size="50" />
                  <div class="user-info">
                    <div class="username">{{ user.username }}</div>
                    <div class="user-bio" v-if="user.bio">{{ user.bio }}</div>
                  </div>
                </el-card>
              </div>
            </div>
          </el-tab-pane>
          
          <el-tab-pane label="粉丝" name="followers">
            <div v-loading="followersLoading">
              <div v-if="followers.length === 0" class="empty-state">
                <el-empty description="暂无粉丝" />
              </div>
              <div v-else class="user-list">
                <el-card
                  v-for="user in followers"
                  :key="user.id"
                  class="user-card"
                  @click="$router.push(`/user/${user.id}`)"
                >
                  <el-avatar :src="user.avatar" :size="50" />
                  <div class="user-info">
                    <div class="username">{{ user.username }}</div>
                    <div class="user-bio" v-if="user.bio">{{ user.bio }}</div>
                  </div>
                </el-card>
              </div>
            </div>
          </el-tab-pane>
          
          <el-tab-pane v-if="isOwnProfile" label="收藏" name="favorites">
            <div v-loading="favoritesLoading">
              <el-card
                v-for="favorite in favorites"
                :key="favorite.id"
                class="article-card"
                @click="$router.push(`/article/${favorite.article.id}`)"
              >
                <div class="article-content-wrapper">
                  <div class="article-main">
                    <h3>{{ favorite.article.title }}</h3>
                    <div class="article-meta">
                      <span>作者: {{ favorite.article.author.username }}</span>
                      <span>{{ formatDate(favorite.article.createdAt) }}</span>
                      <span>阅读 {{ favorite.article.viewCount }}</span>
                      <span>点赞 {{ favorite.article.likeCount }}</span>
                    </div>
                  </div>
                  <div v-if="favorite.article.coverImage" class="article-cover">
                    <el-image
                      :src="favorite.article.coverImage"
                      fit="cover"
                      style="width: 120px; height: 80px; border-radius: 4px;"
                    />
                  </div>
                </div>
              </el-card>
              <el-empty v-if="!favoritesLoading && favorites.length === 0" description="暂无收藏" />
            </div>
          </el-tab-pane>
        </el-tabs>
      </el-card>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import api from '../utils/api'

const route = useRoute()
const loading = ref(false)
const articlesLoading = ref(false)
const followingLoading = ref(false)
const followersLoading = ref(false)
const favoritesLoading = ref(false)
const profileUser = ref(null)
const articles = ref([])
const following = ref([])
const followers = ref([])
const favorites = ref([])
const articleCount = ref(0)
const followingCount = ref(0)
const followersCount = ref(0)
const favoriteCount = ref(0)
const isFollowing = ref(false)
const activeTab = ref('articles')
const levelInfo = ref(null)

const currentUser = computed(() => {
  const userStr = localStorage.getItem('user')
  return userStr ? JSON.parse(userStr) : null
})

const isOwnProfile = computed(() => {
  return currentUser.value && currentUser.value.userId == route.params.id
})

const levelBadge = computed(() => {
  if (!profileUser.value) return '🌱'
  const level = profileUser.value.level || 1
  const badges = {
    1: '🌱', 2: '🌿', 3: '🍀', 4: '🌳', 5: '🌲',
    6: '⭐', 7: '🌟', 8: '💫', 9: '✨', 10: '👑'
  }
  return badges[level] || '🌱'
})

const getProgressColor = (level) => {
  const colors = [
    '#67C23A', '#E6A23C', '#F56C6C', '#409EFF', '#909399',
    '#67C23A', '#E6A23C', '#F56C6C', '#409EFF', '#FFD700'
  ]
  return colors[level - 1] || '#409EFF'
}

const loadUser = async () => {
  loading.value = true
  try {
    profileUser.value = await api.get(`/users/${route.params.id}`)
    followingCount.value = profileUser.value.following?.length || 0
    followersCount.value = profileUser.value.followers?.length || 0
    if (currentUser.value && currentUser.value.userId !== route.params.id) {
      checkFollowStatus()
    }
    // 加载等级信息
    try {
      const info = await api.get(`/users/${route.params.id}/level-info`)
      levelInfo.value = info
    } catch (error) {
      console.error('加载等级信息失败:', error)
    }
  } catch (error) {
    ElMessage.error('加载用户信息失败')
  } finally {
    loading.value = false
  }
}

const loadArticles = async () => {
  articlesLoading.value = true
  try {
    const response = await api.get(`/articles/user/${route.params.id}`, {
      params: {
        page: 0,
        size: 20
      }
    })
    articles.value = response.content
    articleCount.value = response.totalElements
  } catch (error) {
    console.error('加载文章失败:', error)
  } finally {
    articlesLoading.value = false
  }
}

const loadFollowing = async () => {
  followingLoading.value = true
  try {
    const followingList = await api.get(`/users/${route.params.id}/following`)
    following.value = Array.isArray(followingList) ? followingList : Array.from(followingList)
  } catch (error) {
    console.error('加载关注列表失败:', error)
  } finally {
    followingLoading.value = false
  }
}

const loadFollowers = async () => {
  followersLoading.value = true
  try {
    const followersList = await api.get(`/users/${route.params.id}/followers`)
    followers.value = Array.isArray(followersList) ? followersList : Array.from(followersList)
  } catch (error) {
    console.error('加载粉丝列表失败:', error)
  } finally {
    followersLoading.value = false
  }
}

const loadFavorites = async () => {
  if (!isOwnProfile.value) return
  favoritesLoading.value = true
  try {
    const response = await api.get(`/favorites/user/${route.params.id}`, {
      params: {
        page: 0,
        size: 20
      }
    })
    favorites.value = response.content || []
    favoriteCount.value = response.totalElements || 0
  } catch (error) {
    console.error('加载收藏列表失败:', error)
  } finally {
    favoritesLoading.value = false
  }
}

const handleTabChange = (tabName) => {
  if (tabName === 'following') {
    loadFollowing()
  } else if (tabName === 'followers') {
    loadFollowers()
  } else if (tabName === 'favorites') {
    loadFavorites()
  } else if (tabName === 'articles') {
    loadArticles()
  }
}

const checkFollowStatus = async () => {
  if (!currentUser.value) return
  try {
    const response = await api.get('/follows/check', {
      params: {
        followerId: currentUser.value.userId,
        followingId: route.params.id
      }
    })
    isFollowing.value = response.isFollowing
  } catch (error) {
    console.error('检查关注状态失败:', error)
  }
}

const handleFollow = async () => {
  if (!currentUser.value) {
    ElMessage.warning('请先登录')
    return
  }
  try {
    const response = await api.post('/follows/toggle', {
      followerId: currentUser.value.userId,
      followingId: route.params.id
    })
    isFollowing.value = response.isFollowing
    ElMessage.success(response.isFollowing ? '关注成功' : '取消关注')
    // 更新关注数
    if (response.isFollowing) {
      followingCount.value++
    } else {
      followingCount.value = Math.max(0, followingCount.value - 1)
    }
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

const formatDate = (dateString) => {
  const date = new Date(dateString)
  return date.toLocaleDateString('zh-CN')
}

onMounted(() => {
  loadUser()
  loadArticles()
})
</script>

<style scoped>
.profile-header {
  display: flex;
  gap: 20px;
  align-items: center;
}

.profile-info {
  flex: 1;
}

.profile-info h2 {
  margin-bottom: 8px;
  display: flex;
  align-items: center;
  gap: 8px;
}

.username-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
}

.level-badge {
  font-size: 24px;
  line-height: 1;
}

.level-progress {
  margin: 12px 0;
  padding: 12px;
  background: #f5f7fa;
  border-radius: 8px;
}

.level-text {
  display: flex;
  font-size: 14px;
  color: #666;
}

.profile-stats {
  margin-top: 12px;
  display: flex;
  gap: 20px;
  color: #666;
}

.profile-stats span {
  transition: color 0.3s;
}

.profile-stats span:hover {
  color: #409EFF;
}

.follow-btn {
  margin-top: 12px;
}

.article-card {
  margin-bottom: 16px;
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

.article-main h3 {
  margin-bottom: 8px;
}

.article-cover {
  flex-shrink: 0;
}

.article-meta {
  font-size: 12px;
  color: #999;
}

.article-meta span {
  margin-right: 16px;
}

.user-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.user-card {
  display: flex;
  align-items: center;
  gap: 16px;
  cursor: pointer;
  transition: box-shadow 0.3s;
}

.user-card:hover {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.user-info {
  flex: 1;
}

.username {
  font-weight: 600;
  margin-bottom: 4px;
}

.user-bio {
  font-size: 12px;
  color: #999;
}

.empty-state {
  padding: 40px 0;
}
</style>
