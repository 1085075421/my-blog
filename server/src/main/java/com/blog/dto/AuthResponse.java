package com.blog.dto;

import lombok.Data;

@Data
public class AuthResponse {
    private String token;
    private Long userId;
    private String account; // 账号
    private String username; // 昵称
    private String email;
    private String avatar;
    
    public AuthResponse(String token, Long userId, String account, String username, String email, String avatar) {
        this.token = token;
        this.userId = userId;
        this.account = account;
        this.username = username;
        this.email = email;
        this.avatar = avatar;
    }
}
