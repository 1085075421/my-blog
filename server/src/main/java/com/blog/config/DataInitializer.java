package com.blog.config;

import com.blog.entity.Category;
import com.blog.entity.Tag;
import com.blog.repository.CategoryRepository;
import com.blog.repository.TagRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Component
public class DataInitializer implements CommandLineRunner {
    
    private static final Logger logger = LoggerFactory.getLogger(DataInitializer.class);
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private TagRepository tagRepository;
    
    @Override
    public void run(String... args) {
        initializeCategories();
        initializeTags();
    }
    
    private void initializeCategories() {
        List<String> defaultCategories = Arrays.asList(
            "技术分享", "生活随笔", "学习笔记", "项目经验", 
            "前端开发", "后端开发", "数据库", "算法与数据结构",
            "工具推荐", "问题解决", "读书笔记", "个人成长"
        );
        
        for (String categoryName : defaultCategories) {
            if (!categoryRepository.findByName(categoryName).isPresent()) {
                Category category = new Category();
                category.setName(categoryName);
                category.setDescription("系统默认分类");
                categoryRepository.save(category);
                logger.info("创建默认分类: {}", categoryName);
            }
        }
    }
    
    private void initializeTags() {
        List<String> defaultTags = Arrays.asList(
            "Java", "Spring Boot", "Vue", "JavaScript", "Python",
            "MySQL", "Redis", "Docker", "Linux", "Git",
            "算法", "数据结构", "设计模式", "微服务", "分布式",
            "前端", "后端", "全栈", "移动开发", "Web开发",
            "学习", "分享", "经验", "教程", "总结"
        );
        
        for (String tagName : defaultTags) {
            if (!tagRepository.findByName(tagName).isPresent()) {
                Tag tag = new Tag();
                tag.setName(tagName);
                tagRepository.save(tag);
                logger.info("创建默认标签: {}", tagName);
            }
        }
    }
}
