/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50713
Source Host           : 127.0.0.1:3306
Source Database       : dzomsdb

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2017-08-28 20:06:32
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
  `realCount` int(11) DEFAULT NULL,
  `realMoney` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zhaoshangdiscount
-- ----------------------------
INSERT INTO `zhaoshangdiscount` VALUES ('1', '1011362260', '2017-08-28', '0', '196', '774816.49', 'QK20170828183251', '169', '665740.31');
INSERT INTO `zhaoshangdiscount` VALUES ('2', '1011375945', '2017-08-28', '0', '206', '812646.61', 'QK20170828185407', '187', '741646.19');
INSERT INTO `zhaoshangdiscount` VALUES ('3', '1011381706', '2017-08-28', '0', '191', '752048.61', 'QK20170828190223', '159', '623972.44');
