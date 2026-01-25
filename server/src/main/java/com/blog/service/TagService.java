package com.blog.service;

import com.blog.entity.Tag;
import com.blog.repository.TagRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TagService {
    
    @Autowired
    private TagRepository tagRepository;
    
    public List<Tag> getAllTags() {
        return tagRepository.findAll();
    }
    
    public List<Tag> getPopularTags(int limit) {
        // 获取所有标签，按文章数量排序（热门标签）
        List<Tag> allTags = tagRepository.findAll();
        return allTags.stream()
                .sorted((a, b) -> {
                    int sizeA = (a.getArticles() != null && !a.getArticles().isEmpty()) ? a.getArticles().size() : 0;
                    int sizeB = (b.getArticles() != null && !b.getArticles().isEmpty()) ? b.getArticles().size() : 0;
                    return Integer.compare(sizeB, sizeA);
                })
                .limit(limit)
                .collect(Collectors.toList());
    }
    
    public Tag createTag(String name) {
        // 如果标签已存在，直接返回
        return tagRepository.findByName(name)
                .orElseGet(() -> {
                    Tag tag = new Tag();
                    tag.setName(name);
                    return tagRepository.save(tag);
                });
    }
}
