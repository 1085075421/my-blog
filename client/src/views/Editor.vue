<template>
  <div class="editor">
    <div class="container">
      <el-card>
        <el-form :model="form" label-width="80px">
          <el-form-item label="标题" required>
            <el-input v-model="form.title" placeholder="请输入文章标题" />
          </el-form-item>
          <el-form-item label="封面图">
            <div style="display: flex; gap: 12px; align-items: flex-start;">
              <el-input
                v-model="form.coverImage"
                placeholder="输入封面图URL（可选）"
                style="flex: 1;"
              />
              <el-image
                v-if="form.coverImage"
                :src="form.coverImage"
                style="width: 120px; height: 80px; border-radius: 4px;"
                fit="cover"
                :preview-src-list="[form.coverImage]"
              />
            </div>
            <div style="font-size: 12px; color: #999; margin-top: 4px;">
              提示：可以输入图片URL，或使用图床服务上传图片后粘贴URL
            </div>
          </el-form-item>
          <el-form-item label="分类">
            <div style="display: flex; gap: 8px; width: 100%;">
              <el-select
                v-model="form.categoryId"
                placeholder="选择分类"
                clearable
                style="flex: 1;"
              >
                <el-option
                  v-for="category in categories"
                  :key="category.id"
                  :label="category.name"
                  :value="category.id"
                />
              </el-select>
              <el-button @click="showCreateCategory = true">新建分类</el-button>
            </div>
          </el-form-item>
          <el-form-item label="标签">
            <el-select
              v-model="form.tags"
              multiple
              filterable
              allow-create
              placeholder="选择或输入标签"
              style="width: 100%;"
            >
              <el-option
                v-for="tag in allTags"
                :key="tag.id"
                :label="tag.name"
                :value="tag.name"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="摘要">
            <el-input
              v-model="form.summary"
              type="textarea"
              :rows="2"
              placeholder="文章摘要（可选）"
            />
          </el-form-item>
          <el-form-item label="内容" required>
            <el-tabs v-model="activeTab">
              <el-tab-pane label="编辑" name="edit">
                <el-input
                  v-model="form.content"
                  type="textarea"
                  :rows="20"
                  placeholder="使用Markdown格式编写文章..."
                />
              </el-tab-pane>
              <el-tab-pane label="预览" name="preview">
                <div class="markdown-body" v-html="htmlContent"></div>
              </el-tab-pane>
            </el-tabs>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="handleSave" :loading="saving">
              {{ isDraft ? '发布' : (isEdit ? '更新' : '发布') }}
            </el-button>
            <el-button @click="handleSaveDraft" :loading="savingDraft">
              {{ isDraft ? '保存草稿' : '保存为草稿' }}
            </el-button>
            <el-button @click="$router.push('/')">取消</el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </div>

    <!-- 创建分类对话框 -->
    <el-dialog v-model="showCreateCategory" title="新建分类" width="400px">
      <el-form :model="newCategory" label-width="80px">
        <el-form-item label="分类名称" required>
          <el-input v-model="newCategory.name" placeholder="请输入分类名称" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input
            v-model="newCategory.description"
            type="textarea"
            :rows="2"
            placeholder="分类描述（可选）"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showCreateCategory = false">取消</el-button>
        <el-button type="primary" @click="handleCreateCategory" :loading="creatingCategory">
          创建
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { marked } from 'marked'
import api from '../utils/api'

const route = useRoute()
const router = useRouter()
const saving = ref(false)
const savingDraft = ref(false)
const activeTab = ref('edit')
const categories = ref([])
const allTags = ref([])
const showCreateCategory = ref(false)
const creatingCategory = ref(false)
const isDraft = ref(false)
const currentDraftId = ref(null)
const newCategory = ref({
  name: '',
  description: ''
})

const form = ref({
  title: '',
  content: '',
  summary: '',
  coverImage: '',
  categoryId: null,
  tags: []
})

const isEdit = computed(() => !!route.params.id)

const htmlContent = computed(() => {
  if (!form.value.content) return ''
  return marked(form.value.content)
})

const loadCategories = async () => {
  try {
    categories.value = await api.get('/categories')
  } catch (error) {
    console.error('加载分类失败:', error)
  }
}

const loadTags = async () => {
  try {
    allTags.value = await api.get('/tags')
  } catch (error) {
    console.error('加载标签失败:', error)
  }
}

const handleCreateCategory = async () => {
  if (!newCategory.value.name.trim()) {
    ElMessage.warning('请输入分类名称')
    return
  }
  creatingCategory.value = true
  try {
    const category = await api.post('/categories', {
      name: newCategory.value.name.trim(),
      description: newCategory.value.description || ''
    })
    categories.value.push(category)
    form.value.categoryId = category.id
    showCreateCategory.value = false
    newCategory.value = { name: '', description: '' }
    ElMessage.success('分类创建成功')
  } catch (error) {
    ElMessage.error(error.response?.data?.message || '创建分类失败')
  } finally {
    creatingCategory.value = false
  }
}

