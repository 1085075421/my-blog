package com.blog.config;

import com.blog.entity.*;
import com.blog.repository.*;
import com.blog.service.UserService;
import com.blog.service.TagService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

@Component
@Order(2) // 在DataInitializer之后执行
public class MockDataGenerator implements CommandLineRunner {
    
    private static final Logger logger = LoggerFactory.getLogger(MockDataGenerator.class);
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private ArticleRepository articleRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private TagRepository tagRepository;
    
    @Autowired
    private CommentRepository commentRepository;
    
    @Autowired
    private ArticleLikeRepository likeRepository;
    
    @Autowired
    private ArticleFavoriteRepository favoriteRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private TagService tagService;
    
    private final Random random = new Random();
    
    // 模拟用户数据：{账号, 邮箱, 昵称, 简介, 头像}
    private final String[][] mockUsers = {
        {"zhangxm", "zhangxiaoming@example.com", "张小明", "全栈开发工程师，热爱技术分享", "https://cube.elemecdn.com/0/88/03b0d4ff20dd7589bb7fd77975b171gc.jpeg"},
        {"lijs", "lijs@example.com", "李技术", "专注于后端开发，Spring Boot专家", "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"},
        {"wangqd", "wangqd@example.com", "王前端", "Vue.js爱好者，前端架构师", "https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a549403c68a25jpeg.jpeg"},
        {"chensf", "chensf@example.com", "陈算法", "算法竞赛选手，数据结构达人", "https://cube.elemecdn.com/f/71/afd9a7d7e0f6b96211e533a9c109bpeg.jpeg"},
        {"liuds", "liuds@example.com", "刘设计", "UI/UX设计师，关注用户体验", "https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg"},
        {"zhaoyw", "zhaoyw@example.com", "赵运维", "DevOps工程师，Docker和K8s实践者", "https://cube.elemecdn.com/c/8b/227a7f0db80d1024fdd8cbd20df8jpeg.jpeg"},
        {"suncp", "suncp@example.com", "孙产品", "产品经理，关注技术趋势", "https://cube.elemecdn.com/2/11/6535bcfb85e8c5b6d8c7d1d5b3ab9jpeg.jpeg"},
        {"zhoucs", "zhoucs@example.com", "周测试", "测试工程师，自动化测试专家", "https://cube.elemecdn.com/e/f48/4445873e693922f0248f7591499jpeg.jpeg"},
        {"wusj", "wusj@example.com", "吴数据", "数据分析师，SQL和Python爱好者", "https://cube.elemecdn.com/1/8e/aecefb37cef74a74b4cd74ae4ae9jpeg.jpeg"},
        {"zhengxx", "zhengxx@example.com", "郑学习", "在校学生，记录学习成长", "https://cube.elemecdn.com/0/88/03b0d4ff20dd7589bb7fd77975b171gc.jpeg"}
    };
    
