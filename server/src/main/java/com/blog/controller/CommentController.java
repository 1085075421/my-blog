package com.blog.controller;

import com.blog.entity.Comment;
import com.blog.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/comments")
@CrossOrigin(origins = "*")
public class CommentController {
    
    @Autowired
    private CommentService commentService;
    
    @PostMapping
    public ResponseEntity<Comment> createComment(@RequestBody Map<String, Object> request) {
        Long articleId = Long.valueOf(request.get("articleId").toString());
        Long userId = Long.valueOf(request.get("userId").toString());
        String content = request.get("content").toString();
        Long parentId = request.get("parentId") != null ? Long.valueOf(request.get("parentId").toString()) : null;
        
        Comment comment = commentService.createComment(articleId, userId, content, parentId);
        return ResponseEntity.ok(comment);
    }
    
    @GetMapping("/article/{articleId}")
    public ResponseEntity<List<Comment>> getCommentsByArticle(@PathVariable Long articleId) {
        List<Comment> comments = commentService.getCommentsByArticle(articleId);
        return ResponseEntity.ok(comments);
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteComment(@PathVariable Long id, @RequestParam Long userId) {
        commentService.deleteComment(id, userId);
        return ResponseEntity.ok().build();
    }
}
