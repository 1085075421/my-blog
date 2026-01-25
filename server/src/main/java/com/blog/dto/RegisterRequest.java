package com.blog.dto;

import lombok.Data;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Data
public class RegisterRequest {
    @NotBlank(message = "账号不能为空")
    @Size(min = 3, max = 20, message = "账号长度必须在3-20个字符之间")
    @jakarta.validation.constraints.Pattern(regexp = "^[a-zA-Z0-9]+$", message = "账号只能包含英文字母和数字")
    private String account; // 账号（英文+数字）
    
    @Size(max = 20, message = "昵称长度不能超过20个字符")
    private String username; // 昵称（可选）
    
    @NotBlank(message = "邮箱不能为空")
    @Email(message = "邮箱格式不正确")
    private String email;
    
    @NotBlank(message = "密码不能为空")
    @Size(min = 6, message = "密码长度至少6个字符")
    private String password;
}
