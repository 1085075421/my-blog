package com.blog.repository;

import com.blog.entity.Article;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArticleRepository extends JpaRepository<Article, Long> {
    // 查询用户文章，置顶文章排在前面
    @Query("SELECT a FROM Article a WHERE a.author.id = :authorId AND a.draft = false ORDER BY a.pinned DESC, a.createdAt DESC")
    Page<Article> findByAuthorId(@Param("authorId") Long authorId, Pageable pageable);
    
    // 按分类查询，置顶文章排在前面
    @Query("SELECT a FROM Article a WHERE a.category.id = :categoryId AND a.draft = false ORDER BY a.pinned DESC, a.createdAt DESC")
    Page<Article> findByCategoryId(@Param("categoryId") Long categoryId, Pageable pageable);
    
    // 按标签查询，置顶文章排在前面
    @Query("SELECT a FROM Article a JOIN a.tags t WHERE t.id = :tagId AND a.draft = false ORDER BY a.pinned DESC, a.createdAt DESC")
    Page<Article> findByTagId(@Param("tagId") Long tagId, Pageable pageable);
    
    // 搜索文章，置顶文章排在前面
    @Query("SELECT a FROM Article a WHERE (a.title LIKE %:keyword% OR a.content LIKE %:keyword%) AND a.draft = false ORDER BY a.pinned DESC, a.createdAt DESC")
    Page<Article> searchByKeyword(@Param("keyword") String keyword, Pageable pageable);
    
    // 查询所有文章，置顶文章排在前面，然后按创建时间倒序
    @Query("SELECT a FROM Article a WHERE a.draft = false ORDER BY a.pinned DESC, a.createdAt DESC")
    Page<Article> findAllByOrderByCreatedAtDesc(Pageable pageable);
    
    // 按点赞数排序，置顶文章排在前面
    @Query("SELECT a FROM Article a WHERE a.draft = false ORDER BY a.pinned DESC, a.likeCount DESC, a.createdAt DESC")
    Page<Article> findAllByOrderByLikeCountDesc(Pageable pageable);
    
    // 按阅读数排序，置顶文章排在前面
    @Query("SELECT a FROM Article a WHERE a.draft = false ORDER BY a.pinned DESC, a.viewCount DESC, a.createdAt DESC")
    Page<Article> findAllByOrderByViewCountDesc(Pageable pageable);
    
    // 按收藏数排序，置顶文章排在前面
    @Query("SELECT a FROM Article a LEFT JOIN a.favorites f WHERE a.draft = false GROUP BY a.id ORDER BY a.pinned DESC, COUNT(f.id) DESC, a.createdAt DESC")
    Page<Article> findAllByOrderByFavoriteCountDesc(Pageable pageable);
    
    // 查询用户的草稿列表（按更新时间倒序）
    Page<Article> findByAuthorIdAndDraftTrueOrderByUpdatedAtDesc(Long authorId, Pageable pageable);
    
    // 查询用户最近的一篇草稿
    @Query("SELECT a FROM Article a WHERE a.author.id = :authorId AND a.draft = true ORDER BY a.updatedAt DESC")
    List<Article> findLatestDraftByAuthorId(@Param("authorId") Long authorId, Pageable pageable);
}
