/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : ssm_hotel

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2020-04-23 13:26:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `customer`
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL COMMENT '客户名',
  `gender` int(1) NOT NULL DEFAULT '1' COMMENT '性别  1男   2女',
  `card_no` varchar(30) NOT NULL COMMENT '身份证号',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='客户表';

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('1', '欧阳锋', '1', '411082199012213344', '2020-03-17 09:12:14');
INSERT INTO `customer` VALUES ('3', '苏明玉', '2', '222222222222222223', '2020-03-21 17:49:28');
INSERT INTO `customer` VALUES ('4', '苏明成', '1', '212222222222222222', '2020-03-22 09:09:29');
INSERT INTO `customer` VALUES ('5', '石天成', '1', '212222222222222333', '2020-03-22 09:09:51');
INSERT INTO `customer` VALUES ('6', '蒙志远', '1', '222222222224442223', '2020-03-22 09:10:11');
INSERT INTO `customer` VALUES ('7', '蔡根花', '2', '333222222224442223', '2020-03-21 09:12:07');
INSERT INTO `customer` VALUES ('8', '张博', '1', '666666666666666666', '2020-03-22 15:34:43');
INSERT INTO `customer` VALUES ('9', '张三', '1', '432432', '2020-03-22 15:51:23');
INSERT INTO `customer` VALUES ('10', 'admin', '1', '234234', '2020-03-22 15:55:52');
INSERT INTO `customer` VALUES ('11', '苏大强', '1', '232323232323232323', '2020-03-22 16:00:33');
INSERT INTO `customer` VALUES ('12', '王五', '1', '67676767676767676767', '2020-03-22 16:08:13');
INSERT INTO `customer` VALUES ('17', '24524', '2', '24524245243', '2020-03-25 18:46:54');
INSERT INTO `customer` VALUES ('18', '热台湾', '1', '6574674756765', '2020-03-25 20:36:43');
INSERT INTO `customer` VALUES ('19', '热台湾', '1', '6574674756765', '2020-03-25 20:39:18');
INSERT INTO `customer` VALUES ('20', '等待戈多', '1', '546353565356', '2020-03-25 20:50:19');
INSERT INTO `customer` VALUES ('21', '7858', '1', '578576', '2020-03-25 21:36:44');
INSERT INTO `customer` VALUES ('22', '小明', '2', '324324524354354', '2020-04-09 18:48:19');
INSERT INTO `customer` VALUES ('26', '小红', '2', '53634563547465', '2020-04-09 19:09:42');
INSERT INTO `customer` VALUES ('27', '李白', '1', '111111111111111111', '2020-04-10 15:17:51');

