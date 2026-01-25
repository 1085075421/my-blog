package com.blog.controller;

import com.blog.entity.User;
import com.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Set;

@RestController
@RequestMapping("/users")
@CrossOrigin(origins = "*")
public class UserController {
    
    @Autowired
    private UserService userService;
    
    @GetMapping("/{id}")
    public ResponseEntity<User> getUser(@PathVariable Long id) {
        User user = userService.getUserById(id);
        // 避免返回密码和循环引用
        user.setPassword(null);
        user.setFollowing(null);
        user.setFollowers(null);
        // 确保role字段返回
        if (user.getRole() == null) {
            user.setRole("USER");
        }
        return ResponseEntity.ok(user);
    }
    
    @GetMapping("/{id}/following")
    public ResponseEntity<Set<User>> getFollowing(@PathVariable Long id) {
        Set<User> following = userService.getFollowing(id);
        // 清理循环引用和敏感信息
        following.forEach(u -> {
            u.setPassword(null);
            u.setFollowing(null);
            u.setFollowers(null);
        });
        return ResponseEntity.ok(following);
    }
    
    @GetMapping("/{id}/followers")
    public ResponseEntity<Set<User>> getFollowers(@PathVariable Long id) {
        Set<User> followers = userService.getFollowers(id);
        // 清理循环引用和敏感信息
        followers.forEach(u -> {
            u.setPassword(null);
            u.setFollowing(null);
            u.setFollowers(null);
        });
        return ResponseEntity.ok(followers);
    }
    
    @PutMapping("/{id}/profile")
    public ResponseEntity<User> updateProfile(
            @PathVariable Long id,
            @RequestBody Map<String, String> request) {
        String username = request.get("username");
        String avatar = request.get("avatar");
        String bio = request.get("bio");
        
        User user = userService.updateProfile(id, username, avatar, bio);
        return ResponseEntity.ok(user);
    }
    
    @PutMapping("/{id}/password")
    public ResponseEntity<Map<String, String>> changePassword(
            @PathVariable Long id,
            @RequestBody Map<String, String> request) {
        String oldPassword = request.get("oldPassword");
        String newPassword = request.get("newPassword");
        
        userService.changePassword(id, oldPassword, newPassword);
        return ResponseEntity.ok(Map.of("message", "密码修改成功"));
    }
    
    @GetMapping("/{id}/level-info")
    public ResponseEntity<Map<String, Object>> getLevelInfo(@PathVariable Long id) {
        User user = userService.getUserById(id);
        int level = user.getLevel();
        int currentExp = user.getExperience();
        int currentLevelExp = userService.getCurrentLevelExperience(level);
        int nextLevelExp = userService.getNextLevelExperience(level);
        
        int progress;
        if (level >= 10) {
            progress = 100; // 满级
        } else {
            int expRange = nextLevelExp - currentLevelExp;
            int expProgress = currentExp - currentLevelExp;
            progress = expRange > 0 ? (int) ((double) expProgress / expRange * 100) : 0;
            progress = Math.max(0, Math.min(100, progress)); // 限制在0-100之间
        }
        
        return ResponseEntity.ok(Map.of(
            "level", level,
            "experience", currentExp,
            "dailyExperience", user.getDailyExperience() != null ? user.getDailyExperience() : 0,
            "badge", userService.getLevelBadge(level),
            "nextLevelExp", nextLevelExp,
            "progress", progress
        ));
    }
}
