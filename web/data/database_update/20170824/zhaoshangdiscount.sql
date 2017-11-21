/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50713
Source Host           : 127.0.0.1:3306
Source Database       : dzomsdb

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2017-08-25 08:56:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for zhaoshangdiscount
-- ----------------------------
DROP TABLE IF EXISTS `zhaoshangdiscount`;
CREATE TABLE `zhaoshangdiscount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bankSeq` varchar(30) DEFAULT NULL,
  `chargeTime` date DEFAULT NULL,
  `states` int(11) DEFAULT NULL,
  `totalCount` int(11) DEFAULT NULL,
  `totalMoney` decimal(8,2) DEFAULT NULL,
  `yurref` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