-- ----------------------------
-- Table structure for `layout`
-- ----------------------------
DROP TABLE IF EXISTS `layout`;
CREATE TABLE `layout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '房型名称',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '价格',
  `area` decimal(10,2) DEFAULT '0.00' COMMENT '面积',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='房型表';

-- ----------------------------
-- Records of layout
-- ----------------------------
INSERT INTO `layout` VALUES ('1', '标准间', '100.00', '30.00');
INSERT INTO `layout` VALUES ('2', '单人间', '60.00', '15.00');
INSERT INTO `layout` VALUES ('3', '三人间', '200.00', '50.00');
INSERT INTO `layout` VALUES ('13', '总统套房', '10000.00', '100.00');
INSERT INTO `layout` VALUES ('18', '麻将房', '299.00', '45.00');
INSERT INTO `layout` VALUES ('20', '情侣房', '99.00', '15.00');
INSERT INTO `layout` VALUES ('22', 'we', '0.00', '0.00');
INSERT INTO `layout` VALUES ('23', 'tr', '0.00', '0.00');
INSERT INTO `layout` VALUES ('24', 'ty', '0.00', '0.00');
INSERT INTO `layout` VALUES ('25', 'sd', '0.00', '0.00');
INSERT INTO `layout` VALUES ('26', 'cx', '0.00', '0.00');
INSERT INTO `layout` VALUES ('27', 'ert', '0.00', '0.00');
INSERT INTO `layout` VALUES ('28', 'sgsf', '0.00', '0.00');
INSERT INTO `layout` VALUES ('29', 'vsb', '0.00', '0.00');
INSERT INTO `layout` VALUES ('30', 'qtq', '0.00', '0.00');

-- ----------------------------
-- Table structure for `menu`
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT 'fa fa-address-book',
  `href` varchar(255) DEFAULT NULL,
  `target` varchar(255) DEFAULT '_self',
  `pid` int(11) DEFAULT NULL,
  `weight` int(3) DEFAULT '0',
  `visible` int(1) DEFAULT '1' COMMENT '1：可见  2不可见',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '常规管理', 'fa fa-home', '', '_self', '0', '0', '1');
INSERT INTO `menu` VALUES ('2', '房间维护', 'fa fa-calendar-check-o', '', '_self', '1', '0', '1');
INSERT INTO `menu` VALUES ('3', '房型管理', 'fa fa-heartbeat', 'layout/listLayout', '_self', '2', '99', '1');
INSERT INTO `menu` VALUES ('4', '房间管理', 'fa fa-building-o', 'room/listRoom', '_self', '2', '50', '1');
INSERT INTO `menu` VALUES ('5', '入住管理', 'fa fa-hotel', '', '_self', '1', '0', '1');
INSERT INTO `menu` VALUES ('6', '顾客管理', 'fa fa-user-plus', 'customer/listCustomer', '_self', '5', '99', '1');
INSERT INTO `menu` VALUES ('7', '入住客房', 'fa fa-align-center', 'move/listMove', '_self', '5', '0', '1');
INSERT INTO `menu` VALUES ('9', '菜单管理', 'fa fa-list-alt', 'menu/listMenu', '_self', '12', '20', '1');
INSERT INTO `menu` VALUES ('10', '角色管理', 'fa fa-address-card-o', 'role/listRole', '_self', '12', '50', '1');
INSERT INTO `menu` VALUES ('11', '用户管理', 'fa fa-user-secret', 'user/listUser', '_self', '12', '99', '1');
INSERT INTO `menu` VALUES ('12', '管理员管理', 'fa fa-users', '', '_self', '1', '0', '1');
INSERT INTO `menu` VALUES ('19', '消息管理', 'fa fa-file-text-o', '', '_self', '1', '0', '1');
INSERT INTO `menu` VALUES ('20', '收件箱', 'fa fa-inbox', 'message/inbox', '_self', '19', '99', '1');
INSERT INTO `menu` VALUES ('21', '发件箱', 'fa fa-send', 'message/outbox', '_self', '19', '66', '1');
INSERT INTO `menu` VALUES ('22', '写消息', 'fa fa-pencil', 'message/addMessage', '_self', '19', '33', '1');
INSERT INTO `menu` VALUES ('24', '添加房型', '', 'layout/addLayout', '_self', '2', '98', '2');
INSERT INTO `menu` VALUES ('25', '修改房型', '', 'layout/editLayout', '_self', '2', '98', '2');
INSERT INTO `menu` VALUES ('26', '删除房型', '', 'layout/deleteLayout', '_self', '2', '98', '2');
INSERT INTO `menu` VALUES ('28', '添加房间', '', 'room/addRoom', '_self', '2', '49', null);
INSERT INTO `menu` VALUES ('29', '修改房间', '', 'room/editRoom', '_self', '2', '49', null);
INSERT INTO `menu` VALUES ('30', '删除房间', '', 'room/deleteRoom', '_self', '2', '49', null);
INSERT INTO `menu` VALUES ('31', '查询收件箱列表', '', 'message/getInboxMessage', '_self', '19', '98', '2');
INSERT INTO `menu` VALUES ('32', '消息详情', '', 'message/detail', '_self', '19', null, null);
INSERT INTO `menu` VALUES ('33', '查询发件箱列表', '', 'message/getOutboxMessage', '_self', '19', '65', '2');
INSERT INTO `menu` VALUES ('34', '提交信息', '', 'message/addMessageAct', '_self', '19', '32', null);
INSERT INTO `menu` VALUES ('36', '添加顾客', '', 'customer/addCustomer', '_self', '5', '0', '2');
INSERT INTO `menu` VALUES ('37', '修改顾客', '', 'customer/editCustomer', '_self', '5', '0', null);
INSERT INTO `menu` VALUES ('38', '删除顾客', '', 'customer/deleteCustomerAct', '_self', '5', '0', null);
INSERT INTO `menu` VALUES ('39', '添加用户', '', 'user/addUser', '_self', '12', '98', '2');
INSERT INTO `menu` VALUES ('41', '删除用户', '', 'user/deleteUserAct', '_self', '12', '99', '2');
INSERT INTO `menu` VALUES ('42', '编辑用户', '', 'user/editUser', '_self', '12', '98', '2');
INSERT INTO `menu` VALUES ('44', '添加角色', '', 'role/addRole', '_self', '12', '49', '2');
INSERT INTO `menu` VALUES ('45', '编辑角色', '', 'role/editRole', '_self', '12', '49', '2');
INSERT INTO `menu` VALUES ('46', '删除角色', '', 'role/deleteRoleAct', '_self', '12', '49', '2');
INSERT INTO `menu` VALUES ('47', '设置权限', '', 'role/setsetMenus', '_self', '12', '49', '2');
INSERT INTO `menu` VALUES ('48', '添加菜单', '', 'menu/addMenu', '_self', '12', '19', '2');
INSERT INTO `menu` VALUES ('49', '编辑菜单', '', 'menu/editMenu', '_self', '12', '19', '2');
INSERT INTO `menu` VALUES ('50', '删除菜单', '', 'menu/deleteMenuAct', '_self', '12', '19', '2');
INSERT INTO `menu` VALUES ('51', '搜索房型', '', 'layout/searchLayout', '_self', '2', '98', '2');
INSERT INTO `menu` VALUES ('52', '搜索房间', '', 'room/searchRoom', '_self', '2', '49', '2');
INSERT INTO `menu` VALUES ('53', '搜索顾客', '', 'customer/searchCustomer', '_self', '5', null, '2');
INSERT INTO `menu` VALUES ('54', '搜索用户', '', 'user/searchUser', '_self', '12', '98', '2');
INSERT INTO `menu` VALUES ('55', '个人信息', '', 'user/profile', '_self', '12', '98', '1');

-- ----------------------------
-- Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `send_id` int(11) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `rank` tinyint(1) DEFAULT '1' COMMENT '紧急级别 1：紧急  2：一般  0：默认',
  `read_flag` tinyint(1) DEFAULT '1' COMMENT '1:未读  2：已读',
  `content` varchar(1000) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `edit_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', '2', '1', '2', '2', '测试消息一', '2020-03-26 16:19:42', '2020-03-26 16:19:46');
