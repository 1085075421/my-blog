package com.blog.dto;

import lombok.Data;
import jakarta.validation.constraints.NotBlank;

@Data
public class LoginRequest {
    @NotBlank(message = "账号不能为空")
    private String account; // 使用账号登录
    
    @NotBlank(message = "密码不能为空")
    private String password;
}
