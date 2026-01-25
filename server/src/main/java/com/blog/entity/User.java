package com.blog.entity;

import jakarta.persistence.*;
import lombok.Data;
import com.fasterxml.jackson.annotation.JsonIgnore;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "users")
@Data
@lombok.EqualsAndHashCode(exclude = {"following", "followers"})
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(unique = true, nullable = false, updatable = false)
    private String account; // 账号（英文+数字，不可修改）
    
    @Column(nullable = false)
    private String username; // 昵称（可修改）
    
    @Column(unique = true, nullable = false)
    private String email;
    
    @Column(nullable = false)
    @JsonIgnore
    private String password;
    
    private String avatar;
    private String bio;
    
    @Column(name = "experience", columnDefinition = "INT DEFAULT 0")
    private Integer experience = 0; // 经验值
    
    @Column(name = "level", columnDefinition = "INT DEFAULT 1")
    private Integer level = 1; // 等级（1-10）
    
    @Column(name = "daily_experience", columnDefinition = "INT DEFAULT 0")
    private Integer dailyExperience = 0; // 今日已获得经验值
    
    @Column(name = "last_experience_reset")
    private LocalDateTime lastExperienceReset; // 上次经验重置时间
    
    @Column(name = "role", columnDefinition = "VARCHAR(20) DEFAULT 'USER'")
    private String role = "USER"; // 角色：USER, ADMIN
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // 关注关系：我关注的人
    @ManyToMany
    @JoinTable(
        name = "user_follows",
        joinColumns = @JoinColumn(name = "follower_id"),
        inverseJoinColumns = @JoinColumn(name = "following_id")
    )
    @JsonIgnore
    private Set<User> following = new HashSet<>();
    
    // 关注关系：关注我的人
    @ManyToMany(mappedBy = "following")
    @JsonIgnore
    private Set<User> followers = new HashSet<>();
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