INSERT INTO `message` VALUES ('2', '3', '1', '1', '2', '沪江词库精选标记为已读英文怎么写、英语单词怎么写、例句等信息 Mark as Read 相似短语 no mark 无标记 of mark 知名的, 杰出的 on the mark 中肯的,...', '2020-03-30 16:25:21', '2020-03-29 16:25:27');
INSERT INTO `message` VALUES ('4', '1', '2', '1', '2', '7575898678758', '2020-03-26 18:02:28', null);
INSERT INTO `message` VALUES ('5', '1', '2', '2', '2', '我uoiuo\n', '2020-03-26 18:02:48', null);
INSERT INTO `message` VALUES ('6', '1', '2', '2', '2', '还好哦哦哦', '2020-03-26 18:09:56', null);
INSERT INTO `message` VALUES ('7', '2', '1', '1', '2', '发送给超级管理员的消息', '2020-03-26 18:11:54', null);
INSERT INTO `message` VALUES ('8', '2', '1', '1', '2', 'hhggghhjj', '2020-03-26 18:57:32', null);
INSERT INTO `message` VALUES ('9', '2', '4', '1', '1', '', '2020-03-26 19:02:29', null);
INSERT INTO `message` VALUES ('10', '2', '1', '1', '2', 'jjjjygybjjkjjj', '2020-03-27 15:14:38', null);
INSERT INTO `message` VALUES ('11', '2', '1', '1', '2', 'gkgbh', '2020-03-27 16:29:18', null);
INSERT INTO `message` VALUES ('12', '1', '20', '1', '2', '检查203房间', '2020-04-10 15:28:19', null);
INSERT INTO `message` VALUES ('13', '20', '1', '1', '2', '收到', '2020-04-10 15:30:21', null);
INSERT INTO `message` VALUES ('14', '20', '1', '1', '2', '正常', '2020-04-10 15:31:47', null);
INSERT INTO `message` VALUES ('15', '1', '20', '1', '2', '收到', '2020-04-10 15:35:41', null);

