package com.blog.service;

import com.blog.entity.Article;
import com.blog.entity.User;
import com.blog.repository.ArticleRepository;
import com.blog.repository.CommentRepository;
import com.blog.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class AdminService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private ArticleRepository articleRepository;
    
    @Autowired
    private CommentRepository commentRepository;
    
    // 获取统计数据
    public Map<String, Object> getStatistics() {
        Map<String, Object> stats = new HashMap<>();
        
        // 用户统计
        long totalUsers = userRepository.count();
        long adminUsers = userRepository.findAll().stream()
                .filter(u -> "ADMIN".equals(u.getRole()))
                .count();
        stats.put("totalUsers", totalUsers);
        stats.put("adminUsers", adminUsers);
        stats.put("normalUsers", totalUsers - adminUsers);
        
        // 文章统计
        long totalArticles = articleRepository.count();
        stats.put("totalArticles", totalArticles);
        
        // 评论统计
        long totalComments = commentRepository.count();
        stats.put("totalComments", totalComments);
        
        // 今日新增
        LocalDateTime todayStart = LocalDate.now().atStartOfDay();
        long todayUsers = userRepository.findAll().stream()
                .filter(u -> u.getCreatedAt() != null && u.getCreatedAt().isAfter(todayStart))
                .count();
        long todayArticles = articleRepository.findAll().stream()
                .filter(a -> a.getCreatedAt() != null && a.getCreatedAt().isAfter(todayStart))
                .count();
        long todayComments = commentRepository.findAll().stream()
                .filter(c -> c.getCreatedAt() != null && c.getCreatedAt().isAfter(todayStart))
                .count();
        
        stats.put("todayUsers", todayUsers);
        stats.put("todayArticles", todayArticles);
        stats.put("todayComments", todayComments);
        
        return stats;
    }
    
    // 获取用户增长趋势（最近30天）
    public Map<String, Object> getUserGrowthTrend() {
        Map<String, Object> result = new HashMap<>();
        List<String> dates = new ArrayList<>();
        List<Long> counts = new ArrayList<>();
        
        for (int i = 29; i >= 0; i--) {
            LocalDate date = LocalDate.now().minusDays(i);
            LocalDateTime start = date.atStartOfDay();
            LocalDateTime end = date.plusDays(1).atStartOfDay();
            
            long count = userRepository.findAll().stream()
                    .filter(u -> u.getCreatedAt() != null 
                            && u.getCreatedAt().isAfter(start) 
                            && u.getCreatedAt().isBefore(end))
                    .count();
            
            dates.add(date.toString());
            counts.add(count);
        }
        
        result.put("dates", dates);
        result.put("counts", counts);
        return result;
    }
    
    // 获取文章发布趋势（最近30天）
    public Map<String, Object> getArticlePublishTrend() {
        Map<String, Object> result = new HashMap<>();
        List<String> dates = new ArrayList<>();
        List<Long> counts = new ArrayList<>();
        
        for (int i = 29; i >= 0; i--) {
            LocalDate date = LocalDate.now().minusDays(i);
            LocalDateTime start = date.atStartOfDay();
            LocalDateTime end = date.plusDays(1).atStartOfDay();
            
            long count = articleRepository.findAll().stream()
                    .filter(a -> a.getCreatedAt() != null 
                            && a.getCreatedAt().isAfter(start) 
                            && a.getCreatedAt().isBefore(end))
                    .count();
            
            dates.add(date.toString());
            counts.add(count);
        }
        
        result.put("dates", dates);
        result.put("counts", counts);
        return result;
    }
    
    // 获取分类文章统计
    public List<Map<String, Object>> getCategoryStatistics() {
        Map<String, Long> categoryMap = new HashMap<>();
        
        articleRepository.findAll().forEach(article -> {
            if (article.getCategory() != null) {
                String categoryName = article.getCategory().getName();
                categoryMap.put(categoryName, categoryMap.getOrDefault(categoryName, 0L) + 1);
            }
        });
        
        return categoryMap.entrySet().stream()
                .map(entry -> {
                    Map<String, Object> item = new HashMap<>();
                    item.put("name", entry.getKey());
                    item.put("value", entry.getValue());
                    return item;
                })
                .sorted((a, b) -> Long.compare((Long) b.get("value"), (Long) a.get("value")))
                .collect(Collectors.toList());
    }
    
    // 获取热门文章（按点赞数）
    public Page<Article> getHotArticlesByLikes(int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "likeCount"));
        return articleRepository.findAll(pageable);
    }
    
    // 获取热门文章（按阅读数）
    public Page<Article> getHotArticlesByViews(int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "viewCount"));
        return articleRepository.findAll(pageable);
    }
    
    // 获取热门文章（按收藏数）
    public Page<Article> getHotArticlesByFavorites(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return articleRepository.findAllByOrderByFavoriteCountDesc(pageable);
    }
    
    // 获取热门文章（综合排序：点赞*2 + 阅读 + 收藏*3）
    public Page<Article> getHotArticlesByScore(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        List<Article> allArticles = articleRepository.findAll();
        
        // 计算综合分数并排序
        allArticles.sort((a, b) -> {
            long scoreA = (a.getLikeCount() != null ? a.getLikeCount() : 0) * 2L
                    + (a.getViewCount() != null ? a.getViewCount() : 0)
                    + (a.getFavorites() != null ? a.getFavorites().size() : 0) * 3L;
            long scoreB = (b.getLikeCount() != null ? b.getLikeCount() : 0) * 2L
                    + (b.getViewCount() != null ? b.getViewCount() : 0)
                    + (b.getFavorites() != null ? b.getFavorites().size() : 0) * 3L;
            return Long.compare(scoreB, scoreA);
        });
        
        // 手动分页
        int start = page * size;
        int end = Math.min(start + size, allArticles.size());
        List<Article> pagedArticles = allArticles.subList(start, end);
        
        // 创建自定义Page对象
        return new PageImpl<>(
                pagedArticles, 
                pageable, 
                allArticles.size()
        );
    }
    
    // 获取所有用户（分页）
    public Page<User> getAllUsers(int page, int size, String keyword) {
        Pageable pageable = PageRequest.of(page, size);
        if (keyword != null && !keyword.trim().isEmpty()) {
            // 简单搜索：在实际项目中应该使用更复杂的查询
            List<User> allUsers = userRepository.findAll();
            List<User> filtered = allUsers.stream()
                    .filter(u -> u.getAccount().contains(keyword) 
                            || u.getUsername().contains(keyword)
                            || u.getEmail().contains(keyword))
                    .collect(Collectors.toList());
            
            int start = page * size;
            int end = Math.min(start + size, filtered.size());
            List<User> paged = start < filtered.size() 
                    ? filtered.subList(start, end) 
                    : new ArrayList<>();
            
            return new PageImpl<>(paged, pageable, filtered.size());
        }
        return userRepository.findAll(pageable);
    }
    
    // 获取所有文章（分页）
    public Page<Article> getAllArticles(int page, int size, String keyword) {
        Pageable pageable = PageRequest.of(page, size);
        if (keyword != null && !keyword.trim().isEmpty()) {
            return articleRepository.searchByKeyword(keyword, pageable);
        }
        return articleRepository.findAllByOrderByCreatedAtDesc(pageable);
    }
    
    // 删除用户
    public void deleteUser(Long userId) {
        userRepository.deleteById(userId);
    }
    
    // 删除文章
    public void deleteArticle(Long articleId) {
        articleRepository.deleteById(articleId);
    }
    
    // 设置用户角色
    public User setUserRole(Long userId, String role) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
        user.setRole(role);
        return userRepository.save(user);
    }
    
    // 检查是否为管理员
    public boolean isAdmin(Long userId) {
        return userRepository.findById(userId)
                .map(u -> "ADMIN".equals(u.getRole()))
                .orElse(false);
    }
}