    // 模拟文章标题和内容
    private final String[][] mockArticles = {
        {"Spring Boot 从入门到精通", "技术分享", "Spring Boot,Java,后端", 
            "本文详细介绍了Spring Boot的核心概念、常用注解和最佳实践。\n\n## 什么是Spring Boot\n\nSpring Boot是Spring框架的扩展，旨在简化Spring应用的开发。\n\n## 核心特性\n\n- 自动配置\n- 起步依赖\n- 内嵌服务器\n\n## 快速开始\n\n```java\n@SpringBootApplication\npublic class Application {\n    public static void main(String[] args) {\n        SpringApplication.run(Application.class, args);\n    }\n}\n```"},
        {"Vue 3 Composition API 深度解析", "前端开发", "Vue,JavaScript,前端", 
            "Vue 3引入了Composition API，提供了更灵活的组合式API。\n\n## 为什么需要Composition API\n\n- 更好的逻辑复用\n- 更清晰的代码组织\n- 更好的TypeScript支持\n\n## 基本用法\n\n```javascript\nimport { ref, computed } from 'vue'\n\nexport default {\n  setup() {\n    const count = ref(0)\n    const doubleCount = computed(() => count.value * 2)\n    return { count, doubleCount }\n  }\n}\n```"},
        {"MySQL索引优化实战", "数据库", "MySQL,数据库,优化", 
            "索引是数据库性能优化的关键。本文分享一些MySQL索引优化的实战经验。\n\n## 索引类型\n\n- B-Tree索引\n- 哈希索引\n- 全文索引\n\n## 优化建议\n\n1. 避免在WHERE子句中使用函数\n2. 合理使用复合索引\n3. 注意索引的选择性"},
        {"算法学习之路：动态规划入门", "算法与数据结构", "算法,数据结构,学习", 
            "动态规划是算法学习中的重要内容。本文通过经典例题讲解DP的基本思想。\n\n## 什么是动态规划\n\n动态规划是一种通过把原问题分解为相对简单的子问题的方式来解决复杂问题的方法。\n\n## 经典例题\n\n### 斐波那契数列\n\n```python\ndef fib(n):\n    if n <= 1:\n        return n\n    dp = [0] * (n + 1)\n    dp[1] = 1\n    for i in range(2, n + 1):\n        dp[i] = dp[i-1] + dp[i-2]\n    return dp[n]\n```"},
        {"Docker容器化部署实践", "工具推荐", "Docker,DevOps,部署", 
            "Docker已经成为现代应用部署的标准。本文分享Docker容器化部署的实践经验。\n\n## Docker基础\n\n- 镜像（Image）\n- 容器（Container）\n- 仓库（Repository）\n\n## 常用命令\n\n```bash\ndocker build -t myapp .\ndocker run -d -p 8080:8080 myapp\ndocker-compose up -d\n```"},
        {"Git工作流最佳实践", "工具推荐", "Git,版本控制,开发工具", 
            "Git是现代开发必备的版本控制工具。本文介绍Git工作流的最佳实践。\n\n## 分支策略\n\n- master/main：生产环境\n- develop：开发环境\n- feature：功能分支\n- hotfix：紧急修复\n\n## 常用命令\n\n```bash\ngit checkout -b feature/new-feature\ngit commit -m \"Add new feature\"\ngit push origin feature/new-feature\n```"},
        {"我的全栈学习之路", "个人成长", "学习,成长,经验", 
            "记录我从零开始学习全栈开发的经历和心得。\n\n## 学习路径\n\n1. 前端基础：HTML、CSS、JavaScript\n2. 前端框架：Vue.js\n3. 后端基础：Java、Spring Boot\n4. 数据库：MySQL\n\n## 心得体会\n\n学习编程最重要的是动手实践，多写代码，多思考。"},
        {"Redis缓存使用指南", "数据库", "Redis,缓存,数据库", 
            "Redis是高性能的内存数据库，广泛应用于缓存场景。\n\n## Redis数据类型\n\n- String\n- Hash\n- List\n- Set\n- Sorted Set\n\n## 使用场景\n\n- 缓存\n- 会话存储\n- 消息队列\n- 计数器"},
        {"前端性能优化技巧", "前端开发", "前端,性能优化,Web开发", 
            "前端性能优化是提升用户体验的关键。\n\n## 优化策略\n\n1. 减少HTTP请求\n2. 使用CDN\n3. 代码压缩\n4. 图片优化\n5. 懒加载\n\n## 工具推荐\n\n- Lighthouse\n- WebPageTest\n- Chrome DevTools"},
        {"Spring Security认证授权", "后端开发", "Spring Security,Java,安全", 
            "Spring Security是Spring生态中的安全框架。\n\n## 核心概念\n\n- 认证（Authentication）\n- 授权（Authorization）\n- 密码加密\n\n## 配置示例\n\n```java\n@Configuration\n@EnableWebSecurity\npublic class SecurityConfig {\n    // 配置代码\n}\n```"},
        {"Vue Router路由管理", "前端开发", "Vue,路由,前端", 
            "Vue Router是Vue.js的官方路由管理器。\n\n## 基本用法\n\n```javascript\nconst routes = [\n  { path: '/', component: Home },\n  { path: '/about', component: About }\n]\n```"},
        {"设计模式：单例模式", "学习笔记", "设计模式,Java,学习", 
            "单例模式是最常用的设计模式之一。\n\n## 实现方式\n\n- 饿汉式\n- 懒汉式\n- 双重检查锁定\n\n## 代码示例\n\n```java\npublic class Singleton {\n    private static Singleton instance;\n    private Singleton() {}\n    public static Singleton getInstance() {\n        if (instance == null) {\n            instance = new Singleton();\n        }\n        return instance;\n    }\n}\n```"},
        {"Linux常用命令总结", "工具推荐", "Linux,命令行,运维", 
            "Linux命令行是开发者的必备技能。\n\n## 常用命令\n\n- ls：列出目录\n- cd：切换目录\n- grep：搜索文本\n- find：查找文件\n- chmod：修改权限"},
        {"Python爬虫入门", "学习笔记", "Python,爬虫,学习", 
            "Python是爬虫开发的首选语言。\n\n## 常用库\n\n- requests：HTTP请求\n- BeautifulSoup：HTML解析\n- Scrapy：爬虫框架\n\n## 示例代码\n\n```python\nimport requests\nfrom bs4 import BeautifulSoup\n\nresponse = requests.get('https://example.com')\nsoup = BeautifulSoup(response.text, 'html.parser')\n```"},
        {"微服务架构设计", "项目经验", "微服务,架构,分布式", 
            "微服务架构是现代应用开发的重要模式。\n\n## 核心概念\n\n- 服务拆分\n- 服务治理\n- 服务发现\n- 配置中心\n\n## 技术栈\n\n- Spring Cloud\n- Docker\n- Kubernetes"},
        {"TypeScript类型系统", "前端开发", "TypeScript,前端,JavaScript", 
            "TypeScript为JavaScript添加了类型系统。\n\n## 基本类型\n\n- number\n- string\n- boolean\n- object\n\n## 高级特性\n\n- 泛型\n- 接口\n- 类型推断"},
        {"数据库设计原则", "数据库", "数据库,设计,MySQL", 
            "良好的数据库设计是应用成功的基础。\n\n## 设计原则\n\n1. 范式化设计\n2. 合理使用索引\n3. 避免过度设计\n4. 考虑扩展性"},
        {"RESTful API设计规范", "后端开发", "API,后端,设计", 
            "RESTful是API设计的标准规范。\n\n## 设计原则\n\n- 使用HTTP动词\n- 资源导向\n- 状态码规范\n- 版本控制"},
        {"前端工程化实践", "前端开发", "前端,工程化,Webpack", 
            "前端工程化是现代前端开发的必备技能。\n\n## 工具链\n\n- Webpack\n- Vite\n- ESLint\n- Prettier\n\n## 最佳实践\n\n- 模块化\n- 组件化\n- 自动化构建"},
        {"Java并发编程", "后端开发", "Java,并发,多线程", 
            "Java并发编程是高级开发者的必备技能。\n\n## 核心概念\n\n- 线程\n- 锁\n- 线程池\n- 并发集合\n\n## 示例\n\n```java\nExecutorService executor = Executors.newFixedThreadPool(10);\nexecutor.submit(() -> {\n    // 任务代码\n});\n```"}
    };
    
