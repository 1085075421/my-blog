# 个人博客社区

一个前后端分离的个人博客社区项目，支持文章Markdown编辑、评论回复、点赞收藏、分类标签、用户关注等功能。

## 技术栈

### 后端
- Spring Boot 3.1.5
- Spring Data JPA
- MySQL 8.0
- JWT认证
- Maven

### 前端
- Vue 3
- Vite
- Element Plus
- Axios
- Marked (Markdown渲染)

## 功能特性

1. **文章Markdown编辑** - 支持Markdown格式编写文章，实时预览
2. **评论回复** - 支持文章评论和回复功能
3. **点赞收藏** - 文章点赞和收藏功能
4. **分类标签** - 文章分类和标签管理
5. **用户关注** - 用户之间可以相互关注

## 项目结构

```
my-blog/
├── server/                 # 后端项目
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/blog/
│   │   │   │   ├── entity/      # 实体类
│   │   │   │   ├── repository/  # 数据访问层
│   │   │   │   ├── service/     # 业务逻辑层
│   │   │   │   ├── controller/  # 控制器层
│   │   │   │   ├── config/      # 配置类
│   │   │   │   ├── dto/         # 数据传输对象
│   │   │   │   └── util/        # 工具类
│   │   │   └── resources/
│   │   │       └── application.yml
│   └── pom.xml
├── client/                 # 前端项目
│   ├── src/
│   │   ├── views/         # 页面组件
│   │   ├── router/        # 路由配置
│   │   └── utils/         # 工具函数
│   ├── package.json
│   └── vite.config.js
└── README.md
```

## 快速开始

### 环境要求

- JDK 17+（必需）
- Node.js 16+（前端必需）
- MySQL 8.0+（必需）
- Maven 3.6+（可选，如果使用IDE运行则不需要）

### 数据库配置

1. 确保MySQL已启动
2. 创建数据库（可选，JPA会自动创建）：
```sql
CREATE DATABASE blog_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

3. 修改 `server/src/main/resources/application.yml` 中的数据库连接信息（如果需要）

### 后端启动

**如果遇到 "无法识别 mvn 命令" 的错误，请参考 `server/启动说明.md`**

#### 方式1：使用Maven命令行（需要先安装Maven）

```bash
cd server
mvn clean install
mvn spring-boot:run
```

#### 方式2：使用IDE运行（推荐，无需安装Maven）

1. **IntelliJ IDEA**：
   - 打开项目根目录
   - 等待IDEA自动识别Maven项目
   - 右键点击 `BlogApplication.java` -> Run 'BlogApplication'

2. **Eclipse / VS Code**：
   - 导入Maven项目
   - 运行 `BlogApplication.java` 的main方法

#### 方式3：使用PowerShell脚本

```powershell
cd server
.\quick-start.ps1
```

后端服务将在 `http://localhost:8080` 启动

### 前端启动

```bash
cd client
npm install
npm run dev
```

前端服务将在 `http://localhost:3000` 启动

## API接口

### 认证接口
- `POST /api/auth/register` - 用户注册
- `POST /api/auth/login` - 用户登录

### 文章接口
- `GET /api/articles` - 获取文章列表
- `GET /api/articles/{id}` - 获取文章详情
- `POST /api/articles` - 创建文章
- `PUT /api/articles/{id}` - 更新文章
- `DELETE /api/articles/{id}` - 删除文章
- `GET /api/articles/search` - 搜索文章
- `GET /api/articles/category/{categoryId}` - 按分类获取文章
- `GET /api/articles/tag/{tagId}` - 按标签获取文章

### 评论接口
- `GET /api/comments/article/{articleId}` - 获取文章评论
- `POST /api/comments` - 创建评论
- `DELETE /api/comments/{id}` - 删除评论

### 点赞接口
- `POST /api/likes/toggle` - 切换点赞状态
- `GET /api/likes/check` - 检查点赞状态

### 收藏接口
- `POST /api/favorites/toggle` - 切换收藏状态
- `GET /api/favorites/check` - 检查收藏状态
- `GET /api/favorites/user/{userId}` - 获取用户收藏

### 关注接口
- `POST /api/follows/toggle` - 切换关注状态
- `GET /api/follows/check` - 检查关注状态

### 分类标签接口
- `GET /api/categories` - 获取所有分类
- `POST /api/categories` - 创建分类
- `GET /api/tags` - 获取所有标签

## 开发说明

### 后端开发
- 使用Spring Data JPA进行数据持久化
- JWT用于用户认证
- 使用BCrypt进行密码加密

### 前端开发
- 使用Vue 3 Composition API
- Element Plus作为UI组件库
- Axios进行HTTP请求
- Marked库渲染Markdown内容

## 注意事项

1. 首次运行会自动创建数据库表结构
2. 默认数据库配置：localhost:3306，用户名root，密码root
3. JWT token存储在localStorage中
4. 前端代理配置在 `vite.config.js` 中

## 许可证

MIT License
