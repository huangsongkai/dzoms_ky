/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50713
Source Host           : 127.0.0.1:3306
Source Database       : dzomsdb

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2017-08-25 08:55:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for authority
-- ----------------------------
DROP TABLE IF EXISTS `authority`;
CREATE TABLE `authority` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `aname` varchar(30) NOT NULL,
  `gname` varchar(30) NOT NULL COMMENT '一级目录',
  `mname` varchar(30) NOT NULL COMMENT '二级目录',
  `tname` varchar(30) DEFAULT NULL COMMENT '三级目录 为空时只有两级',
  `url` varchar(255) NOT NULL,
  `order` int(3) NOT NULL COMMENT '在菜单中的顺序',
  `cssClass` varchar(255) DEFAULT NULL COMMENT 'css class',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `visible` bit(1) DEFAULT b'1' COMMENT '是否可视',
  `frameSize` int(11) NOT NULL DEFAULT '1200',
  `img` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authority
-- ----------------------------
INSERT INTO `authority` VALUES ('1', '废业发起', '审批管理', '生成废业', null, 'vehicle/AbandonApproval/vehicle_abandon01.jsp', '17', 'bg-red', 'icon-sign-out', '', '1000', 'document-attribute-x');
INSERT INTO `authority` VALUES ('2', '废业审批', '审批管理', '废业审批', null, 'vehicle/AbandonApproval/judge.jsp', '18', 'bg-yellow', 'icon-clipboard', '', '1000', 'blue-document-hf-delete-footer');
INSERT INTO `authority` VALUES ('10', '开业审批', '审批管理', '开业审批', null, 'vehicle/CreateApproval/approval_list.jsp', '16', 'bg-yellow', 'icon-sort-amount-desc', '', '1000', 'document-task');
INSERT INTO `authority` VALUES ('15', '开业发起', '审批管理', '生成开业', null, 'vehicle/CreateApproval/vehicle_approval01.jsp', '15', 'bg-main', 'icon-sign-in', '', '1000', 'blue-document--plus');
INSERT INTO `authority` VALUES ('16', '驾驶员登记', '驾驶员', '聘用', '聘用审核', 'driver/driverCheck', '2', null, '', '', '2450', null);
INSERT INTO `authority` VALUES ('17', '驾驶员查看', '驾驶员', '聘用', '驾驶员查询', 'driver/search.jsp', '3', 'default-show', null, '', '1200', null);
INSERT INTO `authority` VALUES ('18', '合同新增', '合同', '合同新增', null, 'contract/contract_new_context.jsp', '1', 'bg-main', 'icon-file', '', '1200', null);
INSERT INTO `authority` VALUES ('19', '查看所有合同', '合同', '所有合同', null, 'contract/contract_search.jsp', '3', 'bg-yellow', 'icon-files-o', '', '1500', 'documents-text');
INSERT INTO `authority` VALUES ('20', '查看有效合同', '合同', '有效合同', null, 'contract/contract_search_avilable.jsp', '4', 'bg-green', 'icon-file-text-o', '', '1500', 'document-hf-insert');
INSERT INTO `authority` VALUES ('21', '查看废止合同', '合同', '已废止合同', null, 'contract/contract_search_abandoned.jsp', '5', 'bg-red', 'icon-file-archive-o', '', '1500', 'document-hf-delete');
INSERT INTO `authority` VALUES ('22', '合同查询', '合同', '合同查询', null, 'contract/search.jsp', '2', 'bg-blue', 'icon-search', '', '1500', 'document-search-result');
INSERT INTO `authority` VALUES ('23', '银行卡新增', '财务', '银行卡管理', '新增', 'contract/bank_card/card_add.jsp', '1', 'bg-main', 'icon-credit-card', '', '1000', null);
INSERT INTO `authority` VALUES ('24', '银行卡查看', '财务', '银行卡管理', '查看', 'contract/bank_card/search.jsp', '2', 'bg-blue', 'icon-search', '', '2500', null);
INSERT INTO `authority` VALUES ('25', '黑名单菜单', '驾驶员', '黑名单', null, '', '99', 'bg-red', 'icon-user', '\0', '1000', 'user-silhouette');
INSERT INTO `authority` VALUES ('26', '发票进货', '财务', '发票管理', '发票进货', 'charge/receipt/in.jsp', '3', 'bg-main', 'icon-tasks', '', '1000', null);
INSERT INTO `authority` VALUES ('27', '发票进货记录', '财务', '发票管理', '发票管理', 'charge/receipt/search_header.jsp', '7', 'bg-blue', 'icon-file-text', '', '1000', null);
INSERT INTO `authority` VALUES ('28', '新增车辆技术信息', '车辆', '新增', '新增车辆技术信息', 'vehicle/vehicle/vehicle_add.jsp', '3', null, null, '', '1600', null);
INSERT INTO `authority` VALUES ('29', '查看车辆技术信息', '车辆', '查询', '查询车辆技术信息', 'vehicle/vehicle/vehicle_search.jsp', '4', '', null, '', '1200', null);
INSERT INTO `authority` VALUES ('30', '查询车辆型号', '车辆', '查询', '查询车辆型号', 'vehicle/VehicleMode/vehiclemode_search.jsp', '2', '', null, '', '1200', null);
INSERT INTO `authority` VALUES ('31', '新增车辆型号', '车辆', '新增', '新增车辆型号', 'vehicle/VehicleMode/vehiclemode_add.jsp', '1', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('32', '事故登记', '驾驶员', '事故', '事故登记', 'driver/accident/accident_add.jsp', '10', null, null, '', '2000', null);
INSERT INTO `authority` VALUES ('33', '事故查询', '驾驶员', '事故', '事故查询', 'driver/accident/accident_search.jsp', '11', 'default-show', null, '', '1000', null);
INSERT INTO `authority` VALUES ('34', '查询黑名单', '驾驶员', '黑名单', '查询黑名单', 'driver/badDriverSearch', '5', 'default-show', null, '', '1000', null);
INSERT INTO `authority` VALUES ('37', '新增黑名单', '驾驶员', '黑名单', '新增黑名单', 'driver/badrecord_add.jsp', '4', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('38', '添加投诉', '驾驶员', '投诉', '添加投诉', 'driver/complain/complain_add.jsp', '12', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('39', '查询投诉', '驾驶员', '投诉', '查询投诉', 'driver/complain/complain_search.jsp', '13', 'default-show', null, '', '1800', null);
INSERT INTO `authority` VALUES ('40', '添加表扬', '驾驶员', '表扬', '添加表扬', 'driver/praise/praise_add.jsp', '14', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('41', '查询表扬', '驾驶员', '表扬', '查询表扬', 'driver/praise/search.jsp', '15', 'default-show', null, '', '1250', null);
INSERT INTO `authority` VALUES ('42', '添加集体荣誉', '驾驶员', '媒体荣誉', '添加媒体荣誉', 'driver/group_praise/group_praise_add.jsp', '26', null, null, '', '2000', null);
INSERT INTO `authority` VALUES ('43', '查询集体荣誉', '驾驶员', '媒体荣誉', '查询媒体荣誉', 'driver/group_praise/search.jsp', '27', 'default-show', null, '', '1300', null);
INSERT INTO `authority` VALUES ('44', '添加活动', '驾驶员', '活动', '添加活动', 'driver/activity/activity_add.jsp', '19', null, null, '', '2500', null);
INSERT INTO `authority` VALUES ('45', '查询活动', '驾驶员', '活动', '查询活动', 'driver/activity/search.jsp', '19', 'default-show', null, '', '1250', null);
INSERT INTO `authority` VALUES ('46', '新增自检计划', '车辆', '自检', '新增自检计划', 'check/addPlan.jsp', '19', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('47', '自检计划查询', '车辆', '自检', '查看计划执行结果', 'check/search_checkplan.jsp', '20', 'default-show', '', '', '1000', null);
INSERT INTO `authority` VALUES ('48', '证照申请', '驾驶员', '证照申请', '申请登记', 'driver/driverInCar/business_apply.jsp', '5', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('49', '证照办理', '驾驶员', '证照办领', '办理登记', 'driver/driverInCar/business_recive.jsp', '6', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('50', '证照查询', '驾驶员', '证照查询', null, 'driver/driverInCar/business_search.jsp', '8', 'bg-blue', 'icon-search', '', '2000', 'document-search-result');
INSERT INTO `authority` VALUES ('51', '上下车记录查询', '驾驶员', '上下车记录查询', null, 'driver/driverInCar/search.jsp', '9', 'bg-blue', 'icon-taxi', '', '1250', 'document-search-result');
INSERT INTO `authority` VALUES ('52', '新增例会', '驾驶员', '例会', '新增例会', 'driver/meeting/meeting_add.jsp', '16', null, null, '', '2300', null);
INSERT INTO `authority` VALUES ('53', '查询例会', '驾驶员', '例会', '例会查询', 'driver/meeting/search.jsp', '17', 'default-show', null, '', '1000', null);
INSERT INTO `authority` VALUES ('54', '待岗申请', '驾驶员', '待岗管理', '待岗申请', 'driver/leave/leave.jsp', '20', null, null, '', '1250', null);
INSERT INTO `authority` VALUES ('55', '车队管理', '驾驶员', '车队管理', null, 'driver/teamQuery', '24', 'bg-yellow', 'icon-users', '', '1000', 'car');
INSERT INTO `authority` VALUES ('56', '新增发票信息', '车辆', '新增', '新增发票信息', 'vehicle/vehicle/invoice_add.jsp', '5', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('57', '查询发票信息', '车辆', '查询', '查询发票信息', 'vehicle/vehicle/invoice_search.jsp', '6', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('58', '新增购置税信息', '车辆', '新增', '新增购置税信息', 'vehicle/vehicle/tax_add.jsp', '7', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('59', '查询购置税信息', '车辆', '查询', '查询购置税信息', 'vehicle/vehicle/tax_search.jsp', '7', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('60', '新增牌照信息', '车辆', '新增', '新增牌照信息', 'vehicle/vehicle/licence_add.jsp', '9', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('61', '查询牌照信息', '车辆', '查询', '查询牌照信息', 'vehicle/vehicle/licence_search.jsp', '9', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('62', '新增计价器信息', '车辆', '新增', '新增计价器信息', 'vehicle/vehicle/service_add.jsp', '11', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('63', '查询计价器信息', '车辆', '查询', '查询计价器信息', 'vehicle/vehicle/service_search.jsp', '11', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('64', '新增经营权信息', '车辆', '新增', '新增经营权信息', 'vehicle/vehicle/trade_add.jsp', '13', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('65', '查询经营权信息', '车辆', '查询', '查询经营权信息', 'vehicle/vehicle/trade_search.jsp', '13', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('66', '客运检车', '车辆', '客运检车', null, 'vehicle/transport_check.jsp', '21', 'bg-main', 'icon-truck', '', '1200', 'truck--plus');
INSERT INTO `authority` VALUES ('67', '电子违章', '车辆', '电子违章', '单车查询', 'vehicle/electric_check.jsp', '22', 'bg-red', 'icon-warning', '', '1000', 'system-monitor--exclamation');
INSERT INTO `authority` VALUES ('68', '上岗申请', '驾驶员', '待岗管理', '上岗申请', 'driver/leave/leaveBack_context.jsp', '20', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('69', '待岗查询', '驾驶员', '待岗管理', '待岗记录查询', 'driver/leave/search.jsp', '22', null, null, '', '1250', null);
INSERT INTO `authority` VALUES ('70', '证照申请注销', '驾驶员', '证照申请', '申请注销', 'driver/driverInCar/business_apply_cancel.jsp', '6', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('71', '证照办理注销', '驾驶员', '证照办领', '办理注销', 'driver/driverInCar/business_recive_cancel.jsp', '7', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('72', '新增保险信息', '车辆', '新增', '新增保险信息', 'vehicle/insurance/insurance_add.jsp', '8', null, null, '', '1350', null);
INSERT INTO `authority` VALUES ('73', '查询保险信息', '车辆', '查询', '查询保险信息', 'vehicle/insurance/insurance_search.jsp', '8', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('74', '批量变更约定', '财务', '批量变更约定', null, 'charge/batch_add.jsp', '8', 'bg-yellow', 'icon-list-ol', '', '1000', null);
INSERT INTO `authority` VALUES ('75', '单车变更约定', '财务', '单车变更约定', null, 'charge/percar_add.jsp', '9', 'bg-yellow', 'icon-list', '', '1000', null);
INSERT INTO `authority` VALUES ('76', '银行导入', '财务', '银行导入', '银行导入', 'charge/bankfile_import.jsp', '10', 'bg-main', 'icon-sign-in', '', '1000', null);
INSERT INTO `authority` VALUES ('77', '银行计划', '财务', '银行计划', null, 'charge/bankfile_export.jsp', '12', 'bg-blue', 'icon-list', '', '2000', null);
INSERT INTO `authority` VALUES ('78', '财务对账表', '财务', '财务对账表', null, '/DZOMS/charge/getCheckChargeTable.jsp', '14', 'bg-blue', 'icon-table', '', '1600', null);
INSERT INTO `authority` VALUES ('79', '取款', '财务', '取款', null, 'charge/get_money.jsp', '16', 'bg-main', 'icon-upload', '', '1000', null);
INSERT INTO `authority` VALUES ('80', '单车收款', '财务', '单车收款', null, 'charge/charge_add.jsp', '18', 'bg-main', 'icon-taxi', '', '1000', null);
INSERT INTO `authority` VALUES ('81', '单车收费查询', '财务', '单车收费查询', null, 'charge/getACarChargeTable.jsp', '20', 'bg-blue', 'icon-search', '', '1000', null);
INSERT INTO `authority` VALUES ('82', '财务清帐', '财务', '结账', null, 'charge/showClearPage', '22', 'bg-red', 'icon-repeat', '', '1000', null);
INSERT INTO `authority` VALUES ('83', '欠款清帐', '财务', '欠款清帐', null, 'charge/oweDeletePage.jsp', '23', 'bg-red', 'icon-undo', '', '1000', null);
INSERT INTO `authority` VALUES ('84', '收费类型查询', '财务', '收费类型查询', null, 'charge/chargeCount.jsp', '25', 'bg-blue', 'icon-search', '', '1000', null);
INSERT INTO `authority` VALUES ('85', '收费统计', '财务', '收费统计', null, 'charge/tongji.jsp', '27', 'bg-blue', 'icon-rmb', '', '1800', null);
INSERT INTO `authority` VALUES ('86', '车辆新增菜单', '车辆', '新增', '', '', '99', 'bg-main', 'icon-taxi', '\0', '1000', 'car');
INSERT INTO `authority` VALUES ('87', '车辆查询菜单', '车辆', '查询', null, ' ', '99', 'bg-blue', 'icon-search', '\0', '1000', 'document-search-result');
INSERT INTO `authority` VALUES ('89', '证照申请菜单', '驾驶员', '证照申请', null, ' ', '99', 'bg-yellow', 'icon-columns', '\0', '1000', 'script--pencil');
INSERT INTO `authority` VALUES ('90', '证照办领菜单', '驾驶员', '证照办领', null, ' ', '99', 'bg-green', 'icon-pencil-square-o', '\0', '1000', 'script--plus');
INSERT INTO `authority` VALUES ('91', '事故菜单', '驾驶员', '事故', null, ' ', '99', 'bg-red', 'icon-ambulance', '\0', '1000', 'heart-break');
INSERT INTO `authority` VALUES ('92', '投诉菜单', '驾驶员', '投诉', null, ' ', '99', 'bg-yellow', 'icon-thumbs-o-down', '\0', '1000', 'mail-send');
INSERT INTO `authority` VALUES ('93', '表扬菜单', '驾驶员', '表扬', null, ' ', '99', 'bg-main', 'icon-thumbs-o-up', '\0', '1000', 'thumb-up');
INSERT INTO `authority` VALUES ('94', '例会菜单', '驾驶员', '例会', null, ' ', '99', 'bg-blue', 'icon-sitemap', '\0', '1000', 'grid');
INSERT INTO `authority` VALUES ('95', '活动菜单', '驾驶员', '活动', null, ' ', '99', 'bg-blue', 'icon-smile-o', '\0', '1000', 'users');
INSERT INTO `authority` VALUES ('96', '待岗管理菜单', '驾驶员', '待岗管理', null, ' ', '99', 'bg-main', 'icon-th', '\0', '1000', 'user-silhouette-question');
INSERT INTO `authority` VALUES ('97', '媒体荣誉菜单', '驾驶员', '媒体荣誉', null, ' ', '99', 'bg-main', 'icon-trophy', '\0', '1000', 'trophy');
INSERT INTO `authority` VALUES ('98', '自检菜单', '车辆', '自检', null, ' ', '99', 'bg-yellow', 'icon-user', '\0', '1000', 'car--plus');
INSERT INTO `authority` VALUES ('99', '聘用菜单', '驾驶员', '聘用', null, ' ', '99', 'bg-main', 'icon-user', '\0', '1000', 'user--plus');
INSERT INTO `authority` VALUES ('100', '车辆废业计划', '车辆', '车辆废业计划', null, 'vehicle/vehicle_abandond_plan.jsp', '37', 'bg-main', 'icon-tasks', '', '1200', 'car-red');
INSERT INTO `authority` VALUES ('104', '家访菜单', '驾驶员', '家访', null, '', '99', 'bg-main', 'icon-tasks', '\0', '1200', 'home');
INSERT INTO `authority` VALUES ('105', '家访登记', '驾驶员', '家访', '登记', 'driver/homevisit/add.jsp', '18', 'bg-main', 'icon-tasks', '', '1200', null);
INSERT INTO `authority` VALUES ('106', '家访查询', '驾驶员', '家访', '查询', 'driver/homevisit/search.jsp', '18', 'bg-main', 'icon-tasks', '', '1200', null);
INSERT INTO `authority` VALUES ('107', '银行卡车辆关联查询', '财务', '银行卡管理', '银行卡--车辆', 'contract/bank_card/search_vehicle_about_bankcard.jsp', '2', null, null, '', '2500', null);
INSERT INTO `authority` VALUES ('147', '自检添加车辆', '车辆', '自检', '添加车辆', 'check/visiable_group.jsp', '20', 'default-show', '', '', '1000', null);
INSERT INTO `authority` VALUES ('148', '发票销售', '财务', '发票管理', '发票销售', 'charge/receipt/out.jsp', '4', 'bg-main', 'icon-tasks', '', '1000', null);
INSERT INTO `authority` VALUES ('149', '库存管理', '财务', '发票管理', '库存管理', 'charge/receipt/storage_header.jsp', '5', 'bg-main', 'icon-tasks', '', '1200', null);
INSERT INTO `authority` VALUES ('150', '作废查询', '财务', '发票管理', '作废查询', 'charge/receipt/remove_header.jsp', '6', 'bg-main', 'icon-tasks', '', '1200', null);
INSERT INTO `authority` VALUES ('151', '银行卡管理', '财务', '银行卡管理', null, ' ', '99', null, null, '\0', '1200', null);
INSERT INTO `authority` VALUES ('152', '发票管理', '财务', '发票管理', null, ' ', '99', null, null, '\0', '1200', null);
INSERT INTO `authority` VALUES ('160', '运营数据导入', '车辆', '运营数据导入', '导入文件', 'vehicle/service/upload.jsp', '25', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('161', '导入数据查询', '车辆', '运营数据导入', '查询', 'vehicle/service/search.jsp', '27', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('162', '错误数据查询', '车辆', '运营数据导入', '错误数据查询', 'vehicle/service/search_err.jsp', '29', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('163', '未导入的车辆', '车辆', '运营数据导入', '未导入的车辆', 'vehicle/service/search_notexist.jsp', '31', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('164', '运营数据导入菜单', '车辆', '运营数据导入', null, ' ', '99', null, null, '\0', '1200', null);
INSERT INTO `authority` VALUES ('165', '营运数据手工录入', '车辆', '运营数据导入', '营运数据手工录入', 'vehicle/service/addOrUpdateDetail.jsp', '35', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('166', '营运数据清理', '车辆', '运营数据导入', '数据清理', 'vehicle/service/clear.jsp', '37', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('167', '日报表统计', '车辆', '运营数据导入', '日报表统计', 'vehicle/service/search_daily.jsp', '39', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('170', '电子违章菜单', '车辆', '电子违章', null, ' ', '99', null, null, '\0', '1200', null);
INSERT INTO `authority` VALUES ('171', '电子违章查询', '车辆', '电子违章', '查询违章', 'http://125.211.198.176:8080/DzElectric/vehicle/electric/fetch_search.jsp', '50', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('172', '电子违章下载', '车辆', '电子违章', '违章数据下载', 'vehicle/electric/search.jsp', '51', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('180', '绑定承租人', '车辆', '新增', '绑定承租人', 'vehicle/vehicle/vehicle_Bind.jsp', '10', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('181', '新增营运证信息', '车辆', '新增', '新增营运证信息', 'vehicle/vehicle/service_right_add.jsp', '12', null, null, '', '1000', null);
INSERT INTO `authority` VALUES ('182', '查询营运证信息', '车辆', '查询', '查询营运证信息', 'vehicle/vehicle/service_right_search.jsp', '12', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('190', '审批状态查询', '审批管理', '审批状态查询', null, 'vehicle/vehicle_approval_search.jsp', '25', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('191', '开业审批状态跟踪', '审批管理', '开业审批状态跟踪', null, 'vehicle/vehicle_approval_search_personal.jsp', '21', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('192', '废业审批状态跟踪', '审批管理', '废业审批状态跟踪', null, 'vehicle/vehicle_abandond_search_personal.jsp', '22', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('201', '添加用户', '系统管理', '添加用户', null, 'manage/adduser.jsp', '1', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('202', '查询用户', '系统管理', '查询用户', null, 'manage/selectAllUsers', '5', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('300', '复检', '车辆', '自检', '复检', 'check/repass_search.jsp', '7', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('301', '统计', '车辆', '自检', '统计', 'check/tonji_search.jsp', '9', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('302', '提请聘用', '驾驶员', '聘用', '聘用申请', 'driver/applycheck/driver_apply.jsp', '1', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('304', '多车计划查询', '财务', '多车计划查询', '多车计划查询', 'charge/plan_detail_mul_car_header.jsp', '102', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('305', '单车约定查询', '财务', '单车约定查询', '单车约定查询', 'charge/bps_header.jsp', '103', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('306', '单车计划查询', '财务', '单车计划查询', '单车计划查询', 'charge/plan_detail_one_car_header.jsp', '101', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('307', '证照申请表打印', '驾驶员', '证照申请表打印', null, 'driver/driverInCar/print_driver_change.jsp', '11', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('308', '保险续保', '车辆', '保险续保', null, 'vehicle/insurance/vehicle_search.jsp', '19', null, null, '', '2500', null);
INSERT INTO `authority` VALUES ('401', '事故修改', '驾驶员', '事故', '事故修改', 'driver/accident_Selects?selectStyle=1', '100', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('402', '事故审核', '驾驶员', '事故', '事故审核', 'driver/accident_Selects?selectStyle=0', '101', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('403', '事故赔付', '驾驶员', '事故', '事故赔付', ' driver/accident_Selects?selectStyle=2', '102', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('404', '违章统计', '车辆', '电子违章', '违章统计', 'http://125.211.198.176:8080/DzElectric/vehicle/electric/anaylse_search.jsp', '52', null, null, '', '1500', null);
INSERT INTO `authority` VALUES ('405', '废业日期查询及录入', '车辆', '车辆废业', null, 'vehicle/vehicle_abandond_date.jsp', '39', null, null, '', '2500', null);
INSERT INTO `authority` VALUES ('406', '银行导入查询', '财务', '银行导入', '银行导入记录', 'charge/file_import_search.jsp', '11', null, null, '', '2500', null);
INSERT INTO `authority` VALUES ('407', '银行导入菜单', '财务', '银行导入', null, '', '99', null, null, '\0', '1200', null);
INSERT INTO `authority` VALUES ('408', '待岗审批', '驾驶员', '待岗管理', '待岗审批', 'driver/leave/search_L.jsp', '21', null, null, '', '1250', null);
INSERT INTO `authority` VALUES ('409', '上岗审批', '驾驶员', '待岗管理', '上岗审批', 'driver/leave/search_B.jsp', '21', null, null, '', '1250', null);
INSERT INTO `authority` VALUES ('410', '审批流程统计', '统计分析', '审批流程统计', '审批流程统计', 'statistics/approval_anaylse.jsp', '1', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('411', '财务统计', '统计分析', '财务统计', '财务统计', 'statistics/charge_anaylse.jsp', '5', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('412', '财务查错', '系统管理', '财务查错', '财务查错', 'manage/adjustPlans.jsp', '9', null, null, '', '1200', null);
INSERT INTO `authority` VALUES ('413', '车辆废业更新对照', '车辆', '废业更新对照', null, 'vehicle/abandond_renew.jsp', '55', null, null, '', '2500', null);
INSERT INTO `authority` VALUES ('414', '投诉落实', '驾驶员', '投诉', '投诉落实', 'driver/complain/complain_check_context.jsp?state=0', '14', 'bg-main', 'icon-tasks', '', '1800', null);
INSERT INTO `authority` VALUES ('415', '投诉回访', '驾驶员', '投诉', '投诉回访', 'driver/complain/complain_check_context.jsp?state=2', '15', 'bg-main', 'icon-tasks', '', '1800', null);
INSERT INTO `authority` VALUES ('416', '投诉完结', '驾驶员', '投诉', '投诉完结', 'driver/complain/complain_check_context.jsp?state=3', '16', 'bg-main', 'icon-tasks', '', '1800', null);
INSERT INTO `authority` VALUES ('417', '投诉补充登记', '驾驶员', '投诉', '投诉补充登记', 'driver/complain/complain_check_context.jsp?state=4', '17', 'bg-main', 'icon-tasks', '', '1800', null);