    // 模拟评论内容
    private final String[] mockComments = {
        "写得很详细，学到了很多！",
        "感谢分享，正好遇到这个问题。",
        "有个小问题想请教一下...",
        "这个方案不错，我也试过类似的方法。",
        "期待后续更新！",
        "很实用的教程，收藏了。",
        "代码示例很清晰，感谢！",
        "受益匪浅，继续关注。",
        "有个地方不太理解，能详细说明一下吗？",
        "这个思路很棒！",
        "实践了一下，确实有效。",
        "希望多分享一些实战经验。",
        "文章质量很高，支持！",
        "学到了，感谢作者。",
        "这个知识点很重要，mark一下。"
    };
    
    @Override
    @Transactional
    public void run(String... args) {
        // 创建默认管理员账号
        createAdminUser();
        
        // 检查是否已有数据
        if (userRepository.count() > 1) { // 大于1说明除了admin还有其他用户
            logger.info("检测到已有用户数据，跳过模拟数据生成");
            return;
        }
        
        logger.info("开始生成模拟数据...");
        
        List<User> users = createMockUsers();
        List<Category> categories = categoryRepository.findAll();
        List<Tag> tags = new ArrayList<>(tagRepository.findAll()); // 使用可变列表
        List<Article> articles = createMockArticles(users, categories, tags);
        
        createMockInteractions(users, articles);
        createMockFollows(users);
        
        logger.info("模拟数据生成完成！生成了 {} 个用户，{} 篇文章", users.size(), articles.size());
    }
    
