/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : blog_db

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 29/01/2026 17:17:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article_favorites
-- ----------------------------
DROP TABLE IF EXISTS `article_favorites`;
CREATE TABLE `article_favorites`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `article_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UKgi67b87kiyylp55v29w0s7xsq`(`article_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `FKogigrbv6299gc2lgy4yyo4pav`(`user_id` ASC) USING BTREE,
  CONSTRAINT `FKkwoosavyapalh4oepsyvojw91` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKogigrbv6299gc2lgy4yyo4pav` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 232 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_favorites
-- ----------------------------
INSERT INTO `article_favorites` VALUES (157, '2026-01-25 16:27:11.953588', 55, 50);
INSERT INTO `article_favorites` VALUES (158, '2026-01-25 16:27:11.955587', 55, 53);
INSERT INTO `article_favorites` VALUES (159, '2026-01-25 16:27:11.957589', 55, 57);
INSERT INTO `article_favorites` VALUES (160, '2026-01-25 16:27:11.959588', 55, 58);
INSERT INTO `article_favorites` VALUES (161, '2026-01-25 16:27:11.961098', 55, 55);
INSERT INTO `article_favorites` VALUES (162, '2026-01-25 16:27:11.962100', 56, 49);
INSERT INTO `article_favorites` VALUES (163, '2026-01-25 16:27:11.963099', 56, 54);
INSERT INTO `article_favorites` VALUES (164, '2026-01-25 16:27:11.963099', 56, 55);
INSERT INTO `article_favorites` VALUES (165, '2026-01-25 16:27:11.964101', 56, 52);
INSERT INTO `article_favorites` VALUES (166, '2026-01-25 16:27:11.965100', 56, 57);
INSERT INTO `article_favorites` VALUES (167, '2026-01-25 16:27:11.965100', 57, 52);
INSERT INTO `article_favorites` VALUES (168, '2026-01-25 16:27:11.966101', 57, 58);
INSERT INTO `article_favorites` VALUES (169, '2026-01-25 16:27:11.967100', 57, 50);
INSERT INTO `article_favorites` VALUES (170, '2026-01-25 16:27:11.967100', 57, 53);
INSERT INTO `article_favorites` VALUES (171, '2026-01-25 16:27:11.968100', 58, 55);
INSERT INTO `article_favorites` VALUES (172, '2026-01-25 16:27:11.968100', 58, 50);
INSERT INTO `article_favorites` VALUES (173, '2026-01-25 16:27:11.969098', 59, 55);
INSERT INTO `article_favorites` VALUES (174, '2026-01-25 16:27:11.969098', 59, 51);
INSERT INTO `article_favorites` VALUES (175, '2026-01-25 16:27:11.969098', 59, 49);
INSERT INTO `article_favorites` VALUES (176, '2026-01-25 16:27:11.970602', 60, 51);
INSERT INTO `article_favorites` VALUES (177, '2026-01-25 16:27:11.971606', 60, 53);
INSERT INTO `article_favorites` VALUES (178, '2026-01-25 16:27:11.971606', 60, 49);
INSERT INTO `article_favorites` VALUES (179, '2026-01-25 16:27:11.972608', 60, 52);
INSERT INTO `article_favorites` VALUES (180, '2026-01-25 16:27:11.972608', 60, 50);
INSERT INTO `article_favorites` VALUES (181, '2026-01-25 16:27:11.974115', 60, 57);
INSERT INTO `article_favorites` VALUES (182, '2026-01-25 16:27:11.975119', 61, 58);
INSERT INTO `article_favorites` VALUES (183, '2026-01-25 16:27:11.976120', 61, 50);
INSERT INTO `article_favorites` VALUES (184, '2026-01-25 16:27:11.976120', 61, 53);
INSERT INTO `article_favorites` VALUES (185, '2026-01-25 16:27:11.978118', 61, 57);
INSERT INTO `article_favorites` VALUES (186, '2026-01-25 16:27:11.978118', 61, 56);
INSERT INTO `article_favorites` VALUES (187, '2026-01-25 16:27:11.979119', 61, 51);
INSERT INTO `article_favorites` VALUES (188, '2026-01-25 16:27:11.979119', 61, 52);
INSERT INTO `article_favorites` VALUES (189, '2026-01-25 16:27:11.980119', 62, 49);
INSERT INTO `article_favorites` VALUES (190, '2026-01-25 16:27:11.980119', 63, 53);
INSERT INTO `article_favorites` VALUES (191, '2026-01-25 16:27:11.981130', 63, 56);
INSERT INTO `article_favorites` VALUES (192, '2026-01-25 16:27:11.982121', 63, 50);
INSERT INTO `article_favorites` VALUES (193, '2026-01-25 16:27:11.983121', 64, 57);
INSERT INTO `article_favorites` VALUES (194, '2026-01-25 16:27:11.985120', 64, 53);
INSERT INTO `article_favorites` VALUES (195, '2026-01-25 16:27:11.987119', 64, 52);
INSERT INTO `article_favorites` VALUES (196, '2026-01-25 16:27:11.987119', 64, 50);
INSERT INTO `article_favorites` VALUES (197, '2026-01-25 16:27:11.988119', 65, 53);
INSERT INTO `article_favorites` VALUES (198, '2026-01-25 16:27:11.989119', 66, 51);
INSERT INTO `article_favorites` VALUES (199, '2026-01-25 16:27:11.990119', 66, 55);
INSERT INTO `article_favorites` VALUES (200, '2026-01-25 16:27:11.990629', 66, 49);
INSERT INTO `article_favorites` VALUES (201, '2026-01-25 16:27:11.991631', 67, 55);
INSERT INTO `article_favorites` VALUES (202, '2026-01-25 16:27:11.991631', 67, 53);
INSERT INTO `article_favorites` VALUES (203, '2026-01-25 16:27:11.992632', 67, 56);
INSERT INTO `article_favorites` VALUES (204, '2026-01-25 16:27:11.992632', 67, 58);
INSERT INTO `article_favorites` VALUES (205, '2026-01-25 16:27:11.993631', 67, 57);
INSERT INTO `article_favorites` VALUES (206, '2026-01-25 16:27:11.993631', 67, 49);
INSERT INTO `article_favorites` VALUES (207, '2026-01-25 16:27:11.993631', 68, 50);
INSERT INTO `article_favorites` VALUES (208, '2026-01-25 16:27:11.995137', 68, 51);
INSERT INTO `article_favorites` VALUES (209, '2026-01-25 16:27:11.996145', 69, 51);
INSERT INTO `article_favorites` VALUES (210, '2026-01-25 16:27:11.997144', 69, 58);
INSERT INTO `article_favorites` VALUES (211, '2026-01-25 16:27:11.997144', 69, 50);
INSERT INTO `article_favorites` VALUES (212, '2026-01-25 16:27:11.998142', 69, 52);
INSERT INTO `article_favorites` VALUES (213, '2026-01-25 16:27:11.998142', 70, 52);
INSERT INTO `article_favorites` VALUES (214, '2026-01-25 16:27:12.000655', 71, 58);
INSERT INTO `article_favorites` VALUES (215, '2026-01-25 16:27:12.001659', 71, 52);
INSERT INTO `article_favorites` VALUES (216, '2026-01-25 16:27:12.003659', 71, 57);
INSERT INTO `article_favorites` VALUES (217, '2026-01-25 16:27:12.004167', 71, 49);
INSERT INTO `article_favorites` VALUES (218, '2026-01-25 16:27:12.005677', 71, 56);
INSERT INTO `article_favorites` VALUES (219, '2026-01-25 16:27:12.006684', 71, 53);
INSERT INTO `article_favorites` VALUES (220, '2026-01-25 16:27:12.007686', 72, 53);
INSERT INTO `article_favorites` VALUES (221, '2026-01-25 16:27:12.008685', 72, 57);
INSERT INTO `article_favorites` VALUES (222, '2026-01-25 16:27:12.008685', 72, 58);
INSERT INTO `article_favorites` VALUES (223, '2026-01-25 16:27:12.010191', 72, 52);
INSERT INTO `article_favorites` VALUES (224, '2026-01-25 16:27:12.010191', 72, 54);
INSERT INTO `article_favorites` VALUES (225, '2026-01-25 16:27:12.011196', 72, 51);
INSERT INTO `article_favorites` VALUES (226, '2026-01-25 16:27:12.011196', 72, 50);
INSERT INTO `article_favorites` VALUES (227, '2026-01-25 16:27:12.011196', 73, 55);
INSERT INTO `article_favorites` VALUES (228, '2026-01-25 16:27:12.012197', 74, 53);
INSERT INTO `article_favorites` VALUES (229, '2026-01-25 16:27:12.012197', 74, 57);
INSERT INTO `article_favorites` VALUES (230, '2026-01-25 16:27:12.012197', 74, 54);
INSERT INTO `article_favorites` VALUES (231, '2026-01-25 16:42:19.170389', 74, 60);

-- ----------------------------
-- Table structure for article_likes
-- ----------------------------
DROP TABLE IF EXISTS `article_likes`;
CREATE TABLE `article_likes`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `article_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK11dmunwp0m42370sg5g0bns9y`(`article_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `FKbtkgmxfbjkfelv3v7ty6mo3n8`(`user_id` ASC) USING BTREE,
  CONSTRAINT `FKbtkgmxfbjkfelv3v7ty6mo3n8` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKq68u12nmkwf7j0k72bg711amn` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 234 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_likes
-- ----------------------------
INSERT INTO `article_likes` VALUES (153, '2026-01-25 16:27:11.880418', 55, 58);
INSERT INTO `article_likes` VALUES (154, '2026-01-25 16:27:11.880924', 56, 56);
INSERT INTO `article_likes` VALUES (155, '2026-01-25 16:27:11.881926', 56, 57);
INSERT INTO `article_likes` VALUES (156, '2026-01-25 16:27:11.883434', 56, 55);
INSERT INTO `article_likes` VALUES (157, '2026-01-25 16:27:11.884441', 56, 52);
INSERT INTO `article_likes` VALUES (158, '2026-01-25 16:27:11.885946', 57, 54);
INSERT INTO `article_likes` VALUES (159, '2026-01-25 16:27:11.885946', 57, 56);
INSERT INTO `article_likes` VALUES (160, '2026-01-25 16:27:11.886949', 58, 55);
INSERT INTO `article_likes` VALUES (161, '2026-01-25 16:27:11.887948', 58, 58);
INSERT INTO `article_likes` VALUES (162, '2026-01-25 16:27:11.888950', 58, 50);
INSERT INTO `article_likes` VALUES (163, '2026-01-25 16:27:11.888950', 58, 51);
INSERT INTO `article_likes` VALUES (164, '2026-01-25 16:27:11.889950', 59, 51);
INSERT INTO `article_likes` VALUES (165, '2026-01-25 16:27:11.891952', 59, 49);
INSERT INTO `article_likes` VALUES (166, '2026-01-25 16:27:11.893459', 59, 54);
INSERT INTO `article_likes` VALUES (167, '2026-01-25 16:27:11.894467', 59, 56);
INSERT INTO `article_likes` VALUES (168, '2026-01-25 16:27:11.896466', 60, 50);
INSERT INTO `article_likes` VALUES (169, '2026-01-25 16:27:11.897465', 61, 49);
INSERT INTO `article_likes` VALUES (170, '2026-01-25 16:27:11.898466', 61, 56);
INSERT INTO `article_likes` VALUES (171, '2026-01-25 16:27:11.898466', 61, 53);
INSERT INTO `article_likes` VALUES (172, '2026-01-25 16:27:11.899467', 61, 51);
INSERT INTO `article_likes` VALUES (173, '2026-01-25 16:27:11.900973', 61, 50);
INSERT INTO `article_likes` VALUES (174, '2026-01-25 16:27:11.900973', 62, 53);
INSERT INTO `article_likes` VALUES (175, '2026-01-25 16:27:11.901979', 62, 50);
INSERT INTO `article_likes` VALUES (176, '2026-01-25 16:27:11.902977', 62, 57);
INSERT INTO `article_likes` VALUES (177, '2026-01-25 16:27:11.903977', 62, 55);
INSERT INTO `article_likes` VALUES (178, '2026-01-25 16:27:11.905977', 62, 54);
INSERT INTO `article_likes` VALUES (179, '2026-01-25 16:27:11.906978', 62, 49);
INSERT INTO `article_likes` VALUES (180, '2026-01-25 16:27:11.907980', 63, 53);
INSERT INTO `article_likes` VALUES (181, '2026-01-25 16:27:11.908978', 63, 54);
INSERT INTO `article_likes` VALUES (182, '2026-01-25 16:27:11.910485', 64, 51);
INSERT INTO `article_likes` VALUES (183, '2026-01-25 16:27:11.911492', 64, 56);
INSERT INTO `article_likes` VALUES (184, '2026-01-25 16:27:11.912492', 64, 57);
INSERT INTO `article_likes` VALUES (185, '2026-01-25 16:27:11.912492', 64, 53);
INSERT INTO `article_likes` VALUES (186, '2026-01-25 16:27:11.913491', 65, 51);
INSERT INTO `article_likes` VALUES (187, '2026-01-25 16:27:11.913997', 65, 58);
INSERT INTO `article_likes` VALUES (188, '2026-01-25 16:27:11.913997', 65, 56);
INSERT INTO `article_likes` VALUES (189, '2026-01-25 16:27:11.916511', 65, 57);
INSERT INTO `article_likes` VALUES (190, '2026-01-25 16:27:11.917511', 65, 50);
INSERT INTO `article_likes` VALUES (191, '2026-01-25 16:27:11.918510', 66, 49);
INSERT INTO `article_likes` VALUES (192, '2026-01-25 16:27:11.918510', 66, 58);
INSERT INTO `article_likes` VALUES (193, '2026-01-25 16:27:11.919510', 67, 57);
INSERT INTO `article_likes` VALUES (194, '2026-01-25 16:27:11.920510', 67, 53);
INSERT INTO `article_likes` VALUES (195, '2026-01-25 16:27:11.921509', 67, 52);
INSERT INTO `article_likes` VALUES (196, '2026-01-25 16:27:11.922511', 67, 56);
INSERT INTO `article_likes` VALUES (197, '2026-01-25 16:27:11.924020', 67, 54);
INSERT INTO `article_likes` VALUES (198, '2026-01-25 16:27:11.924020', 67, 50);
INSERT INTO `article_likes` VALUES (199, '2026-01-25 16:27:11.925528', 68, 58);
INSERT INTO `article_likes` VALUES (200, '2026-01-25 16:27:11.926535', 68, 53);
INSERT INTO `article_likes` VALUES (201, '2026-01-25 16:27:11.927533', 68, 49);
INSERT INTO `article_likes` VALUES (202, '2026-01-25 16:27:11.928535', 68, 50);
INSERT INTO `article_likes` VALUES (203, '2026-01-25 16:27:11.929535', 69, 49);
INSERT INTO `article_likes` VALUES (204, '2026-01-25 16:27:11.929535', 69, 58);
INSERT INTO `article_likes` VALUES (205, '2026-01-25 16:27:11.930534', 69, 55);
INSERT INTO `article_likes` VALUES (206, '2026-01-25 16:27:11.931042', 69, 52);
INSERT INTO `article_likes` VALUES (207, '2026-01-25 16:27:11.932048', 69, 54);
INSERT INTO `article_likes` VALUES (208, '2026-01-25 16:27:11.934566', 70, 51);
INSERT INTO `article_likes` VALUES (209, '2026-01-25 16:27:11.935564', 70, 50);
INSERT INTO `article_likes` VALUES (210, '2026-01-25 16:27:11.936569', 70, 55);
INSERT INTO `article_likes` VALUES (211, '2026-01-25 16:27:11.936569', 71, 57);
INSERT INTO `article_likes` VALUES (212, '2026-01-25 16:27:11.937564', 71, 52);
INSERT INTO `article_likes` VALUES (213, '2026-01-25 16:27:11.938563', 71, 58);
INSERT INTO `article_likes` VALUES (214, '2026-01-25 16:27:11.938563', 71, 49);
INSERT INTO `article_likes` VALUES (215, '2026-01-25 16:27:11.938563', 71, 50);
INSERT INTO `article_likes` VALUES (216, '2026-01-25 16:27:11.939562', 72, 54);
INSERT INTO `article_likes` VALUES (217, '2026-01-25 16:27:11.940564', 72, 58);
INSERT INTO `article_likes` VALUES (218, '2026-01-25 16:27:11.941071', 72, 52);
INSERT INTO `article_likes` VALUES (219, '2026-01-25 16:27:11.942076', 72, 50);
INSERT INTO `article_likes` VALUES (220, '2026-01-25 16:27:11.943074', 72, 57);
INSERT INTO `article_likes` VALUES (221, '2026-01-25 16:27:11.943074', 72, 55);
INSERT INTO `article_likes` VALUES (222, '2026-01-25 16:27:11.944073', 73, 52);
INSERT INTO `article_likes` VALUES (223, '2026-01-25 16:27:11.945075', 73, 53);
INSERT INTO `article_likes` VALUES (224, '2026-01-25 16:27:11.945075', 73, 55);
INSERT INTO `article_likes` VALUES (225, '2026-01-25 16:27:11.946073', 73, 56);
INSERT INTO `article_likes` VALUES (226, '2026-01-25 16:27:11.947074', 73, 58);
INSERT INTO `article_likes` VALUES (227, '2026-01-25 16:27:11.948075', 73, 50);
INSERT INTO `article_likes` VALUES (228, '2026-01-25 16:27:11.949075', 74, 49);
INSERT INTO `article_likes` VALUES (229, '2026-01-25 16:27:11.950074', 74, 53);
INSERT INTO `article_likes` VALUES (230, '2026-01-25 16:27:11.950074', 74, 52);
INSERT INTO `article_likes` VALUES (231, '2026-01-25 16:27:11.951074', 74, 54);
INSERT INTO `article_likes` VALUES (232, '2026-01-25 16:27:11.951074', 74, 50);
INSERT INTO `article_likes` VALUES (233, '2026-01-25 16:42:18.687379', 74, 60);

-- ----------------------------
-- Table structure for article_tags
-- ----------------------------
DROP TABLE IF EXISTS `article_tags`;
CREATE TABLE `article_tags`  (
  `article_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL,
  PRIMARY KEY (`article_id`, `tag_id`) USING BTREE,
  INDEX `FKr17guaxramkeyxq0f1xn3bxbw`(`tag_id` ASC) USING BTREE,
  CONSTRAINT `FKeoil73g36agokjw6vuklqgli3` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKr17guaxramkeyxq0f1xn3bxbw` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_tags
-- ----------------------------
INSERT INTO `article_tags` VALUES (55, 139);
INSERT INTO `article_tags` VALUES (55, 140);
INSERT INTO `article_tags` VALUES (64, 140);
INSERT INTO `article_tags` VALUES (66, 140);
INSERT INTO `article_tags` VALUES (74, 140);
INSERT INTO `article_tags` VALUES (55, 141);
INSERT INTO `article_tags` VALUES (72, 141);
INSERT INTO `article_tags` VALUES (56, 142);
INSERT INTO `article_tags` VALUES (65, 142);
INSERT INTO `article_tags` VALUES (56, 143);
INSERT INTO `article_tags` VALUES (70, 143);
INSERT INTO `article_tags` VALUES (56, 144);
INSERT INTO `article_tags` VALUES (63, 144);
INSERT INTO `article_tags` VALUES (65, 144);
INSERT INTO `article_tags` VALUES (70, 144);
INSERT INTO `article_tags` VALUES (73, 144);
INSERT INTO `article_tags` VALUES (57, 145);
INSERT INTO `article_tags` VALUES (71, 145);
INSERT INTO `article_tags` VALUES (57, 146);
INSERT INTO `article_tags` VALUES (62, 146);
INSERT INTO `article_tags` VALUES (71, 146);
INSERT INTO `article_tags` VALUES (57, 147);
INSERT INTO `article_tags` VALUES (58, 148);
INSERT INTO `article_tags` VALUES (58, 149);
INSERT INTO `article_tags` VALUES (58, 150);
INSERT INTO `article_tags` VALUES (61, 150);
INSERT INTO `article_tags` VALUES (66, 150);
INSERT INTO `article_tags` VALUES (68, 150);
INSERT INTO `article_tags` VALUES (59, 151);
INSERT INTO `article_tags` VALUES (59, 152);
INSERT INTO `article_tags` VALUES (59, 153);
INSERT INTO `article_tags` VALUES (60, 154);
INSERT INTO `article_tags` VALUES (60, 155);
INSERT INTO `article_tags` VALUES (60, 156);
INSERT INTO `article_tags` VALUES (61, 157);
INSERT INTO `article_tags` VALUES (61, 158);
INSERT INTO `article_tags` VALUES (62, 159);
INSERT INTO `article_tags` VALUES (62, 160);
INSERT INTO `article_tags` VALUES (63, 161);
INSERT INTO `article_tags` VALUES (63, 162);
INSERT INTO `article_tags` VALUES (64, 163);
INSERT INTO `article_tags` VALUES (64, 164);
INSERT INTO `article_tags` VALUES (65, 165);
INSERT INTO `article_tags` VALUES (66, 166);
INSERT INTO `article_tags` VALUES (67, 167);
INSERT INTO `article_tags` VALUES (67, 168);
INSERT INTO `article_tags` VALUES (67, 169);
INSERT INTO `article_tags` VALUES (68, 170);
INSERT INTO `article_tags` VALUES (68, 171);
INSERT INTO `article_tags` VALUES (69, 172);
INSERT INTO `article_tags` VALUES (69, 173);
INSERT INTO `article_tags` VALUES (69, 174);
INSERT INTO `article_tags` VALUES (70, 175);
INSERT INTO `article_tags` VALUES (71, 176);
INSERT INTO `article_tags` VALUES (72, 176);
INSERT INTO `article_tags` VALUES (72, 177);
INSERT INTO `article_tags` VALUES (73, 178);
INSERT INTO `article_tags` VALUES (73, 179);
INSERT INTO `article_tags` VALUES (74, 180);
INSERT INTO `article_tags` VALUES (74, 181);

-- ----------------------------
-- Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `html_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `like_count` int NULL DEFAULT NULL,
  `summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  `view_count` int NULL DEFAULT NULL,
  `author_id` bigint NOT NULL,
  `category_id` bigint NULL DEFAULT NULL,
  `cover_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `draft` tinyint(1) NOT NULL DEFAULT 0,
  `pinned` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否置顶：0-否，1-是',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKe02fs2ut6qqoabfhj325wcjul`(`author_id` ASC) USING BTREE,
  INDEX `FK7i4rryg7kqwyyrr08temnc71e`(`category_id` ASC) USING BTREE,
  CONSTRAINT `FK7i4rryg7kqwyyrr08temnc71e` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKe02fs2ut6qqoabfhj325wcjul` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of articles
-- ----------------------------
INSERT INTO `articles` VALUES (55, '本文详细介绍了Spring Boot的核心概念、常用注解和最佳实践。\n\n## 什么是Spring Boot\n\nSpring Boot是Spring框架的扩展，旨在简化Spring应用的开发。\n\n## 核心特性\n\n- 自动配置\n- 起步依赖\n- 内嵌服务器\n\n## 快速开始\n\n```java\n@SpringBootApplication\npublic class Application {\n    public static void main(String[] args) {\n        SpringApplication.run(Application.class, args);\n    }\n}\n```', '2026-01-25 16:27:11.734717', '本文详细介绍了Spring Boot的核心概念、常用注解和最佳实践。<br/><br/><h2>什么是Spring Boot</h2><br/><br/>Spring Boot是Spring框架的扩展，旨在简化Spring应用的开发。<br/><br/><h2>核心特性</h2><br/><br/>- 自动配置<br/>- 起步依赖<br/>- 内嵌服务器<br/><br/><h2>快速开始</h2><br/><br/><code>`</code>java<br/>@SpringBootApplication<br/>public class Application {<br/>    public static void main(String[] args) {<br/>        SpringApplication.run(Application.class, args);<br/>    }<br/>}<br/><code>`</code>', 1, '本文详细介绍了Spring Boot的核心概念、常用注解和最佳实践。\n\n 什么是Spring Boot\n\nSpring Boot是Spring框架的扩展，旨在简化Spring应用的开发。\n\n 核心特性...', 'Spring Boot 从入门到精通', '2026-01-25 16:27:12.090804', 55, 49, NULL, 'https://picsum.photos/800/400?random=0', 0, 0);
INSERT INTO `articles` VALUES (56, 'Vue 3引入了Composition API，提供了更灵活的组合式API。\n\n## 为什么需要Composition API\n\n- 更好的逻辑复用\n- 更清晰的代码组织\n- 更好的TypeScript支持\n\n## 基本用法\n\n```javascript\nimport { ref, computed } from \'vue\'\n\nexport default {\n  setup() {\n    const count = ref(0)\n    const doubleCount = computed(() => count.value * 2)\n    return { count, doubleCount }\n  }\n}\n```', '2026-01-25 16:27:11.750221', 'Vue 3引入了Composition API，提供了更灵活的组合式API。<br/><br/><h2>为什么需要Composition API</h2><br/><br/>- 更好的逻辑复用<br/>- 更清晰的代码组织<br/>- 更好的TypeScript支持<br/><br/><h2>基本用法</h2><br/><br/><code>`</code>javascript<br/>import { ref, computed } from \'vue\'<br/><br/>export default {<br/>  setup() {<br/>    const count = ref(0)<br/>    const doubleCount = computed(() => count.value * 2)<br/>    return { count, doubleCount }<br/>  }<br/>}<br/><code>`</code>', 4, 'Vue 3引入了Composition API，提供了更灵活的组合式API。\n\n 为什么需要Composition API\n\n- 更好的逻辑复用\n- 更清晰的代码组织\n- 更好的TypeScript支...', 'Vue 3 Composition API 深度解析', '2026-01-25 16:27:12.090804', 497, 50, NULL, NULL, 0, 0);
INSERT INTO `articles` VALUES (57, '索引是数据库性能优化的关键。本文分享一些MySQL索引优化的实战经验。\n\n## 索引类型\n\n- B-Tree索引\n- 哈希索引\n- 全文索引\n\n## 优化建议\n\n1. 避免在WHERE子句中使用函数\n2. 合理使用复合索引\n3. 注意索引的选择性', '2026-01-25 16:27:11.761251', '索引是数据库性能优化的关键。本文分享一些MySQL索引优化的实战经验。<br/><br/><h2>索引类型</h2><br/><br/>- B-Tree索引<br/>- 哈希索引<br/>- 全文索引<br/><br/><h2>优化建议</h2><br/><br/>1. 避免在WHERE子句中使用函数<br/>2. 合理使用复合索引<br/>3. 注意索引的选择性', 2, '索引是数据库性能优化的关键。本文分享一些MySQL索引优化的实战经验。\n\n 索引类型\n\n- B-Tree索引\n- 哈希索引\n- 全文索引\n\n 优化建议\n\n1. 避免在WHERE子句中使用函数\n2. 合...', 'MySQL索引优化实战', '2026-01-25 16:27:12.090804', 374, 51, NULL, NULL, 0, 0);
INSERT INTO `articles` VALUES (58, '动态规划是算法学习中的重要内容。本文通过经典例题讲解DP的基本思想。\n\n## 什么是动态规划\n\n动态规划是一种通过把原问题分解为相对简单的子问题的方式来解决复杂问题的方法。\n\n## 经典例题\n\n### 斐波那契数列\n\n```python\ndef fib(n):\n    if n <= 1:\n        return n\n    dp = [0] * (n + 1)\n    dp[1] = 1\n    for i in range(2, n + 1):\n        dp[i] = dp[i-1] + dp[i-2]\n    return dp[n]\n```', '2026-01-25 16:27:11.772760', '动态规划是算法学习中的重要内容。本文通过经典例题讲解DP的基本思想。<br/><br/><h2>什么是动态规划</h2><br/><br/>动态规划是一种通过把原问题分解为相对简单的子问题的方式来解决复杂问题的方法。<br/><br/><h2>经典例题</h2><br/><br/>#<h2>斐波那契数列</h2><br/><br/><code>`</code>python<br/>def fib(n):<br/>    if n <= 1:<br/>        return n<br/>    dp = [0] * (n + 1)<br/>    dp[1] = 1<br/>    for i in range(2, n + 1):<br/>        dp[i] = dp[i-1] + dp[i-2]<br/>    return dp[n]<br/><code>`</code>', 4, '动态规划是算法学习中的重要内容。本文通过经典例题讲解DP的基本思想。\n\n 什么是动态规划\n\n动态规划是一种通过把原问题分解为相对简单的子问题的方式来解决复杂问题的方法。\n\n 经典例题\n\n 斐波那契数列', '算法学习之路：动态规划入门', '2026-01-25 16:27:12.090804', 39, 52, NULL, 'https://picsum.photos/800/400?random=3', 0, 0);
INSERT INTO `articles` VALUES (59, 'Docker已经成为现代应用部署的标准。本文分享Docker容器化部署的实践经验。\n\n## Docker基础\n\n- 镜像（Image）\n- 容器（Container）\n- 仓库（Repository）\n\n## 常用命令\n\n```bash\ndocker build -t myapp .\ndocker run -d -p 8080:8080 myapp\ndocker-compose up -d\n```', '2026-01-25 16:27:11.780264', 'Docker已经成为现代应用部署的标准。本文分享Docker容器化部署的实践经验。<br/><br/><h2>Docker基础</h2><br/><br/>- 镜像（Image）<br/>- 容器（Container）<br/>- 仓库（Repository）<br/><br/><h2>常用命令</h2><br/><br/><code>`</code>bash<br/>docker build -t myapp .<br/>docker run -d -p 8080:8080 myapp<br/>docker-compose up -d<br/><code>`</code>', 4, 'Docker已经成为现代应用部署的标准。本文分享Docker容器化部署的实践经验。\n\n Docker基础\n\n- 镜像（Image）\n- 容器（Container）\n- 仓库（Repository）\n\n...', 'Docker容器化部署实践', '2026-01-25 16:27:12.090804', 504, 53, NULL, 'https://picsum.photos/800/400?random=4', 0, 0);
INSERT INTO `articles` VALUES (60, 'Git是现代开发必备的版本控制工具。本文介绍Git工作流的最佳实践。\n\n## 分支策略\n\n- master/main：生产环境\n- develop：开发环境\n- feature：功能分支\n- hotfix：紧急修复\n\n## 常用命令\n\n```bash\ngit checkout -b feature/new-feature\ngit commit -m \"Add new feature\"\ngit push origin feature/new-feature\n```', '2026-01-25 16:27:11.789269', 'Git是现代开发必备的版本控制工具。本文介绍Git工作流的最佳实践。<br/><br/><h2>分支策略</h2><br/><br/>- master/main：生产环境<br/>- develop：开发环境<br/>- feature：功能分支<br/>- hotfix：紧急修复<br/><br/><h2>常用命令</h2><br/><br/><code>`</code>bash<br/>git checkout -b feature/new-feature<br/>git commit -m \"Add new feature\"<br/>git push origin feature/new-feature<br/><code>`</code>', 1, 'Git是现代开发必备的版本控制工具。本文介绍Git工作流的最佳实践。\n\n 分支策略\n\n- master/main：生产环境\n- develop：开发环境\n- feature：功能分支\n- hotfix...', 'Git工作流最佳实践', '2026-01-25 16:27:12.090804', 416, 54, NULL, NULL, 0, 0);
INSERT INTO `articles` VALUES (61, '记录我从零开始学习全栈开发的经历和心得。\n\n## 学习路径\n\n1. 前端基础：HTML、CSS、JavaScript\n2. 前端框架：Vue.js\n3. 后端基础：Java、Spring Boot\n4. 数据库：MySQL\n\n## 心得体会\n\n学习编程最重要的是动手实践，多写代码，多思考。', '2026-01-25 16:27:11.795796', '记录我从零开始学习全栈开发的经历和心得。<br/><br/><h2>学习路径</h2><br/><br/>1. 前端基础：HTML、CSS、JavaScript<br/>2. 前端框架：Vue.js<br/>3. 后端基础：Java、Spring Boot<br/>4. 数据库：MySQL<br/><br/><h2>心得体会</h2><br/><br/>学习编程最重要的是动手实践，多写代码，多思考。', 5, '记录我从零开始学习全栈开发的经历和心得。\n\n 学习路径\n\n1. 前端基础：HTML、CSS、JavaScript\n2. 前端框架：Vue.js\n3. 后端基础：Java、Spring Boot\n4. ...', '我的全栈学习之路', '2026-01-25 16:27:12.090804', 56, 55, NULL, 'https://picsum.photos/800/400?random=6', 0, 0);
INSERT INTO `articles` VALUES (62, 'Redis是高性能的内存数据库，广泛应用于缓存场景。\n\n## Redis数据类型\n\n- String\n- Hash\n- List\n- Set\n- Sorted Set\n\n## 使用场景\n\n- 缓存\n- 会话存储\n- 消息队列\n- 计数器', '2026-01-25 16:27:11.803803', 'Redis是高性能的内存数据库，广泛应用于缓存场景。<br/><br/><h2>Redis数据类型</h2><br/><br/>- String<br/>- Hash<br/>- List<br/>- Set<br/>- Sorted Set<br/><br/><h2>使用场景</h2><br/><br/>- 缓存<br/>- 会话存储<br/>- 消息队列<br/>- 计数器', 6, 'Redis是高性能的内存数据库，广泛应用于缓存场景。\n\n Redis数据类型\n\n- String\n- Hash\n- List\n- Set\n- Sorted Set\n\n 使用场景\n\n- 缓存\n- 会话存...', 'Redis缓存使用指南', '2026-01-25 16:27:12.090804', 271, 56, NULL, 'https://picsum.photos/800/400?random=7', 0, 0);
INSERT INTO `articles` VALUES (63, '前端性能优化是提升用户体验的关键。\n\n## 优化策略\n\n1. 减少HTTP请求\n2. 使用CDN\n3. 代码压缩\n4. 图片优化\n5. 懒加载\n\n## 工具推荐\n\n- Lighthouse\n- WebPageTest\n- Chrome DevTools', '2026-01-25 16:27:11.810329', '前端性能优化是提升用户体验的关键。<br/><br/><h2>优化策略</h2><br/><br/>1. 减少HTTP请求<br/>2. 使用CDN<br/>3. 代码压缩<br/>4. 图片优化<br/>5. 懒加载<br/><br/><h2>工具推荐</h2><br/><br/>- Lighthouse<br/>- WebPageTest<br/>- Chrome DevTools', 2, '前端性能优化是提升用户体验的关键。\n\n 优化策略\n\n1. 减少HTTP请求\n2. 使用CDN\n3. 代码压缩\n4. 图片优化\n5. 懒加载\n\n 工具推荐\n\n- Lighthouse\n- WebPage...', '前端性能优化技巧', '2026-01-25 16:27:12.090804', 199, 57, NULL, NULL, 0, 0);
INSERT INTO `articles` VALUES (64, 'Spring Security是Spring生态中的安全框架。\n\n## 核心概念\n\n- 认证（Authentication）\n- 授权（Authorization）\n- 密码加密\n\n## 配置示例\n\n```java\n@Configuration\n@EnableWebSecurity\npublic class SecurityConfig {\n    // 配置代码\n}\n```', '2026-01-25 16:27:11.818848', 'Spring Security是Spring生态中的安全框架。<br/><br/><h2>核心概念</h2><br/><br/>- 认证（Authentication）<br/>- 授权（Authorization）<br/>- 密码加密<br/><br/><h2>配置示例</h2><br/><br/><code>`</code>java<br/>@Configuration<br/>@EnableWebSecurity<br/>public class SecurityConfig {<br/>    // 配置代码<br/>}<br/><code>`</code>', 4, 'Spring Security是Spring生态中的安全框架。\n\n 核心概念\n\n- 认证（Authentication）\n- 授权（Authorization）\n- 密码加密\n\n 配置示例', 'Spring Security认证授权', '2026-01-25 16:27:12.090804', 501, 58, NULL, 'https://picsum.photos/800/400?random=9', 0, 0);
INSERT INTO `articles` VALUES (65, 'Vue Router是Vue.js的官方路由管理器。\n\n## 基本用法\n\n```javascript\nconst routes = [\n  { path: \'/\', component: Home },\n  { path: \'/about\', component: About }\n]\n```', '2026-01-25 16:27:11.823359', 'Vue Router是Vue.js的官方路由管理器。<br/><br/><h2>基本用法</h2><br/><br/><code>`</code>javascript<br/>const routes = [<br/>  { path: \'/\', component: Home },<br/>  { path: \'/about\', component: About }<br/>]<br/><code>`</code>', 5, 'Vue Router是Vue.js的官方路由管理器。\n\n 基本用法', 'Vue Router路由管理', '2026-01-25 16:27:12.090804', 492, 49, NULL, NULL, 0, 0);
INSERT INTO `articles` VALUES (66, '单例模式是最常用的设计模式之一。\n\n## 实现方式\n\n- 饿汉式\n- 懒汉式\n- 双重检查锁定\n\n## 代码示例\n\n```java\npublic class Singleton {\n    private static Singleton instance;\n    private Singleton() {}\n    public static Singleton getInstance() {\n        if (instance == null) {\n            instance = new Singleton();\n        }\n        return instance;\n    }\n}\n```', '2026-01-25 16:27:11.827359', '单例模式是最常用的设计模式之一。<br/><br/><h2>实现方式</h2><br/><br/>- 饿汉式<br/>- 懒汉式<br/>- 双重检查锁定<br/><br/><h2>代码示例</h2><br/><br/><code>`</code>java<br/>public class Singleton {<br/>    private static Singleton instance;<br/>    private Singleton() {}<br/>    public static Singleton getInstance() {<br/>        if (instance == null) {<br/>            instance = new Singleton();<br/>        }<br/>        return instance;<br/>    }<br/>}<br/><code>`</code>', 2, '单例模式是最常用的设计模式之一。\n\n 实现方式\n\n- 饿汉式\n- 懒汉式\n- 双重检查锁定\n\n 代码示例', '设计模式：单例模式', '2026-01-25 16:27:12.090804', 264, 50, NULL, 'https://picsum.photos/800/400?random=11', 0, 0);
INSERT INTO `articles` VALUES (67, 'Linux命令行是开发者的必备技能。\n\n## 常用命令\n\n- ls：列出目录\n- cd：切换目录\n- grep：搜索文本\n- find：查找文件\n- chmod：修改权限', '2026-01-25 16:27:11.837358', 'Linux命令行是开发者的必备技能。<br/><br/><h2>常用命令</h2><br/><br/>- ls：列出目录<br/>- cd：切换目录<br/>- grep：搜索文本<br/>- find：查找文件<br/>- chmod：修改权限', 6, 'Linux命令行是开发者的必备技能。\n\n 常用命令\n\n- ls：列出目录\n- cd：切换目录\n- grep：搜索文本\n- find：查找文件\n- chmod：修改权限', 'Linux常用命令总结', '2026-01-25 16:27:12.090804', 352, 51, NULL, 'https://picsum.photos/800/400?random=12', 0, 0);
INSERT INTO `articles` VALUES (68, 'Python是爬虫开发的首选语言。\n\n## 常用库\n\n- requests：HTTP请求\n- BeautifulSoup：HTML解析\n- Scrapy：爬虫框架\n\n## 示例代码\n\n```python\nimport requests\nfrom bs4 import BeautifulSoup\n\nresponse = requests.get(\'https://example.com\')\nsoup = BeautifulSoup(response.text, \'html.parser\')\n```', '2026-01-25 16:27:11.842872', 'Python是爬虫开发的首选语言。<br/><br/><h2>常用库</h2><br/><br/>- requests：HTTP请求<br/>- BeautifulSoup：HTML解析<br/>- Scrapy：爬虫框架<br/><br/><h2>示例代码</h2><br/><br/><code>`</code>python<br/>import requests<br/>from bs4 import BeautifulSoup<br/><br/>response = requests.get(\'https://example.com\')<br/>soup = BeautifulSoup(response.text, \'html.parser\')<br/><code>`</code>', 4, 'Python是爬虫开发的首选语言。\n\n 常用库\n\n- requests：HTTP请求\n- BeautifulSoup：HTML解析\n- Scrapy：爬虫框架\n\n 示例代码', 'Python爬虫入门', '2026-01-25 16:27:12.090804', 369, 52, NULL, NULL, 0, 0);
INSERT INTO `articles` VALUES (69, '微服务架构是现代应用开发的重要模式。\n\n## 核心概念\n\n- 服务拆分\n- 服务治理\n- 服务发现\n- 配置中心\n\n## 技术栈\n\n- Spring Cloud\n- Docker\n- Kubernetes', '2026-01-25 16:27:11.852895', '微服务架构是现代应用开发的重要模式。<br/><br/><h2>核心概念</h2><br/><br/>- 服务拆分<br/>- 服务治理<br/>- 服务发现<br/>- 配置中心<br/><br/><h2>技术栈</h2><br/><br/>- Spring Cloud<br/>- Docker<br/>- Kubernetes', 5, '微服务架构是现代应用开发的重要模式。\n\n 核心概念\n\n- 服务拆分\n- 服务治理\n- 服务发现\n- 配置中心\n\n 技术栈\n\n- Spring Cloud\n- Docker\n- Kubernetes', '微服务架构设计', '2026-01-25 16:27:12.090804', 325, 53, NULL, 'https://picsum.photos/800/400?random=14', 0, 0);
INSERT INTO `articles` VALUES (70, 'TypeScript为JavaScript添加了类型系统。\n\n## 基本类型\n\n- number\n- string\n- boolean\n- object\n\n## 高级特性\n\n- 泛型\n- 接口\n- 类型推断', '2026-01-25 16:27:11.855909', 'TypeScript为JavaScript添加了类型系统。<br/><br/><h2>基本类型</h2><br/><br/>- number<br/>- string<br/>- boolean<br/>- object<br/><br/><h2>高级特性</h2><br/><br/>- 泛型<br/>- 接口<br/>- 类型推断', 3, 'TypeScript为JavaScript添加了类型系统。\n\n 基本类型\n\n- number\n- string\n- boolean\n- object\n\n 高级特性\n\n- 泛型\n- 接口\n- 类型推断', 'TypeScript类型系统', '2026-01-25 16:27:12.091806', 78, 54, NULL, NULL, 0, 0);
INSERT INTO `articles` VALUES (71, '良好的数据库设计是应用成功的基础。\n\n## 设计原则\n\n1. 范式化设计\n2. 合理使用索引\n3. 避免过度设计\n4. 考虑扩展性', '2026-01-25 16:27:11.861910', '良好的数据库设计是应用成功的基础。<br/><br/><h2>设计原则</h2><br/><br/>1. 范式化设计<br/>2. 合理使用索引<br/>3. 避免过度设计<br/>4. 考虑扩展性', 5, '良好的数据库设计是应用成功的基础。\n\n 设计原则\n\n1. 范式化设计\n2. 合理使用索引\n3. 避免过度设计\n4. 考虑扩展性', '数据库设计原则', '2026-01-25 16:27:12.091806', 355, 55, NULL, 'https://picsum.photos/800/400?random=16', 0, 0);
INSERT INTO `articles` VALUES (72, 'RESTful是API设计的标准规范。\n\n## 设计原则\n\n- 使用HTTP动词\n- 资源导向\n- 状态码规范\n- 版本控制', '2026-01-25 16:27:11.866912', 'RESTful是API设计的标准规范。<br/><br/><h2>设计原则</h2><br/><br/>- 使用HTTP动词<br/>- 资源导向<br/>- 状态码规范<br/>- 版本控制', 6, 'RESTful是API设计的标准规范。\n\n 设计原则\n\n- 使用HTTP动词\n- 资源导向\n- 状态码规范\n- 版本控制', 'RESTful API设计规范', '2026-01-25 16:27:12.091806', 311, 56, NULL, NULL, 0, 0);
INSERT INTO `articles` VALUES (73, '前端工程化是现代前端开发的必备技能。\n\n## 工具链\n\n- Webpack\n- Vite\n- ESLint\n- Prettier\n\n## 最佳实践\n\n- 模块化\n- 组件化\n- 自动化构建', '2026-01-25 16:27:11.872420', '前端工程化是现代前端开发的必备技能。<br/><br/><h2>工具链</h2><br/><br/>- Webpack<br/>- Vite<br/>- ESLint<br/>- Prettier<br/><br/><h2>最佳实践</h2><br/><br/>- 模块化<br/>- 组件化<br/>- 自动化构建', 6, '前端工程化是现代前端开发的必备技能。\n\n 工具链\n\n- Webpack\n- Vite\n- ESLint\n- Prettier\n\n 最佳实践\n\n- 模块化\n- 组件化\n- 自动化构建', '前端工程化实践', '2026-01-25 16:43:36.638554', 305, 57, NULL, 'https://picsum.photos/800/400?random=18', 0, 0);
INSERT INTO `articles` VALUES (74, 'Java并发编程是高级开发者的必备技能。\n\n## 核心概念\n\n- 线程\n- 锁\n- 线程池\n- 并发集合\n\n## 示例\n\n```java\nExecutorService executor = Executors.newFixedThreadPool(10);\nexecutor.submit(() -> {\n    // 任务代码\n});\n```', '2026-01-25 16:27:11.878420', 'Java并发编程是高级开发者的必备技能。<br/><br/><h2>核心概念</h2><br/><br/>- 线程<br/>- 锁<br/>- 线程池<br/>- 并发集合<br/><br/><h2>示例</h2><br/><br/><code>`</code>java<br/>ExecutorService executor = Executors.newFixedThreadPool(10);<br/>executor.submit(() -> {<br/>    // 任务代码<br/>});<br/><code>`</code>', 6, 'Java并发编程是高级开发者的必备技能。\n\n 核心概念\n\n- 线程\n- 锁\n- 线程池\n- 并发集合\n\n 示例', 'Java并发编程', '2026-01-25 18:32:15.648663', 245, 58, NULL, 'https://picsum.photos/800/400?random=19', 0, 0);
INSERT INTO `articles` VALUES (75, '', '2026-01-27 17:49:27.220712', '', 0, '', '这是我的生活', '2026-01-27 17:49:27.220712', 0, 59, 16, NULL, 1, 0);

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_t8o6pivur7nn124jehx7cygw5`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (15, '2026-01-25 16:27:12.160381', '系统默认分类', '技术分享');
INSERT INTO `categories` VALUES (16, '2026-01-25 16:27:12.165898', '系统默认分类', '生活随笔');
INSERT INTO `categories` VALUES (17, '2026-01-25 16:27:12.171431', '系统默认分类', '学习笔记');
INSERT INTO `categories` VALUES (18, '2026-01-25 16:27:12.176938', '系统默认分类', '项目经验');
INSERT INTO `categories` VALUES (19, '2026-01-25 16:27:12.181457', '系统默认分类', '前端开发');
INSERT INTO `categories` VALUES (20, '2026-01-25 16:27:12.186456', '系统默认分类', '后端开发');
INSERT INTO `categories` VALUES (21, '2026-01-25 16:27:12.192459', '系统默认分类', '数据库');
INSERT INTO `categories` VALUES (22, '2026-01-25 16:27:12.197458', '系统默认分类', '算法与数据结构');
INSERT INTO `categories` VALUES (23, '2026-01-25 16:27:12.204052', '系统默认分类', '工具推荐');
INSERT INTO `categories` VALUES (24, '2026-01-25 16:27:12.209053', '系统默认分类', '问题解决');
INSERT INTO `categories` VALUES (25, '2026-01-25 16:27:12.215068', '系统默认分类', '读书笔记');
INSERT INTO `categories` VALUES (26, '2026-01-25 16:27:12.219066', '系统默认分类', '个人成长');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  `article_id` bigint NOT NULL,
  `parent_id` bigint NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKk4ib6syde10dalk7r7xdl0m5p`(`article_id` ASC) USING BTREE,
  INDEX `FKlri30okf66phtcgbe5pok7cc0`(`parent_id` ASC) USING BTREE,
  INDEX `FK8omq0tc18jd43bu5tjh6jvraq`(`user_id` ASC) USING BTREE,
  CONSTRAINT `FK8omq0tc18jd43bu5tjh6jvraq` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKk4ib6syde10dalk7r7xdl0m5p` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKlri30okf66phtcgbe5pok7cc0` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 441 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (299, '有个小问题想请教一下...', '2026-01-25 16:27:12.013701', '2026-01-25 16:27:12.013701', 55, NULL, 53);
INSERT INTO `comments` VALUES (300, '有个地方不太理解，能详细说明一下吗？', '2026-01-25 16:27:12.014709', '2026-01-25 16:27:12.014709', 55, NULL, 57);
INSERT INTO `comments` VALUES (301, '这个思路很棒！', '2026-01-25 16:27:12.015709', '2026-01-25 16:27:12.015709', 55, NULL, 51);
INSERT INTO `comments` VALUES (302, '这个知识点很重要，mark一下。', '2026-01-25 16:27:12.015709', '2026-01-25 16:27:12.015709', 55, NULL, 50);
INSERT INTO `comments` VALUES (303, '有个小问题想请教一下...', '2026-01-25 16:27:12.016708', '2026-01-25 16:27:12.016708', 55, NULL, 52);
INSERT INTO `comments` VALUES (304, '受益匪浅，继续关注。', '2026-01-25 16:27:12.017707', '2026-01-25 16:27:12.017707', 55, NULL, 51);
INSERT INTO `comments` VALUES (305, '学到了，感谢作者。', '2026-01-25 16:27:12.017707', '2026-01-25 16:27:12.017707', 55, NULL, 52);
INSERT INTO `comments` VALUES (306, '这个思路很棒！', '2026-01-25 16:27:12.018705', '2026-01-25 16:27:12.018705', 56, NULL, 52);
INSERT INTO `comments` VALUES (307, '期待后续更新！', '2026-01-25 16:27:12.018705', '2026-01-25 16:27:12.018705', 56, NULL, 50);
INSERT INTO `comments` VALUES (308, '实践了一下，确实有效。', '2026-01-25 16:27:12.018705', '2026-01-25 16:27:12.018705', 56, NULL, 53);
INSERT INTO `comments` VALUES (309, '这个方案不错，我也试过类似的方法。', '2026-01-25 16:27:12.020209', '2026-01-25 16:27:12.020209', 56, NULL, 57);
INSERT INTO `comments` VALUES (310, '受益匪浅，继续关注。', '2026-01-25 16:27:12.021216', '2026-01-25 16:27:12.021216', 56, NULL, 55);
INSERT INTO `comments` VALUES (311, '这个方案不错，我也试过类似的方法。', '2026-01-25 16:27:12.021216', '2026-01-25 16:27:12.021216', 56, NULL, 58);
INSERT INTO `comments` VALUES (312, '感谢分享，正好遇到这个问题。', '2026-01-25 16:27:12.022216', '2026-01-25 16:27:12.022216', 56, NULL, 49);
INSERT INTO `comments` VALUES (313, '有个小问题想请教一下...', '2026-01-25 16:27:12.022216', '2026-01-25 16:27:12.022216', 57, NULL, 54);
INSERT INTO `comments` VALUES (314, '很实用的教程，收藏了。', '2026-01-25 16:27:12.023215', '2026-01-25 16:27:12.023215', 57, NULL, 54);
INSERT INTO `comments` VALUES (315, '期待后续更新！', '2026-01-25 16:27:12.024217', '2026-01-25 16:27:12.024217', 57, NULL, 55);
INSERT INTO `comments` VALUES (316, '这个思路很棒！', '2026-01-25 16:27:12.025216', '2026-01-25 16:27:12.025216', 57, NULL, 56);
INSERT INTO `comments` VALUES (317, '有个小问题想请教一下...', '2026-01-25 16:27:12.026216', '2026-01-25 16:27:12.026216', 57, NULL, 52);
INSERT INTO `comments` VALUES (318, '这个方案不错，我也试过类似的方法。', '2026-01-25 16:27:12.026216', '2026-01-25 16:27:12.026216', 57, NULL, 51);
INSERT INTO `comments` VALUES (319, '期待后续更新！', '2026-01-25 16:27:12.027215', '2026-01-25 16:27:12.027215', 57, NULL, 51);
INSERT INTO `comments` VALUES (320, '这个方案不错，我也试过类似的方法。', '2026-01-25 16:27:12.027215', '2026-01-25 16:27:12.027215', 58, NULL, 56);
INSERT INTO `comments` VALUES (321, '文章质量很高，支持！', '2026-01-25 16:27:12.028216', '2026-01-25 16:27:12.028216', 58, NULL, 56);
INSERT INTO `comments` VALUES (322, '期待后续更新！', '2026-01-25 16:27:12.029217', '2026-01-25 16:27:12.029217', 58, NULL, 55);
INSERT INTO `comments` VALUES (323, '很实用的教程，收藏了。', '2026-01-25 16:27:12.029217', '2026-01-25 16:27:12.029217', 58, NULL, 58);
INSERT INTO `comments` VALUES (324, '受益匪浅，继续关注。', '2026-01-25 16:27:12.030215', '2026-01-25 16:27:12.030215', 59, NULL, 58);
INSERT INTO `comments` VALUES (325, '实践了一下，确实有效。', '2026-01-25 16:27:12.030215', '2026-01-25 16:27:12.030215', 59, NULL, 52);
INSERT INTO `comments` VALUES (326, '期待后续更新！', '2026-01-25 16:27:12.030721', '2026-01-25 16:27:12.030721', 59, NULL, 53);
INSERT INTO `comments` VALUES (327, '感谢分享，正好遇到这个问题。', '2026-01-25 16:27:12.031726', '2026-01-25 16:27:12.031726', 60, NULL, 54);
INSERT INTO `comments` VALUES (328, '这个方案不错，我也试过类似的方法。', '2026-01-25 16:27:12.034234', '2026-01-25 16:27:12.034234', 60, NULL, 56);
INSERT INTO `comments` VALUES (329, '写得很详细，学到了很多！', '2026-01-25 16:27:12.034234', '2026-01-25 16:27:12.034234', 60, NULL, 54);
INSERT INTO `comments` VALUES (330, '感谢分享，正好遇到这个问题。', '2026-01-25 16:27:12.035741', '2026-01-25 16:27:12.035741', 60, NULL, 58);
INSERT INTO `comments` VALUES (331, '这个方案不错，我也试过类似的方法。', '2026-01-25 16:27:12.035741', '2026-01-25 16:27:12.035741', 60, NULL, 52);
INSERT INTO `comments` VALUES (332, '实践了一下，确实有效。', '2026-01-25 16:27:12.036749', '2026-01-25 16:27:12.036749', 60, NULL, 58);
INSERT INTO `comments` VALUES (333, '受益匪浅，继续关注。', '2026-01-25 16:27:12.036749', '2026-01-25 16:27:12.036749', 60, NULL, 51);
INSERT INTO `comments` VALUES (334, '很实用的教程，收藏了。', '2026-01-25 16:27:12.037748', '2026-01-25 16:27:12.037748', 60, NULL, 57);
INSERT INTO `comments` VALUES (335, '代码示例很清晰，感谢！', '2026-01-25 16:27:12.037748', '2026-01-25 16:27:12.037748', 60, NULL, 51);
INSERT INTO `comments` VALUES (336, '学到了，感谢作者。', '2026-01-25 16:27:12.038747', '2026-01-25 16:27:12.038747', 60, NULL, 54);
INSERT INTO `comments` VALUES (337, '期待后续更新！', '2026-01-25 16:27:12.038747', '2026-01-25 16:27:12.038747', 61, NULL, 56);
INSERT INTO `comments` VALUES (338, '代码示例很清晰，感谢！', '2026-01-25 16:27:12.039760', '2026-01-25 16:27:12.039760', 61, NULL, 58);
INSERT INTO `comments` VALUES (339, '有个地方不太理解，能详细说明一下吗？', '2026-01-25 16:27:12.039760', '2026-01-25 16:27:12.039760', 61, NULL, 54);
INSERT INTO `comments` VALUES (340, '实践了一下，确实有效。', '2026-01-25 16:27:12.040748', '2026-01-25 16:27:12.040748', 61, NULL, 56);
INSERT INTO `comments` VALUES (341, '有个地方不太理解，能详细说明一下吗？', '2026-01-25 16:27:12.040748', '2026-01-25 16:27:12.040748', 61, NULL, 54);
INSERT INTO `comments` VALUES (342, '学到了，感谢作者。', '2026-01-25 16:27:12.041747', '2026-01-25 16:27:12.041747', 62, NULL, 57);
INSERT INTO `comments` VALUES (343, '受益匪浅，继续关注。', '2026-01-25 16:27:12.041747', '2026-01-25 16:27:12.041747', 62, NULL, 55);
INSERT INTO `comments` VALUES (344, '有个地方不太理解，能详细说明一下吗？', '2026-01-25 16:27:12.042748', '2026-01-25 16:27:12.042748', 62, NULL, 49);
INSERT INTO `comments` VALUES (345, '希望多分享一些实战经验。', '2026-01-25 16:27:12.043387', '2026-01-25 16:27:12.043387', 62, NULL, 56);
INSERT INTO `comments` VALUES (346, '很实用的教程，收藏了。', '2026-01-25 16:27:12.043911', '2026-01-25 16:27:12.043911', 62, NULL, 50);
INSERT INTO `comments` VALUES (347, '受益匪浅，继续关注。', '2026-01-25 16:27:12.044445', '2026-01-25 16:27:12.044445', 62, NULL, 53);
INSERT INTO `comments` VALUES (348, '受益匪浅，继续关注。', '2026-01-25 16:27:12.044445', '2026-01-25 16:27:12.044445', 62, NULL, 56);
INSERT INTO `comments` VALUES (349, '受益匪浅，继续关注。', '2026-01-25 16:27:12.044991', '2026-01-25 16:27:12.044991', 62, NULL, 58);
INSERT INTO `comments` VALUES (350, '这个知识点很重要，mark一下。', '2026-01-25 16:27:12.045520', '2026-01-25 16:27:12.045520', 62, NULL, 54);
INSERT INTO `comments` VALUES (351, '这个方案不错，我也试过类似的方法。', '2026-01-25 16:27:12.046049', '2026-01-25 16:27:12.046049', 63, NULL, 51);
INSERT INTO `comments` VALUES (352, '代码示例很清晰，感谢！', '2026-01-25 16:27:12.046577', '2026-01-25 16:27:12.046577', 63, NULL, 58);
INSERT INTO `comments` VALUES (353, '这个知识点很重要，mark一下。', '2026-01-25 16:27:12.047116', '2026-01-25 16:27:12.047116', 63, NULL, 50);
INSERT INTO `comments` VALUES (354, '学到了，感谢作者。', '2026-01-25 16:27:12.047673', '2026-01-25 16:27:12.047673', 63, NULL, 56);
INSERT INTO `comments` VALUES (355, '学到了，感谢作者。', '2026-01-25 16:27:12.048289', '2026-01-25 16:27:12.048289', 63, NULL, 53);
INSERT INTO `comments` VALUES (356, '期待后续更新！', '2026-01-25 16:27:12.048835', '2026-01-25 16:27:12.048835', 64, NULL, 49);
INSERT INTO `comments` VALUES (357, '受益匪浅，继续关注。', '2026-01-25 16:27:12.049379', '2026-01-25 16:27:12.049379', 64, NULL, 49);
INSERT INTO `comments` VALUES (358, '期待后续更新！', '2026-01-25 16:27:12.050472', '2026-01-25 16:27:12.050472', 64, NULL, 49);
INSERT INTO `comments` VALUES (359, '实践了一下，确实有效。', '2026-01-25 16:27:12.051029', '2026-01-25 16:27:12.051029', 64, NULL, 55);
INSERT INTO `comments` VALUES (360, '很实用的教程，收藏了。', '2026-01-25 16:27:12.052109', '2026-01-25 16:27:12.052109', 64, NULL, 51);
INSERT INTO `comments` VALUES (361, '感谢分享，正好遇到这个问题。', '2026-01-25 16:27:12.052636', '2026-01-25 16:27:12.052636', 65, NULL, 53);
INSERT INTO `comments` VALUES (362, '代码示例很清晰，感谢！', '2026-01-25 16:27:12.053715', '2026-01-25 16:27:12.053715', 65, NULL, 53);
INSERT INTO `comments` VALUES (363, '有个地方不太理解，能详细说明一下吗？', '2026-01-25 16:27:12.054269', '2026-01-25 16:27:12.054269', 65, NULL, 53);
INSERT INTO `comments` VALUES (364, '有个地方不太理解，能详细说明一下吗？', '2026-01-25 16:27:12.054269', '2026-01-25 16:27:12.054269', 65, NULL, 58);
INSERT INTO `comments` VALUES (365, '文章质量很高，支持！', '2026-01-25 16:27:12.054269', '2026-01-25 16:27:12.054269', 65, NULL, 49);
INSERT INTO `comments` VALUES (366, '期待后续更新！', '2026-01-25 16:27:12.055274', '2026-01-25 16:27:12.055274', 65, NULL, 52);
INSERT INTO `comments` VALUES (367, '有个小问题想请教一下...', '2026-01-25 16:27:12.055274', '2026-01-25 16:27:12.055274', 65, NULL, 50);
INSERT INTO `comments` VALUES (368, '受益匪浅，继续关注。', '2026-01-25 16:27:12.056273', '2026-01-25 16:27:12.056273', 65, NULL, 54);
INSERT INTO `comments` VALUES (369, '这个知识点很重要，mark一下。', '2026-01-25 16:27:12.056273', '2026-01-25 16:27:12.056273', 65, NULL, 57);
INSERT INTO `comments` VALUES (370, '文章质量很高，支持！', '2026-01-25 16:27:12.057273', '2026-01-25 16:27:12.057273', 65, NULL, 58);
INSERT INTO `comments` VALUES (371, '有个小问题想请教一下...', '2026-01-25 16:27:12.057273', '2026-01-25 16:27:12.057273', 66, NULL, 51);
INSERT INTO `comments` VALUES (372, '很实用的教程，收藏了。', '2026-01-25 16:27:12.058275', '2026-01-25 16:27:12.058275', 66, NULL, 51);
INSERT INTO `comments` VALUES (373, '实践了一下，确实有效。', '2026-01-25 16:27:12.058275', '2026-01-25 16:27:12.058275', 66, NULL, 49);
INSERT INTO `comments` VALUES (374, '受益匪浅，继续关注。', '2026-01-25 16:27:12.059275', '2026-01-25 16:27:12.059275', 67, NULL, 53);
INSERT INTO `comments` VALUES (375, '这个知识点很重要，mark一下。', '2026-01-25 16:27:12.059275', '2026-01-25 16:27:12.059275', 67, NULL, 55);
INSERT INTO `comments` VALUES (376, '很实用的教程，收藏了。', '2026-01-25 16:27:12.059275', '2026-01-25 16:27:12.059275', 67, NULL, 57);
INSERT INTO `comments` VALUES (377, '很实用的教程，收藏了。', '2026-01-25 16:27:12.060274', '2026-01-25 16:27:12.060274', 67, NULL, 58);
INSERT INTO `comments` VALUES (378, '文章质量很高，支持！', '2026-01-25 16:27:12.060779', '2026-01-25 16:27:12.060779', 67, NULL, 57);
INSERT INTO `comments` VALUES (379, '有个小问题想请教一下...', '2026-01-25 16:27:12.061784', '2026-01-25 16:27:12.061784', 67, NULL, 55);
INSERT INTO `comments` VALUES (380, '这个方案不错，我也试过类似的方法。', '2026-01-25 16:27:12.061784', '2026-01-25 16:27:12.061784', 67, NULL, 49);
INSERT INTO `comments` VALUES (381, '这个知识点很重要，mark一下。', '2026-01-25 16:27:12.062782', '2026-01-25 16:27:12.062782', 67, NULL, 53);
INSERT INTO `comments` VALUES (382, '有个小问题想请教一下...', '2026-01-25 16:27:12.063783', '2026-01-25 16:27:12.063783', 68, NULL, 56);
INSERT INTO `comments` VALUES (383, '代码示例很清晰，感谢！', '2026-01-25 16:27:12.063783', '2026-01-25 16:27:12.063783', 68, NULL, 56);
INSERT INTO `comments` VALUES (384, '学到了，感谢作者。', '2026-01-25 16:27:12.064785', '2026-01-25 16:27:12.064785', 68, NULL, 56);
INSERT INTO `comments` VALUES (385, '有个地方不太理解，能详细说明一下吗？', '2026-01-25 16:27:12.064785', '2026-01-25 16:27:12.064785', 68, NULL, 58);
INSERT INTO `comments` VALUES (386, '希望多分享一些实战经验。', '2026-01-25 16:27:12.065783', '2026-01-25 16:27:12.065783', 68, NULL, 58);
INSERT INTO `comments` VALUES (387, '很实用的教程，收藏了。', '2026-01-25 16:27:12.065783', '2026-01-25 16:27:12.065783', 68, NULL, 54);
INSERT INTO `comments` VALUES (388, '这个知识点很重要，mark一下。', '2026-01-25 16:27:12.066785', '2026-01-25 16:27:12.066785', 68, NULL, 55);
INSERT INTO `comments` VALUES (389, '实践了一下，确实有效。', '2026-01-25 16:27:12.067785', '2026-01-25 16:27:12.067785', 68, NULL, 54);
INSERT INTO `comments` VALUES (390, '很实用的教程，收藏了。', '2026-01-25 16:27:12.067785', '2026-01-25 16:27:12.067785', 68, NULL, 50);
INSERT INTO `comments` VALUES (391, '这个知识点很重要，mark一下。', '2026-01-25 16:27:12.068785', '2026-01-25 16:27:12.068785', 69, NULL, 57);
INSERT INTO `comments` VALUES (392, '这个知识点很重要，mark一下。', '2026-01-25 16:27:12.068785', '2026-01-25 16:27:12.068785', 69, NULL, 50);
INSERT INTO `comments` VALUES (393, '写得很详细，学到了很多！', '2026-01-25 16:27:12.068785', '2026-01-25 16:27:12.068785', 69, NULL, 51);
INSERT INTO `comments` VALUES (394, '文章质量很高，支持！', '2026-01-25 16:27:12.069782', '2026-01-25 16:27:12.069782', 69, NULL, 50);
INSERT INTO `comments` VALUES (395, '感谢分享，正好遇到这个问题。', '2026-01-25 16:27:12.069782', '2026-01-25 16:27:12.069782', 69, NULL, 53);
INSERT INTO `comments` VALUES (396, '文章质量很高，支持！', '2026-01-25 16:27:12.070783', '2026-01-25 16:27:12.070783', 69, NULL, 53);
INSERT INTO `comments` VALUES (397, '文章质量很高，支持！', '2026-01-25 16:27:12.070783', '2026-01-25 16:27:12.070783', 69, NULL, 58);
INSERT INTO `comments` VALUES (398, '有个地方不太理解，能详细说明一下吗？', '2026-01-25 16:27:12.071783', '2026-01-25 16:27:12.071783', 70, NULL, 53);
INSERT INTO `comments` VALUES (399, '写得很详细，学到了很多！', '2026-01-25 16:27:12.071783', '2026-01-25 16:27:12.071783', 70, NULL, 53);
INSERT INTO `comments` VALUES (400, '写得很详细，学到了很多！', '2026-01-25 16:27:12.072780', '2026-01-25 16:27:12.072780', 70, NULL, 53);
INSERT INTO `comments` VALUES (401, '有个小问题想请教一下...', '2026-01-25 16:27:12.072780', '2026-01-25 16:27:12.072780', 70, NULL, 54);
INSERT INTO `comments` VALUES (402, '学到了，感谢作者。', '2026-01-25 16:27:12.073782', '2026-01-25 16:27:12.073782', 70, NULL, 49);
INSERT INTO `comments` VALUES (403, '有个地方不太理解，能详细说明一下吗？', '2026-01-25 16:27:12.073782', '2026-01-25 16:27:12.073782', 70, NULL, 53);
INSERT INTO `comments` VALUES (404, '很实用的教程，收藏了。', '2026-01-25 16:27:12.073782', '2026-01-25 16:27:12.073782', 70, NULL, 52);
INSERT INTO `comments` VALUES (405, '这个思路很棒！', '2026-01-25 16:27:12.074781', '2026-01-25 16:27:12.074781', 70, NULL, 50);
INSERT INTO `comments` VALUES (406, '感谢分享，正好遇到这个问题。', '2026-01-25 16:27:12.074781', '2026-01-25 16:27:12.074781', 71, NULL, 55);
INSERT INTO `comments` VALUES (407, '写得很详细，学到了很多！', '2026-01-25 16:27:12.075782', '2026-01-25 16:27:12.075782', 71, NULL, 57);
INSERT INTO `comments` VALUES (408, '这个思路很棒！', '2026-01-25 16:27:12.075782', '2026-01-25 16:27:12.075782', 71, NULL, 49);
INSERT INTO `comments` VALUES (409, '代码示例很清晰，感谢！', '2026-01-25 16:27:12.076782', '2026-01-25 16:27:12.076782', 71, NULL, 52);
INSERT INTO `comments` VALUES (410, '很实用的教程，收藏了。', '2026-01-25 16:27:12.076782', '2026-01-25 16:27:12.076782', 71, NULL, 57);
INSERT INTO `comments` VALUES (411, '希望多分享一些实战经验。', '2026-01-25 16:27:12.076782', '2026-01-25 16:27:12.076782', 71, NULL, 56);
INSERT INTO `comments` VALUES (412, '这个思路很棒！', '2026-01-25 16:27:12.077782', '2026-01-25 16:27:12.077782', 71, NULL, 53);
INSERT INTO `comments` VALUES (413, '有个小问题想请教一下...', '2026-01-25 16:27:12.077782', '2026-01-25 16:27:12.077782', 71, NULL, 51);
INSERT INTO `comments` VALUES (414, '文章质量很高，支持！', '2026-01-25 16:27:12.078782', '2026-01-25 16:27:12.078782', 71, NULL, 58);
INSERT INTO `comments` VALUES (415, '实践了一下，确实有效。', '2026-01-25 16:27:12.078782', '2026-01-25 16:27:12.078782', 72, NULL, 49);
INSERT INTO `comments` VALUES (416, '这个思路很棒！', '2026-01-25 16:27:12.078782', '2026-01-25 16:27:12.078782', 72, NULL, 52);
INSERT INTO `comments` VALUES (417, '很实用的教程，收藏了。', '2026-01-25 16:27:12.078782', '2026-01-25 16:27:12.078782', 72, NULL, 52);
INSERT INTO `comments` VALUES (418, '实践了一下，确实有效。', '2026-01-25 16:27:12.080288', '2026-01-25 16:27:12.080288', 72, NULL, 57);
INSERT INTO `comments` VALUES (419, '这个思路很棒！', '2026-01-25 16:27:12.080288', '2026-01-25 16:27:12.080288', 72, NULL, 54);
INSERT INTO `comments` VALUES (420, '有个地方不太理解，能详细说明一下吗？', '2026-01-25 16:27:12.080288', '2026-01-25 16:27:12.080288', 72, NULL, 56);
INSERT INTO `comments` VALUES (421, '这个方案不错，我也试过类似的方法。', '2026-01-25 16:27:12.081293', '2026-01-25 16:27:12.081293', 72, NULL, 58);
INSERT INTO `comments` VALUES (422, '实践了一下，确实有效。', '2026-01-25 16:27:12.081293', '2026-01-25 16:27:12.081293', 72, NULL, 52);
INSERT INTO `comments` VALUES (423, '这个方案不错，我也试过类似的方法。', '2026-01-25 16:27:12.082296', '2026-01-25 16:27:12.082296', 72, NULL, 56);
INSERT INTO `comments` VALUES (424, '有个小问题想请教一下...', '2026-01-25 16:27:12.082296', '2026-01-25 16:27:12.082296', 72, NULL, 49);
INSERT INTO `comments` VALUES (425, '代码示例很清晰，感谢！', '2026-01-25 16:27:12.083295', '2026-01-25 16:27:12.083295', 72, NULL, 50);
INSERT INTO `comments` VALUES (426, '这个思路很棒！', '2026-01-25 16:27:12.083295', '2026-01-25 16:27:12.083295', 73, NULL, 50);
INSERT INTO `comments` VALUES (427, '写得很详细，学到了很多！', '2026-01-25 16:27:12.084294', '2026-01-25 16:27:12.084294', 73, NULL, 54);
INSERT INTO `comments` VALUES (428, '学到了，感谢作者。', '2026-01-25 16:27:12.084294', '2026-01-25 16:27:12.084294', 73, NULL, 51);
INSERT INTO `comments` VALUES (429, '文章质量很高，支持！', '2026-01-25 16:27:12.084294', '2026-01-25 16:27:12.084294', 73, NULL, 54);
INSERT INTO `comments` VALUES (430, '希望多分享一些实战经验。', '2026-01-25 16:27:12.085293', '2026-01-25 16:27:12.085293', 73, NULL, 55);
INSERT INTO `comments` VALUES (431, '希望多分享一些实战经验。', '2026-01-25 16:27:12.085293', '2026-01-25 16:27:12.085293', 73, NULL, 58);
INSERT INTO `comments` VALUES (432, '期待后续更新！', '2026-01-25 16:27:12.086294', '2026-01-25 16:27:12.086294', 73, NULL, 53);
INSERT INTO `comments` VALUES (433, '这个知识点很重要，mark一下。', '2026-01-25 16:27:12.086294', '2026-01-25 16:27:12.086294', 73, NULL, 55);
INSERT INTO `comments` VALUES (434, '写得很详细，学到了很多！', '2026-01-25 16:27:12.087294', '2026-01-25 16:27:12.087294', 73, NULL, 54);
INSERT INTO `comments` VALUES (435, '文章质量很高，支持！', '2026-01-25 16:27:12.087294', '2026-01-25 16:27:12.087294', 73, NULL, 53);
INSERT INTO `comments` VALUES (436, '写得很详细，学到了很多！', '2026-01-25 16:27:12.087294', '2026-01-25 16:27:12.087294', 74, NULL, 54);
INSERT INTO `comments` VALUES (437, '期待后续更新！', '2026-01-25 16:27:12.088292', '2026-01-25 16:27:12.088292', 74, NULL, 54);
INSERT INTO `comments` VALUES (438, '学到了，感谢作者。', '2026-01-25 16:27:12.088292', '2026-01-25 16:27:12.088292', 74, NULL, 50);
INSERT INTO `comments` VALUES (439, '很实用的教程，收藏了。', '2026-01-25 16:27:12.088292', '2026-01-25 16:27:12.088292', 74, NULL, 56);
INSERT INTO `comments` VALUES (440, '有个地方不太理解，能详细说明一下吗？', '2026-01-25 16:27:12.089292', '2026-01-25 16:27:12.089292', 74, NULL, 56);

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_t48xdq560gs3gap9g7jg36kgc`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 187 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tags
-- ----------------------------
INSERT INTO `tags` VALUES (139, '2026-01-25 16:27:11.726205', 'Spring Boot');
INSERT INTO `tags` VALUES (140, '2026-01-25 16:27:11.730712', 'Java');
INSERT INTO `tags` VALUES (141, '2026-01-25 16:27:11.733717', '后端');
INSERT INTO `tags` VALUES (142, '2026-01-25 16:27:11.744713', 'Vue');
INSERT INTO `tags` VALUES (143, '2026-01-25 16:27:11.746716', 'JavaScript');
INSERT INTO `tags` VALUES (144, '2026-01-25 16:27:11.748716', '前端');
INSERT INTO `tags` VALUES (145, '2026-01-25 16:27:11.753740', 'MySQL');
INSERT INTO `tags` VALUES (146, '2026-01-25 16:27:11.757739', '数据库');
INSERT INTO `tags` VALUES (147, '2026-01-25 16:27:11.761251', '优化');
INSERT INTO `tags` VALUES (148, '2026-01-25 16:27:11.766762', '算法');
INSERT INTO `tags` VALUES (149, '2026-01-25 16:27:11.768763', '数据结构');
INSERT INTO `tags` VALUES (150, '2026-01-25 16:27:11.771760', '学习');
INSERT INTO `tags` VALUES (151, '2026-01-25 16:27:11.775760', 'Docker');
INSERT INTO `tags` VALUES (152, '2026-01-25 16:27:11.777759', 'DevOps');
INSERT INTO `tags` VALUES (153, '2026-01-25 16:27:11.778759', '部署');
INSERT INTO `tags` VALUES (154, '2026-01-25 16:27:11.783271', 'Git');
INSERT INTO `tags` VALUES (155, '2026-01-25 16:27:11.786271', '版本控制');
INSERT INTO `tags` VALUES (156, '2026-01-25 16:27:11.788270', '开发工具');
INSERT INTO `tags` VALUES (157, '2026-01-25 16:27:11.792783', '成长');
INSERT INTO `tags` VALUES (158, '2026-01-25 16:27:11.794289', '经验');
INSERT INTO `tags` VALUES (159, '2026-01-25 16:27:11.799804', 'Redis');
INSERT INTO `tags` VALUES (160, '2026-01-25 16:27:11.802802', '缓存');
INSERT INTO `tags` VALUES (161, '2026-01-25 16:27:11.806825', '性能优化');
INSERT INTO `tags` VALUES (162, '2026-01-25 16:27:11.808824', 'Web开发');
INSERT INTO `tags` VALUES (163, '2026-01-25 16:27:11.813841', 'Spring Security');
INSERT INTO `tags` VALUES (164, '2026-01-25 16:27:11.817850', '安全');
INSERT INTO `tags` VALUES (165, '2026-01-25 16:27:11.822359', '路由');
INSERT INTO `tags` VALUES (166, '2026-01-25 16:27:11.826361', '设计模式');
INSERT INTO `tags` VALUES (167, '2026-01-25 16:27:11.831358', 'Linux');
INSERT INTO `tags` VALUES (168, '2026-01-25 16:27:11.834359', '命令行');
INSERT INTO `tags` VALUES (169, '2026-01-25 16:27:11.837358', '运维');
INSERT INTO `tags` VALUES (170, '2026-01-25 16:27:11.840870', 'Python');
INSERT INTO `tags` VALUES (171, '2026-01-25 16:27:11.842872', '爬虫');
INSERT INTO `tags` VALUES (172, '2026-01-25 16:27:11.845871', '微服务');
INSERT INTO `tags` VALUES (173, '2026-01-25 16:27:11.847871', '架构');
INSERT INTO `tags` VALUES (174, '2026-01-25 16:27:11.850379', '分布式');
INSERT INTO `tags` VALUES (175, '2026-01-25 16:27:11.854910', 'TypeScript');
INSERT INTO `tags` VALUES (176, '2026-01-25 16:27:11.859909', '设计');
INSERT INTO `tags` VALUES (177, '2026-01-25 16:27:11.864911', 'API');
INSERT INTO `tags` VALUES (178, '2026-01-25 16:27:11.868910', '工程化');
INSERT INTO `tags` VALUES (179, '2026-01-25 16:27:11.871420', 'Webpack');
INSERT INTO `tags` VALUES (180, '2026-01-25 16:27:11.876420', '并发');
INSERT INTO `tags` VALUES (181, '2026-01-25 16:27:11.878420', '多线程');
INSERT INTO `tags` VALUES (182, '2026-01-25 16:27:12.242087', '全栈');
INSERT INTO `tags` VALUES (183, '2026-01-25 16:27:12.246107', '移动开发');
INSERT INTO `tags` VALUES (184, '2026-01-25 16:27:12.253612', '分享');
INSERT INTO `tags` VALUES (185, '2026-01-25 16:27:12.262131', '教程');
INSERT INTO `tags` VALUES (186, '2026-01-25 16:27:12.267130', '总结');

-- ----------------------------
-- Table structure for user_follows
-- ----------------------------
DROP TABLE IF EXISTS `user_follows`;
CREATE TABLE `user_follows`  (
  `follower_id` bigint NOT NULL,
  `following_id` bigint NOT NULL,
  PRIMARY KEY (`follower_id`, `following_id`) USING BTREE,
  INDEX `FKp1rxuw1ulwo6mu84qaajuttrk`(`following_id` ASC) USING BTREE,
  CONSTRAINT `FKp1rxuw1ulwo6mu84qaajuttrk` FOREIGN KEY (`following_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKqx9mu1fniaua5jfe1cdyspxdt` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_follows
-- ----------------------------
INSERT INTO `user_follows` VALUES (51, 49);
INSERT INTO `user_follows` VALUES (52, 49);
INSERT INTO `user_follows` VALUES (54, 49);
INSERT INTO `user_follows` VALUES (56, 49);
INSERT INTO `user_follows` VALUES (58, 49);
INSERT INTO `user_follows` VALUES (51, 50);
INSERT INTO `user_follows` VALUES (57, 50);
INSERT INTO `user_follows` VALUES (49, 51);
INSERT INTO `user_follows` VALUES (50, 51);
INSERT INTO `user_follows` VALUES (52, 51);
INSERT INTO `user_follows` VALUES (56, 51);
INSERT INTO `user_follows` VALUES (54, 52);
INSERT INTO `user_follows` VALUES (55, 52);
INSERT INTO `user_follows` VALUES (50, 53);
INSERT INTO `user_follows` VALUES (52, 53);
INSERT INTO `user_follows` VALUES (55, 53);
INSERT INTO `user_follows` VALUES (49, 54);
INSERT INTO `user_follows` VALUES (50, 54);
INSERT INTO `user_follows` VALUES (53, 54);
INSERT INTO `user_follows` VALUES (53, 56);
INSERT INTO `user_follows` VALUES (55, 56);
INSERT INTO `user_follows` VALUES (49, 57);
INSERT INTO `user_follows` VALUES (55, 57);
INSERT INTO `user_follows` VALUES (56, 57);
INSERT INTO `user_follows` VALUES (49, 58);
INSERT INTO `user_follows` VALUES (55, 58);
INSERT INTO `user_follows` VALUES (56, 58);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `bio` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `daily_experience` int NULL DEFAULT NULL,
  `experience` int NULL DEFAULT NULL,
  `last_experience_reset` datetime(6) NULL DEFAULT NULL,
  `level` int NULL DEFAULT NULL,
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'USER',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_6dotkott2kjsp8vw4d0m25fb7`(`email` ASC) USING BTREE,
  UNIQUE INDEX `UK_r43af9ap4edm43mmtq01oddj6`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (49, 'https://cube.elemecdn.com/0/88/03b0d4ff20dd7589bb7fd77975b171gc.jpeg', '全栈开发工程师，热爱技术分享', '2026-01-25 16:27:11.165834', 'zhangxiaoming@example.com', '$2a$10$gAyeM9msu7dBvf2KI3s3EeNPvqMqmsCV20QYFDGShVS0SegZdz1.G', '2026-01-25 16:27:12.090804', '张小明', 86, 176, '2026-01-25 16:27:11.740715', 4, '', 'USER');
INSERT INTO `users` VALUES (50, 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '专注于后端开发，Spring Boot专家', '2026-01-25 16:27:11.242551', 'lijs@example.com', '$2a$10$3SqIg0IFgv.WVVgfLK4BkOL3l.dDIIgJHFrndUBNfAYULDN6ud1A.', '2026-01-25 16:27:12.090804', '李技术', 100, 550, '2026-01-25 16:27:11.752228', 6, '', 'USER');
INSERT INTO `users` VALUES (51, 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a549403c68a25jpeg.jpeg', 'Vue.js爱好者，前端架构师', '2026-01-25 16:27:11.301278', 'wangqd@example.com', '$2a$10$4GH7FdXxHZ0y6gAE11qwsuNtSn5ngRPRKJZm/aFRBKY3lvgbQQTky', '2026-01-25 16:27:12.090804', '王前端', 85, 92, '2026-01-25 16:27:11.762250', 3, '', 'USER');
INSERT INTO `users` VALUES (52, 'https://cube.elemecdn.com/f/71/afd9a7d7e0f6b96211e533a9c109bpeg.jpeg', '算法竞赛选手，数据结构达人', '2026-01-25 16:27:11.361089', 'chensf@example.com', '$2a$10$ubE8FlagGqD58gFS51lj0ObQjfMM7OzeanRg.XwrTgl3cFEOvLjp.', '2026-01-25 16:27:12.090804', '陈算法', 88, 221, '2026-01-25 16:27:11.773760', 4, '', 'USER');
INSERT INTO `users` VALUES (53, 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg', 'UI/UX设计师，关注用户体验', '2026-01-25 16:27:11.420298', 'liuds@example.com', '$2a$10$01xb6oK/yy6T6iT8Y1kKCeLPJJOOxwo2knLEHhdObvCE56AhHam0u', '2026-01-25 16:27:12.090804', '刘设计', 100, 450, '2026-01-25 16:27:11.781269', 5, '', 'USER');
INSERT INTO `users` VALUES (54, 'https://cube.elemecdn.com/c/8b/227a7f0db80d1024fdd8cbd20df8jpeg.jpeg', 'DevOps工程师，Docker和K8s实践者', '2026-01-25 16:27:11.478617', 'zhaoyw@example.com', '$2a$10$.kYZw/kc15pWowhAV3I.Q.woC9BU.Q/PVq3yxcLD8pa1F5JaDjP4q', '2026-01-25 16:27:12.090804', '赵运维', 96, 287, '2026-01-25 16:27:11.790781', 4, '', 'USER');
INSERT INTO `users` VALUES (55, 'https://cube.elemecdn.com/2/11/6535bcfb85e8c5b6d8c7d1d5b3ab9jpeg.jpeg', '产品经理，关注技术趋势', '2026-01-25 16:27:11.537857', 'suncp@example.com', '$2a$10$ufhfws19348yLaINtMvAe.GoBd4gmX/A1QuFsR7Gu6qa/zFHBzb3C', '2026-01-25 16:27:12.090804', '孙产品', 81, 170, '2026-01-25 16:27:11.797804', 4, '', 'USER');
INSERT INTO `users` VALUES (56, 'https://cube.elemecdn.com/e/f48/4445873e693922f0248f7591499jpeg.jpeg', '测试工程师，自动化测试专家', '2026-01-25 16:27:11.595468', 'zhoucs@example.com', '$2a$10$WKGMsg9ALsbGWE18pdabPOAMELl2J9qkHDIIR0L0xz3jX.WbklUu.', '2026-01-25 16:27:12.090804', '周测试', 95, 340, '2026-01-25 16:27:11.804310', 5, '', 'USER');
INSERT INTO `users` VALUES (57, 'https://cube.elemecdn.com/1/8e/aecefb37cef74a74b4cd74ae4ae9jpeg.jpeg', '数据分析师，SQL和Python爱好者', '2026-01-25 16:27:11.652190', 'wusj@example.com', '$2a$10$htBpvjRR7AD7wenuj3oEl.lAcbmQhb6rnqMH5LmXEugTd0ZEJ1bFG', '2026-01-25 16:27:12.090804', '吴数据', 85, 231, '2026-01-25 16:27:11.811337', 4, '', 'USER');
INSERT INTO `users` VALUES (58, 'https://cube.elemecdn.com/0/88/03b0d4ff20dd7589bb7fd77975b171gc.jpeg', '在校学生，记录学习成长', '2026-01-25 16:27:11.710362', 'zhengxx@example.com', '$2a$10$Lc0EZkdQA8Sblov2y5DXKugdjkKdoV2hlVQZSf.j5QLLJnvoyv0/i', '2026-01-25 16:27:12.090804', '郑学习', 100, 290, '2026-01-25 16:27:11.820353', 4, '', 'USER');
INSERT INTO `users` VALUES (59, 'https://cube.elemecdn.com/0/88/03b0d4ff20dd7589bb7fd77975b171gc.jpeg', '这个人很懒，什么都没留下', '2026-01-25 16:40:06.373245', 'admin@gmail.com', '$2a$10$a..i/2ycLXuNdYo4bBj6d.KYPW515.QJxHSIItJIi8DxA2.bZwviu', '2026-01-25 17:59:12.383900', '管理员', 0, 0, NULL, 1, 'admin', 'ADMIN');
INSERT INTO `users` VALUES (60, 'https://cube.elemecdn.com/0/88/03b0d4ff20dd7589bb7fd77975b171gc.jpeg', '这个人很懒，什么都没留下', '2026-01-25 16:42:05.638398', '123456@qq.com', '$2a$10$qQZdxRMowtnMjCv0Xssth.rqjy0hjo2qj7v4WV90AAbpbEWtWY2r6', '2026-01-25 16:42:19.171389', '测试', 4, 4, '2026-01-25 16:42:18.689378', 1, '123456', 'USER');
INSERT INTO `users` VALUES (61, 'https://cube.elemecdn.com/0/88/03b0d4ff20dd7589bb7fd77975b171gc.jpeg', '这个人很懒，什么都没留下', '2026-01-28 12:43:09.349179', '12345678@qq.com', '$2a$10$vLaKsiWVYSyMQggO6jlhl.cUyXRDOp3jBbpMIpV.WbAWam/cd4KLG', '2026-01-28 12:43:09.349179', '12345678', 0, 0, NULL, 1, '12345678', 'USER');

SET FOREIGN_KEY_CHECKS = 1;
