package com.blog.controller;

import com.blog.service.LikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/likes")
@CrossOrigin(origins = "*")
public class LikeController {
    
    @Autowired
    private LikeService likeService;
    
    @PostMapping("/toggle")
    public ResponseEntity<Map<String, Object>> toggleLike(@RequestBody Map<String, Long> request) {
        Long articleId = request.get("articleId");
        Long userId = request.get("userId");
        boolean isLiked = likeService.toggleLike(articleId, userId);
        return ResponseEntity.ok(Map.of("isLiked", isLiked));
    }
    
    @GetMapping("/check")
    public ResponseEntity<Map<String, Object>> checkLike(
            @RequestParam Long articleId,
            @RequestParam Long userId) {
        boolean isLiked = likeService.isLiked(articleId, userId);
        return ResponseEntity.ok(Map.of("isLiked", isLiked));
    }
}
