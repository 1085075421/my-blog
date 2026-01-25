package com.blog.service;

import com.blog.entity.User;
import com.blog.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class FollowService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Transactional
    public boolean toggleFollow(Long followerId, Long followingId) {
        if (followerId.equals(followingId)) {
            throw new RuntimeException("不能关注自己");
        }
        
        User follower = userRepository.findById(followerId)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
        
        User following = userRepository.findById(followingId)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
        
        if (follower.getFollowing().contains(following)) {
            // 取消关注
            follower.getFollowing().remove(following);
            userRepository.save(follower);
            return false;
        } else {
            // 关注
            follower.getFollowing().add(following);
            userRepository.save(follower);
            return true;
        }
    }
    
    public boolean isFollowing(Long followerId, Long followingId) {
        User follower = userRepository.findById(followerId)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
        
        User following = userRepository.findById(followingId)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
        
        return follower.getFollowing().contains(following);
    }
}