const loadArticle = async () => {
  try {
    const article = await api.get(`/articles/${route.params.id}`)
    isDraft.value = article.draft === true
    currentDraftId.value = article.draft ? article.id : null
    form.value = {
      title: article.title,
      content: article.content,
      summary: article.summary || '',
      coverImage: article.coverImage || '',
      categoryId: article.category?.id || null,
      tags: article.tags?.map(t => t.name) || []
    }
  } catch (error) {
    ElMessage.error('加载文章失败')
    router.push('/')
  }
}

const handleSave = async () => {
  if (!form.value.title.trim()) {
    ElMessage.warning('请输入文章标题')
    return
  }
  if (!form.value.content.trim()) {
    ElMessage.warning('请输入文章内容')
    return
  }

  const user = JSON.parse(localStorage.getItem('user') || '{}')
  if (!user.userId) {
    ElMessage.warning('请先登录')
    router.push('/login')
    return
  }

  saving.value = true
  try {
    // 处理标签：如果标签不存在，自动创建
    const processedTags = []
    for (const tagName of form.value.tags) {
      if (tagName && tagName.trim()) {
        try {
          // 尝试创建标签（如果已存在会直接返回）
          await api.post('/tags', { name: tagName.trim() })
        } catch (error) {
          console.warn('创建标签失败:', error)
        }
        processedTags.push(tagName.trim())
      }
    }

    const data = {
      userId: user.userId,
      title: form.value.title,
      content: form.value.content,
      htmlContent: htmlContent.value,
      summary: form.value.summary,
      coverImage: form.value.coverImage || null,
      categoryId: form.value.categoryId,
      tags: processedTags
    }

    // 如果是草稿，先发布草稿
    if (isDraft.value && currentDraftId.value) {
      await api.post(`/articles/drafts/${currentDraftId.value}/publish?userId=${user.userId}`)
      ElMessage.success('发布成功')
      router.push('/')
      return
    }

    if (isEdit.value) {
      await api.put(`/articles/${route.params.id}`, data)
      ElMessage.success('更新成功')
    } else {
      await api.post('/articles', data)
      ElMessage.success('发布成功')
    }
    router.push('/')
  } catch (error) {
    ElMessage.error('保存失败')
  } finally {
    saving.value = false
  }
}

const handleSaveDraft = async () => {
  const user = JSON.parse(localStorage.getItem('user') || '{}')
  if (!user.userId) {
    ElMessage.warning('请先登录')
    router.push('/login')
    return
  }

  savingDraft.value = true
  try {
    // 处理标签：如果标签不存在，自动创建
    const processedTags = []
    for (const tagName of form.value.tags) {
      if (tagName && tagName.trim()) {
        try {
          // 尝试创建标签（如果已存在会直接返回）
          await api.post('/tags', { name: tagName.trim() })
        } catch (error) {
          console.warn('创建标签失败:', error)
        }
        processedTags.push(tagName.trim())
      }
    }

    const data = {
      userId: user.userId,
      title: form.value.title || '无标题',
      content: form.value.content || '',
      htmlContent: htmlContent.value || '',
      summary: form.value.summary || '',
      coverImage: form.value.coverImage || null,
      categoryId: form.value.categoryId || null,
      tags: processedTags
    }

    // 如果是编辑草稿，更新草稿
    if (isDraft.value && currentDraftId.value) {
      await api.put(`/articles/drafts/${currentDraftId.value}`, data)
      ElMessage.success('草稿已保存')
      // 更新currentDraftId，确保后续保存时知道这是草稿
      const updatedDraft = await api.get(`/articles/${currentDraftId.value}`)
      currentDraftId.value = updatedDraft.id
    } else {
      // 创建新草稿
      const draft = await api.post('/articles/drafts', data)
      currentDraftId.value = draft.id
      isDraft.value = true
      ElMessage.success('草稿已保存')
      // 更新路由，但不刷新页面
      router.replace(`/editor/${draft.id}`)
    }
  } catch (error) {
    console.error('保存草稿失败:', error)
    ElMessage.error('保存草稿失败')
  } finally {
    savingDraft.value = false
  }
}

onMounted(async () => {
  await loadCategories()
  await loadTags()
  if (isEdit.value) {
    await loadArticle()
  } else {
    // 如果是新建文章，检查是否有最近草稿（这个检查已经在App.vue的goToEditor中做了）
    // 但为了保险起见，这里也清空一下状态
    isDraft.value = false
    currentDraftId.value = null
  }
})
</script>

<style scoped>
.editor {
  min-height: calc(100vh - 200px);
}
</style>
