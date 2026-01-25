package com.blog.service;

import com.blog.entity.Article;
import com.blog.entity.ArticleLike;
import com.blog.entity.User;
import com.blog.repository.ArticleLikeRepository;
import com.blog.repository.ArticleRepository;
import com.blog.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LikeService {
    
    @Autowired
    private ArticleLikeRepository likeRepository;
    
    @Autowired
    private ArticleRepository articleRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private UserService userService;
    
    @Transactional
    public boolean toggleLike(Long articleId, Long userId) {
        Article article = articleRepository.findById(articleId)
                .orElseThrow(() -> new RuntimeException("文章不存在"));
        
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
        
        ArticleLike like = likeRepository.findByArticleIdAndUserId(articleId, userId)
                .orElse(null);
        
        if (like != null) {
            // 取消点赞
            likeRepository.delete(like);
            article.setLikeCount(Math.max(0, article.getLikeCount() - 1));
            articleRepository.save(article);
            return false;
        } else {
            // 点赞
            ArticleLike newLike = new ArticleLike();
            newLike.setArticle(article);
            newLike.setUser(user);
            likeRepository.save(newLike);
            article.setLikeCount(article.getLikeCount() + 1);
            articleRepository.save(article);
            
            // 点赞获得经验值：2点
            userService.addExperience(userId, 2, "like_article");
            
            return true;
        }
    }
    
    public boolean isLiked(Long articleId, Long userId) {
        return likeRepository.existsByArticleIdAndUserId(articleId, userId);
    }
}
