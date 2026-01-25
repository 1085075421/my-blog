package com.blog.controller;

import com.blog.entity.Article;
import com.blog.entity.User;
import com.blog.service.AdminService;
import com.blog.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin")
@CrossOrigin(origins = "*")
public class AdminController {
    
    @Autowired
    private AdminService adminService;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    // 检查管理员权限
    private boolean checkAdmin(String token) {
        if (token == null || token.isEmpty()) {
            return false;
        }
        try {
            String cleanToken = token.startsWith("Bearer ") ? token.substring(7) : token;
            Long userId = jwtUtil.getUserIdFromToken(cleanToken);
            return adminService.isAdmin(userId);
        } catch (Exception e) {
            return false;
        }
    }
    
    // 获取统计数据
    @GetMapping("/statistics")
    public ResponseEntity<Map<String, Object>> getStatistics(@RequestHeader(value = "Authorization", required = false) String token) {
        if (!checkAdmin(token)) {
            return ResponseEntity.status(403).body(Map.of("error", "无权限访问"));
        }
        return ResponseEntity.ok(adminService.getStatistics());
    }
    
    // 获取用户增长趋势
    @GetMapping("/statistics/user-growth")
    public ResponseEntity<Map<String, Object>> getUserGrowthTrend(@RequestHeader(value = "Authorization", required = false) String token) {
        if (!checkAdmin(token)) {
            return ResponseEntity.status(403).body(Map.of("error", "无权限访问"));
        }
        return ResponseEntity.ok(adminService.getUserGrowthTrend());
    }
    
    // 获取文章发布趋势
    @GetMapping("/statistics/article-publish")
    public ResponseEntity<Map<String, Object>> getArticlePublishTrend(@RequestHeader(value = "Authorization", required = false) String token) {
        if (!checkAdmin(token)) {
            return ResponseEntity.status(403).body(Map.of("error", "无权限访问"));
        }
        return ResponseEntity.ok(adminService.getArticlePublishTrend());
    }
    
    // 获取分类统计
    @GetMapping("/statistics/category")
    public ResponseEntity<List<Map<String, Object>>> getCategoryStatistics(@RequestHeader(value = "Authorization", required = false) String token) {
        if (!checkAdmin(token)) {
            return ResponseEntity.status(403).build();
        }
        return ResponseEntity.ok(adminService.getCategoryStatistics());
    }
    
    // 获取热门文章（按点赞）
    @GetMapping("/articles/hot/likes")
    public ResponseEntity<Page<Article>> getHotArticlesByLikes(
            @RequestHeader(value = "Authorization", required = false) String token,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        if (!checkAdmin(token)) {
            return ResponseEntity.status(403).build();
        }
        return ResponseEntity.ok(adminService.getHotArticlesByLikes(page, size));
    }
    
    // 获取热门文章（按阅读）
    @GetMapping("/articles/hot/views")
    public ResponseEntity<Page<Article>> getHotArticlesByViews(
            @RequestHeader(value = "Authorization", required = false) String token,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        if (!checkAdmin(token)) {
            return ResponseEntity.status(403).build();
        }
        return ResponseEntity.ok(adminService.getHotArticlesByViews(page, size));
    }
    
    // 获取热门文章（按收藏）
    @GetMapping("/articles/hot/favorites")
    public ResponseEntity<Page<Article>> getHotArticlesByFavorites(
            @RequestHeader(value = "Authorization", required = false) String token,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        if (!checkAdmin(token)) {
            return ResponseEntity.status(403).build();
        }
        return ResponseEntity.ok(adminService.getHotArticlesByFavorites(page, size));
    }
    
    // 获取热门文章（综合排序）
    @GetMapping("/articles/hot/score")
    public ResponseEntity<Page<Article>> getHotArticlesByScore(
            @RequestHeader(value = "Authorization", required = false) String token,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        if (!checkAdmin(token)) {
            return ResponseEntity.status(403).build();
        }
        return ResponseEntity.ok(adminService.getHotArticlesByScore(page, size));
    }
    
    // 获取所有用户
    @GetMapping("/users")
    public ResponseEntity<Page<User>> getAllUsers(
            @RequestHeader(value = "Authorization", required = false) String token,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword) {
        if (!checkAdmin(token)) {
            return ResponseEntity.status(403).build();
        }
        Page<User> users = adminService.getAllUsers(page, size, keyword);
        // 清理敏感信息
        users.getContent().forEach(u -> {
            u.setPassword(null);
            u.setFollowing(null);
            u.setFollowers(null);
        });
        return ResponseEntity.ok(users);
    }
    
    // 获取所有文章
    @GetMapping("/articles")
    public ResponseEntity<Page<Article>> getAllArticles(
            @RequestHeader(value = "Authorization", required = false) String token,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword) {
        if (!checkAdmin(token)) {
            return ResponseEntity.status(403).build();
        }
        return ResponseEntity.ok(adminService.getAllArticles(page, size, keyword));
    }
    
    // 删除用户
    @DeleteMapping("/users/{id}")
    public ResponseEntity<Map<String, String>> deleteUser(
            @RequestHeader(value = "Authorization", required = false) String token,
            @PathVariable Long id) {
        if (!checkAdmin(token)) {
            return ResponseEntity.status(403).body(Map.of("error", "无权限访问"));
        }
        adminService.deleteUser(id);
        return ResponseEntity.ok(Map.of("message", "删除成功"));
    }
    
    // 删除文章
    @DeleteMapping("/articles/{id}")
    public ResponseEntity<Map<String, String>> deleteArticle(
            @RequestHeader(value = "Authorization", required = false) String token,
            @PathVariable Long id) {
        if (!checkAdmin(token)) {
            return ResponseEntity.status(403).body(Map.of("error", "无权限访问"));
        }
        adminService.deleteArticle(id);
        return ResponseEntity.ok(Map.of("message", "删除成功"));
    }
    
    // 设置用户角色
    @PutMapping("/users/{id}/role")
    public ResponseEntity<User> setUserRole(
            @RequestHeader(value = "Authorization", required = false) String token,
            @PathVariable Long id,
            @RequestBody Map<String, String> request) {
        if (!checkAdmin(token)) {
            return ResponseEntity.status(403).build();
        }
        String role = request.get("role");
        User user = adminService.setUserRole(id, role);
        user.setPassword(null);
        user.setFollowing(null);
        user.setFollowers(null);
        return ResponseEntity.ok(user);
    }
}
