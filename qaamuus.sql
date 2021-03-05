/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : qaamuus

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 05/03/2021 08:57:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auditLogs
-- ----------------------------
DROP TABLE IF EXISTS `auditLogs`;
CREATE TABLE `auditLogs` (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `entityName` varchar(255) NOT NULL,
  `entityId` varchar(255) NOT NULL,
  `tenantId` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `action` varchar(32) NOT NULL,
  `createdById` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `createdByEmail` varchar(255) DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `values` json NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auditLogs
-- ----------------------------
BEGIN;
INSERT INTO `auditLogs` VALUES ('01e3f0d1-8490-4553-8fca-2eab31eef8ed', 'user', 'b5d520ee-ef92-4708-a4de-b83f5dd1707b', NULL, 'update', NULL, NULL, '2021-03-04 20:48:08', '{\"id\": \"b5d520ee-ef92-4708-a4de-b83f5dd1707b\", \"phoneVerified\": true}');
INSERT INTO `auditLogs` VALUES ('170b245c-5183-4607-b4d4-5b0f8a485a73', 'user', 'b5d520ee-ef92-4708-a4de-b83f5dd1707b', NULL, 'create', NULL, NULL, '2021-03-04 20:47:40', '{\"id\": \"b5d520ee-ef92-4708-a4de-b83f5dd1707b\", \"email\": \"admin@gmail.com\", \"gender\": false, \"fullName\": \"amein abdi\", \"lastName\": null, \"createdAt\": \"2021-03-04T20:47:40.139Z\", \"firstName\": \"amein abdi\", \"updatedAt\": \"2021-03-04T20:47:40.139Z\", \"phoneNumber\": \"+252612363996\", \"emailVerified\": false, \"phoneVerified\": false, \"verificationCode\": \"0317\"}');
INSERT INTO `auditLogs` VALUES ('2d368c69-cd7e-4265-9d48-ab727b0394d8', 'user', 'b5d520ee-ef92-4708-a4de-b83f5dd1707b', NULL, 'create', 'b5d520ee-ef92-4708-a4de-b83f5dd1707b', 'admin@gmail.com', '2021-03-04 20:47:40', '{\"email\": \"admin@gmail.com\", \"roles\": [\"admin\"], \"status\": \"active\"}');
INSERT INTO `auditLogs` VALUES ('7c33f32f-d0e2-4817-bedd-de1100f6d484', 'tenant', '20f2f499-698a-47bc-8033-904798d06516', '20f2f499-698a-47bc-8033-904798d06516', 'create', 'b5d520ee-ef92-4708-a4de-b83f5dd1707b', 'admin@gmail.com', '2021-03-04 20:47:40', '{\"id\": \"20f2f499-698a-47bc-8033-904798d06516\", \"url\": \"default\", \"name\": \"default\", \"plan\": \"free\", \"createdAt\": \"2021-03-04T20:47:40.378Z\", \"updatedAt\": \"2021-03-04T20:47:40.378Z\", \"planStatus\": \"active\", \"createdById\": \"b5d520ee-ef92-4708-a4de-b83f5dd1707b\", \"updatedById\": \"b5d520ee-ef92-4708-a4de-b83f5dd1707b\"}');
COMMIT;

-- ----------------------------
-- Table structure for files
-- ----------------------------
DROP TABLE IF EXISTS `files`;
CREATE TABLE `files` (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `belongsTo` varchar(255) DEFAULT NULL,
  `belongsToId` varchar(255) DEFAULT NULL,
  `belongsToColumn` varchar(255) DEFAULT NULL,
  `name` varchar(2083) NOT NULL,
  `sizeInBytes` int DEFAULT NULL,
  `privateUrl` varchar(2083) DEFAULT NULL,
  `publicUrl` varchar(2083) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `tenantId` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `createdById` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `updatedById` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tenantId` (`tenantId`),
  KEY `createdById` (`createdById`),
  KEY `updatedById` (`updatedById`),
  CONSTRAINT `files_ibfk_1` FOREIGN KEY (`tenantId`) REFERENCES `tenants` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `files_ibfk_2` FOREIGN KEY (`createdById`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `files_ibfk_3` FOREIGN KEY (`updatedById`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of files
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for lessons
-- ----------------------------
DROP TABLE IF EXISTS `lessons`;
CREATE TABLE `lessons` (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` text,
  `embed` text,
  `chapterId` int DEFAULT NULL,
  `subjectId` int DEFAULT NULL,
  `classId` int DEFAULT NULL,
  `levelId` int DEFAULT NULL,
  `realeaseDate` datetime DEFAULT NULL,
  `position` tinyint(1) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  `importHash` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `tenantId` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `createdById` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `updatedById` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lessons_import_hash_tenant_id` (`importHash`,`tenantId`),
  KEY `tenantId` (`tenantId`),
  KEY `createdById` (`createdById`),
  KEY `updatedById` (`updatedById`),
  CONSTRAINT `lessons_ibfk_1` FOREIGN KEY (`tenantId`) REFERENCES `tenants` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `lessons_ibfk_2` FOREIGN KEY (`createdById`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `lessons_ibfk_3` FOREIGN KEY (`updatedById`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lessons
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` varchar(255) NOT NULL DEFAULT 'default',
  `theme` varchar(255) NOT NULL,
  `backgroundImageUrl` varchar(1024) DEFAULT NULL,
  `logoUrl` varchar(1024) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `tenantId` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `createdById` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `updatedById` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tenantId` (`tenantId`),
  KEY `createdById` (`createdById`),
  KEY `updatedById` (`updatedById`),
  CONSTRAINT `settings_ibfk_1` FOREIGN KEY (`tenantId`) REFERENCES `tenants` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `settings_ibfk_2` FOREIGN KEY (`createdById`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `settings_ibfk_3` FOREIGN KEY (`updatedById`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of settings
-- ----------------------------
BEGIN;
INSERT INTO `settings` VALUES ('20f2f499-698a-47bc-8033-904798d06516', 'default', NULL, NULL, '2021-03-04 20:47:40', '2021-03-04 20:47:40', NULL, '20f2f499-698a-47bc-8033-904798d06516', 'b5d520ee-ef92-4708-a4de-b83f5dd1707b', NULL);
COMMIT;

-- ----------------------------
-- Table structure for tenants
-- ----------------------------
DROP TABLE IF EXISTS `tenants`;
CREATE TABLE `tenants` (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(50) NOT NULL,
  `plan` enum('free','growth','enterprise') NOT NULL DEFAULT 'free',
  `planStatus` enum('active','cancel_at_period_end','error') NOT NULL DEFAULT 'active',
  `planStripeCustomerId` varchar(255) DEFAULT NULL,
  `planUserId` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `createdById` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `updatedById` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tenants_url` (`url`),
  KEY `createdById` (`createdById`),
  KEY `updatedById` (`updatedById`),
  CONSTRAINT `tenants_ibfk_1` FOREIGN KEY (`createdById`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tenants_ibfk_2` FOREIGN KEY (`updatedById`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tenants
-- ----------------------------
BEGIN;
INSERT INTO `tenants` VALUES ('20f2f499-698a-47bc-8033-904798d06516', 'default', 'default', 'free', 'active', NULL, NULL, '2021-03-04 20:47:40', '2021-03-04 20:47:40', NULL, 'b5d520ee-ef92-4708-a4de-b83f5dd1707b', 'b5d520ee-ef92-4708-a4de-b83f5dd1707b');
COMMIT;

-- ----------------------------
-- Table structure for tenantUsers
-- ----------------------------
DROP TABLE IF EXISTS `tenantUsers`;
CREATE TABLE `tenantUsers` (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `roles` json DEFAULT NULL,
  `invitationToken` varchar(255) DEFAULT NULL,
  `status` enum('active','invited','empty-permissions') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `tenantId` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `userId` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `createdById` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `updatedById` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tenantId` (`tenantId`),
  KEY `userId` (`userId`),
  KEY `createdById` (`createdById`),
  KEY `updatedById` (`updatedById`),
  CONSTRAINT `tenantusers_ibfk_1` FOREIGN KEY (`tenantId`) REFERENCES `tenants` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tenantusers_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tenantusers_ibfk_3` FOREIGN KEY (`createdById`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tenantusers_ibfk_4` FOREIGN KEY (`updatedById`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tenantUsers
-- ----------------------------
BEGIN;
INSERT INTO `tenantUsers` VALUES ('922eb5aa-1e14-4314-aa97-25bfc8c47a14', '[\"admin\"]', NULL, 'active', '2021-03-04 20:47:40', '2021-03-04 20:47:40', NULL, '20f2f499-698a-47bc-8033-904798d06516', 'b5d520ee-ef92-4708-a4de-b83f5dd1707b', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `firstName` varchar(80) DEFAULT NULL,
  `region` varchar(80) DEFAULT NULL,
  `gender` varchar(80) DEFAULT NULL,
  `level` varchar(80) DEFAULT NULL,
  `classlevel` varchar(80) DEFAULT NULL,
  `verificationCode` int DEFAULT NULL,
  `phoneVerified` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(255) DEFAULT NULL,
  `emailVerified` tinyint(1) NOT NULL DEFAULT '0',
  `emailVerificationToken` varchar(255) DEFAULT NULL,
  `emailVerificationTokenExpiresAt` datetime DEFAULT NULL,
  `passwordResetToken` varchar(255) DEFAULT NULL,
  `passwordResetTokenExpiresAt` datetime DEFAULT NULL,
  `lastName` varchar(175) DEFAULT NULL,
  `phoneNumber` varchar(24) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `jwtTokenInvalidBefore` datetime DEFAULT NULL,
  `importHash` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `createdById` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `updatedById` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email` (`email`),
  UNIQUE KEY `users_import_hash` (`importHash`),
  KEY `createdById` (`createdById`),
  KEY `updatedById` (`updatedById`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`createdById`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`updatedById`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('b5d520ee-ef92-4708-a4de-b83f5dd1707b', 'amein abdi', 'amein abdi', NULL, '0', NULL, NULL, 3173, 1, '$2b$12$2x1v9DD5CyQzBtMRxJ3Pu.X7Jp.yuhamxSw.8yXKhhpzKn9B56ism', 0, NULL, NULL, NULL, NULL, NULL, '+252612363996', 'admin@gmail.com', NULL, NULL, '2021-03-04 20:47:40', '2021-03-04 20:48:08', NULL, NULL, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