-- ----------------------------
-- Table structure for `move`
-- ----------------------------
DROP TABLE IF EXISTS `move`;
CREATE TABLE `move` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户id',
  `room_id` int(11) NOT NULL DEFAULT '0' COMMENT '房间id',
  `move_time` datetime DEFAULT NULL COMMENT '入住时间',
  `expire_time` datetime DEFAULT NULL COMMENT '到期时间',
  `total_price` decimal(8,2) DEFAULT '0.00',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='入住表';

-- ----------------------------
-- Records of move
-- ----------------------------
INSERT INTO `move` VALUES ('1', '1', '1', '2020-03-21 14:00:17', '2020-03-28 14:00:08', '700.00', '2020-03-21 09:39:28');
INSERT INTO `move` VALUES ('2', '3', '4', '2020-03-22 14:39:34', '2020-03-24 12:39:44', '198.00', '2020-03-21 09:39:52');
INSERT INTO `move` VALUES ('3', '11', '1', '2020-03-01 00:00:00', '2020-03-21 00:00:00', '2000.00', '2020-03-22 16:00:33');
INSERT INTO `move` VALUES ('4', '12', '1', '2020-03-03 00:00:00', '2020-03-23 00:00:00', '2000.00', '2020-03-22 16:08:13');
INSERT INTO `move` VALUES ('5', '20', '1', '2020-03-15 00:00:00', '2020-03-28 00:00:00', '1300.00', '2020-03-25 20:50:19');
INSERT INTO `move` VALUES ('6', '21', '2', '2020-03-25 14:00:00', '2020-03-26 12:00:00', '60.00', '2020-03-25 21:36:45');
INSERT INTO `move` VALUES ('7', '22', '5', '2020-04-09 18:47:35', '2020-04-12 12:00:00', '99.99', '2020-04-09 18:48:19');
INSERT INTO `move` VALUES ('8', '26', '5', '2020-04-09 19:09:33', '2020-04-20 00:00:00', '1100.00', '2020-04-09 19:09:42');
INSERT INTO `move` VALUES ('9', '27', '6', '2020-04-10 15:16:53', '2020-04-13 00:00:00', '300.00', '2020-04-10 15:17:51');

-- ----------------------------
-- Table structure for `permission`
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `available` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超级管理员');
INSERT INTO `role` VALUES ('2', '经理');
INSERT INTO `role` VALUES ('3', '客服');
INSERT INTO `role` VALUES ('4', '服务员');
INSERT INTO `role` VALUES ('5', '保洁员');
INSERT INTO `role` VALUES ('7', '维修员');