    private void createAdminUser() {
        // 检查是否存在admin账号
        User existingAdmin = userRepository.findByAccount("admin").orElse(null);
        
        if (existingAdmin == null) {
            // 创建新管理员
            User admin = new User();
            admin.setAccount("admin");
            admin.setUsername("管理员");
            admin.setEmail("admin@example.com");
            admin.setPassword(passwordEncoder.encode("admin123"));
            admin.setRole("ADMIN");
            admin.setAvatar("https://cube.elemecdn.com/0/88/03b0d4ff20dd7589bb7fd77975b171gc.jpeg");
            admin.setBio("系统管理员");
            admin.setExperience(1000);
            admin.setLevel(10);
            userRepository.save(admin);
            logger.info("创建默认管理员账号: admin / admin123");
        } else {
            // 如果已存在，确保role是ADMIN
            if (!"ADMIN".equals(existingAdmin.getRole())) {
                existingAdmin.setRole("ADMIN");
                userRepository.save(existingAdmin);
                logger.info("更新admin账号角色为管理员");
            }
        }
    }
    
    private List<User> createMockUsers() {
        List<User> users = new ArrayList<>();
        
        for (String[] userData : mockUsers) {
            // userData格式：{账号, 邮箱, 昵称, 简介, 头像}
            if (userRepository.existsByAccount(userData[0]) || 
                userRepository.existsByEmail(userData[1])) {
                continue; // 跳过已存在的用户
            }
            
            User user = new User();
            user.setAccount(userData[0]); // 账号
            user.setEmail(userData[1]); // 邮箱
            user.setUsername(userData[2]); // 昵称
            user.setPassword(passwordEncoder.encode("123456")); // 统一密码
            user.setAvatar(userData[4]); // 头像
            user.setBio(userData[3]); // 简介
            user.setExperience(random.nextInt(500)); // 随机经验值
            user.setLevel(userService.calculateLevel(user.getExperience()));
            user.setDailyExperience(0);
            user.setLastExperienceReset(LocalDateTime.now().minusDays(random.nextInt(7)));
            user.setRole("USER"); // 默认普通用户
            
            user = userRepository.save(user);
            users.add(user);
        }
        
        return users;
    }
    
    private List<Article> createMockArticles(List<User> users, List<Category> categories, List<Tag> tags) {
        List<Article> articles = new ArrayList<>();
        
        for (int i = 0; i < mockArticles.length && i < users.size() * 2; i++) {
            String[] articleData = mockArticles[i];
            User author = users.get(i % users.size());
            
            Article article = new Article();
            article.setTitle(articleData[0]);
            article.setContent(articleData[3]);
            article.setHtmlContent(convertMarkdownToHtml(articleData[3]));
            article.setSummary(generateSummary(articleData[3]));
            article.setAuthor(author);
            article.setViewCount(random.nextInt(500) + 10);
            article.setLikeCount(0);
            article.setCreatedAt(LocalDateTime.now().minusDays(random.nextInt(30)));
            
            // 随机分配分类
            if (!categories.isEmpty()) {
                Category category = categories.stream()
                    .filter(c -> c.getName().equals(articleData[1]))
                    .findFirst()
                    .orElse(categories.get(random.nextInt(categories.size())));
                article.setCategory(category);
            }
            
            // 分配标签
            String[] tagNames = articleData[2].split(",");
            Set<Tag> articleTags = new HashSet<>();
            for (String tagNameRaw : tagNames) {
                final String tagName = tagNameRaw.trim();
                // 先从已加载的标签列表中查找
                Tag tag = tags.stream()
                    .filter(t -> t.getName().equals(tagName))
                    .findFirst()
                    .orElse(null);
                // 如果没找到，使用TagService创建（会自动检查是否存在）
                if (tag == null) {
                    tag = tagService.createTag(tagName);
                    // 添加到标签列表，避免重复查询
                    tags.add(tag);
                }
                articleTags.add(tag);
            }
            article.setTags(articleTags);
            
            // 随机封面图
            if (random.nextBoolean()) {
                article.setCoverImage("https://picsum.photos/800/400?random=" + i);
            }
            
            article = articleRepository.save(article);
            articles.add(article);
            
            // 给作者添加经验值（发布文章）
            userService.addExperience(author.getId(), 10, "publish_article");
        }
        
        return articles;
    }
    
