package com.blog.controller;

import com.blog.entity.Tag;
import com.blog.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/tags")
@CrossOrigin(origins = "*")
public class TagController {
    
    @Autowired
    private TagService tagService;
    
    @GetMapping
    public ResponseEntity<List<Tag>> getAllTags(@RequestParam(required = false) Boolean popular) {
        List<Tag> tags;
        if (popular != null && popular) {
            tags = tagService.getPopularTags(20); // 返回前20个热门标签
        } else {
            tags = tagService.getAllTags();
        }
        return ResponseEntity.ok(tags);
    }
    
    @PostMapping
    public ResponseEntity<Tag> createTag(@RequestBody Map<String, String> request) {
        String name = request.get("name");
        if (name == null || name.trim().isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        Tag tag = tagService.createTag(name.trim());
        return ResponseEntity.ok(tag);
    }
}
