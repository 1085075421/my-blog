package com.blog.service;

import com.blog.entity.Article;
import com.blog.entity.ArticleFavorite;
import com.blog.entity.User;
import com.blog.repository.ArticleFavoriteRepository;
import com.blog.repository.ArticleRepository;
import com.blog.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class FavoriteService {
    
    @Autowired
    private ArticleFavoriteRepository favoriteRepository;
    
    @Autowired
    private ArticleRepository articleRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private UserService userService;
    
    @Transactional
    public boolean toggleFavorite(Long articleId, Long userId) {
        Article article = articleRepository.findById(articleId)
                .orElseThrow(() -> new RuntimeException("文章不存在"));
        
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
        
        ArticleFavorite favorite = favoriteRepository.findByArticleIdAndUserId(articleId, userId)
                .orElse(null);
        
        if (favorite != null) {
            // 取消收藏
            favoriteRepository.delete(favorite);
            return false;
        } else {
            // 收藏
            ArticleFavorite newFavorite = new ArticleFavorite();
            newFavorite.setArticle(article);
            newFavorite.setUser(user);
            favoriteRepository.save(newFavorite);
            
            // 收藏获得经验值：2点
            userService.addExperience(userId, 2, "favorite_article");
            
            return true;
        }
    }
    
    public boolean isFavorited(Long articleId, Long userId) {
        return favoriteRepository.existsByArticleIdAndUserId(articleId, userId);
    }
    
    public Page<ArticleFavorite> getFavoritesByUser(Long userId, Pageable pageable) {
        return favoriteRepository.findByUserId(userId, pageable);
    }
}
