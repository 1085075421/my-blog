<template>
  <div class="admin-dashboard">
    <h2>数据统计</h2>
    
    <!-- 统计卡片 -->
    <el-row :gutter="20" style="margin-bottom: 20px;">
      <el-col :span="6">
        <el-card>
          <div class="stat-card">
            <div class="stat-icon" style="background: #409EFF;">
              <el-icon size="30"><User /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ statistics.totalUsers || 0 }}</div>
              <div class="stat-label">总用户数</div>
              <div class="stat-today">今日新增: {{ statistics.todayUsers || 0 }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card>
          <div class="stat-card">
            <div class="stat-icon" style="background: #67C23A;">
              <el-icon size="30"><Document /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ statistics.totalArticles || 0 }}</div>
              <div class="stat-label">总文章数</div>
              <div class="stat-today">今日新增: {{ statistics.todayArticles || 0 }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card>
          <div class="stat-card">
            <div class="stat-icon" style="background: #E6A23C;">
              <el-icon size="30"><ChatLineRound /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ statistics.totalComments || 0 }}</div>
              <div class="stat-label">总评论数</div>
              <div class="stat-today">今日新增: {{ statistics.todayComments || 0 }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card>
          <div class="stat-card">
            <div class="stat-icon" style="background: #F56C6C;">
              <el-icon size="30"><UserFilled /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ statistics.adminUsers || 0 }}</div>
              <div class="stat-label">管理员数</div>
              <div class="stat-today">普通用户: {{ statistics.normalUsers || 0 }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    
    <!-- 图表 -->
    <el-row :gutter="20">
      <el-col :span="12">
        <el-card>
          <template #header>
            <span>用户增长趋势（最近30天）</span>
          </template>
          <div ref="userGrowthChart" style="width: 100%; height: 300px;"></div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <template #header>
            <span>文章发布趋势（最近30天）</span>
          </template>
          <div ref="articlePublishChart" style="width: 100%; height: 300px;"></div>
        </el-card>
      </el-col>
    </el-row>
    
    <el-row style="margin-top: 20px;">
      <el-col :span="24">
        <el-card>
          <template #header>
            <span>分类文章统计</span>
          </template>
          <div ref="categoryChart" style="width: 100%; height: 400px;"></div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick } from 'vue'
import * as echarts from 'echarts'
import { User, Document, ChatLineRound, UserFilled } from '@element-plus/icons-vue'
import api from '../../utils/api'

const statistics = ref({})
const userGrowthChart = ref(null)
const articlePublishChart = ref(null)
const categoryChart = ref(null)

let userGrowthChartInstance = null
let articlePublishChartInstance = null
let categoryChartInstance = null

const loadStatistics = async () => {
  try {
    statistics.value = await api.get('/admin/statistics')
  } catch (error) {
    console.error('加载统计数据失败:', error)
  }
}

const loadUserGrowthTrend = async () => {
  try {
    const data = await api.get('/admin/statistics/user-growth')
    if (userGrowthChartInstance) {
      userGrowthChartInstance.setOption({
        title: { text: '用户增长趋势', left: 'center' },
        tooltip: { trigger: 'axis' },
        xAxis: {
          type: 'category',
          data: data.dates,
          axisLabel: { rotate: 45 }
        },
        yAxis: { type: 'value' },
        series: [{
          data: data.counts,
          type: 'line',
          smooth: true,
          areaStyle: {},
          itemStyle: { color: '#409EFF' }
        }]
      })
    }
  } catch (error) {
    console.error('加载用户增长趋势失败:', error)
  }
}

const loadArticlePublishTrend = async () => {
  try {
    const data = await api.get('/admin/statistics/article-publish')
    if (articlePublishChartInstance) {
      articlePublishChartInstance.setOption({
        title: { text: '文章发布趋势', left: 'center' },
        tooltip: { trigger: 'axis' },
        xAxis: {
          type: 'category',
          data: data.dates,
          axisLabel: { rotate: 45 }
        },
        yAxis: { type: 'value' },
        series: [{
          data: data.counts,
          type: 'bar',
          itemStyle: { color: '#67C23A' }
        }]
      })
    }
  } catch (error) {
    console.error('加载文章发布趋势失败:', error)
  }
}

const loadCategoryStatistics = async () => {
  try {
    const data = await api.get('/admin/statistics/category')
    if (categoryChartInstance) {
      categoryChartInstance.setOption({
        title: { text: '分类文章分布', left: 'center' },
        tooltip: { trigger: 'item' },
        legend: { orient: 'vertical', left: 'left' },
        series: [{
          type: 'pie',
          radius: '50%',
          data: data,
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
          }
        }]
      })
    }
  } catch (error) {
    console.error('加载分类统计失败:', error)
  }
}

onMounted(async () => {
  await loadStatistics()
  
  await nextTick()
  
  // 初始化图表
  if (userGrowthChart.value) {
    userGrowthChartInstance = echarts.init(userGrowthChart.value)
    await loadUserGrowthTrend()
  }
  
  if (articlePublishChart.value) {
    articlePublishChartInstance = echarts.init(articlePublishChart.value)
    await loadArticlePublishTrend()
  }
  
  if (categoryChart.value) {
    categoryChartInstance = echarts.init(categoryChart.value)
    await loadCategoryStatistics()
  }
  
  // 窗口大小改变时重新调整图表
  window.addEventListener('resize', () => {
    userGrowthChartInstance?.resize()
    articlePublishChartInstance?.resize()
    categoryChartInstance?.resize()
  })
})
</script>

<style scoped>
.admin-dashboard h2 {
  margin-bottom: 20px;
}

.stat-card {
  display: flex;
  align-items: center;
  gap: 16px;
}

.stat-icon {
  width: 60px;
  height: 60px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
}

.stat-info {
  flex: 1;
}

.stat-value {
  font-size: 28px;
  font-weight: bold;
  color: #303133;
  margin-bottom: 4px;
}

.stat-label {
  font-size: 14px;
  color: #909399;
  margin-bottom: 4px;
}

.stat-today {
  font-size: 12px;
  color: #67C23A;
}
</style>
