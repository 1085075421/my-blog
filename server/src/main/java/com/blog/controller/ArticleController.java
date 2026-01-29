package com.blog.controller;

import com.blog.entity.Article;
import com.blog.service.ArticleService;
import com.blog.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/articles")
@CrossOrigin(origins = "*")
public class ArticleController {
    
    @Autowired
    private ArticleService articleService;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    @PostMapping
    public ResponseEntity<Article> createArticle(@RequestBody Map<String, Object> request) {
        Long userId = Long.valueOf(request.get("userId").toString());
        String title = request.get("title").toString();
        String content = request.get("content").toString();
        String htmlContent = request.get("htmlContent") != null ? request.get("htmlContent").toString() : "";
        String summary = request.get("summary") != null ? request.get("summary").toString() : "";
        String coverImage = request.get("coverImage") != null ? request.get("coverImage").toString() : null;
        Long categoryId = request.get("categoryId") != null ? Long.valueOf(request.get("categoryId").toString()) : null;
        @SuppressWarnings("unchecked")
        List<String> tagNames = (List<String>) request.get("tags");
        
        Article article = articleService.createArticle(userId, title, content, htmlContent, summary, coverImage, categoryId, tagNames);
        return ResponseEntity.ok(article);
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<Article> updateArticle(@PathVariable Long id, @RequestBody Map<String, Object> request) {
        Long userId = Long.valueOf(request.get("userId").toString());
        String title = request.get("title").toString();
        String content = request.get("content").toString();
        String htmlContent = request.get("htmlContent") != null ? request.get("htmlContent").toString() : "";
        String summary = request.get("summary") != null ? request.get("summary").toString() : "";
        String coverImage = request.get("coverImage") != null ? request.get("coverImage").toString() : null;
        Long categoryId = request.get("categoryId") != null ? Long.valueOf(request.get("categoryId").toString()) : null;
        @SuppressWarnings("unchecked")
        List<String> tagNames = (List<String>) request.get("tags");
        
        Article article = articleService.updateArticle(id, userId, title, content, htmlContent, summary, coverImage, categoryId, tagNames);
        return ResponseEntity.ok(article);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<Article> getArticle(@PathVariable Long id) {
        Article article = articleService.getArticleById(id);
        return ResponseEntity.ok(article);
    }
    
    @GetMapping
    public ResponseEntity<Page<Article>> getAllArticles(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String sort) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Article> articles;
        if (sort != null && !sort.isEmpty()) {
            articles = articleService.getArticlesBySort(sort, pageable);
        } else {
            articles = articleService.getAllArticles(pageable);
        }
        return ResponseEntity.ok(articles);
    }
    
    @GetMapping("/category/{categoryId}")
    public ResponseEntity<Page<Article>> getArticlesByCategory(
            @PathVariable Long categoryId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Article> articles = articleService.getArticlesByCategory(categoryId, pageable);
        return ResponseEntity.ok(articles);
    }
    
    @GetMapping("/tag/{tagId}")
    public ResponseEntity<Page<Article>> getArticlesByTag(
            @PathVariable Long tagId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Article> articles = articleService.getArticlesByTag(tagId, pageable);
        return ResponseEntity.ok(articles);
    }
    
    @GetMapping("/search")
    public ResponseEntity<Page<Article>> searchArticles(
            @RequestParam String keyword,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Article> articles = articleService.searchArticles(keyword, pageable);
        return ResponseEntity.ok(articles);
    }
    
    @GetMapping("/user/{userId}")
    public ResponseEntity<Page<Article>> getArticlesByUser(
            @PathVariable Long userId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Article> articles = articleService.getArticlesByUser(userId, pageable);
        return ResponseEntity.ok(articles);
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteArticle(@PathVariable Long id, @RequestParam Long userId) {
        articleService.deleteArticle(id, userId);
        return ResponseEntity.ok().build();
    }
    
    // 保存草稿
    @PostMapping("/drafts")
    public ResponseEntity<Article> saveDraft(@RequestBody Map<String, Object> request) {
        Long userId = Long.valueOf(request.get("userId").toString());
        String title = request.get("title") != null ? request.get("title").toString() : "";
        String content = request.get("content") != null ? request.get("content").toString() : "";
        String htmlContent = request.get("htmlContent") != null ? request.get("htmlContent").toString() : "";
        String summary = request.get("summary") != null ? request.get("summary").toString() : "";
        String coverImage = request.get("coverImage") != null ? request.get("coverImage").toString() : null;
        Long categoryId = request.get("categoryId") != null ? Long.valueOf(request.get("categoryId").toString()) : null;
        @SuppressWarnings("unchecked")
        List<String> tagNames = (List<String>) request.get("tags");
        
        Article article = articleService.saveDraft(userId, title, content, htmlContent, summary, coverImage, categoryId, tagNames);
        return ResponseEntity.ok(article);
    }
    
    // 更新草稿
    @PutMapping("/drafts/{id}")
    public ResponseEntity<Article> updateDraft(@PathVariable Long id, @RequestBody Map<String, Object> request) {
        Long userId = Long.valueOf(request.get("userId").toString());
        String title = request.get("title") != null ? request.get("title").toString() : "";
        String content = request.get("content") != null ? request.get("content").toString() : "";
        String htmlContent = request.get("htmlContent") != null ? request.get("htmlContent").toString() : "";
        String summary = request.get("summary") != null ? request.get("summary").toString() : "";
        String coverImage = request.get("coverImage") != null ? request.get("coverImage").toString() : null;
        Long categoryId = request.get("categoryId") != null ? Long.valueOf(request.get("categoryId").toString()) : null;
        @SuppressWarnings("unchecked")
        List<String> tagNames = (List<String>) request.get("tags");
        
        Article article = articleService.updateDraft(id, userId, title, content, htmlContent, summary, coverImage, categoryId, tagNames);
        return ResponseEntity.ok(article);
    }
    
    // 发布草稿
    @PostMapping("/drafts/{id}/publish")
    public ResponseEntity<Article> publishDraft(@PathVariable Long id, @RequestParam Long userId) {
        Article article = articleService.publishDraft(id, userId);
        return ResponseEntity.ok(article);
    }
    
    // 获取用户的草稿列表
    @GetMapping("/drafts")
    public ResponseEntity<Page<Article>> getDrafts(
            @RequestParam Long userId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Article> drafts = articleService.getDraftsByUser(userId, pageable);
        return ResponseEntity.ok(drafts);
    }
    
    // 获取用户最近的一篇草稿
    @GetMapping("/drafts/latest")
    public ResponseEntity<Article> getLatestDraft(@RequestParam Long userId) {
        Article draft = articleService.getLatestDraft(userId);
        if (draft == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(draft);
    }
    
    // 置顶/取消置顶文章（仅管理员）
    @PutMapping("/{id}/pin")
    public ResponseEntity<Article> togglePinArticle(
            @PathVariable Long id,
            @RequestHeader(value = "Authorization", required = false) String token) {
        if (token == null || token.isEmpty()) {
            return ResponseEntity.status(401).build();
        }
        try {
            String cleanToken = token.startsWith("Bearer ") ? token.substring(7) : token;
            Long userId = jwtUtil.getUserIdFromToken(cleanToken);
            Article article = articleService.togglePinArticle(id, userId);
            return ResponseEntity.ok(article);
        } catch (RuntimeException e) {
            return ResponseEntity.status(403).build();
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }
}