-- ----------------------------
-- Table structure for `role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=343 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES ('140', '1', '1');
INSERT INTO `role_menu` VALUES ('141', '1', '2');
INSERT INTO `role_menu` VALUES ('142', '1', '3');
INSERT INTO `role_menu` VALUES ('143', '1', '26');
INSERT INTO `role_menu` VALUES ('144', '1', '4');
INSERT INTO `role_menu` VALUES ('145', '1', '5');
INSERT INTO `role_menu` VALUES ('146', '1', '6');
INSERT INTO `role_menu` VALUES ('147', '1', '7');
INSERT INTO `role_menu` VALUES ('148', '1', '12');
INSERT INTO `role_menu` VALUES ('149', '1', '11');
INSERT INTO `role_menu` VALUES ('150', '1', '10');
INSERT INTO `role_menu` VALUES ('151', '1', '9');
INSERT INTO `role_menu` VALUES ('152', '1', '19');
INSERT INTO `role_menu` VALUES ('153', '1', '20');
INSERT INTO `role_menu` VALUES ('154', '1', '21');
INSERT INTO `role_menu` VALUES ('155', '1', '22');
INSERT INTO `role_menu` VALUES ('278', '2', '1');
INSERT INTO `role_menu` VALUES ('279', '2', '2');
INSERT INTO `role_menu` VALUES ('280', '2', '3');
INSERT INTO `role_menu` VALUES ('281', '2', '25');
INSERT INTO `role_menu` VALUES ('282', '2', '51');
INSERT INTO `role_menu` VALUES ('283', '2', '4');
INSERT INTO `role_menu` VALUES ('284', '2', '29');
INSERT INTO `role_menu` VALUES ('285', '2', '52');
INSERT INTO `role_menu` VALUES ('286', '2', '5');
INSERT INTO `role_menu` VALUES ('287', '2', '6');
INSERT INTO `role_menu` VALUES ('288', '2', '7');
INSERT INTO `role_menu` VALUES ('289', '2', '53');
INSERT INTO `role_menu` VALUES ('290', '2', '12');
INSERT INTO `role_menu` VALUES ('291', '2', '11');
INSERT INTO `role_menu` VALUES ('292', '2', '54');
INSERT INTO `role_menu` VALUES ('293', '2', '55');
INSERT INTO `role_menu` VALUES ('294', '2', '19');
INSERT INTO `role_menu` VALUES ('295', '2', '20');
INSERT INTO `role_menu` VALUES ('296', '2', '31');
INSERT INTO `role_menu` VALUES ('297', '2', '21');
INSERT INTO `role_menu` VALUES ('298', '2', '33');
INSERT INTO `role_menu` VALUES ('299', '2', '22');
INSERT INTO `role_menu` VALUES ('300', '2', '34');
INSERT INTO `role_menu` VALUES ('301', '2', '32');
INSERT INTO `role_menu` VALUES ('302', '3', '1');
INSERT INTO `role_menu` VALUES ('303', '3', '2');
INSERT INTO `role_menu` VALUES ('304', '3', '3');
INSERT INTO `role_menu` VALUES ('305', '3', '4');
INSERT INTO `role_menu` VALUES ('306', '3', '12');
INSERT INTO `role_menu` VALUES ('307', '3', '55');
INSERT INTO `role_menu` VALUES ('308', '3', '19');
INSERT INTO `role_menu` VALUES ('309', '3', '20');
INSERT INTO `role_menu` VALUES ('310', '3', '21');
INSERT INTO `role_menu` VALUES ('311', '3', '22');
INSERT INTO `role_menu` VALUES ('312', '4', '1');
INSERT INTO `role_menu` VALUES ('313', '4', '2');
INSERT INTO `role_menu` VALUES ('314', '4', '4');
INSERT INTO `role_menu` VALUES ('315', '4', '12');
INSERT INTO `role_menu` VALUES ('316', '4', '55');
INSERT INTO `role_menu` VALUES ('317', '4', '19');
INSERT INTO `role_menu` VALUES ('318', '4', '20');
INSERT INTO `role_menu` VALUES ('319', '4', '31');
INSERT INTO `role_menu` VALUES ('320', '4', '21');
INSERT INTO `role_menu` VALUES ('321', '4', '33');
INSERT INTO `role_menu` VALUES ('322', '4', '22');
INSERT INTO `role_menu` VALUES ('323', '4', '34');
INSERT INTO `role_menu` VALUES ('324', '4', '32');
INSERT INTO `role_menu` VALUES ('325', '5', '1');
INSERT INTO `role_menu` VALUES ('326', '5', '2');
INSERT INTO `role_menu` VALUES ('327', '5', '4');
INSERT INTO `role_menu` VALUES ('328', '5', '12');
INSERT INTO `role_menu` VALUES ('329', '5', '55');
INSERT INTO `role_menu` VALUES ('330', '5', '19');
INSERT INTO `role_menu` VALUES ('331', '5', '20');
INSERT INTO `role_menu` VALUES ('332', '5', '21');
INSERT INTO `role_menu` VALUES ('333', '5', '22');
INSERT INTO `role_menu` VALUES ('334', '7', '1');
INSERT INTO `role_menu` VALUES ('335', '7', '2');
INSERT INTO `role_menu` VALUES ('336', '7', '4');
INSERT INTO `role_menu` VALUES ('337', '7', '12');
INSERT INTO `role_menu` VALUES ('338', '7', '55');
INSERT INTO `role_menu` VALUES ('339', '7', '19');
INSERT INTO `role_menu` VALUES ('340', '7', '20');
INSERT INTO `role_menu` VALUES ('341', '7', '21');
INSERT INTO `role_menu` VALUES ('342', '7', '22');

-- ----------------------------
-- Table structure for `role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `permission_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_permission
-- ----------------------------

-- ----------------------------
-- Table structure for `room`
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_no` varchar(255) DEFAULT NULL COMMENT '房间号',
  `layout_id` int(11) DEFAULT NULL COMMENT '房型id',
  `status` int(2) DEFAULT NULL COMMENT '房间状态 1 空房  2打扫 3 维修 4 有人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='房间表';

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES ('1', '101', '1', '4');
INSERT INTO `room` VALUES ('2', '201', '2', '4');
INSERT INTO `room` VALUES ('4', '202', '20', '1');
INSERT INTO `room` VALUES ('5', '102', '1', '4');
INSERT INTO `room` VALUES ('6', '103', '1', '4');
INSERT INTO `room` VALUES ('7', '105', '1', '1');
INSERT INTO `room` VALUES ('8', '203', '1', '1');
INSERT INTO `room` VALUES ('9', '301', '1', '3');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `gender` int(1) DEFAULT '1' COMMENT '1:男   2：女',
  `locked` int(1) DEFAULT '1' COMMENT '1 正常 2：禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '3ef7164d1f6167cb9f2658c07d3c2f0a', '1', '1');
