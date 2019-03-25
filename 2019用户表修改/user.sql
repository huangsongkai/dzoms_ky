/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50724
Source Host           : localhost:3306
Source Database       : ky_dzomsdb

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2019-03-25 18:18:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `uname` varchar(30) NOT NULL COMMENT '用户名',
  `pwdSalt` varchar(255) DEFAULT NULL,
  `pwdHash` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;



INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (1, 'admin', 'djijFK741acy/EGH3aZIOA==', '$argon2d$v=19$m=65536,t=3,p=4$djijFK741acy/EGH3aZIOA$KjY6KVYQhmi8hBUqNTuWGg', '管理员', '管理员', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (11, '陈东慧', '/OyBATeWoCOn29oQexbrHA==', '$argon2d$v=19$m=65536,t=3,p=4$/OyBATeWoCOn29oQexbrHA$IURbnFuZ6tLqFzICckoCFQ', '计财部', '经理', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (13, '明慧君', '1oFyJwIxJLPk3m9yt5QqrQ==', '$argon2d$v=19$m=65536,t=3,p=4$1oFyJwIxJLPk3m9yt5QqrQ$yNeHbaMzb29rVor4nNZTSA', '计财部', '会计', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (14, '夏滨', 'pDf1ClOe1kEqVow9UuM5HQ==', '$argon2d$v=19$m=65536,t=3,p=4$pDf1ClOe1kEqVow9UuM5HQ$WRl7ts0UtJAI/utLF3DNPQ', '运营管理部', '经理', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (15, '尹丽波', 'Nzgj1K8jSsmiHx26XfWXyQ==', '$argon2d$v=19$m=65536,t=3,p=4$Nzgj1K8jSsmiHx26XfWXyQ$+xXnJ+tyimyu8XaLgkIMHw', '运营管理部', '收款员', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (16, '金山', 'qYAfbvcpgJ4NouYizAUpwA==', '$argon2d$v=19$m=65536,t=3,p=4$qYAfbvcpgJ4NouYizAUpwA$uy71c15HT6R9ry2vuer+6w', '运营管理部', '一公司经理', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (17, '王晓华', '7MxuSk9n5rmr5Q0ZiUc/3w==', '$argon2d$v=19$m=65536,t=3,p=4$7MxuSk9n5rmr5Q0ZiUc/3w$LT6IihHZF84dvgXrdhDnOA', '运营管理部', '证照员', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (19, '季兴仁', 'osHHusMJnz9HY8b9gdbL1w==', '$argon2d$v=19$m=65536,t=3,p=4$osHHusMJnz9HY8b9gdbL1w$UQdvhIbigxBPMymbthwTNA', '运营管理部', '安全员', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (21, '郭庆辉', 'CFjo+KbfaZ+YrrV+kz6pmg==', '$argon2d$v=19$m=65536,t=3,p=4$CFjo+KbfaZ+YrrV+kz6pmg$amaHYk78XfXRzp2J2WvUUw', '运营管理部', '二公司经理', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (22, '李志强', 'LLbeu96YbSWhkDu3jGPleQ==', '$argon2d$v=19$m=65536,t=3,p=4$LLbeu96YbSWhkDu3jGPleQ$1hzsh4krjs61aFW4/02Xlw', '信息部', '信息部副经理', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (27, '吕文虎', '6sNyrOaMDSNPZbPgr2kmNw==', '$argon2d$v=19$m=65536,t=3,p=4$6sNyrOaMDSNPZbPgr2kmNw$59xxn5MspPFXN1JpEW6mlQ', '运营管理部', '安全员', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (29, '邹研', 'yRovQfz89kq6GIanA4Tsrg==', '$argon2d$v=19$m=65536,t=3,p=4$yRovQfz89kq6GIanA4Tsrg$+0H1tbkG8RnA3kzuHB3lxw', '综合办公室', '办公室副主任', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (30, '刘波', 'AlLlSNWFpPeoxfQScpgzxg==', '$argon2d$v=19$m=65536,t=3,p=4$AlLlSNWFpPeoxfQScpgzxg$bQcY8/VLVh/DqIboc92D+A', '综合办公室', '办公室主任', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (31, '汤伟丽', '0HCPaQlFhKPrhZGa1PCD/A==', '$argon2d$v=19$m=65536,t=3,p=4$0HCPaQlFhKPrhZGa1PCD/A$pdPlvJzql0Ae7pI22hPHIA', '总经理办公室', '副总经理', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (33, '王星', 'G3hu8Y1wnUkHWlNNp6tE+w==', '$argon2d$v=19$m=65536,t=3,p=4$G3hu8Y1wnUkHWlNNp6tE+w$KenoYPamDDWc4qxsvtKxqw', '总经理办公室', '总经理', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (35, '赵顺', 'BNhWcyZ/BD1+JhGriLUJ2Q==', '$argon2d$v=19$m=65536,t=3,p=4$BNhWcyZ/BD1+JhGriLUJ2Q$+5mur0COgTF7pYvJwSKbaA', '信息部', '网络工程师', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (36, '冉铮', 'B/nBaRQm7wi716bzN+32Sw==', '$argon2d$v=19$m=65536,t=3,p=4$B/nBaRQm7wi716bzN+32Sw$noTcr8E7umcz/7OgrCvtBw', '计财部', '出纳', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (37, '孙大勇', 'E7iEtUhgtWgxedR4FW1JsQ==', '$argon2d$v=19$m=65536,t=3,p=4$E7iEtUhgtWgxedR4FW1JsQ$XJaI04bEOTp4gSvx6OPrUQ', '总经理办公室', '副总经理', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (38, '杨爽', '9S4wwUo1uCoAXPV/jT3zlQ==', '$argon2d$v=19$m=65536,t=3,p=4$9S4wwUo1uCoAXPV/jT3zlQ$UbFlnNayYqq+7MZ8XrToxw', '运营管理部', '法律主管', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (39, '赵立军', '/41pXyeI7FPonsfWrOpxaw==', '$argon2d$v=19$m=65536,t=3,p=4$/41pXyeI7FPonsfWrOpxaw$0mYEcluuuMfa7c3JyGhuyQ', '运营管理部', '三公司经理', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (40, '胡越', 'Xic+jk0En83KfzXUPjd0Yg==', '$argon2d$v=19$m=65536,t=3,p=4$Xic+jk0En83KfzXUPjd0Yg$YPhK7YBDoICNM8LeYdcpzA', '运营管理部', '分部助理', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (42, '刘巍', 'oaBWN5R2GpZt37Xzl/zBfQ==', '$argon2d$v=19$m=65536,t=3,p=4$oaBWN5R2GpZt37Xzl/zBfQ$wTENPO/vERF2J8N36ft/AQ', '运营管理部', '分部经理', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (43, '考核组', 'SyusBHsAWKrok7GOmE57og==', '$argon2d$v=19$m=65536,t=3,p=4$SyusBHsAWKrok7GOmE57og$0yloE7fEntd68ygyU9HUHw', '考核小组', '考核小组', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (44, '常亮', 'reu6qDgz/0IcGMKK1Px2Ww==', '$argon2d$v=19$m=65536,t=3,p=4$reu6qDgz/0IcGMKK1Px2Ww$BBoCrIKW4s5Q3Bf0YJPpqA', '综合办公室', '办公室内勤', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (46, '王雅君', 'mVvuSSyevKKNG7WH197MUw==', '$argon2d$v=19$m=65536,t=3,p=4$mVvuSSyevKKNG7WH197MUw$m4ZImtp6Cddg45GLmYtKXg', '运营管理部', '证照员', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (47, '王奇', 'HYtO5E9Ogrui50BRKA1now==', '$argon2d$v=19$m=65536,t=3,p=4$HYtO5E9Ogrui50BRKA1now$gFe8E+ifo5KeYSla5batmg', '运营管理部', '分部助理', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (48, '保洁员', 'fbIQ23BEauwTfch6hXVd3A==', '$argon2d$v=19$m=65536,t=3,p=4$fbIQ23BEauwTfch6hXVd3A$OCxM8UME1ACU120inxHYBA', '综合办公室', '保洁员', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (49, '门卫一', 'koIaNtqZ6IWdArAopgfYCg==', '$argon2d$v=19$m=65536,t=3,p=4$koIaNtqZ6IWdArAopgfYCg$GeDD1JYHVgYY9gD5cuHzig', '综合办公室', '门卫一', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (50, '门卫二', 'VZZRoL1ZlM8LJd4cwE2rmQ==', '$argon2d$v=19$m=65536,t=3,p=4$VZZRoL1ZlM8LJd4cwE2rmQ$46XwyhYaU3RR3GwPqbj37g', '综合办公室', '门卫二', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (51, '炊事员', '0vh+yjbMxRGUd91XCqwC0g==', '$argon2d$v=19$m=65536,t=3,p=4$0vh+yjbMxRGUd91XCqwC0g$pT4w7JERxT2pfpRWnXBzDA', '综合办公室', '炊事员', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (52, '张建超', 'MTf4ac4UzGGNRtdTBV3U6g==', '$argon2d$v=19$m=65536,t=3,p=4$MTf4ac4UzGGNRtdTBV3U6g$zP9reI3qI2nW11ZxdYmdnA', '运营管理部', '二分部助理', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (53, '李鹏雪', 'uXiX7sz0HjL52EMqLTj3pQ==', '$argon2d$v=19$m=65536,t=3,p=4$uXiX7sz0HjL52EMqLTj3pQ$cTgkM8Lh6Y0G0QrCGALLLg', '运营管理部', '法务主管', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (54, '付辉', 'hD8uC9v+0UDWnxi29AADNw==', '$argon2d$v=19$m=65536,t=3,p=4$hD8uC9v+0UDWnxi29AADNw$hlcO5TnJ6hP6Jk+3An/yaA', '计财部', '副经理', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (55, '刘江龙', '4EcdKhFUEZLui9TgxqVC1Q==', '$argon2d$v=19$m=65536,t=3,p=4$4EcdKhFUEZLui9TgxqVC1Q$+4CQEIirtrHBmRX8ZeJ60Q', '综合办公室', '内勤', NULL);
INSERT INTO `user` (`uid`, `uname`, `pwdSalt`, `pwdHash`, `department`, `position`, `phone`) VALUES (56, '王军', 'SgGrPJkrt7dPFZBXeA1aHQ==', '$argon2d$v=19$m=65536,t=3,p=4$SgGrPJkrt7dPFZBXeA1aHQ$kWg/jBDYG4LvHC3SAydwQQ', '综合办公室', '文员', NULL);