    private void createMockInteractions(List<User> users, List<Article> articles) {
        // 创建点赞
        for (Article article : articles) {
            int likeCount = random.nextInt(Math.min(users.size(), 15)) + 1;
            Set<Long> likedUsers = new HashSet<>();
            
            for (int i = 0; i < likeCount; i++) {
                User user = users.get(random.nextInt(users.size()));
                if (!likedUsers.contains(user.getId()) && !user.getId().equals(article.getAuthor().getId())) {
                    ArticleLike like = new ArticleLike();
                    like.setArticle(article);
                    like.setUser(user);
                    likeRepository.save(like);
                    likedUsers.add(user.getId());
                    
                    // 添加经验值
                    userService.addExperience(user.getId(), 2, "like_article");
                }
            }
            
            article.setLikeCount(likedUsers.size());
            articleRepository.save(article);
        }
        
        // 创建收藏
        for (Article article : articles) {
            int favoriteCount = random.nextInt(Math.min(users.size(), 10)) + 1;
            Set<Long> favoritedUsers = new HashSet<>();
            
            for (int i = 0; i < favoriteCount; i++) {
                User user = users.get(random.nextInt(users.size()));
                if (!favoritedUsers.contains(user.getId()) && !user.getId().equals(article.getAuthor().getId())) {
                    ArticleFavorite favorite = new ArticleFavorite();
                    favorite.setArticle(article);
                    favorite.setUser(user);
                    favoriteRepository.save(favorite);
                    favoritedUsers.add(user.getId());
                    
                    // 添加经验值
                    userService.addExperience(user.getId(), 2, "favorite_article");
                }
            }
        }
        
        // 创建评论
        for (Article article : articles) {
            int commentCount = random.nextInt(10) + 2;
            
            for (int i = 0; i < commentCount; i++) {
                User commenter = users.get(random.nextInt(users.size()));
                Comment comment = new Comment();
                comment.setArticle(article);
                comment.setUser(commenter);
                comment.setContent(mockComments[random.nextInt(mockComments.length)]);
                comment.setCreatedAt(article.getCreatedAt().plusDays(random.nextInt(7)));
                
                // 30%概率是回复评论
                if (random.nextDouble() < 0.3 && !article.getComments().isEmpty()) {
                    Comment parent = article.getComments().stream()
                        .skip(random.nextInt(article.getComments().size()))
                        .findFirst()
                        .orElse(null);
                    if (parent != null) {
                        comment.setParent(parent);
                    }
                }
                
                commentRepository.save(comment);
                
                // 添加经验值
                userService.addExperience(commenter.getId(), 3, "comment_article");
            }
        }
    }
    
    private void createMockFollows(List<User> users) {
        // 创建关注关系
        for (User user : users) {
            int followCount = random.nextInt(5) + 1;
            Set<Long> followingIds = new HashSet<>();
            
            for (int i = 0; i < followCount && i < users.size() - 1; i++) {
                User target = users.get(random.nextInt(users.size()));
                if (!target.getId().equals(user.getId()) && !followingIds.contains(target.getId())) {
                    user.getFollowing().add(target);
                    followingIds.add(target.getId());
                }
            }
            
            userRepository.save(user);
        }
    }
    
    private String convertMarkdownToHtml(String markdown) {
        // 简单的Markdown转HTML（实际项目中应该使用专业的库）
        return markdown
            .replaceAll("## (.+)", "<h2>$1</h2>")
            .replaceAll("### (.+)", "<h3>$1</h3>")
            .replaceAll("\\*\\*(.+?)\\*\\*", "<strong>$1</strong>")
            .replaceAll("`(.+?)`", "<code>$1</code>")
            .replaceAll("\n", "<br/>");
    }
    
    private String generateSummary(String content) {
        // 生成摘要（取前100个字符）
        String text = content.replaceAll("#+", "").replaceAll("```[\\s\\S]*?```", "")
            .replaceAll("`[^`]+`", "").trim();
        if (text.length() > 100) {
            return text.substring(0, 100) + "...";
        }
        return text;
    }
}
