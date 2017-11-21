/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50713
Source Host           : 127.0.0.1:3306
Source Database       : dzomsdb

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2017-08-28 19:34:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bankitem
-- ----------------------------
DROP TABLE IF EXISTS `bankitem`;
CREATE TABLE `bankitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applyTime` datetime DEFAULT NULL,
  `cardNumber` varchar(30) DEFAULT NULL,
  `forTime` date DEFAULT NULL,
  `planFee` decimal(19,2) DEFAULT NULL,
  `realFee` decimal(19,2) DEFAULT NULL,
  `realTime` datetime DEFAULT NULL,
  `register` varchar(30) DEFAULT NULL,
  `state` int(11) NOT NULL,
  `contract_id` int(11) DEFAULT NULL,
  `zhaoShangDiscount_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_nq9u5umxr7ngyhniyduqoy1di` (`contract_id`),
  KEY `FK_wqgq772o9jucx7km3skdy35d` (`zhaoShangDiscount_id`),
  CONSTRAINT `FK_nq9u5umxr7ngyhniyduqoy1di` FOREIGN KEY (`contract_id`) REFERENCES `contract` (`id`),
  CONSTRAINT `FK_wqgq772o9jucx7km3skdy35d` FOREIGN KEY (`zhaoShangDiscount_id`) REFERENCES `zhaoshangdiscount` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
