package com.blog.controller;

import com.blog.entity.ArticleFavorite;
import com.blog.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/favorites")
@CrossOrigin(origins = "*")
public class FavoriteController {
    
    @Autowired
    private FavoriteService favoriteService;
    
    @PostMapping("/toggle")
    public ResponseEntity<Map<String, Object>> toggleFavorite(@RequestBody Map<String, Long> request) {
        Long articleId = request.get("articleId");
        Long userId = request.get("userId");
        boolean isFavorited = favoriteService.toggleFavorite(articleId, userId);
        return ResponseEntity.ok(Map.of("isFavorited", isFavorited));
    }
    
    @GetMapping("/check")
    public ResponseEntity<Map<String, Object>> checkFavorite(
            @RequestParam Long articleId,
            @RequestParam Long userId) {
        boolean isFavorited = favoriteService.isFavorited(articleId, userId);
        return ResponseEntity.ok(Map.of("isFavorited", isFavorited));
    }
    
    @GetMapping("/user/{userId}")
    public ResponseEntity<Page<ArticleFavorite>> getFavoritesByUser(
            @PathVariable Long userId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<ArticleFavorite> favorites = favoriteService.getFavoritesByUser(userId, pageable);
        return ResponseEntity.ok(favorites);
    }
}