INSERT INTO `user` VALUES ('2', 'manager', 'bb2ec153e560c6cb94a35b370eb7a07b', '2', '1');
INSERT INTO `user` VALUES ('3', 'bj2', 'a92b0ddbb9f3194061546dacc8c1385a', '2', '1');
INSERT INTO `user` VALUES ('4', 'wx2', 'f97eedf6c6b7e733ff70e56f1488b3d7', '1', '1');
INSERT INTO `user` VALUES ('18', 'bj1', 'd597431310657eb76ebd5b2188ba6605', '2', '1');
INSERT INTO `user` VALUES ('19', 'wx1', 'c27bcf1f98e6f6590a2b628c92ce11f8', '1', '1');
INSERT INTO `user` VALUES ('20', 'servicer1', 'dc2420e2450b98ce07fde54e5364e818', '2', '1');

-- ----------------------------
-- Table structure for `user_role`
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('18', '18', '5');
INSERT INTO `user_role` VALUES ('19', '19', '7');
INSERT INTO `user_role` VALUES ('20', '3', '5');
INSERT INTO `user_role` VALUES ('21', '4', '7');
INSERT INTO `user_role` VALUES ('22', '1', '1');
INSERT INTO `user_role` VALUES ('23', '20', '4');
INSERT INTO `user_role` VALUES ('24', '2', '2');
