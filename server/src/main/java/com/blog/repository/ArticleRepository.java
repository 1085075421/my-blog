package com.blog.repository;

import com.blog.entity.Article;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ArticleRepository extends JpaRepository<Article, Long> {
    Page<Article> findByAuthorId(Long authorId, Pageable pageable);
    Page<Article> findByCategoryId(Long categoryId, Pageable pageable);
    
    @Query("SELECT a FROM Article a JOIN a.tags t WHERE t.id = :tagId")
    Page<Article> findByTagId(@Param("tagId") Long tagId, Pageable pageable);
    
    @Query("SELECT a FROM Article a WHERE a.title LIKE %:keyword% OR a.content LIKE %:keyword%")
    Page<Article> searchByKeyword(@Param("keyword") String keyword, Pageable pageable);
    
    Page<Article> findAllByOrderByCreatedAtDesc(Pageable pageable);
    
    Page<Article> findAllByOrderByLikeCountDesc(Pageable pageable);
    
    Page<Article> findAllByOrderByViewCountDesc(Pageable pageable);
    
    @Query("SELECT a FROM Article a LEFT JOIN a.favorites f GROUP BY a.id ORDER BY COUNT(f.id) DESC, a.createdAt DESC")
    Page<Article> findAllByOrderByFavoriteCountDesc(Pageable pageable);
}
