/*
Navicat MySQL Data Transfer

Source Server         : hyq
Source Server Version : 50625
Source Host           : 127.0.0.1:3306
Source Database       : hyq_exam

Target Server Type    : MYSQL
Target Server Version : 50625
File Encoding         : 65001

Date: 2016-11-10 22:35:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_apply
-- ----------------------------
DROP TABLE IF EXISTS `t_apply`;
CREATE TABLE `t_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applyInfoId` int(11) NOT NULL,
  `userId` varchar(40) NOT NULL,
  `applyStatus` varchar(20) NOT NULL COMMENT '报名状态',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `t_apply_ibfk_1` (`applyInfoId`),
  CONSTRAINT `t_apply_ibfk_1` FOREIGN KEY (`applyInfoId`) REFERENCES `t_applyinfo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_apply_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_apply
-- ----------------------------
INSERT INTO `t_apply` VALUES ('1', '1', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '待审核');
INSERT INTO `t_apply` VALUES ('3', '6', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '待审核');
INSERT INTO `t_apply` VALUES ('4', '1', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '已通过');
INSERT INTO `t_apply` VALUES ('5', '6', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '待审核');
INSERT INTO `t_apply` VALUES ('6', '1', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '已通过');
INSERT INTO `t_apply` VALUES ('7', '14', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '待审核');

-- ----------------------------
-- Table structure for t_applyinfo
-- ----------------------------
DROP TABLE IF EXISTS `t_applyinfo`;
CREATE TABLE `t_applyinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '报名信息id',
  `title` varchar(100) NOT NULL COMMENT '报名标题',
  `description` varchar(255) DEFAULT NULL COMMENT '报名描述',
  `startTime` datetime DEFAULT NULL COMMENT '报名开始时间',
  `status` varchar(255) DEFAULT NULL COMMENT '报名状态',
  `endTime` datetime DEFAULT NULL COMMENT '报名结束时间',
  `parentId` int(11) DEFAULT NULL COMMENT '上轮报名id,因为涉及到多个轮次',
  `isHandConfirm` varchar(255) DEFAULT NULL COMMENT '是否手工确认报名信息',
  PRIMARY KEY (`id`),
  KEY `parentId` (`parentId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_applyinfo
-- ----------------------------
INSERT INTO `t_applyinfo` VALUES ('1', '修改的报名', '1描述', '2016-05-23 00:00:00', '进行中', '1995-08-23 00:00:00', '1', 'yes');
INSERT INTO `t_applyinfo` VALUES ('6', '地方', '1描述', '2016-05-31 00:00:00', '进行中', '1995-08-23 00:00:00', '11', 'yes');
INSERT INTO `t_applyinfo` VALUES ('7', '1', '1', '2016-06-21 15:10:35', '进行中', '1995-08-23 13:00:00', '-1', 'yes');
INSERT INTO `t_applyinfo` VALUES ('9', '第1_1次报名', '1描述', '2016-06-29 17:24:27', '进行中', '1995-08-23 00:00:00', '7', 'yes');
INSERT INTO `t_applyinfo` VALUES ('10', '1_1_1次报名', '1描述', '2016-06-29 17:25:00', '进行中', '1995-08-23 00:00:00', '9', 'no');
INSERT INTO `t_applyinfo` VALUES ('11', '1_1_1_1次报名', '1描述', '2016-06-29 17:25:25', '进行中', '1995-08-23 00:00:00', '10', 'no');
INSERT INTO `t_applyinfo` VALUES ('12', '老师', '1234567@qq2233.com', '2016-07-03 10:42:57', '进行中', '2016-07-07 00:00:00', '7', 'yes');
INSERT INTO `t_applyinfo` VALUES ('13', '支教老师报名', '支教老师的报名描述', '2016-07-07 00:00:00', '未开始', '2016-07-13 00:00:00', '12', 'yes');
INSERT INTO `t_applyinfo` VALUES ('14', '18381307126', '11111', '2016-07-13 11:26:00', '未开始', '2016-07-15 17:26:00', '13', 'yes');

-- ----------------------------
-- Table structure for t_judge
-- ----------------------------
DROP TABLE IF EXISTS `t_judge`;
CREATE TABLE `t_judge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `level` varchar(10) DEFAULT NULL,
  `answerAnalysis` varchar(255) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `point` varchar(255) DEFAULT NULL,
  `answer` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `typeId` (`typeId`),
  CONSTRAINT `t_judge_ibfk_1` FOREIGN KEY (`typeId`) REFERENCES `t_question_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_judge
-- ----------------------------
INSERT INTO `t_judge` VALUES ('3', '你会好的，对吗？', '困难', '1', '2', '默认,气象知识', '错误');
INSERT INTO `t_judge` VALUES ('4', '在跑步过后能立马洗冷水澡吗？', '容易', '不能立马洗澡', '2', '1级,1_2级', '错误');
INSERT INTO `t_judge` VALUES ('5', '你是猪吗？', '容易', '搞怪问题\n', '2', null, '错误');
INSERT INTO `t_judge` VALUES ('6', '12222', '困难', '1', '2', null, '正确');
INSERT INTO `t_judge` VALUES ('7', '11111', '一般', '1111', '2', null, '正确');

-- ----------------------------
-- Table structure for t_message
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(40) DEFAULT NULL,
  `accepter` varchar(40) DEFAULT NULL,
  `content` text,
  `sendTime` varchar(40) DEFAULT NULL,
  `isGet` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------
INSERT INTO `t_message` VALUES ('1', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '在吗', '2016-06-51 18:51:25', '1');
INSERT INTO `t_message` VALUES ('2', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '小轩在不在', '2016-06-52 18:52:14', '1');
INSERT INTO `t_message` VALUES ('3', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '我是娇妹', '2016-06-52 18:52:24', '1');
INSERT INTO `t_message` VALUES ('4', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '在吗', '2016-09-47 21:47:14', '1');
INSERT INTO `t_message` VALUES ('5', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '[Ljava.lang.String;@1170def', '啊', '2016-08-48 08:48:37', '0');
INSERT INTO `t_message` VALUES ('6', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '[Ljava.lang.String;@1170def', '在哪里', '2016-08-50 08:50:37', '0');
INSERT INTO `t_message` VALUES ('7', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '[Ljava.lang.String;@1170def', '在哪里方法', '2016-08-52 08:52:20', '0');
INSERT INTO `t_message` VALUES ('8', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', 'fsd发生的', '2016-09-01 09:01:50', '1');
INSERT INTO `t_message` VALUES ('9', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '', 'fsd发生的', '2016-09-01 09:01:50', '0');
INSERT INTO `t_message` VALUES ('10', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '拆', '2016-09-07 09:07:31', '1');
INSERT INTO `t_message` VALUES ('11', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '拆', '2016-09-07 09:07:31', '1');
INSERT INTO `t_message` VALUES ('12', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '', '拆', '2016-09-07 09:07:31', '0');
INSERT INTO `t_message` VALUES ('13', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '再试试', '2016-09-11 09:11:29', '1');
INSERT INTO `t_message` VALUES ('14', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '再试试', '2016-09-11 09:11:29', '1');
INSERT INTO `t_message` VALUES ('15', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '草', '2016-09-30 09:30:04', '1');
INSERT INTO `t_message` VALUES ('16', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '草', '2016-09-30 09:30:04', '1');
INSERT INTO `t_message` VALUES ('17', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '？？？', '2016-10-07 10:07:24', '1');
INSERT INTO `t_message` VALUES ('18', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '你是谁？', '2016-10-07 10:07:34', '1');
INSERT INTO `t_message` VALUES ('19', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '擦', '2016-10-07 10:07:40', '1');
INSERT INTO `t_message` VALUES ('20', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '小伙子，不要骂人', '2016-10-08 10:08:33', '1');
INSERT INTO `t_message` VALUES ('21', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '说出你的需求', '2016-10-08 10:08:44', '1');
INSERT INTO `t_message` VALUES ('22', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '小伙子，不要骂人', '2016-10-10 10:10:22', '1');
INSERT INTO `t_message` VALUES ('23', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '咋', '2016-10-10 10:10:55', '1');
INSERT INTO `t_message` VALUES ('24', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '就是骂人？', '2016-10-11 10:11:04', '1');
INSERT INTO `t_message` VALUES ('25', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '好凶！', '2016-10-11 10:11:23', '1');
INSERT INTO `t_message` VALUES ('26', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '11', '2016-10-13 10:13:23', '1');
INSERT INTO `t_message` VALUES ('27', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '就是骂人？', '2016-10-13 10:13:31', '1');
INSERT INTO `t_message` VALUES ('28', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '就是骂人？', '2016-10-13 10:13:42', '1');
INSERT INTO `t_message` VALUES ('29', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '就是骂人？', '2016-10-13 10:13:44', '1');
INSERT INTO `t_message` VALUES ('66', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '发生的是我发了', '2016-11-14 09:11:32', '1');
INSERT INTO `t_message` VALUES ('67', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '？？？', '2016-11-14 09:11:52', '1');
INSERT INTO `t_message` VALUES ('68', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', 'ni你是管理员吗\n', '2016-13-14 09:13:46', '1');
INSERT INTO `t_message` VALUES ('69', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '你是不是管理', '2016-15-14 09:15:18', '1');
INSERT INTO `t_message` VALUES ('70', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '在哪里', '2016-09-33 09:33:24', '1');
INSERT INTO `t_message` VALUES ('71', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '在哪里', '2016-09-34 09:34:25', '1');
INSERT INTO `t_message` VALUES ('72', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '你猜', '2016-34-14 09:34:34', '1');
INSERT INTO `t_message` VALUES ('73', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '猜你妹啊', '2016-09-34 09:34:54', '1');
INSERT INTO `t_message` VALUES ('74', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '在吗', '2016-38-14 09:38:26', '1');
INSERT INTO `t_message` VALUES ('75', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '在吗', '2016-39-14 09:39:45', '1');
INSERT INTO `t_message` VALUES ('76', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '在吗发的', '2016-46-14 09:46:40', '1');
INSERT INTO `t_message` VALUES ('77', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', 'fsd', '2016-49-15 09:49:29', '1');
INSERT INTO `t_message` VALUES ('78', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '你是管理员？', '2016-01-15 10:01:17', '1');
INSERT INTO `t_message` VALUES ('79', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '我是啊', '2016-01-15 10:01:53', '1');
INSERT INTO `t_message` VALUES ('80', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '我来找hyq', '2016-03-15 10:03:34', '1');
INSERT INTO `t_message` VALUES ('81', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '我是hyq你是2吗', '2016-10-04 10:04:08', '1');
INSERT INTO `t_message` VALUES ('82', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '猜对了', '2016-04-15 10:04:24', '1');
INSERT INTO `t_message` VALUES ('83', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '我是2', '2016-07-15 10:07:56', '1');
INSERT INTO `t_message` VALUES ('84', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '我才是管理员好吧', '2016-09-15 10:09:17', '1');
INSERT INTO `t_message` VALUES ('85', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '发送出去？', '2016-05-04 15:05:37', '1');
INSERT INTO `t_message` VALUES ('86', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '发送出去？发水电费', '2016-08-04 15:08:40', '1');
INSERT INTO `t_message` VALUES ('87', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '发送出去？发水电费', '2016-16-04 15:16:51', '1');
INSERT INTO `t_message` VALUES ('88', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '啊？\n', '2016-16-04 15:16:58', '1');
INSERT INTO `t_message` VALUES ('89', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '发顺丰', '2016-17-04 15:17:57', '1');
INSERT INTO `t_message` VALUES ('90', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '发生的', '2016-17-04 15:17:59', '1');
INSERT INTO `t_message` VALUES ('91', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '1', '2016-18-04 15:18:46', '1');
INSERT INTO `t_message` VALUES ('92', '987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '2', '2016-18-04 15:18:48', '1');
INSERT INTO `t_message` VALUES ('93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '', 'a', '2016-53-04 16:53:32', '0');
INSERT INTO `t_message` VALUES ('94', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '', '1', '2016-53-04 16:53:35', '0');
INSERT INTO `t_message` VALUES ('95', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '', '??', '2016-58-04 16:58:43', '0');
INSERT INTO `t_message` VALUES ('96', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '', 'sb', '2016-03-04 17:03:35', '0');
INSERT INTO `t_message` VALUES ('97', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '', '发的', '2016-06-04 19:06:05', '0');
INSERT INTO `t_message` VALUES ('98', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '', '2', '2016-08-04 19:08:56', '0');
INSERT INTO `t_message` VALUES ('99', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', 'fs', '2016-15-04 19:15:26', '1');
INSERT INTO `t_message` VALUES ('100', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '飞', '2016-28-04 19:28:42', '1');
INSERT INTO `t_message` VALUES ('101', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', 'fds', '2016-07-42 19:42:32', '1');
INSERT INTO `t_message` VALUES ('102', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '分上的范德萨', '2016-42-04 19:42:47', '1');
INSERT INTO `t_message` VALUES ('103', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', 'aaa', '2016-07-43 19:43:00', '1');
INSERT INTO `t_message` VALUES ('104', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '丰盛的', '2016-43-04 19:43:16', '1');
INSERT INTO `t_message` VALUES ('105', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '!!!', '2016-07-44 19:44:45', '1');
INSERT INTO `t_message` VALUES ('106', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '( ⊙ o ⊙ )啊！', '2016-44-04 19:44:53', '1');
INSERT INTO `t_message` VALUES ('107', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', 'fsd', '2016-07-45 19:45:04', '1');
INSERT INTO `t_message` VALUES ('108', 'eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '丰盛的', '2016-45-04 19:45:10', '1');

-- ----------------------------
-- Table structure for t_mutichoice
-- ----------------------------
DROP TABLE IF EXISTS `t_mutichoice`;
CREATE TABLE `t_mutichoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `level` varchar(10) DEFAULT NULL,
  `answerAnalysis` varchar(255) DEFAULT NULL,
  `point` varchar(200) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `item` varchar(255) DEFAULT NULL,
  `trueItem` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `typeId` (`typeId`),
  CONSTRAINT `t_mutichoice_ibfk_1` FOREIGN KEY (`typeId`) REFERENCES `t_question_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_mutichoice
-- ----------------------------
INSERT INTO `t_mutichoice` VALUES ('3', '列举你所知道的天气？', '容易', '开放性答案', '默认,气象知识', '4', '晴天,阴天,雨天,雪', '晴天,阴天,雨天,雪');
INSERT INTO `t_mutichoice` VALUES ('5', '1', '容易', null, null, '4', '', '');
INSERT INTO `t_mutichoice` VALUES ('6', '顶级有多少种方式？', '困难', '开放性问答', '顶级', '4', '1种,2种,3种', '2种,3种');

-- ----------------------------
-- Table structure for t_notice
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `deployer` varchar(100) DEFAULT NULL,
  `deployTime` varchar(30) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('4', 'wo我要同步', '<p>搞sheme！<br/></p>', '', '2016-06-21 15:24:01', '0');
INSERT INTO `t_notice` VALUES ('5', 'vvv', '<p>搞毛！<br/></p>', '', '2016-06-04 14:37:42', '2');
INSERT INTO `t_notice` VALUES ('6', 'bvb', '<p>搞毛！<br/></p>', '', '2016-06-04 15:01:46', '3');
INSERT INTO `t_notice` VALUES ('7', '0989', '<p>搞毛！<br/></p>', '', '2016-06-04 15:07:14', '4');
INSERT INTO `t_notice` VALUES ('8', '高考公告', '<p>搞毛！<br/></p>', '', '2016-06-04 14:21:19', '5');
INSERT INTO `t_notice` VALUES ('9', '还不行？', '<p>发生的<br/></p>', '', '2016-06-04 15:17:36', '6');
INSERT INTO `t_notice` VALUES ('10', '佛挡杀佛', '<p>撒旦<br/></p>', '', '2016-06-04 15:57:01', '9');
INSERT INTO `t_notice` VALUES ('11', '水电费水电费', '阿斯蒂芬发送', '', '2016-06-04 15:57:07', '7');
INSERT INTO `t_notice` VALUES ('12', '这次呢', '<p>发生的<br/></p>', '', '2016-06-07 10:46:22', '8');

-- ----------------------------
-- Table structure for t_point
-- ----------------------------
DROP TABLE IF EXISTS `t_point`;
CREATE TABLE `t_point` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(80) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parentId` (`parentId`),
  CONSTRAINT `t_point_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `t_point` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_point
-- ----------------------------
INSERT INTO `t_point` VALUES ('-1', '默认', '缺省的知识点', null);
INSERT INTO `t_point` VALUES ('6', '气象知识', '关注天气变化', '-1');
INSERT INTO `t_point` VALUES ('9', '1级', '1级描述', null);
INSERT INTO `t_point` VALUES ('10', '1_2级', '1-2描述', '9');
INSERT INTO `t_point` VALUES ('11', '医学常识', '常见的医学方面的常识', null);
INSERT INTO `t_point` VALUES ('12', '外科知识', '外科方面的知识', '11');
INSERT INTO `t_point` VALUES ('13', '顶级', '1', null);
INSERT INTO `t_point` VALUES ('14', '2', '2', '13');

-- ----------------------------
-- Table structure for t_privilege
-- ----------------------------
DROP TABLE IF EXISTS `t_privilege`;
CREATE TABLE `t_privilege` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_privilege
-- ----------------------------
INSERT INTO `t_privilege` VALUES ('1', '发布公告', '/notice/addNoticeUI', '4');
INSERT INTO `t_privilege` VALUES ('2', '发布报名信息', '/apply/addApplyInfoUI', '3');
INSERT INTO `t_privilege` VALUES ('3', '报名管理', null, null);
INSERT INTO `t_privilege` VALUES ('4', '公告管理', null, null);
INSERT INTO `t_privilege` VALUES ('5', '发布公告2', null, '1');
INSERT INTO `t_privilege` VALUES ('6', '发布公告2_1', null, '5');

-- ----------------------------
-- Table structure for t_question_type
-- ----------------------------
DROP TABLE IF EXISTS `t_question_type`;
CREATE TABLE `t_question_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_question_type
-- ----------------------------
INSERT INTO `t_question_type` VALUES ('1', '单项选择题');
INSERT INTO `t_question_type` VALUES ('2', '判断题');
INSERT INTO `t_question_type` VALUES ('3', '问答题');
INSERT INTO `t_question_type` VALUES ('4', '多项选择题');

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('3', '考生', '可以进行在线考试');
INSERT INTO `t_role` VALUES ('7', '管理员', '负责网站维护、管理');
INSERT INTO `t_role` VALUES ('8', '教授', '叫兽知识');
INSERT INTO `t_role` VALUES ('9', '阅卷老师', '负责阅卷工作');

-- ----------------------------
-- Table structure for t_role_privilege
-- ----------------------------
DROP TABLE IF EXISTS `t_role_privilege`;
CREATE TABLE `t_role_privilege` (
  `roleId` int(11) NOT NULL,
  `privilegeId` int(11) NOT NULL,
  PRIMARY KEY (`roleId`,`privilegeId`),
  KEY `privilegeId` (`privilegeId`),
  CONSTRAINT `t_role_privilege_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `t_role` (`id`),
  CONSTRAINT `t_role_privilege_ibfk_2` FOREIGN KEY (`privilegeId`) REFERENCES `t_privilege` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_privilege
-- ----------------------------
INSERT INTO `t_role_privilege` VALUES ('3', '1');
INSERT INTO `t_role_privilege` VALUES ('7', '1');
INSERT INTO `t_role_privilege` VALUES ('8', '1');
INSERT INTO `t_role_privilege` VALUES ('7', '2');
INSERT INTO `t_role_privilege` VALUES ('8', '2');
INSERT INTO `t_role_privilege` VALUES ('7', '3');
INSERT INTO `t_role_privilege` VALUES ('8', '3');
INSERT INTO `t_role_privilege` VALUES ('3', '4');
INSERT INTO `t_role_privilege` VALUES ('7', '4');
INSERT INTO `t_role_privilege` VALUES ('8', '4');
INSERT INTO `t_role_privilege` VALUES ('3', '5');
INSERT INTO `t_role_privilege` VALUES ('7', '5');
INSERT INTO `t_role_privilege` VALUES ('8', '5');
INSERT INTO `t_role_privilege` VALUES ('3', '6');
INSERT INTO `t_role_privilege` VALUES ('8', '6');

-- ----------------------------
-- Table structure for t_singlechoice
-- ----------------------------
DROP TABLE IF EXISTS `t_singlechoice`;
CREATE TABLE `t_singlechoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `level` varchar(20) DEFAULT NULL,
  `answerAnalysis` varchar(255) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `itemA` varchar(200) DEFAULT NULL,
  `itemB` varchar(200) DEFAULT NULL,
  `lastItem` varchar(255) DEFAULT NULL,
  `trueItem` varchar(200) DEFAULT NULL,
  `point` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `typeId` (`typeId`),
  CONSTRAINT `t_singlechoice_ibfk_1` FOREIGN KEY (`typeId`) REFERENCES `t_question_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_singlechoice
-- ----------------------------
INSERT INTO `t_singlechoice` VALUES ('2', '请问这是一个什么题目？', '一般', '没有解析', '1', '单选', '多选', '不是踢,啥？,补刀', '啥？', '医学常识,外科医学,1级');
INSERT INTO `t_singlechoice` VALUES ('3', '1加1是多少？', '容易', '答案也不知道', '1', '不知道', '不知道2', '不知道2', '不知道2', '1级');
INSERT INTO `t_singlechoice` VALUES ('4', '急救的方式有几种？', '容易', '急救可以分为等级1、等级2、等级3', '1', '1种', '2种', '3种', '3种', '医学常识2');
INSERT INTO `t_singlechoice` VALUES ('5', '你从医的方式？', '容易', null, '1', '正规', '非法', null, '非法', '医学常识');
INSERT INTO `t_singlechoice` VALUES ('6', '如何判断气候变化？', '容易', '天气预报，你值得选择\n', '1', '人发抖', '看天气预报', '占卜', '看天气预报', '默认,气象知识');
INSERT INTO `t_singlechoice` VALUES ('7', '请问今天心情如何？', '困难', '物解析', '1', '好', '还行', '糟糕', '还行', null);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` varchar(40) NOT NULL,
  `nickname` varchar(40) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `truename` varchar(20) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `idCardType` varchar(10) DEFAULT NULL,
  `idCardNumber` varchar(40) DEFAULT NULL,
  `birth` date DEFAULT NULL COMMENT '出生日期',
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(80) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL COMMENT '当前状态(在校、在职、其他)',
  `education` text,
  `doctorInfo` varchar(255) DEFAULT NULL COMMENT '从医信息',
  `emplore` text,
  `other` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('48e10517-33c7-11e6-b9b6-5cf9dd5e9d93', 'hyk', null, 'hyk', '123', '1234567@qq2233.com', null, null, null, '1111', null, null, null, null, null, null);
INSERT INTO `t_user` VALUES ('8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', 'hyq', '男', '黄泉', 'hyq', '1234567@qq2233.com', '身份证', '513425', '1994-08-23', '18381307126', '四川会理', '在校', '会理一中@1994-08-23 12:22:22@1990-08-23 12:22:22@读高中#四川理工学院@1994-08-23 12:22:22@1990-08-23 12:22:22@读大学#', 'yes@123#', '2年@四川科技@项目经理@硕士#', '其他要说的');
INSERT INTO `t_user` VALUES ('987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '1', '男', '黄泉', '1', '1234567@qq2233.com', '身份证', '1111', '1994-08-23', '9527', '', '请选择', null, null, null, null);
INSERT INTO `t_user` VALUES ('b681e0c6-33c7-11e6-b9b6-5cf9dd5e9d93', 'wyn', null, 'wyn', '123', '1234567@qq2233.com', null, null, null, '11343', null, null, null, null, null, null);
INSERT INTO `t_user` VALUES ('eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '2', '男', '黄泉2', '2', '1234567@qq2233.com', '身份证', '1111', '1994-08-23', '12345672233', '', '请选择', null, null, null, null);

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
  `userId` varchar(40) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`roleId`),
  KEY `t_user_role_ibfk_2` (`roleId`),
  CONSTRAINT `t_user_role_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_user_role_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `t_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES ('48e10517-33c7-11e6-b9b6-5cf9dd5e9d93', '7');
INSERT INTO `t_user_role` VALUES ('8201945c-1ef0-11e6-ba54-5cf9dd5e9d93', '7');
INSERT INTO `t_user_role` VALUES ('b681e0c6-33c7-11e6-b9b6-5cf9dd5e9d93', '7');
INSERT INTO `t_user_role` VALUES ('eec83f77-1e68-11e6-bacc-5cf9dd5e9d93', '8');
INSERT INTO `t_user_role` VALUES ('987f9356-1e6a-11e6-bacc-5cf9dd5e9d93', '9');

-- ----------------------------
-- Table structure for t_wd
-- ----------------------------
DROP TABLE IF EXISTS `t_wd`;
CREATE TABLE `t_wd` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `level` varchar(10) DEFAULT NULL,
  `answerAnalysis` varchar(255) DEFAULT NULL,
  `point` varchar(200) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `typeId` (`typeId`),
  CONSTRAINT `t_wd_ibfk_1` FOREIGN KEY (`typeId`) REFERENCES `t_question_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wd
-- ----------------------------
