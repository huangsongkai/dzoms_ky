/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50713
Source Host           : 127.0.0.1:3306
Source Database       : dzomsdb

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2017-08-25 08:55:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bankcardofvehicle
-- ----------------------------
DROP TABLE IF EXISTS `bankcardofvehicle`;
CREATE TABLE `bankcardofvehicle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isDefaultRecive` bit(1) DEFAULT NULL,
  `bankCard_id` int(11) DEFAULT NULL,
  `vehicle_carframe_num` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_r3lk3vhruxfnk9qoopceub0sv` (`vehicle_carframe_num`),
  KEY `bankCard_id` (`bankCard_id`) USING BTREE,
  CONSTRAINT `FK_r3lk3vhruxfnk9qoopceub0sv` FOREIGN KEY (`vehicle_carframe_num`) REFERENCES `vehicle` (`carframe_num`)
) ENGINE=InnoDB AUTO_INCREMENT=751 DEFAULT CHARSET=utf8;
