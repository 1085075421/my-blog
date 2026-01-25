package com.blog.service;

import com.blog.entity.Article;
import com.blog.entity.Category;
import com.blog.entity.Tag;
import com.blog.entity.User;
import com.blog.repository.ArticleRepository;
import com.blog.repository.CategoryRepository;
import com.blog.repository.TagRepository;
import com.blog.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class ArticleService {
    
    @Autowired
    private ArticleRepository articleRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private TagRepository tagRepository;
    
    @Autowired
    private UserService userService;
    
    @Transactional
    public Article createArticle(Long userId, String title, String content, 
                                String htmlContent, String summary, 
                                String coverImage, Long categoryId, List<String> tagNames) {
        User author = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
        
        Article article = new Article();
        article.setTitle(title);
        article.setContent(content);
        article.setHtmlContent(htmlContent);
        article.setSummary(summary);
        article.setCoverImage(coverImage);
        article.setAuthor(author);
        
        if (categoryId != null) {
            Category category = categoryRepository.findById(categoryId)
                    .orElse(null);
            article.setCategory(category);
        }
        
        if (tagNames != null && !tagNames.isEmpty()) {
            Set<Tag> tags = new HashSet<>();
            for (String tagName : tagNames) {
                Tag tag = tagRepository.findByName(tagName)
                        .orElseGet(() -> {
                            Tag newTag = new Tag();
                            newTag.setName(tagName);
                            return tagRepository.save(newTag);
                        });
                tags.add(tag);
            }
            article.setTags(tags);
        }
        
        Article savedArticle = articleRepository.save(article);
        
        // 发布文章获得经验值：10点
        userService.addExperience(userId, 10, "publish_article");
        
        return savedArticle;
    }
    
    @Transactional
    public Article updateArticle(Long articleId, Long userId, String title, 
                                String content, String htmlContent, String summary,
                                String coverImage, Long categoryId, List<String> tagNames) {
        Article article = articleRepository.findById(articleId)
                .orElseThrow(() -> new RuntimeException("文章不存在"));
        
        if (!article.getAuthor().getId().equals(userId)) {
            throw new RuntimeException("无权修改此文章");
        }
        
        article.setTitle(title);
        article.setContent(content);
        article.setHtmlContent(htmlContent);
        article.setSummary(summary);
        if (coverImage != null) {
            article.setCoverImage(coverImage);
        }
        
        if (categoryId != null) {
            Category category = categoryRepository.findById(categoryId)
                    .orElse(null);
            article.setCategory(category);
        }
        
        if (tagNames != null) {
            Set<Tag> tags = new HashSet<>();
            for (String tagName : tagNames) {
                Tag tag = tagRepository.findByName(tagName)
                        .orElseGet(() -> {
                            Tag newTag = new Tag();
                            newTag.setName(tagName);
                            return tagRepository.save(newTag);
                        });
                tags.add(tag);
            }
            article.setTags(tags);
        }
        
        return articleRepository.save(article);
    }
    
    public Article getArticleById(Long id) {
        Article article = articleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("文章不存在"));
        article.setViewCount(article.getViewCount() + 1);
        articleRepository.save(article);
        return article;
    }
    
    public Page<Article> getAllArticles(Pageable pageable) {
        return articleRepository.findAllByOrderByCreatedAtDesc(pageable);
    }
    
    public Page<Article> getArticlesBySort(String sortBy, Pageable pageable) {
        switch (sortBy) {
            case "latest":
                return articleRepository.findAllByOrderByCreatedAtDesc(pageable);
            case "likes":
                return articleRepository.findAllByOrderByLikeCountDesc(pageable);
            case "views":
                return articleRepository.findAllByOrderByViewCountDesc(pageable);
            case "favorites":
                return articleRepository.findAllByOrderByFavoriteCountDesc(pageable);
            default:
                return articleRepository.findAllByOrderByCreatedAtDesc(pageable);
        }
    }
    
    public Page<Article> getArticlesByCategory(Long categoryId, Pageable pageable) {
        return articleRepository.findByCategoryId(categoryId, pageable);
    }
    
    public Page<Article> getArticlesByTag(Long tagId, Pageable pageable) {
        return articleRepository.findByTagId(tagId, pageable);
    }
    
    public Page<Article> searchArticles(String keyword, Pageable pageable) {
        return articleRepository.searchByKeyword(keyword, pageable);
    }
    
    public Page<Article> getArticlesByUser(Long userId, Pageable pageable) {
        return articleRepository.findByAuthorId(userId, pageable);
    }
    
    @Transactional
    public void deleteArticle(Long articleId, Long userId) {
        Article article = articleRepository.findById(articleId)
                .orElseThrow(() -> new RuntimeException("文章不存在"));
        
        if (!article.getAuthor().getId().equals(userId)) {
            throw new RuntimeException("无权删除此文章");
        }
        
        articleRepository.delete(article);
    }
}
