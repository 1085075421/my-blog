package com.blog.service;

import com.blog.entity.User;
import com.blog.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Set;

@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    public User getUserById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
    }
    
    public Set<User> getFollowing(Long userId) {
        User user = getUserById(userId);
        return user.getFollowing();
    }
    
    public Set<User> getFollowers(Long userId) {
        User user = getUserById(userId);
        return user.getFollowers();
    }
    
    public long getFollowingCount(Long userId) {
        User user = getUserById(userId);
        return user.getFollowing().size();
    }
    
    public long getFollowersCount(Long userId) {
        User user = getUserById(userId);
        return user.getFollowers().size();
    }
    
    @Transactional
    public User updateProfile(Long userId, String username, String avatar, String bio) {
        User user = getUserById(userId);
        
        // 检查用户名是否已被其他用户使用
        if (username != null && !username.equals(user.getUsername())) {
            if (userRepository.existsByUsername(username)) {
                throw new RuntimeException("用户名已被使用");
            }
            user.setUsername(username);
        }
        
        if (avatar != null) {
            user.setAvatar(avatar);
        }
        
        if (bio != null) {
            user.setBio(bio);
        }
        
        return userRepository.save(user);
    }
    
    @Transactional
    public void changePassword(Long userId, String oldPassword, String newPassword) {
        User user = getUserById(userId);
        
        // 验证旧密码
        if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
            throw new RuntimeException("旧密码错误");
        }
        
        // 设置新密码
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);
    }
    
    // 计算等级（1-10级）
    public int calculateLevel(int experience) {
        if (experience < 10) return 1;
        if (experience < 50) return 2;
        if (experience < 150) return 3;
        if (experience < 300) return 4;
        if (experience < 500) return 5;
        if (experience < 800) return 6;
        if (experience < 1200) return 7;
        if (experience < 1800) return 8;
        if (experience < 2500) return 9;
        return 10;
    }
    
    // 获取等级标识（emoji或文字）
    public String getLevelBadge(int level) {
        switch (level) {
            case 1: return "🌱"; // 新芽
            case 2: return "🌿"; // 嫩叶
            case 3: return "🍀"; // 三叶草
            case 4: return "🌳"; // 小树
            case 5: return "🌲"; // 大树
            case 6: return "⭐"; // 星星
            case 7: return "🌟"; // 闪星
            case 8: return "💫"; // 流星
            case 9: return "✨"; // 闪光
            case 10: return "👑"; // 皇冠
            default: return "🌱";
        }
    }
    
    // 添加经验值（带每日限制）
    @Transactional
    public void addExperience(Long userId, int amount, String action) {
        User user = getUserById(userId);
        
        // 初始化经验值字段（兼容旧数据）
        if (user.getExperience() == null) {
            user.setExperience(0);
        }
        if (user.getLevel() == null) {
            user.setLevel(1);
        }
        if (user.getDailyExperience() == null) {
            user.setDailyExperience(0);
        }
        
        // 检查是否需要重置每日经验
        LocalDateTime now = LocalDateTime.now();
        if (user.getLastExperienceReset() == null || 
            user.getLastExperienceReset().toLocalDate().isBefore(now.toLocalDate())) {
            user.setDailyExperience(0);
            user.setLastExperienceReset(now);
        }
        
        // 每日经验上限：100点
        int dailyLimit = 100;
        int currentDaily = user.getDailyExperience() != null ? user.getDailyExperience() : 0;
        int remainingDaily = dailyLimit - currentDaily;
        
        if (remainingDaily <= 0) {
            return; // 今日经验已满
        }
        
        // 实际获得的经验值（不超过每日剩余）
        int actualAmount = Math.min(amount, remainingDaily);
        
        // 更新经验值
        int oldExperience = user.getExperience() != null ? user.getExperience() : 0;
        user.setExperience(oldExperience + actualAmount);
        user.setDailyExperience(currentDaily + actualAmount);
        
        // 计算新等级
        int newLevel = calculateLevel(user.getExperience());
        user.setLevel(newLevel);
        
        userRepository.save(user);
    }
    
    // 获取当前等级所需经验
    public int getCurrentLevelExperience(int level) {
        switch (level) {
            case 1: return 0;
            case 2: return 10;
            case 3: return 50;
            case 4: return 150;
            case 5: return 300;
            case 6: return 500;
            case 7: return 800;
            case 8: return 1200;
            case 9: return 1800;
            case 10: return 2500;
            default: return 0;
        }
    }
    
    // 获取下一级所需经验
    public int getNextLevelExperience(int currentLevel) {
        switch (currentLevel) {
            case 1: return 10;
            case 2: return 50;
            case 3: return 150;
            case 4: return 300;
            case 5: return 500;
            case 6: return 800;
            case 7: return 1200;
            case 8: return 1800;
            case 9: return 2500;
            case 10: return 2500; // 满级，保持最大值
            default: return 10;
        }
    }
}
