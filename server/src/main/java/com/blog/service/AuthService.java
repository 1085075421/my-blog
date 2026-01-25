package com.blog.service;

import com.blog.dto.AuthResponse;
import com.blog.dto.LoginRequest;
import com.blog.dto.RegisterRequest;
import com.blog.entity.User;
import com.blog.repository.UserRepository;
import com.blog.util.JwtUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AuthService {
    
    private static final Logger logger = LoggerFactory.getLogger(AuthService.class);
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Transactional
    public AuthResponse register(RegisterRequest request) {
        logger.info("开始注册用户: account={}, email={}", request.getAccount(), request.getEmail());
        
        // 检查账号是否已存在
        if (userRepository.existsByAccount(request.getAccount())) {
            logger.warn("注册失败: 账号已存在 - {}", request.getAccount());
            throw new RuntimeException("账号已存在");
        }
        // 检查邮箱是否已被注册
        if (userRepository.existsByEmail(request.getEmail())) {
            logger.warn("注册失败: 邮箱已被注册 - {}", request.getEmail());
            throw new RuntimeException("邮箱已被注册");
        }
        
        // 创建新用户
        User user = new User();
        user.setAccount(request.getAccount());
        // 如果提供了昵称，使用昵称；否则使用账号作为默认昵称
        user.setUsername(request.getUsername() != null && !request.getUsername().trim().isEmpty() 
                        ? request.getUsername() 
                        : request.getAccount());
        user.setEmail(request.getEmail());
        // 加密密码
        String encodedPassword = passwordEncoder.encode(request.getPassword());
        user.setPassword(encodedPassword);
        user.setAvatar("https://cube.elemecdn.com/0/88/03b0d4ff20dd7589bb7fd77975b171gc.jpeg"); // 默认头像
        user.setBio("这个人很懒，什么都没留下"); // 默认简介
        
        logger.info("准备保存用户到数据库: account={}", request.getAccount());
        
        // 保存用户到数据库
        try {
            user = userRepository.save(user);
            // 确保用户已保存并获取ID
            if (user.getId() == null) {
                logger.error("用户保存失败: 未获取到用户ID");
                throw new RuntimeException("用户保存失败，未获取到用户ID");
            }
            logger.info("用户保存成功: id={}, account={}, username={}", user.getId(), user.getAccount(), user.getUsername());
        } catch (Exception e) {
            logger.error("保存用户失败: {}", e.getMessage(), e);
            throw new RuntimeException("保存用户失败: " + e.getMessage(), e);
        }
        
        // 生成JWT token
        String token = jwtUtil.generateToken(user.getId(), user.getAccount());
        logger.info("注册成功: userId={}, account={}", user.getId(), user.getAccount());
        
        // 返回认证响应
        return new AuthResponse(token, user.getId(), user.getAccount(), user.getUsername(),
                               user.getEmail(), user.getAvatar());
    }
    
    public AuthResponse login(LoginRequest request) {
        User user = userRepository.findByAccount(request.getAccount())
                .orElseThrow(() -> new RuntimeException("账号或密码错误"));
        
        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new RuntimeException("账号或密码错误");
        }
        
        String token = jwtUtil.generateToken(user.getId(), user.getAccount());
        return new AuthResponse(token, user.getId(), user.getAccount(), user.getUsername(),
                               user.getEmail(), user.getAvatar());
    }
}
