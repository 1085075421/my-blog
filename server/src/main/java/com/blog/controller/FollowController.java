package com.blog.controller;

import com.blog.service.FollowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/follows")
@CrossOrigin(origins = "*")
public class FollowController {
    
    @Autowired
    private FollowService followService;
    
    @PostMapping("/toggle")
    public ResponseEntity<Map<String, Object>> toggleFollow(@RequestBody Map<String, Long> request) {
        Long followerId = request.get("followerId");
        Long followingId = request.get("followingId");
        boolean isFollowing = followService.toggleFollow(followerId, followingId);
        return ResponseEntity.ok(Map.of("isFollowing", isFollowing));
    }
    
    @GetMapping("/check")
    public ResponseEntity<Map<String, Object>> checkFollow(
            @RequestParam Long followerId,
            @RequestParam Long followingId) {
        boolean isFollowing = followService.isFollowing(followerId, followingId);
        return ResponseEntity.ok(Map.of("isFollowing", isFollowing));
    }
}
