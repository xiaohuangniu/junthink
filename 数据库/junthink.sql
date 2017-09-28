/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : junthink

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-09-28 18:01:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jun_job
-- ----------------------------
DROP TABLE IF EXISTS `jun_job`;
CREATE TABLE `jun_job` (
  `j_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `j_name` varchar(40) DEFAULT NULL COMMENT '岗位名称',
  `s_id` int(11) DEFAULT NULL COMMENT '组织ID',
  `r_id` varchar(255) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`j_id`),
  KEY `s_id` (`s_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='岗位表';

-- ----------------------------
-- Records of jun_job
-- ----------------------------
INSERT INTO `jun_job` VALUES ('4', 'PHP工程师', '4', '10');
INSERT INTO `jun_job` VALUES ('5', '实习生', '4', '11');
INSERT INTO `jun_job` VALUES ('6', '部门老大', '4', '11,12');

-- ----------------------------
-- Table structure for jun_manager
-- ----------------------------
DROP TABLE IF EXISTS `jun_manager`;
CREATE TABLE `jun_manager` (
  `m_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `j_id` int(11) NOT NULL DEFAULT '0' COMMENT '岗位ID，0为超级管理员',
  `m_name` varchar(30) DEFAULT NULL COMMENT '用户名',
  `m_pwd` varchar(35) DEFAULT NULL COMMENT 'MD5后的密码',
  `m_nice` varchar(20) DEFAULT NULL COMMENT '昵称',
  `m_phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `m_time` int(10) DEFAULT NULL COMMENT '添加时间，秘钥',
  `m_status` tinyint(1) DEFAULT '1' COMMENT '状态，1开启，2禁用',
  PRIMARY KEY (`m_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of jun_manager
-- ----------------------------
INSERT INTO `jun_manager` VALUES ('3', '0', 'admin', 'e40800c264922d6a22add5fb189a08e0', '小黄牛', '15992438888', '1506418602', '1');

-- ----------------------------
-- Table structure for jun_manager_action_log
-- ----------------------------
DROP TABLE IF EXISTS `jun_manager_action_log`;
CREATE TABLE `jun_manager_action_log` (
  `mal_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `m_id` int(11) DEFAULT NULL COMMENT '管理员ID',
  `mal_type` varchar(40) DEFAULT NULL COMMENT '操作类型',
  `mal_des` varchar(50) DEFAULT NULL COMMENT '详细描述',
  `mal_status` tinyint(1) DEFAULT NULL COMMENT '操作状态 1成功， 2失败，3异常',
  `mal_mode` varchar(10) DEFAULT NULL COMMENT '请求类型',
  `mal_ip` varchar(15) DEFAULT NULL COMMENT '操作时的IP',
  `mal_url` varchar(255) DEFAULT NULL COMMENT '操作的完整URL',
  `mal_time` int(10) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`mal_id`),
  KEY `m_id` (`m_id`),
  KEY `mal_type` (`mal_type`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='管理员操作日志';

-- ----------------------------
-- Records of jun_manager_action_log
-- ----------------------------

-- ----------------------------
-- Table structure for jun_manager_login_log
-- ----------------------------
DROP TABLE IF EXISTS `jun_manager_login_log`;
CREATE TABLE `jun_manager_login_log` (
  `l_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `m_id` int(11) DEFAULT NULL COMMENT '管理员ID',
  `l_ip` varchar(15) DEFAULT NULL COMMENT '登录IP',
  `l_time` int(10) DEFAULT NULL COMMENT '登录时间',
  PRIMARY KEY (`l_id`),
  KEY `m_id` (`m_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='管理登录日志表';

-- ----------------------------
-- Records of jun_manager_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for jun_menu
-- ----------------------------
DROP TABLE IF EXISTS `jun_menu`;
CREATE TABLE `jun_menu` (
  `m_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `m_pid` int(11) DEFAULT '0' COMMENT '父ID',
  `m_name` varchar(20) DEFAULT NULL COMMENT '菜单名称',
  `m_controller` varchar(35) DEFAULT '' COMMENT '控制器名称',
  `m_action` varchar(35) DEFAULT NULL COMMENT '方法名称',
  `m_path` varchar(25) DEFAULT NULL COMMENT '全等级路径',
  `m_type` tinyint(1) DEFAULT '1' COMMENT '菜单类型  1：权限认证+菜单  2：只作为菜单',
  `m_display` tinyint(1) DEFAULT '1' COMMENT '状态，1开启，2关闭',
  `m_icon` varchar(60) DEFAULT NULL COMMENT 'ICON的class名',
  `m_remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `m_sort` int(11) DEFAULT '0' COMMENT '排序',
  `m_request` varchar(6) DEFAULT NULL COMMENT '请求方式，GET,POST,AJAX',
  PRIMARY KEY (`m_id`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of jun_menu
-- ----------------------------
INSERT INTO `jun_menu` VALUES ('6', '0', '管理员设置', '', '', '6', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('7', '6', '权限管理', '', '', '6/7', '1', '1', 'glyphicon glyphicon-stats text-primary-dk', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('8', '7', '地区列表', 'region', 'showlist', '6/7/8', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('9', '8', '添加地区', 'region', 'add', '6/7/8/9', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('10', '8', '修改地区', 'region', 'upd', '6/7/8/10', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('11', '8', '删除地区', 'region', 'del', '6/7/8/11', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('12', '7', '组织列表', 'structure', 'showlist', '6/7/12', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('13', '12', '添加组织', 'structure', 'add', '6/7/12/13', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('14', '12', '修改组织', 'structure', 'upd', '6/7/12/14', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('15', '12', '删除组织', 'structure', 'del', '6/7/12/15', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('16', '7', '岗位列表', 'job', 'showlist', '6/7/16', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('17', '16', '添加岗位', 'job', 'add', '6/7/16/17', '1', '1', '', '', '0', 'Ajax');
INSERT INTO `jun_menu` VALUES ('18', '16', '修改岗位', 'job', 'upd', '6/7/16/18', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('19', '16', '删除岗位', 'job', 'del', '6/7/16/19', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('20', '7', '角色列表', 'role', 'showlist', '6/7/20', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('21', '20', '添加角色', 'role', 'add', '6/7/20/21', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('22', '20', '修改角色', 'role', 'upd', '6/7/20/22', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('23', '20', '删除角色', 'role', 'del', '6/7/20/23', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('24', '7', '菜单列表', 'menu', 'showlist', '6/7/24', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('25', '24', '添加菜单', 'menu', 'add', '6/7/24/25', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('26', '24', '修改菜单', 'menu', 'upd', '6/7/24/26', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('27', '24', '删除菜单', 'menu', 'del', '6/7/24/27', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('28', '7', '管理员列表', 'manager', 'showlist', '6/7/28', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('29', '28', '添加管理员', 'manager', 'add', '6/7/28/29', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('30', '28', '修改管理员', 'manager', 'upd', '6/7/28/30', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('31', '28', '删除管理员', 'manager', 'del', '6/7/28/31', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('32', '0', '系统设置', '', '', '32', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('33', '32', '日志管理', '', '', '32/33', '1', '1', 'fa fa-calendar-o', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('34', '33', '登录日志', 'loginlog', 'showlist', '32/33/34', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('35', '34', '删除日志', 'loginlog', 'del', '32/33/34/35', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('37', '33', '操作记录', 'actionlog', 'showlist', '32/33/37', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('38', '37', '查看详情', 'actionlog', 'details', '32/33/37/38', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('39', '37', '删除日志', 'actionlog', 'del', '32/33/37/39', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('40', '37', '清空日志', 'actionlog', 'emptyall', '32/33/37/40', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('41', '32', '数据库管理', '', '', '32/41', '1', '1', 'fa fa-database text-primary-dk', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('42', '41', '数据库列表', 'database', 'showlist', '32/41/42', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('43', '42', '查看详情', 'database', 'details', '32/41/42/43', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('44', '42', '数据库备份', 'database', 'backup', '32/41/42/44', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('45', '42', '下载备份', 'database', 'download', '32/41/42/45', '1', '1', '', '', '0', '0');
INSERT INTO `jun_menu` VALUES ('46', '42', '备份还原', 'database', 'restore', '32/41/42/46', '1', '1', '', '', '0', '0');

-- ----------------------------
-- Table structure for jun_region
-- ----------------------------
DROP TABLE IF EXISTS `jun_region`;
CREATE TABLE `jun_region` (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `r_pid` smallint(5) unsigned DEFAULT '0' COMMENT '父ID',
  `r_name` varchar(120) DEFAULT NULL COMMENT '名称',
  `r_pinyin` varchar(50) DEFAULT NULL COMMENT '拼音',
  `r_code` int(5) DEFAULT '0' COMMENT '编码',
  `r_sort` smallint(3) DEFAULT '1' COMMENT '排序',
  PRIMARY KEY (`r_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3386 DEFAULT CHARSET=utf8 COMMENT='地区表';

-- ----------------------------
-- Records of jun_region
-- ----------------------------
INSERT INTO `jun_region` VALUES ('1', '0', '中国', '', '0', '1');
INSERT INTO `jun_region` VALUES ('2', '1', '北京', 'BeiJing', '110000', '2');
INSERT INTO `jun_region` VALUES ('3', '1', '安徽', 'AnHui', '340000', '1');
INSERT INTO `jun_region` VALUES ('4', '1', '福建', 'FuJian', '350000', '1');
INSERT INTO `jun_region` VALUES ('5', '1', '甘肃', 'GanSu', '620000', '1');
INSERT INTO `jun_region` VALUES ('6', '1', '广东', 'GuangDong', '440000', '4');
INSERT INTO `jun_region` VALUES ('7', '1', '广西', 'GuangXi', '450000', '1');
INSERT INTO `jun_region` VALUES ('8', '1', '贵州', 'GuiZhou', '520000', '1');
INSERT INTO `jun_region` VALUES ('9', '1', '海南', 'HaiNan', '460000', '1');
INSERT INTO `jun_region` VALUES ('10', '1', '河北', 'HeBei', '130000', '1');
INSERT INTO `jun_region` VALUES ('11', '1', '河南', 'HeNan', '410000', '1');
INSERT INTO `jun_region` VALUES ('12', '1', '黑龙江', 'HeiLongJiang', '230000', '1');
INSERT INTO `jun_region` VALUES ('13', '1', '湖北', 'HuBei', '420000', '1');
INSERT INTO `jun_region` VALUES ('14', '1', '湖南', 'HuNan', '430000', '1');
INSERT INTO `jun_region` VALUES ('15', '1', '吉林', 'JiLin', '220000', '1');
INSERT INTO `jun_region` VALUES ('16', '1', '江苏', 'JiangSu', '320000', '1');
INSERT INTO `jun_region` VALUES ('17', '1', '江西', 'JiangXi', '360000', '1');
INSERT INTO `jun_region` VALUES ('18', '1', '辽宁', 'LiaoNing', '210000', '1');
INSERT INTO `jun_region` VALUES ('19', '1', '内蒙古', 'NaMengGu', '150000', '1');
INSERT INTO `jun_region` VALUES ('20', '1', '宁夏', 'NingXia', '640000', '1');
INSERT INTO `jun_region` VALUES ('21', '1', '青海', 'QingHai', '630000', '1');
INSERT INTO `jun_region` VALUES ('22', '1', '山东', 'ShanDong', '370000', '1');
INSERT INTO `jun_region` VALUES ('23', '1', '山西', 'ShanXi', '140000', '1');
INSERT INTO `jun_region` VALUES ('24', '1', '陕西', 'XiAnShi', '610000', '1');
INSERT INTO `jun_region` VALUES ('25', '1', '上海', 'ShangHai', '310000', '1');
INSERT INTO `jun_region` VALUES ('26', '1', '四川', 'SiChuan', '510000', '1');
INSERT INTO `jun_region` VALUES ('27', '1', '天津', 'TianJin', '120000', '1');
INSERT INTO `jun_region` VALUES ('28', '1', '西藏', 'XiCang', '540000', '1');
INSERT INTO `jun_region` VALUES ('29', '1', '新疆', 'XinJiang', '650000', '1');
INSERT INTO `jun_region` VALUES ('30', '1', '云南', 'YunNan', '530000', '1');
INSERT INTO `jun_region` VALUES ('31', '1', '浙江', 'ZheJiang', '330000', '1');
INSERT INTO `jun_region` VALUES ('32', '1', '重庆', 'ChongQing', '500000', '1');
INSERT INTO `jun_region` VALUES ('36', '3', '安庆', 'AnQingShi', '340800', '1');
INSERT INTO `jun_region` VALUES ('37', '3', '蚌埠', 'BangBuShi', '340300', '1');
INSERT INTO `jun_region` VALUES ('39', '3', '池州', 'ChiZhouShi', '341700', '1');
INSERT INTO `jun_region` VALUES ('40', '3', '滁州', 'ChuZhouShi', '341100', '1');
INSERT INTO `jun_region` VALUES ('41', '3', '阜阳', 'FuYangShi', '341200', '1');
INSERT INTO `jun_region` VALUES ('42', '3', '淮北', 'HuaiBeiShi', '340600', '1');
INSERT INTO `jun_region` VALUES ('43', '3', '淮南', 'HuaiNanShi', '340400', '1');
INSERT INTO `jun_region` VALUES ('44', '3', '黄山', 'HuangShanShi', '341000', '1');
INSERT INTO `jun_region` VALUES ('45', '3', '六安', 'LiuAnShi', '341500', '1');
INSERT INTO `jun_region` VALUES ('46', '3', '马鞍山', 'MaAnShanShi', '340500', '1');
INSERT INTO `jun_region` VALUES ('47', '3', '宿州', 'SuZhouShi', '341300', '1');
INSERT INTO `jun_region` VALUES ('48', '3', '铜陵', 'TongLingShi', '340700', '1');
INSERT INTO `jun_region` VALUES ('49', '3', '芜湖', 'WuHuShi', '340200', '1');
INSERT INTO `jun_region` VALUES ('50', '3', '宣城', 'XuanChengShi', '341800', '1');
INSERT INTO `jun_region` VALUES ('51', '3', '亳州', 'BoZhouShi', '341600', '1');
INSERT INTO `jun_region` VALUES ('53', '4', '福州', 'FuZhouShi', '350100', '1');
INSERT INTO `jun_region` VALUES ('54', '4', '龙岩', 'LongYanShi', '350800', '1');
INSERT INTO `jun_region` VALUES ('55', '4', '南平', 'NanPingShi', '350700', '1');
INSERT INTO `jun_region` VALUES ('56', '4', '宁德', 'NingDeShi', '350900', '1');
INSERT INTO `jun_region` VALUES ('57', '4', '莆田', 'PuTianShi', '350300', '1');
INSERT INTO `jun_region` VALUES ('58', '4', '泉州', 'QuanZhouShi', '350500', '1');
INSERT INTO `jun_region` VALUES ('59', '4', '三明', 'SanMingShi', '350400', '1');
INSERT INTO `jun_region` VALUES ('60', '4', '厦门', 'XiaMenShi', '350200', '1');
INSERT INTO `jun_region` VALUES ('61', '4', '漳州', 'ZhangZhouShi', '350600', '1');
INSERT INTO `jun_region` VALUES ('62', '5', '兰州', 'LanZhouShi', '620100', '1');
INSERT INTO `jun_region` VALUES ('63', '5', '白银', 'BaiYinShi', '620400', '1');
INSERT INTO `jun_region` VALUES ('64', '5', '定西', 'DingXiShi', '621100', '1');
INSERT INTO `jun_region` VALUES ('65', '5', '甘南', 'GanNanZhou', '623000', '1');
INSERT INTO `jun_region` VALUES ('66', '5', '嘉峪关', 'JiaYuGuanShi', '620200', '1');
INSERT INTO `jun_region` VALUES ('67', '5', '金昌', 'JinChangShi', '620300', '1');
INSERT INTO `jun_region` VALUES ('68', '5', '酒泉', 'JiuQuanShi', '620900', '1');
INSERT INTO `jun_region` VALUES ('69', '5', '临夏', 'LinXiaZhou', '622900', '1');
INSERT INTO `jun_region` VALUES ('70', '5', '陇南', 'LongNanShi', '621200', '1');
INSERT INTO `jun_region` VALUES ('71', '5', '平凉', 'PingLiangShi', '620800', '1');
INSERT INTO `jun_region` VALUES ('72', '5', '庆阳', 'QingYangShi', '621000', '1');
INSERT INTO `jun_region` VALUES ('73', '5', '天水', 'TianShuiShi', '620500', '1');
INSERT INTO `jun_region` VALUES ('74', '5', '武威', 'WuWeiShi', '620600', '1');
INSERT INTO `jun_region` VALUES ('75', '5', '张掖', 'ZhangYeShi', '620700', '1');
INSERT INTO `jun_region` VALUES ('76', '6', '广州', 'GuangZhouShi', '440100', '4');
INSERT INTO `jun_region` VALUES ('77', '6', '深圳', 'ShenChouShi', '440300', '1');
INSERT INTO `jun_region` VALUES ('78', '6', '潮州', 'ChaoZhouShi', '445100', '1');
INSERT INTO `jun_region` VALUES ('79', '6', '东莞', 'DongGuanShi', '441900', '1');
INSERT INTO `jun_region` VALUES ('80', '6', '佛山', 'FuShanShi', '440600', '1');
INSERT INTO `jun_region` VALUES ('81', '6', '河源', 'HeYuanShi', '441600', '1');
INSERT INTO `jun_region` VALUES ('82', '6', '惠州', 'HuiZhouShi', '441300', '1');
INSERT INTO `jun_region` VALUES ('83', '6', '江门', 'JiangMenShi', '440700', '1');
INSERT INTO `jun_region` VALUES ('84', '6', '揭阳', 'JieYangShi', '445200', '1');
INSERT INTO `jun_region` VALUES ('85', '6', '茂名', 'MaoMingShi', '440900', '1');
INSERT INTO `jun_region` VALUES ('86', '6', '梅州', 'MeiZhouShi', '441400', '1');
INSERT INTO `jun_region` VALUES ('87', '6', '清远', 'QingYuanShi', '441800', '1');
INSERT INTO `jun_region` VALUES ('88', '6', '汕头', 'ShanTouShi', '440500', '1');
INSERT INTO `jun_region` VALUES ('89', '6', '汕尾', 'ShanWeiShi', '441500', '1');
INSERT INTO `jun_region` VALUES ('90', '6', '韶关', 'ShaoGuanShi', '440200', '1');
INSERT INTO `jun_region` VALUES ('91', '6', '阳江', 'YangJiangShi', '441700', '1');
INSERT INTO `jun_region` VALUES ('92', '6', '云浮', 'YunFuShi', '445300', '1');
INSERT INTO `jun_region` VALUES ('93', '6', '湛江', 'ZhanJiangShi', '440800', '1');
INSERT INTO `jun_region` VALUES ('94', '6', '肇庆', 'ZhaoQingShi', '441200', '1');
INSERT INTO `jun_region` VALUES ('95', '6', '中山', 'ZhongShanShi', '442000', '1');
INSERT INTO `jun_region` VALUES ('96', '6', '珠海', 'ZhuHaiShi', '440400', '1');
INSERT INTO `jun_region` VALUES ('97', '7', '南宁', 'NanNingShi', '450100', '1');
INSERT INTO `jun_region` VALUES ('98', '7', '桂林', 'GuiLinShi', '450300', '1');
INSERT INTO `jun_region` VALUES ('99', '7', '百色', 'BaiSeShi', '451000', '1');
INSERT INTO `jun_region` VALUES ('100', '7', '北海', 'BeiHaiShi', '450500', '1');
INSERT INTO `jun_region` VALUES ('101', '7', '崇左', 'ChongZuoShi', '451400', '1');
INSERT INTO `jun_region` VALUES ('102', '7', '防城港', 'FangChengGangShi', '450600', '1');
INSERT INTO `jun_region` VALUES ('103', '7', '贵港', 'GuiGangShi', '450800', '1');
INSERT INTO `jun_region` VALUES ('104', '7', '河池', 'HeChiShi', '451200', '1');
INSERT INTO `jun_region` VALUES ('105', '7', '贺州', 'HeZhouShi', '451100', '1');
INSERT INTO `jun_region` VALUES ('106', '7', '来宾', 'LaiBinShi', '451300', '1');
INSERT INTO `jun_region` VALUES ('107', '7', '柳州', 'LiuZhouShi', '450200', '1');
INSERT INTO `jun_region` VALUES ('108', '7', '钦州', 'QinZhouShi', '450700', '1');
INSERT INTO `jun_region` VALUES ('109', '7', '梧州', 'WuZhouShi', '450400', '1');
INSERT INTO `jun_region` VALUES ('110', '7', '玉林', 'YuLinShi', '450900', '1');
INSERT INTO `jun_region` VALUES ('111', '8', '贵阳', 'GuiYangShi', '520100', '1');
INSERT INTO `jun_region` VALUES ('112', '8', '安顺', 'AnShunShi', '520400', '1');
INSERT INTO `jun_region` VALUES ('113', '8', '毕节', 'BiJieDiQu', '522500', '1');
INSERT INTO `jun_region` VALUES ('114', '8', '六盘水', 'LiuPanShuiShi', '520200', '1');
INSERT INTO `jun_region` VALUES ('115', '8', '黔东南', 'QianDongNanZhou', '522600', '1');
INSERT INTO `jun_region` VALUES ('116', '8', '黔南', 'QianNanZhou', '522700', '1');
INSERT INTO `jun_region` VALUES ('117', '8', '黔西南', 'QianXiNanZhou', '522300', '1');
INSERT INTO `jun_region` VALUES ('118', '8', '铜仁', 'TongRenDiQu', '522200', '1');
INSERT INTO `jun_region` VALUES ('119', '8', '遵义', 'ZunYiShi', '520300', '1');
INSERT INTO `jun_region` VALUES ('120', '9', '海口', 'HaiKouShi', '460100', '1');
INSERT INTO `jun_region` VALUES ('121', '9', '三亚', 'SanYaShi', '460200', '1');
INSERT INTO `jun_region` VALUES ('122', '9', '白沙', 'BaiShaXian', '469025', '1');
INSERT INTO `jun_region` VALUES ('123', '9', '保亭', 'BaoTingXian', '469029', '1');
INSERT INTO `jun_region` VALUES ('124', '9', '昌江', '', '469026', '1');
INSERT INTO `jun_region` VALUES ('125', '9', '澄迈县', 'ChengMaiXian', '469023', '1');
INSERT INTO `jun_region` VALUES ('126', '9', '定安县', 'DingAnXian', '469021', '1');
INSERT INTO `jun_region` VALUES ('127', '9', '东方', 'DongFangShi', '469007', '1');
INSERT INTO `jun_region` VALUES ('128', '9', '乐东', '', '469027', '1');
INSERT INTO `jun_region` VALUES ('129', '9', '临高县', 'LinGaoXian', '469024', '1');
INSERT INTO `jun_region` VALUES ('130', '9', '陵水', '', '469028', '1');
INSERT INTO `jun_region` VALUES ('131', '9', '琼海', 'QiongHaiShi', '469002', '1');
INSERT INTO `jun_region` VALUES ('132', '9', '琼中', '', '469030', '1');
INSERT INTO `jun_region` VALUES ('133', '9', '屯昌县', 'TunChangXian', '469022', '1');
INSERT INTO `jun_region` VALUES ('134', '9', '万宁', 'WanNingShi', '469006', '1');
INSERT INTO `jun_region` VALUES ('135', '9', '文昌', 'WenChangShi', '469005', '1');
INSERT INTO `jun_region` VALUES ('136', '9', '五指山', 'WuZhiShanShi', '469001', '1');
INSERT INTO `jun_region` VALUES ('137', '9', '儋州', 'DanZhouShi', '469003', '1');
INSERT INTO `jun_region` VALUES ('138', '10', '石家庄', 'ShiJiaZhuangShi', '130100', '1');
INSERT INTO `jun_region` VALUES ('139', '10', '保定', 'BaoDingShi', '130600', '1');
INSERT INTO `jun_region` VALUES ('140', '10', '沧州', 'CangZhouShi', '130900', '1');
INSERT INTO `jun_region` VALUES ('141', '10', '承德', 'ChengDeShi', '130800', '1');
INSERT INTO `jun_region` VALUES ('142', '10', '邯郸', 'HanDanShi', '130400', '1');
INSERT INTO `jun_region` VALUES ('143', '10', '衡水', 'HengShuiShi', '131100', '1');
INSERT INTO `jun_region` VALUES ('144', '10', '廊坊', 'LangFangShi', '131000', '1');
INSERT INTO `jun_region` VALUES ('145', '10', '秦皇岛', 'QinHuangDaoShi', '130300', '1');
INSERT INTO `jun_region` VALUES ('146', '10', '唐山', 'TangShanShi', '130200', '1');
INSERT INTO `jun_region` VALUES ('147', '10', '邢台', 'XingTaiShi', '130500', '1');
INSERT INTO `jun_region` VALUES ('148', '10', '张家口', 'ZhangJiaKouShi', '130700', '1');
INSERT INTO `jun_region` VALUES ('149', '11', '郑州', 'ZhengZhouShi', '410100', '1');
INSERT INTO `jun_region` VALUES ('150', '11', '洛阳', 'LuoYangShi', '410300', '1');
INSERT INTO `jun_region` VALUES ('151', '11', '开封', 'KaiFengShi', '410200', '1');
INSERT INTO `jun_region` VALUES ('152', '11', '安阳', 'AnYangShi', '410500', '1');
INSERT INTO `jun_region` VALUES ('153', '11', '鹤壁', 'HeBiShi', '410600', '1');
INSERT INTO `jun_region` VALUES ('154', '11', '济源', '', '419001', '1');
INSERT INTO `jun_region` VALUES ('155', '11', '焦作', 'JiaoZuoShi', '410800', '1');
INSERT INTO `jun_region` VALUES ('156', '11', '南阳', 'NanYangShi', '411300', '1');
INSERT INTO `jun_region` VALUES ('157', '11', '平顶山', 'PingDingShanShi', '410400', '1');
INSERT INTO `jun_region` VALUES ('158', '11', '三门峡', 'SanMenXiaShi', '411200', '1');
INSERT INTO `jun_region` VALUES ('159', '11', '商丘', 'ShangQiuShi', '411400', '1');
INSERT INTO `jun_region` VALUES ('160', '11', '新乡', 'XinXiangShi', '410700', '1');
INSERT INTO `jun_region` VALUES ('161', '11', '信阳', 'XinYangShi', '411500', '1');
INSERT INTO `jun_region` VALUES ('162', '11', '许昌', 'XuChangShi', '411000', '1');
INSERT INTO `jun_region` VALUES ('163', '11', '周口', 'ZhouKouShi', '411600', '1');
INSERT INTO `jun_region` VALUES ('164', '11', '驻马店', 'ZhuMaDianShi', '411700', '1');
INSERT INTO `jun_region` VALUES ('165', '11', '漯河', 'LeiHeShi', '411100', '1');
INSERT INTO `jun_region` VALUES ('166', '11', '濮阳', 'PuYangShi', '410900', '1');
INSERT INTO `jun_region` VALUES ('167', '12', '哈尔滨', 'HaErBinShi', '230100', '1');
INSERT INTO `jun_region` VALUES ('168', '12', '大庆', 'DaQingShi', '230600', '1');
INSERT INTO `jun_region` VALUES ('169', '12', '大兴安岭', '', '232700', '1');
INSERT INTO `jun_region` VALUES ('170', '12', '鹤岗', 'HeGangShi', '230400', '1');
INSERT INTO `jun_region` VALUES ('171', '12', '黑河', 'HeiHeShi', '231100', '1');
INSERT INTO `jun_region` VALUES ('172', '12', '鸡西', 'JiXiShi', '230300', '1');
INSERT INTO `jun_region` VALUES ('173', '12', '佳木斯', 'JiaMuSiShi', '230800', '1');
INSERT INTO `jun_region` VALUES ('174', '12', '牡丹江', 'MuDanJiangShi', '231000', '1');
INSERT INTO `jun_region` VALUES ('175', '12', '七台河', 'QiTaiHeShi', '230900', '1');
INSERT INTO `jun_region` VALUES ('176', '12', '齐齐哈尔', 'QiQiHaErShi', '230200', '1');
INSERT INTO `jun_region` VALUES ('177', '12', '双鸭山', 'ShuangYaShanShi', '230500', '1');
INSERT INTO `jun_region` VALUES ('178', '12', '绥化', 'SuiHuaShi', '231200', '1');
INSERT INTO `jun_region` VALUES ('179', '12', '伊春', 'YiChunShi', '230700', '1');
INSERT INTO `jun_region` VALUES ('180', '13', '武汉', 'WuHanShi', '420100', '1');
INSERT INTO `jun_region` VALUES ('181', '13', '仙桃', 'XianTaoShi', '429004', '1');
INSERT INTO `jun_region` VALUES ('182', '13', '鄂州', 'EZhouShi', '420700', '1');
INSERT INTO `jun_region` VALUES ('183', '13', '黄冈', 'HuangGangShi', '421100', '1');
INSERT INTO `jun_region` VALUES ('184', '13', '黄石', 'HuangShiShi', '420200', '1');
INSERT INTO `jun_region` VALUES ('185', '13', '荆门', 'JingMenShi', '420800', '1');
INSERT INTO `jun_region` VALUES ('186', '13', '荆州', 'JingZhouShi', '421000', '1');
INSERT INTO `jun_region` VALUES ('187', '13', '潜江', 'QianJiangShi', '429005', '1');
INSERT INTO `jun_region` VALUES ('188', '13', '神农架林区', 'ShenNongJiaLinQu', '429021', '1');
INSERT INTO `jun_region` VALUES ('189', '13', '十堰', 'ShiYanShi', '420300', '1');
INSERT INTO `jun_region` VALUES ('190', '13', '随州', 'SuiZhouShi', '421300', '1');
INSERT INTO `jun_region` VALUES ('191', '13', '天门', 'TianMenShi', '429006', '1');
INSERT INTO `jun_region` VALUES ('192', '13', '咸宁', 'XianNingShi', '421200', '1');
INSERT INTO `jun_region` VALUES ('193', '13', '襄阳', 'XiangYangShi', '420600', '1');
INSERT INTO `jun_region` VALUES ('194', '13', '孝感', 'XiaoGanShi', '420900', '1');
INSERT INTO `jun_region` VALUES ('195', '13', '宜昌', 'YiChangShi', '420500', '1');
INSERT INTO `jun_region` VALUES ('196', '13', '恩施', '', '422800', '1');
INSERT INTO `jun_region` VALUES ('197', '14', '长沙', 'ChangShaShi', '430100', '1');
INSERT INTO `jun_region` VALUES ('198', '14', '张家界', 'ZhangJiaJieShi', '430800', '1');
INSERT INTO `jun_region` VALUES ('199', '14', '常德', 'ChangDeShi', '430700', '1');
INSERT INTO `jun_region` VALUES ('200', '14', '郴州', 'ChenZhouShi', '431000', '1');
INSERT INTO `jun_region` VALUES ('201', '14', '衡阳', 'HengYangShi', '430400', '1');
INSERT INTO `jun_region` VALUES ('202', '14', '怀化', 'HuaiHuaShi', '431200', '1');
INSERT INTO `jun_region` VALUES ('203', '14', '娄底', 'LouDiShi', '431300', '1');
INSERT INTO `jun_region` VALUES ('204', '14', '邵阳', 'ShaoYangShi', '430500', '1');
INSERT INTO `jun_region` VALUES ('205', '14', '湘潭', 'XiangTanShi', '430300', '1');
INSERT INTO `jun_region` VALUES ('206', '14', '湘西', '', '433100', '1');
INSERT INTO `jun_region` VALUES ('207', '14', '益阳', 'YiYangShi', '430900', '1');
INSERT INTO `jun_region` VALUES ('208', '14', '永州', 'YongZhouShi', '431100', '1');
INSERT INTO `jun_region` VALUES ('209', '14', '岳阳', 'YueYangShi', '430600', '1');
INSERT INTO `jun_region` VALUES ('210', '14', '株洲', 'ZhuZhouShi', '430200', '1');
INSERT INTO `jun_region` VALUES ('211', '15', '长春', 'ChangChunShi', '220100', '1');
INSERT INTO `jun_region` VALUES ('212', '15', '吉林', 'JiLinShi', '220200', '1');
INSERT INTO `jun_region` VALUES ('213', '15', '白城', 'BaiChengShi', '220800', '1');
INSERT INTO `jun_region` VALUES ('214', '15', '白山', 'BaiShanShi', '220600', '1');
INSERT INTO `jun_region` VALUES ('215', '15', '辽源', 'LiaoYuanShi', '220400', '1');
INSERT INTO `jun_region` VALUES ('216', '15', '四平', 'SiPingShi', '220300', '1');
INSERT INTO `jun_region` VALUES ('217', '15', '松原', 'SongYuanShi', '220700', '1');
INSERT INTO `jun_region` VALUES ('218', '15', '通化', 'TongHuaShi', '220500', '1');
INSERT INTO `jun_region` VALUES ('219', '15', '延边', '', '222400', '1');
INSERT INTO `jun_region` VALUES ('220', '16', '南京', 'NanJingShi', '320100', '1');
INSERT INTO `jun_region` VALUES ('221', '16', '苏州', 'SuZhouShi', '320500', '1');
INSERT INTO `jun_region` VALUES ('222', '16', '无锡', 'WuXiShi', '320200', '1');
INSERT INTO `jun_region` VALUES ('223', '16', '常州', 'ChangZhouShi', '320400', '1');
INSERT INTO `jun_region` VALUES ('224', '16', '淮安', 'HuaiAnShi', '320800', '1');
INSERT INTO `jun_region` VALUES ('225', '16', '连云港', 'LianYunGangShi', '320700', '1');
INSERT INTO `jun_region` VALUES ('226', '16', '南通', 'NanTongShi', '320600', '1');
INSERT INTO `jun_region` VALUES ('227', '16', '宿迁', 'SuQianShi', '321300', '1');
INSERT INTO `jun_region` VALUES ('228', '16', '泰州', 'TaiZhouShi', '321200', '1');
INSERT INTO `jun_region` VALUES ('229', '16', '徐州', 'XuZhouShi', '320300', '1');
INSERT INTO `jun_region` VALUES ('230', '16', '盐城', 'YanChengShi', '320900', '1');
INSERT INTO `jun_region` VALUES ('231', '16', '扬州', 'YangZhouShi', '321000', '1');
INSERT INTO `jun_region` VALUES ('232', '16', '镇江', 'ZhenJiangShi', '321100', '1');
INSERT INTO `jun_region` VALUES ('233', '17', '南昌', 'NanChangShi', '360100', '1');
INSERT INTO `jun_region` VALUES ('234', '17', '抚州', 'FuZhouShi', '361000', '1');
INSERT INTO `jun_region` VALUES ('235', '17', '赣州', 'GanZhouShi', '360700', '1');
INSERT INTO `jun_region` VALUES ('236', '17', '吉安', 'JiAnShi', '360800', '1');
INSERT INTO `jun_region` VALUES ('237', '17', '景德镇', 'JingDeZhenShi', '360200', '1');
INSERT INTO `jun_region` VALUES ('238', '17', '九江', 'JiuJiangShi', '360400', '1');
INSERT INTO `jun_region` VALUES ('239', '17', '萍乡', 'PingXiangShi', '360300', '1');
INSERT INTO `jun_region` VALUES ('240', '17', '上饶', 'ShangRaoShi', '361100', '1');
INSERT INTO `jun_region` VALUES ('241', '17', '新余', 'XinYuShi', '360500', '1');
INSERT INTO `jun_region` VALUES ('242', '17', '宜春', 'YiChunShi', '360900', '1');
INSERT INTO `jun_region` VALUES ('243', '17', '鹰潭', 'YingTanShi', '360600', '1');
INSERT INTO `jun_region` VALUES ('244', '18', '沈阳', 'ShenYangShi', '210100', '1');
INSERT INTO `jun_region` VALUES ('245', '18', '大连', 'DaLianShi', '210200', '1');
INSERT INTO `jun_region` VALUES ('246', '18', '鞍山', 'AnShanShi', '210300', '1');
INSERT INTO `jun_region` VALUES ('247', '18', '本溪', 'BenXiShi', '210500', '1');
INSERT INTO `jun_region` VALUES ('248', '18', '朝阳', 'ChaoYangShi', '211300', '1');
INSERT INTO `jun_region` VALUES ('249', '18', '丹东', 'DanDongShi', '210600', '1');
INSERT INTO `jun_region` VALUES ('250', '18', '抚顺', 'FuShunShi', '210400', '1');
INSERT INTO `jun_region` VALUES ('251', '18', '阜新', 'FuXinShi', '210900', '1');
INSERT INTO `jun_region` VALUES ('252', '18', '葫芦岛', 'HuLuDaoShi', '211400', '1');
INSERT INTO `jun_region` VALUES ('253', '18', '锦州', 'JinZhouShi', '210700', '1');
INSERT INTO `jun_region` VALUES ('254', '18', '辽阳', 'LiaoYangShi', '211000', '1');
INSERT INTO `jun_region` VALUES ('255', '18', '盘锦', 'PanJinShi', '211100', '1');
INSERT INTO `jun_region` VALUES ('256', '18', '铁岭', 'TieLingShi', '211200', '1');
INSERT INTO `jun_region` VALUES ('257', '18', '营口', 'YingKouShi', '210800', '1');
INSERT INTO `jun_region` VALUES ('258', '19', '呼和浩特', 'HuHeHaoTeShi', '150100', '1');
INSERT INTO `jun_region` VALUES ('259', '19', '阿拉善盟', 'ALaShanMeng', '152900', '1');
INSERT INTO `jun_region` VALUES ('260', '19', '巴彦淖尔市', '', '150800', '1');
INSERT INTO `jun_region` VALUES ('261', '19', '包头', 'BaoTouShi', '150200', '1');
INSERT INTO `jun_region` VALUES ('262', '19', '赤峰', 'ChiFengShi', '150400', '1');
INSERT INTO `jun_region` VALUES ('263', '19', '鄂尔多斯', 'EErDuoSiShi', '150600', '1');
INSERT INTO `jun_region` VALUES ('264', '19', '呼伦贝尔', 'HuLunBeiErShi', '150700', '1');
INSERT INTO `jun_region` VALUES ('265', '19', '通辽', 'TongLiaoShi', '150500', '1');
INSERT INTO `jun_region` VALUES ('266', '19', '乌海', 'WuHaiShi', '150300', '1');
INSERT INTO `jun_region` VALUES ('267', '19', '乌兰察布', '', '150900', '1');
INSERT INTO `jun_region` VALUES ('268', '19', '锡林郭勒盟', 'XiLinGuoLeMeng', '152500', '1');
INSERT INTO `jun_region` VALUES ('269', '19', '兴安盟', 'XingAnMeng', '152200', '1');
INSERT INTO `jun_region` VALUES ('270', '20', '银川', 'YinChuanShi', '640100', '1');
INSERT INTO `jun_region` VALUES ('271', '20', '固原', 'GuYuanShi', '640400', '1');
INSERT INTO `jun_region` VALUES ('272', '20', '石嘴山', 'ShiZuiShanShi', '640200', '1');
INSERT INTO `jun_region` VALUES ('273', '20', '吴忠', 'WuZhongShi', '640300', '1');
INSERT INTO `jun_region` VALUES ('274', '20', '中卫', 'ZhongWeiShi', '640500', '1');
INSERT INTO `jun_region` VALUES ('275', '21', '西宁', 'XiNingShi', '630100', '1');
INSERT INTO `jun_region` VALUES ('276', '21', '果洛', '', '632600', '1');
INSERT INTO `jun_region` VALUES ('277', '21', '海北', '', '632200', '1');
INSERT INTO `jun_region` VALUES ('278', '21', '海东', '', '630200', '1');
INSERT INTO `jun_region` VALUES ('279', '21', '海南', 'HaiNanZhou', '632500', '1');
INSERT INTO `jun_region` VALUES ('280', '21', '海西', '', '632800', '1');
INSERT INTO `jun_region` VALUES ('281', '21', '黄南', '', '632300', '1');
INSERT INTO `jun_region` VALUES ('282', '21', '玉树', '', '632700', '1');
INSERT INTO `jun_region` VALUES ('283', '22', '济南', 'JiNanShi', '370100', '1');
INSERT INTO `jun_region` VALUES ('284', '22', '青岛', 'QingDaoShi', '370200', '1');
INSERT INTO `jun_region` VALUES ('285', '22', '滨州', 'BinZhouShi', '371600', '1');
INSERT INTO `jun_region` VALUES ('286', '22', '德州', 'DeZhouShi', '371400', '1');
INSERT INTO `jun_region` VALUES ('287', '22', '东营', 'DongYingShi', '370500', '1');
INSERT INTO `jun_region` VALUES ('288', '22', '菏泽', 'HeZeShi', '371700', '1');
INSERT INTO `jun_region` VALUES ('289', '22', '济宁', 'JiNingShi', '370800', '1');
INSERT INTO `jun_region` VALUES ('290', '22', '莱芜', 'LaiWuShi', '371200', '1');
INSERT INTO `jun_region` VALUES ('291', '22', '聊城', 'LiaoChengShi', '371500', '1');
INSERT INTO `jun_region` VALUES ('292', '22', '临沂', 'LinYiShi', '371300', '1');
INSERT INTO `jun_region` VALUES ('293', '22', '日照', 'RiZhaoShi', '371100', '1');
INSERT INTO `jun_region` VALUES ('294', '22', '泰安', 'TaiAnShi', '370900', '1');
INSERT INTO `jun_region` VALUES ('295', '22', '威海', 'WeiHaiShi', '371000', '1');
INSERT INTO `jun_region` VALUES ('296', '22', '潍坊', 'WeiFangShi', '370700', '1');
INSERT INTO `jun_region` VALUES ('297', '22', '烟台', 'YanTaiShi', '370600', '1');
INSERT INTO `jun_region` VALUES ('298', '22', '枣庄', 'ZaoZhuangShi', '370400', '1');
INSERT INTO `jun_region` VALUES ('299', '22', '淄博', 'ZiBoShi', '370300', '1');
INSERT INTO `jun_region` VALUES ('300', '23', '太原', 'TaiYuanShi', '140100', '1');
INSERT INTO `jun_region` VALUES ('301', '23', '长治', 'ChangZhiShi', '140400', '1');
INSERT INTO `jun_region` VALUES ('302', '23', '大同', 'DaTongShi', '140200', '1');
INSERT INTO `jun_region` VALUES ('303', '23', '晋城', 'JinChengShi', '140500', '1');
INSERT INTO `jun_region` VALUES ('304', '23', '晋中', 'JinZhongShi', '140700', '1');
INSERT INTO `jun_region` VALUES ('305', '23', '临汾', 'LinFenShi', '141000', '1');
INSERT INTO `jun_region` VALUES ('306', '23', '吕梁', 'LvLiangShi', '141100', '1');
INSERT INTO `jun_region` VALUES ('307', '23', '朔州', 'ShuoZhouShi', '140600', '1');
INSERT INTO `jun_region` VALUES ('308', '23', '忻州', 'XinZhouShi', '140900', '1');
INSERT INTO `jun_region` VALUES ('309', '23', '阳泉', 'YangQuanShi', '140300', '1');
INSERT INTO `jun_region` VALUES ('310', '23', '运城', 'YunChengShi', '140800', '1');
INSERT INTO `jun_region` VALUES ('311', '24', '西安', 'XiAnShi', '610100', '1');
INSERT INTO `jun_region` VALUES ('312', '24', '安康', 'AnKangShi', '610900', '1');
INSERT INTO `jun_region` VALUES ('313', '24', '宝鸡', 'BaoJiShi', '610300', '1');
INSERT INTO `jun_region` VALUES ('314', '24', '汉中', 'HanZhongShi', '610700', '1');
INSERT INTO `jun_region` VALUES ('315', '24', '商洛', 'ShangLuoShi', '611000', '1');
INSERT INTO `jun_region` VALUES ('316', '24', '铜川', 'TongChuanShi', '610200', '1');
INSERT INTO `jun_region` VALUES ('317', '24', '渭南', 'WeiNanShi', '610500', '1');
INSERT INTO `jun_region` VALUES ('318', '24', '咸阳', 'XianYangShi', '610400', '1');
INSERT INTO `jun_region` VALUES ('319', '24', '延安', 'YanAnShi', '610600', '1');
INSERT INTO `jun_region` VALUES ('320', '24', '榆林', 'YuLinShi', '610800', '1');
INSERT INTO `jun_region` VALUES ('321', '25', '上海', '', '310100', '1');
INSERT INTO `jun_region` VALUES ('322', '26', '成都', 'ChengDuShi', '510100', '1');
INSERT INTO `jun_region` VALUES ('323', '26', '绵阳', 'MianYangShi', '510700', '1');
INSERT INTO `jun_region` VALUES ('324', '26', '阿坝', '', '513200', '1');
INSERT INTO `jun_region` VALUES ('325', '26', '巴中', 'BaZhongShi', '511900', '1');
INSERT INTO `jun_region` VALUES ('326', '26', '达州', 'DaZhouShi', '511700', '1');
INSERT INTO `jun_region` VALUES ('327', '26', '德阳', 'DeYangShi', '510600', '1');
INSERT INTO `jun_region` VALUES ('328', '26', '甘孜', '', '513300', '1');
INSERT INTO `jun_region` VALUES ('329', '26', '广安', 'GuangAnShi', '511600', '1');
INSERT INTO `jun_region` VALUES ('330', '26', '广元', 'GuangYuanShi', '510800', '1');
INSERT INTO `jun_region` VALUES ('331', '26', '乐山', 'LeShanShi', '511100', '1');
INSERT INTO `jun_region` VALUES ('332', '26', '凉山', '', '513400', '1');
INSERT INTO `jun_region` VALUES ('333', '26', '眉山', 'MeiShanShi', '511400', '1');
INSERT INTO `jun_region` VALUES ('334', '26', '南充', 'NanChongShi', '511300', '1');
INSERT INTO `jun_region` VALUES ('335', '26', '内江', 'NaJiangShi', '511000', '1');
INSERT INTO `jun_region` VALUES ('336', '26', '攀枝花', 'PanZhiHuaShi', '510400', '1');
INSERT INTO `jun_region` VALUES ('337', '26', '遂宁', 'SuiNingShi', '510900', '1');
INSERT INTO `jun_region` VALUES ('338', '26', '雅安', 'YaAnShi', '511800', '1');
INSERT INTO `jun_region` VALUES ('339', '26', '宜宾', 'YiBinShi', '511500', '1');
INSERT INTO `jun_region` VALUES ('340', '26', '资阳', 'ZiYangShi', '512000', '1');
INSERT INTO `jun_region` VALUES ('341', '26', '自贡', 'ZiGongShi', '510300', '1');
INSERT INTO `jun_region` VALUES ('342', '26', '泸州', 'LuZhouShi', '510500', '1');
INSERT INTO `jun_region` VALUES ('343', '27', '天津', '', '120100', '1');
INSERT INTO `jun_region` VALUES ('344', '28', '拉萨', 'LaSaShi', '540100', '1');
INSERT INTO `jun_region` VALUES ('345', '28', '阿里', '', '542500', '1');
INSERT INTO `jun_region` VALUES ('346', '28', '昌都', '', '542100', '1');
INSERT INTO `jun_region` VALUES ('347', '28', '林芝', '', '542600', '1');
INSERT INTO `jun_region` VALUES ('348', '28', '那曲', '', '542400', '1');
INSERT INTO `jun_region` VALUES ('349', '28', '日喀则', '', '542300', '1');
INSERT INTO `jun_region` VALUES ('350', '28', '山南', '', '542200', '1');
INSERT INTO `jun_region` VALUES ('351', '29', '乌鲁木齐', 'WuLuMuQiShi', '650100', '1');
INSERT INTO `jun_region` VALUES ('352', '29', '阿克苏', '', '652900', '1');
INSERT INTO `jun_region` VALUES ('354', '29', '巴音郭楞', '', '652800', '1');
INSERT INTO `jun_region` VALUES ('355', '29', '博尔塔拉', '', '652700', '1');
INSERT INTO `jun_region` VALUES ('356', '29', '昌吉', '', '652300', '1');
INSERT INTO `jun_region` VALUES ('357', '29', '哈密', '', '652200', '1');
INSERT INTO `jun_region` VALUES ('358', '29', '和田', '', '653200', '1');
INSERT INTO `jun_region` VALUES ('359', '29', '喀什', '', '653100', '1');
INSERT INTO `jun_region` VALUES ('360', '29', '克拉玛依', 'KeLaMaYiShi', '650200', '1');
INSERT INTO `jun_region` VALUES ('361', '29', '克孜勒苏', '', '653000', '1');
INSERT INTO `jun_region` VALUES ('362', '29', '石河子', 'ShiHeZiShi', '659001', '1');
INSERT INTO `jun_region` VALUES ('363', '29', '图木舒克', 'TuMuShuKeShi', '659003', '1');
INSERT INTO `jun_region` VALUES ('364', '29', '吐鲁番', '', '650400', '1');
INSERT INTO `jun_region` VALUES ('365', '29', '五家渠', 'WuJiaQuShi', '659004', '1');
INSERT INTO `jun_region` VALUES ('366', '29', '伊犁', '', '654000', '1');
INSERT INTO `jun_region` VALUES ('367', '30', '昆明', 'KunMingShi', '530100', '1');
INSERT INTO `jun_region` VALUES ('368', '30', '怒江', '', '533300', '1');
INSERT INTO `jun_region` VALUES ('369', '30', '普洱', 'PuErShi', '530800', '1');
INSERT INTO `jun_region` VALUES ('370', '30', '丽江', 'LiJiangShi', '530700', '1');
INSERT INTO `jun_region` VALUES ('371', '30', '保山', 'BaoShanShi', '530500', '1');
INSERT INTO `jun_region` VALUES ('372', '30', '楚雄', '', '532300', '1');
INSERT INTO `jun_region` VALUES ('373', '30', '大理', '', '532900', '1');
INSERT INTO `jun_region` VALUES ('374', '30', '德宏', '', '533100', '1');
INSERT INTO `jun_region` VALUES ('375', '30', '迪庆', '', '533400', '1');
INSERT INTO `jun_region` VALUES ('376', '30', '红河', '', '532500', '1');
INSERT INTO `jun_region` VALUES ('377', '30', '临沧', 'LinCangShi', '530900', '1');
INSERT INTO `jun_region` VALUES ('378', '30', '曲靖', 'QuJingShi', '530300', '1');
INSERT INTO `jun_region` VALUES ('379', '30', '文山', '', '532600', '1');
INSERT INTO `jun_region` VALUES ('380', '30', '西双版纳', 'XiShuangBanNaZhou', '532800', '1');
INSERT INTO `jun_region` VALUES ('381', '30', '玉溪', 'YuXiShi', '530400', '1');
INSERT INTO `jun_region` VALUES ('382', '30', '昭通', 'ZhaoTongShi', '530600', '1');
INSERT INTO `jun_region` VALUES ('383', '31', '杭州', 'HangZhouShi', '330100', '1');
INSERT INTO `jun_region` VALUES ('384', '31', '湖州', 'HuZhouShi', '330500', '1');
INSERT INTO `jun_region` VALUES ('385', '31', '嘉兴', 'JiaXingShi', '330400', '1');
INSERT INTO `jun_region` VALUES ('386', '31', '金华', 'JinHuaShi', '330700', '1');
INSERT INTO `jun_region` VALUES ('387', '31', '丽水', 'LiShuiShi', '331100', '1');
INSERT INTO `jun_region` VALUES ('388', '31', '宁波', 'NingBoShi', '330200', '1');
INSERT INTO `jun_region` VALUES ('389', '31', '绍兴', 'ShaoXingShi', '330600', '1');
INSERT INTO `jun_region` VALUES ('390', '31', '台州', 'TaiZhouShi', '331000', '1');
INSERT INTO `jun_region` VALUES ('391', '31', '温州', 'WenZhouShi', '330300', '1');
INSERT INTO `jun_region` VALUES ('392', '31', '舟山', 'ZhouShanShi', '330900', '1');
INSERT INTO `jun_region` VALUES ('393', '31', '衢州', 'QuZhouShi', '330800', '1');
INSERT INTO `jun_region` VALUES ('394', '32', '重庆', '', '2147483647', '1');
INSERT INTO `jun_region` VALUES ('395', '138', '长安区', '', '130102', '1');
INSERT INTO `jun_region` VALUES ('396', '138', '桥西区', '', '130104', '1');
INSERT INTO `jun_region` VALUES ('397', '138', '新华区', '', '130105', '1');
INSERT INTO `jun_region` VALUES ('398', '138', '井陉矿区', '', '130107', '1');
INSERT INTO `jun_region` VALUES ('399', '138', '裕华区', '', '130108', '1');
INSERT INTO `jun_region` VALUES ('400', '138', '井陉县', '', '130121', '1');
INSERT INTO `jun_region` VALUES ('401', '138', '正定县', '', '130123', '1');
INSERT INTO `jun_region` VALUES ('402', '138', '栾城区', '', '130111', '1');
INSERT INTO `jun_region` VALUES ('403', '138', '行唐县', '', '130125', '1');
INSERT INTO `jun_region` VALUES ('404', '138', '灵寿县', '', '130126', '1');
INSERT INTO `jun_region` VALUES ('405', '138', '高邑县', '', '130127', '1');
INSERT INTO `jun_region` VALUES ('406', '138', '深泽县', '', '130128', '1');
INSERT INTO `jun_region` VALUES ('407', '138', '赞皇县', '', '130129', '1');
INSERT INTO `jun_region` VALUES ('408', '138', '无极县', '', '130130', '1');
INSERT INTO `jun_region` VALUES ('409', '138', '平山县', '', '130131', '1');
INSERT INTO `jun_region` VALUES ('410', '138', '元氏县', '', '130132', '1');
INSERT INTO `jun_region` VALUES ('411', '138', '赵县', '', '130133', '1');
INSERT INTO `jun_region` VALUES ('412', '138', '藁城区', '', '130109', '1');
INSERT INTO `jun_region` VALUES ('413', '138', '晋州市', '', '130183', '1');
INSERT INTO `jun_region` VALUES ('414', '138', '新乐市', '', '130184', '1');
INSERT INTO `jun_region` VALUES ('415', '138', '鹿泉区', '', '130110', '1');
INSERT INTO `jun_region` VALUES ('416', '146', '路南区', '', '130202', '1');
INSERT INTO `jun_region` VALUES ('417', '146', '路北区', '', '130203', '1');
INSERT INTO `jun_region` VALUES ('418', '146', '古冶区', '', '130204', '1');
INSERT INTO `jun_region` VALUES ('419', '146', '开平区', '', '130205', '1');
INSERT INTO `jun_region` VALUES ('420', '146', '丰南区', '', '130207', '1');
INSERT INTO `jun_region` VALUES ('421', '146', '丰润区', '', '130208', '1');
INSERT INTO `jun_region` VALUES ('422', '146', '滦县', '', '130223', '1');
INSERT INTO `jun_region` VALUES ('423', '146', '滦南县', '', '130224', '1');
INSERT INTO `jun_region` VALUES ('424', '146', '乐亭县', '', '130225', '1');
INSERT INTO `jun_region` VALUES ('425', '146', '迁西县', '', '130227', '1');
INSERT INTO `jun_region` VALUES ('426', '146', '玉田县', '', '130229', '1');
INSERT INTO `jun_region` VALUES ('427', '146', '遵化市', '', '130281', '1');
INSERT INTO `jun_region` VALUES ('428', '146', '迁安市', '', '130283', '1');
INSERT INTO `jun_region` VALUES ('429', '145', '海港区', '', '130302', '1');
INSERT INTO `jun_region` VALUES ('430', '145', '山海关区', '', '130303', '1');
INSERT INTO `jun_region` VALUES ('431', '145', '北戴河区', '', '130304', '1');
INSERT INTO `jun_region` VALUES ('432', '145', '青龙满族自治县', '', '130321', '1');
INSERT INTO `jun_region` VALUES ('433', '145', '昌黎县', '', '130322', '1');
INSERT INTO `jun_region` VALUES ('434', '145', '抚宁区', '', '130306', '1');
INSERT INTO `jun_region` VALUES ('435', '145', '卢龙县', '', '130324', '1');
INSERT INTO `jun_region` VALUES ('436', '142', '邯山区', '', '130402', '1');
INSERT INTO `jun_region` VALUES ('437', '142', '丛台区', '', '130403', '1');
INSERT INTO `jun_region` VALUES ('438', '142', '复兴区', '', '130404', '1');
INSERT INTO `jun_region` VALUES ('439', '142', '峰峰矿区', '', '130406', '1');
INSERT INTO `jun_region` VALUES ('440', '142', '邯郸县', '', '130421', '1');
INSERT INTO `jun_region` VALUES ('441', '142', '临漳县', '', '130423', '1');
INSERT INTO `jun_region` VALUES ('442', '142', '成安县', '', '130424', '1');
INSERT INTO `jun_region` VALUES ('443', '142', '大名县', '', '130425', '1');
INSERT INTO `jun_region` VALUES ('444', '142', '涉县', '', '130426', '1');
INSERT INTO `jun_region` VALUES ('445', '142', '磁县', '', '130427', '1');
INSERT INTO `jun_region` VALUES ('446', '142', '肥乡县', '', '130428', '1');
INSERT INTO `jun_region` VALUES ('447', '142', '永年县', '', '130429', '1');
INSERT INTO `jun_region` VALUES ('448', '142', '邱县', '', '130430', '1');
INSERT INTO `jun_region` VALUES ('449', '142', '鸡泽县', '', '130431', '1');
INSERT INTO `jun_region` VALUES ('450', '142', '广平县', '', '130432', '1');
INSERT INTO `jun_region` VALUES ('451', '142', '馆陶县', '', '130433', '1');
INSERT INTO `jun_region` VALUES ('452', '142', '魏县', '', '130434', '1');
INSERT INTO `jun_region` VALUES ('453', '142', '曲周县', '', '130435', '1');
INSERT INTO `jun_region` VALUES ('454', '142', '武安市', '', '130481', '1');
INSERT INTO `jun_region` VALUES ('455', '147', '桥东区', '', '130502', '1');
INSERT INTO `jun_region` VALUES ('456', '147', '桥西区', '', '130503', '1');
INSERT INTO `jun_region` VALUES ('457', '147', '邢台县', '', '130521', '1');
INSERT INTO `jun_region` VALUES ('458', '147', '临城县', '', '130522', '1');
INSERT INTO `jun_region` VALUES ('459', '147', '内丘县', '', '130523', '1');
INSERT INTO `jun_region` VALUES ('460', '147', '柏乡县', '', '130524', '1');
INSERT INTO `jun_region` VALUES ('461', '147', '隆尧县', '', '130525', '1');
INSERT INTO `jun_region` VALUES ('462', '147', '任县', '', '130526', '1');
INSERT INTO `jun_region` VALUES ('463', '147', '南和县', '', '130527', '1');
INSERT INTO `jun_region` VALUES ('464', '147', '宁晋县', '', '130528', '1');
INSERT INTO `jun_region` VALUES ('465', '147', '巨鹿县', '', '130529', '1');
INSERT INTO `jun_region` VALUES ('466', '147', '新河县', '', '130530', '1');
INSERT INTO `jun_region` VALUES ('467', '147', '广宗县', '', '130531', '1');
INSERT INTO `jun_region` VALUES ('468', '147', '平乡县', '', '130532', '1');
INSERT INTO `jun_region` VALUES ('469', '147', '威县', '', '130533', '1');
INSERT INTO `jun_region` VALUES ('470', '147', '清河县', '', '130534', '1');
INSERT INTO `jun_region` VALUES ('471', '147', '临西县', '', '130535', '1');
INSERT INTO `jun_region` VALUES ('472', '147', '南宫市', '', '130581', '1');
INSERT INTO `jun_region` VALUES ('473', '147', '沙河市', '', '130582', '1');
INSERT INTO `jun_region` VALUES ('474', '139', '满城区', '', '130607', '1');
INSERT INTO `jun_region` VALUES ('475', '139', '清苑区', '', '130608', '1');
INSERT INTO `jun_region` VALUES ('476', '139', '涞水县', '', '130623', '1');
INSERT INTO `jun_region` VALUES ('477', '139', '阜平县', '', '130624', '1');
INSERT INTO `jun_region` VALUES ('478', '139', '徐水区', '', '130609', '1');
INSERT INTO `jun_region` VALUES ('479', '139', '定兴县', '', '130626', '1');
INSERT INTO `jun_region` VALUES ('480', '139', '唐县', '', '130627', '1');
INSERT INTO `jun_region` VALUES ('481', '139', '高阳县', '', '130628', '1');
INSERT INTO `jun_region` VALUES ('482', '139', '容城县', '', '130629', '1');
INSERT INTO `jun_region` VALUES ('483', '139', '涞源县', '', '130630', '1');
INSERT INTO `jun_region` VALUES ('484', '139', '望都县', '', '130631', '1');
INSERT INTO `jun_region` VALUES ('485', '139', '安新县', '', '130632', '1');
INSERT INTO `jun_region` VALUES ('486', '139', '易县', '', '130633', '1');
INSERT INTO `jun_region` VALUES ('487', '139', '曲阳县', '', '130634', '1');
INSERT INTO `jun_region` VALUES ('488', '139', '蠡县', '', '130635', '1');
INSERT INTO `jun_region` VALUES ('489', '139', '顺平县', '', '130636', '1');
INSERT INTO `jun_region` VALUES ('490', '139', '博野县', '', '130637', '1');
INSERT INTO `jun_region` VALUES ('491', '139', '雄县', '', '130638', '1');
INSERT INTO `jun_region` VALUES ('492', '139', '涿州市', '', '130681', '1');
INSERT INTO `jun_region` VALUES ('493', '139', '安国市', '', '130683', '1');
INSERT INTO `jun_region` VALUES ('494', '139', '高碑店市', '', '130684', '1');
INSERT INTO `jun_region` VALUES ('495', '148', '桥东区', '', '130702', '1');
INSERT INTO `jun_region` VALUES ('496', '148', '桥西区', '', '130703', '1');
INSERT INTO `jun_region` VALUES ('497', '148', '宣化区', '', '130705', '1');
INSERT INTO `jun_region` VALUES ('498', '148', '下花园区', '', '130706', '1');
INSERT INTO `jun_region` VALUES ('499', '148', '宣化县', '', '130721', '1');
INSERT INTO `jun_region` VALUES ('500', '148', '张北县', '', '130722', '1');
INSERT INTO `jun_region` VALUES ('501', '148', '康保县', '', '130723', '1');
INSERT INTO `jun_region` VALUES ('502', '148', '沽源县', '', '130724', '1');
INSERT INTO `jun_region` VALUES ('503', '148', '尚义县', '', '130725', '1');
INSERT INTO `jun_region` VALUES ('504', '148', '蔚县', '', '130726', '1');
INSERT INTO `jun_region` VALUES ('505', '148', '阳原县', '', '130727', '1');
INSERT INTO `jun_region` VALUES ('506', '148', '怀安县', '', '130728', '1');
INSERT INTO `jun_region` VALUES ('507', '148', '万全县', '', '130729', '1');
INSERT INTO `jun_region` VALUES ('508', '148', '怀来县', '', '130730', '1');
INSERT INTO `jun_region` VALUES ('509', '148', '涿鹿县', '', '130731', '1');
INSERT INTO `jun_region` VALUES ('510', '148', '赤城县', '', '130732', '1');
INSERT INTO `jun_region` VALUES ('511', '148', '崇礼县', '', '130733', '1');
INSERT INTO `jun_region` VALUES ('512', '141', '双桥区', '', '130802', '1');
INSERT INTO `jun_region` VALUES ('513', '141', '双滦区', '', '130803', '1');
INSERT INTO `jun_region` VALUES ('514', '141', '鹰手营子矿区', '', '130804', '1');
INSERT INTO `jun_region` VALUES ('515', '141', '承德县', '', '130821', '1');
INSERT INTO `jun_region` VALUES ('516', '141', '兴隆县', '', '130822', '1');
INSERT INTO `jun_region` VALUES ('517', '141', '平泉县', '', '130823', '1');
INSERT INTO `jun_region` VALUES ('518', '141', '滦平县', '', '130824', '1');
INSERT INTO `jun_region` VALUES ('519', '141', '隆化县', '', '130825', '1');
INSERT INTO `jun_region` VALUES ('520', '141', '丰宁满族自治县', '', '130826', '1');
INSERT INTO `jun_region` VALUES ('521', '141', '宽城满族自治县', '', '130827', '1');
INSERT INTO `jun_region` VALUES ('522', '141', '围场满族蒙古族自治县', '', '130828', '1');
INSERT INTO `jun_region` VALUES ('523', '140', '新华区', '', '130902', '1');
INSERT INTO `jun_region` VALUES ('524', '140', '运河区', '', '130903', '1');
INSERT INTO `jun_region` VALUES ('525', '140', '沧县', '', '130921', '1');
INSERT INTO `jun_region` VALUES ('526', '140', '青县', '', '130922', '1');
INSERT INTO `jun_region` VALUES ('527', '140', '东光县', '', '130923', '1');
INSERT INTO `jun_region` VALUES ('528', '140', '海兴县', '', '130924', '1');
INSERT INTO `jun_region` VALUES ('529', '140', '盐山县', '', '130925', '1');
INSERT INTO `jun_region` VALUES ('530', '140', '肃宁县', '', '130926', '1');
INSERT INTO `jun_region` VALUES ('531', '140', '南皮县', '', '130927', '1');
INSERT INTO `jun_region` VALUES ('532', '140', '吴桥县', '', '130928', '1');
INSERT INTO `jun_region` VALUES ('533', '140', '献县', '', '130929', '1');
INSERT INTO `jun_region` VALUES ('534', '140', '孟村回族自治县', '', '130930', '1');
INSERT INTO `jun_region` VALUES ('535', '140', '泊头市', '', '130981', '1');
INSERT INTO `jun_region` VALUES ('536', '140', '任丘市', '', '130982', '1');
INSERT INTO `jun_region` VALUES ('537', '140', '黄骅市', '', '130983', '1');
INSERT INTO `jun_region` VALUES ('538', '140', '河间市', '', '130984', '1');
INSERT INTO `jun_region` VALUES ('539', '144', '安次区', '', '131002', '1');
INSERT INTO `jun_region` VALUES ('540', '144', '广阳区', '', '131003', '1');
INSERT INTO `jun_region` VALUES ('541', '144', '固安县', '', '131022', '1');
INSERT INTO `jun_region` VALUES ('542', '144', '永清县', '', '131023', '1');
INSERT INTO `jun_region` VALUES ('543', '144', '香河县', '', '131024', '1');
INSERT INTO `jun_region` VALUES ('544', '144', '大城县', '', '131025', '1');
INSERT INTO `jun_region` VALUES ('545', '144', '文安县', '', '131026', '1');
INSERT INTO `jun_region` VALUES ('546', '144', '大厂回族自治县', '', '131028', '1');
INSERT INTO `jun_region` VALUES ('547', '144', '霸州市', '', '131081', '1');
INSERT INTO `jun_region` VALUES ('548', '144', '三河市', '', '131082', '1');
INSERT INTO `jun_region` VALUES ('549', '143', '桃城区', '', '131102', '1');
INSERT INTO `jun_region` VALUES ('550', '143', '枣强县', '', '131121', '1');
INSERT INTO `jun_region` VALUES ('551', '143', '武邑县', '', '131122', '1');
INSERT INTO `jun_region` VALUES ('552', '143', '武强县', '', '131123', '1');
INSERT INTO `jun_region` VALUES ('553', '143', '饶阳县', '', '131124', '1');
INSERT INTO `jun_region` VALUES ('554', '143', '安平县', '', '131125', '1');
INSERT INTO `jun_region` VALUES ('555', '143', '故城县', '', '131126', '1');
INSERT INTO `jun_region` VALUES ('556', '143', '景县', '', '131127', '1');
INSERT INTO `jun_region` VALUES ('557', '143', '阜城县', '', '131128', '1');
INSERT INTO `jun_region` VALUES ('558', '143', '冀州市', '', '131181', '1');
INSERT INTO `jun_region` VALUES ('559', '143', '深州市', '', '131182', '1');
INSERT INTO `jun_region` VALUES ('560', '300', '小店区', '', '140105', '1');
INSERT INTO `jun_region` VALUES ('561', '300', '迎泽区', '', '140106', '1');
INSERT INTO `jun_region` VALUES ('562', '300', '杏花岭区', '', '140107', '1');
INSERT INTO `jun_region` VALUES ('563', '300', '尖草坪区', '', '140108', '1');
INSERT INTO `jun_region` VALUES ('564', '300', '万柏林区', '', '140109', '1');
INSERT INTO `jun_region` VALUES ('565', '300', '晋源区', '', '140110', '1');
INSERT INTO `jun_region` VALUES ('566', '300', '清徐县', '', '140121', '1');
INSERT INTO `jun_region` VALUES ('567', '300', '阳曲县', '', '140122', '1');
INSERT INTO `jun_region` VALUES ('568', '300', '娄烦县', '', '140123', '1');
INSERT INTO `jun_region` VALUES ('569', '300', '古交市', '', '140181', '1');
INSERT INTO `jun_region` VALUES ('570', '302', '城区', '', '140202', '1');
INSERT INTO `jun_region` VALUES ('571', '302', '矿区', '', '140203', '1');
INSERT INTO `jun_region` VALUES ('572', '302', '南郊区', '', '140211', '1');
INSERT INTO `jun_region` VALUES ('573', '302', '新荣区', '', '140212', '1');
INSERT INTO `jun_region` VALUES ('574', '302', '阳高县', '', '140221', '1');
INSERT INTO `jun_region` VALUES ('575', '302', '天镇县', '', '140222', '1');
INSERT INTO `jun_region` VALUES ('576', '302', '广灵县', '', '140223', '1');
INSERT INTO `jun_region` VALUES ('577', '302', '灵丘县', '', '140224', '1');
INSERT INTO `jun_region` VALUES ('578', '302', '浑源县', '', '140225', '1');
INSERT INTO `jun_region` VALUES ('579', '302', '左云县', '', '140226', '1');
INSERT INTO `jun_region` VALUES ('580', '302', '大同县', '', '140227', '1');
INSERT INTO `jun_region` VALUES ('581', '309', '城区', '', '140302', '1');
INSERT INTO `jun_region` VALUES ('582', '309', '矿区', '', '140303', '1');
INSERT INTO `jun_region` VALUES ('583', '309', '郊区', '', '140311', '1');
INSERT INTO `jun_region` VALUES ('584', '309', '平定县', '', '140321', '1');
INSERT INTO `jun_region` VALUES ('585', '309', '盂县', '', '140322', '1');
INSERT INTO `jun_region` VALUES ('586', '301', '城区', '', '140402', '1');
INSERT INTO `jun_region` VALUES ('587', '301', '郊区', '', '140411', '1');
INSERT INTO `jun_region` VALUES ('588', '301', '长治县', '', '140421', '1');
INSERT INTO `jun_region` VALUES ('589', '301', '襄垣县', '', '140423', '1');
INSERT INTO `jun_region` VALUES ('590', '301', '屯留县', '', '140424', '1');
INSERT INTO `jun_region` VALUES ('591', '301', '平顺县', '', '140425', '1');
INSERT INTO `jun_region` VALUES ('592', '301', '黎城县', '', '140426', '1');
INSERT INTO `jun_region` VALUES ('593', '301', '壶关县', '', '140427', '1');
INSERT INTO `jun_region` VALUES ('594', '301', '长子县', '', '140428', '1');
INSERT INTO `jun_region` VALUES ('595', '301', '武乡县', '', '140429', '1');
INSERT INTO `jun_region` VALUES ('596', '301', '沁县', '', '140430', '1');
INSERT INTO `jun_region` VALUES ('597', '301', '沁源县', '', '140431', '1');
INSERT INTO `jun_region` VALUES ('598', '301', '潞城市', '', '140481', '1');
INSERT INTO `jun_region` VALUES ('599', '303', '城区', '', '140502', '1');
INSERT INTO `jun_region` VALUES ('600', '303', '沁水县', '', '140521', '1');
INSERT INTO `jun_region` VALUES ('601', '303', '阳城县', '', '140522', '1');
INSERT INTO `jun_region` VALUES ('602', '303', '陵川县', '', '140524', '1');
INSERT INTO `jun_region` VALUES ('603', '303', '泽州县', '', '140525', '1');
INSERT INTO `jun_region` VALUES ('604', '303', '高平市', '', '140581', '1');
INSERT INTO `jun_region` VALUES ('605', '307', '朔城区', '', '140602', '1');
INSERT INTO `jun_region` VALUES ('606', '307', '平鲁区', '', '140603', '1');
INSERT INTO `jun_region` VALUES ('607', '307', '山阴县', '', '140621', '1');
INSERT INTO `jun_region` VALUES ('608', '307', '应县', '', '140622', '1');
INSERT INTO `jun_region` VALUES ('609', '307', '右玉县', '', '140623', '1');
INSERT INTO `jun_region` VALUES ('610', '307', '怀仁县', '', '140624', '1');
INSERT INTO `jun_region` VALUES ('611', '304', '榆次区', '', '140702', '1');
INSERT INTO `jun_region` VALUES ('612', '304', '榆社县', '', '140721', '1');
INSERT INTO `jun_region` VALUES ('613', '304', '左权县', '', '140722', '1');
INSERT INTO `jun_region` VALUES ('614', '304', '和顺县', '', '140723', '1');
INSERT INTO `jun_region` VALUES ('615', '304', '昔阳县', '', '140724', '1');
INSERT INTO `jun_region` VALUES ('616', '304', '寿阳县', '', '140725', '1');
INSERT INTO `jun_region` VALUES ('617', '304', '太谷县', '', '140726', '1');
INSERT INTO `jun_region` VALUES ('618', '304', '祁县', '', '140727', '1');
INSERT INTO `jun_region` VALUES ('619', '304', '平遥县', '', '140728', '1');
INSERT INTO `jun_region` VALUES ('620', '304', '灵石县', '', '140729', '1');
INSERT INTO `jun_region` VALUES ('621', '304', '介休市', '', '140781', '1');
INSERT INTO `jun_region` VALUES ('622', '310', '盐湖区', '', '140802', '1');
INSERT INTO `jun_region` VALUES ('623', '310', '临猗县', '', '140821', '1');
INSERT INTO `jun_region` VALUES ('624', '310', '万荣县', '', '140822', '1');
INSERT INTO `jun_region` VALUES ('625', '310', '闻喜县', '', '140823', '1');
INSERT INTO `jun_region` VALUES ('626', '310', '稷山县', '', '140824', '1');
INSERT INTO `jun_region` VALUES ('627', '310', '新绛县', '', '140825', '1');
INSERT INTO `jun_region` VALUES ('628', '310', '绛县', '', '140826', '1');
INSERT INTO `jun_region` VALUES ('629', '310', '垣曲县', '', '140827', '1');
INSERT INTO `jun_region` VALUES ('630', '310', '夏县', '', '140828', '1');
INSERT INTO `jun_region` VALUES ('631', '310', '平陆县', '', '140829', '1');
INSERT INTO `jun_region` VALUES ('632', '310', '芮城县', '', '140830', '1');
INSERT INTO `jun_region` VALUES ('633', '310', '永济市', '', '140881', '1');
INSERT INTO `jun_region` VALUES ('634', '310', '河津市', '', '140882', '1');
INSERT INTO `jun_region` VALUES ('635', '308', '忻府区', '', '140902', '1');
INSERT INTO `jun_region` VALUES ('636', '308', '定襄县', '', '140921', '1');
INSERT INTO `jun_region` VALUES ('637', '308', '五台县', '', '140922', '1');
INSERT INTO `jun_region` VALUES ('638', '308', '代县', '', '140923', '1');
INSERT INTO `jun_region` VALUES ('639', '308', '繁峙县', '', '140924', '1');
INSERT INTO `jun_region` VALUES ('640', '308', '宁武县', '', '140925', '1');
INSERT INTO `jun_region` VALUES ('641', '308', '静乐县', '', '140926', '1');
INSERT INTO `jun_region` VALUES ('642', '308', '神池县', '', '140927', '1');
INSERT INTO `jun_region` VALUES ('643', '308', '五寨县', '', '140928', '1');
INSERT INTO `jun_region` VALUES ('644', '308', '岢岚县', '', '140929', '1');
INSERT INTO `jun_region` VALUES ('645', '308', '河曲县', '', '140930', '1');
INSERT INTO `jun_region` VALUES ('646', '308', '保德县', '', '140931', '1');
INSERT INTO `jun_region` VALUES ('647', '308', '偏关县', '', '140932', '1');
INSERT INTO `jun_region` VALUES ('648', '308', '原平市', '', '140981', '1');
INSERT INTO `jun_region` VALUES ('649', '305', '尧都区', '', '141002', '1');
INSERT INTO `jun_region` VALUES ('650', '305', '曲沃县', '', '141021', '1');
INSERT INTO `jun_region` VALUES ('651', '305', '翼城县', '', '141022', '1');
INSERT INTO `jun_region` VALUES ('652', '305', '襄汾县', '', '141023', '1');
INSERT INTO `jun_region` VALUES ('653', '305', '洪洞县', '', '141024', '1');
INSERT INTO `jun_region` VALUES ('654', '305', '古县', '', '141025', '1');
INSERT INTO `jun_region` VALUES ('655', '305', '安泽县', '', '141026', '1');
INSERT INTO `jun_region` VALUES ('656', '305', '浮山县', '', '141027', '1');
INSERT INTO `jun_region` VALUES ('657', '305', '吉县', '', '141028', '1');
INSERT INTO `jun_region` VALUES ('658', '305', '乡宁县', '', '141029', '1');
INSERT INTO `jun_region` VALUES ('659', '305', '大宁县', '', '141030', '1');
INSERT INTO `jun_region` VALUES ('660', '305', '隰县', '', '141031', '1');
INSERT INTO `jun_region` VALUES ('661', '305', '永和县', '', '141032', '1');
INSERT INTO `jun_region` VALUES ('662', '305', '蒲县', '', '141033', '1');
INSERT INTO `jun_region` VALUES ('663', '305', '汾西县', '', '141034', '1');
INSERT INTO `jun_region` VALUES ('664', '305', '侯马市', '', '141081', '1');
INSERT INTO `jun_region` VALUES ('665', '305', '霍州市', '', '141082', '1');
INSERT INTO `jun_region` VALUES ('666', '306', '离石区', '', '141102', '1');
INSERT INTO `jun_region` VALUES ('667', '306', '文水县', '', '141121', '1');
INSERT INTO `jun_region` VALUES ('668', '306', '交城县', '', '141122', '1');
INSERT INTO `jun_region` VALUES ('669', '306', '兴县', '', '141123', '1');
INSERT INTO `jun_region` VALUES ('670', '306', '临县', '', '141124', '1');
INSERT INTO `jun_region` VALUES ('671', '306', '柳林县', '', '141125', '1');
INSERT INTO `jun_region` VALUES ('672', '306', '石楼县', '', '141126', '1');
INSERT INTO `jun_region` VALUES ('673', '306', '岚县', '', '141127', '1');
INSERT INTO `jun_region` VALUES ('674', '306', '方山县', '', '141128', '1');
INSERT INTO `jun_region` VALUES ('675', '306', '中阳县', '', '141129', '1');
INSERT INTO `jun_region` VALUES ('676', '306', '交口县', '', '141130', '1');
INSERT INTO `jun_region` VALUES ('677', '306', '孝义市', '', '141181', '1');
INSERT INTO `jun_region` VALUES ('678', '306', '汾阳市', '', '141182', '1');
INSERT INTO `jun_region` VALUES ('679', '258', '新城区', '', '150102', '1');
INSERT INTO `jun_region` VALUES ('680', '258', '回民区', '', '150103', '1');
INSERT INTO `jun_region` VALUES ('681', '258', '玉泉区', '', '150104', '1');
INSERT INTO `jun_region` VALUES ('682', '258', '赛罕区', '', '150105', '1');
INSERT INTO `jun_region` VALUES ('683', '258', '土默特左旗', '', '150121', '1');
INSERT INTO `jun_region` VALUES ('684', '258', '托克托县', '', '150122', '1');
INSERT INTO `jun_region` VALUES ('685', '258', '和林格尔县', '', '150123', '1');
INSERT INTO `jun_region` VALUES ('686', '258', '清水河县', '', '150124', '1');
INSERT INTO `jun_region` VALUES ('687', '258', '武川县', '', '150125', '1');
INSERT INTO `jun_region` VALUES ('688', '261', '东河区', '', '150202', '1');
INSERT INTO `jun_region` VALUES ('689', '261', '昆都仑区', '', '150203', '1');
INSERT INTO `jun_region` VALUES ('690', '261', '青山区', '', '150204', '1');
INSERT INTO `jun_region` VALUES ('691', '261', '石拐区', '', '150205', '1');
INSERT INTO `jun_region` VALUES ('692', '261', '白云鄂博矿区', '', '150206', '1');
INSERT INTO `jun_region` VALUES ('693', '261', '九原区', '', '150207', '1');
INSERT INTO `jun_region` VALUES ('694', '261', '土默特右旗', '', '150221', '1');
INSERT INTO `jun_region` VALUES ('695', '261', '固阳县', '', '150222', '1');
INSERT INTO `jun_region` VALUES ('696', '261', '达尔罕茂明安联合旗', '', '150223', '1');
INSERT INTO `jun_region` VALUES ('697', '266', '海勃湾区', '', '150302', '1');
INSERT INTO `jun_region` VALUES ('698', '266', '海南区', '', '150303', '1');
INSERT INTO `jun_region` VALUES ('699', '266', '乌达区', '', '150304', '1');
INSERT INTO `jun_region` VALUES ('700', '262', '红山区', '', '150402', '1');
INSERT INTO `jun_region` VALUES ('701', '262', '元宝山区', '', '150403', '1');
INSERT INTO `jun_region` VALUES ('702', '262', '松山区', '', '150404', '1');
INSERT INTO `jun_region` VALUES ('703', '262', '阿鲁科尔沁旗', '', '150421', '1');
INSERT INTO `jun_region` VALUES ('704', '262', '巴林左旗', '', '150423', '1');
INSERT INTO `jun_region` VALUES ('705', '262', '巴林右旗', '', '150423', '1');
INSERT INTO `jun_region` VALUES ('706', '262', '林西县', '', '150424', '1');
INSERT INTO `jun_region` VALUES ('707', '262', '克什克腾旗', '', '150425', '1');
INSERT INTO `jun_region` VALUES ('708', '262', '翁牛特旗', '', '150426', '1');
INSERT INTO `jun_region` VALUES ('709', '262', '喀喇沁旗', '', '150428', '1');
INSERT INTO `jun_region` VALUES ('710', '262', '宁城县', '', '150429', '1');
INSERT INTO `jun_region` VALUES ('711', '262', '敖汉旗', '', '150430', '1');
INSERT INTO `jun_region` VALUES ('712', '265', '科尔沁区', '', '150502', '1');
INSERT INTO `jun_region` VALUES ('713', '265', '科尔沁左翼中旗', '', '150521', '1');
INSERT INTO `jun_region` VALUES ('714', '265', '科尔沁左翼后旗', '', '150522', '1');
INSERT INTO `jun_region` VALUES ('715', '265', '开鲁县', '', '150523', '1');
INSERT INTO `jun_region` VALUES ('716', '265', '库伦旗', '', '150524', '1');
INSERT INTO `jun_region` VALUES ('717', '265', '奈曼旗', '', '150525', '1');
INSERT INTO `jun_region` VALUES ('718', '265', '扎鲁特旗', '', '150526', '1');
INSERT INTO `jun_region` VALUES ('719', '265', '霍林郭勒市', '', '150581', '1');
INSERT INTO `jun_region` VALUES ('720', '263', '东胜区', '', '150602', '1');
INSERT INTO `jun_region` VALUES ('721', '263', '达拉特旗', '', '150621', '1');
INSERT INTO `jun_region` VALUES ('722', '263', '准格尔旗', '', '150622', '1');
INSERT INTO `jun_region` VALUES ('723', '263', '鄂托克前旗', '', '150623', '1');
INSERT INTO `jun_region` VALUES ('724', '263', '鄂托克旗', '', '150624', '1');
INSERT INTO `jun_region` VALUES ('725', '263', '杭锦旗', '', '150625', '1');
INSERT INTO `jun_region` VALUES ('726', '263', '乌审旗', '', '150626', '1');
INSERT INTO `jun_region` VALUES ('727', '263', '伊金霍洛旗', '', '150627', '1');
INSERT INTO `jun_region` VALUES ('728', '264', '海拉尔区', '', '150702', '1');
INSERT INTO `jun_region` VALUES ('729', '264', '阿荣旗', '', '150721', '1');
INSERT INTO `jun_region` VALUES ('730', '264', '莫力达瓦达斡尔族自治旗', '', '150722', '1');
INSERT INTO `jun_region` VALUES ('731', '264', '鄂伦春自治旗', '', '150723', '1');
INSERT INTO `jun_region` VALUES ('732', '264', '鄂温克族自治旗', '', '150724', '1');
INSERT INTO `jun_region` VALUES ('733', '264', '陈巴尔虎旗', '', '150725', '1');
INSERT INTO `jun_region` VALUES ('734', '264', '新巴尔虎左旗', '', '150726', '1');
INSERT INTO `jun_region` VALUES ('735', '264', '新巴尔虎右旗', '', '150727', '1');
INSERT INTO `jun_region` VALUES ('736', '264', '满洲里市', '', '150781', '1');
INSERT INTO `jun_region` VALUES ('737', '264', '牙克石市', '', '150782', '1');
INSERT INTO `jun_region` VALUES ('738', '264', '扎兰屯市', '', '150783', '1');
INSERT INTO `jun_region` VALUES ('739', '264', '额尔古纳市', '', '150784', '1');
INSERT INTO `jun_region` VALUES ('740', '264', '根河市', '', '150785', '1');
INSERT INTO `jun_region` VALUES ('741', '244', '和平区', '', '210102', '1');
INSERT INTO `jun_region` VALUES ('742', '244', '沈河区', '', '210103', '1');
INSERT INTO `jun_region` VALUES ('743', '244', '大东区', '', '210104', '1');
INSERT INTO `jun_region` VALUES ('744', '244', '皇姑区', '', '210105', '1');
INSERT INTO `jun_region` VALUES ('745', '244', '铁西区', '', '210106', '1');
INSERT INTO `jun_region` VALUES ('746', '244', '苏家屯区', '', '210111', '1');
INSERT INTO `jun_region` VALUES ('747', '244', '浑南区', '', '210112', '1');
INSERT INTO `jun_region` VALUES ('748', '244', '沈北新区', '', '210113', '1');
INSERT INTO `jun_region` VALUES ('749', '244', '于洪区', '', '210114', '1');
INSERT INTO `jun_region` VALUES ('750', '244', '辽中县', '', '210122', '1');
INSERT INTO `jun_region` VALUES ('751', '244', '康平县', '', '210123', '1');
INSERT INTO `jun_region` VALUES ('752', '244', '法库县', '', '210124', '1');
INSERT INTO `jun_region` VALUES ('753', '244', '新民市', '', '210181', '1');
INSERT INTO `jun_region` VALUES ('754', '245', '中山区', '', '210202', '1');
INSERT INTO `jun_region` VALUES ('755', '245', '西岗区', '', '210203', '1');
INSERT INTO `jun_region` VALUES ('756', '245', '沙河口区', '', '210204', '1');
INSERT INTO `jun_region` VALUES ('757', '245', '甘井子区', '', '210211', '1');
INSERT INTO `jun_region` VALUES ('758', '245', '旅顺口区', '', '210212', '1');
INSERT INTO `jun_region` VALUES ('759', '245', '金州区', '', '210213', '1');
INSERT INTO `jun_region` VALUES ('760', '245', '长海县', '', '210224', '1');
INSERT INTO `jun_region` VALUES ('761', '245', '瓦房店市', '', '210281', '1');
INSERT INTO `jun_region` VALUES ('762', '245', '普兰店市', '', '210282', '1');
INSERT INTO `jun_region` VALUES ('763', '245', '庄河市', '', '210283', '1');
INSERT INTO `jun_region` VALUES ('764', '246', '铁东区', '', '210302', '1');
INSERT INTO `jun_region` VALUES ('765', '246', '铁西区', '', '210303', '1');
INSERT INTO `jun_region` VALUES ('766', '246', '立山区', '', '210304', '1');
INSERT INTO `jun_region` VALUES ('767', '246', '千山区', '', '210311', '1');
INSERT INTO `jun_region` VALUES ('768', '246', '台安县', '', '210321', '1');
INSERT INTO `jun_region` VALUES ('769', '246', '岫岩满族自治县', '', '210323', '1');
INSERT INTO `jun_region` VALUES ('770', '246', '海城市', '', '210381', '1');
INSERT INTO `jun_region` VALUES ('771', '250', '新抚区', '', '210402', '1');
INSERT INTO `jun_region` VALUES ('772', '250', '东洲区', '', '210403', '1');
INSERT INTO `jun_region` VALUES ('773', '250', '望花区', '', '210404', '1');
INSERT INTO `jun_region` VALUES ('774', '250', '顺城区', '', '210411', '1');
INSERT INTO `jun_region` VALUES ('775', '250', '抚顺县', '', '210421', '1');
INSERT INTO `jun_region` VALUES ('776', '250', '新宾满族自治县', '', '210422', '1');
INSERT INTO `jun_region` VALUES ('777', '250', '清原满族自治县', '', '210423', '1');
INSERT INTO `jun_region` VALUES ('778', '247', '平山区', '', '210502', '1');
INSERT INTO `jun_region` VALUES ('779', '247', '溪湖区', '', '210503', '1');
INSERT INTO `jun_region` VALUES ('780', '247', '明山区', '', '210504', '1');
INSERT INTO `jun_region` VALUES ('781', '247', '南芬区', '', '210505', '1');
INSERT INTO `jun_region` VALUES ('782', '247', '本溪满族自治县', '', '210521', '1');
INSERT INTO `jun_region` VALUES ('783', '247', '桓仁满族自治县', '', '210522', '1');
INSERT INTO `jun_region` VALUES ('784', '249', '元宝区', '', '210602', '1');
INSERT INTO `jun_region` VALUES ('785', '249', '振兴区', '', '210603', '1');
INSERT INTO `jun_region` VALUES ('786', '249', '振安区', '', '210604', '1');
INSERT INTO `jun_region` VALUES ('787', '249', '宽甸满族自治县', '', '210624', '1');
INSERT INTO `jun_region` VALUES ('788', '249', '东港市', '', '210681', '1');
INSERT INTO `jun_region` VALUES ('789', '249', '凤城市', '', '210682', '1');
INSERT INTO `jun_region` VALUES ('790', '253', '古塔区', '', '210702', '1');
INSERT INTO `jun_region` VALUES ('791', '253', '凌河区', '', '210703', '1');
INSERT INTO `jun_region` VALUES ('792', '253', '太和区', '', '210711', '1');
INSERT INTO `jun_region` VALUES ('793', '253', '黑山县', '', '210726', '1');
INSERT INTO `jun_region` VALUES ('794', '253', '义县', '', '210727', '1');
INSERT INTO `jun_region` VALUES ('795', '253', '凌海市', '', '210781', '1');
INSERT INTO `jun_region` VALUES ('796', '253', '北镇市', '', '210782', '1');
INSERT INTO `jun_region` VALUES ('797', '257', '站前区', '', '210802', '1');
INSERT INTO `jun_region` VALUES ('798', '257', '西市区', '', '210803', '1');
INSERT INTO `jun_region` VALUES ('799', '257', '鲅鱼圈区', '', '210804', '1');
INSERT INTO `jun_region` VALUES ('800', '257', '老边区', '', '210811', '1');
INSERT INTO `jun_region` VALUES ('801', '257', '盖州市', '', '210881', '1');
INSERT INTO `jun_region` VALUES ('802', '257', '大石桥市', '', '210882', '1');
INSERT INTO `jun_region` VALUES ('803', '251', '海州区', '', '210902', '1');
INSERT INTO `jun_region` VALUES ('804', '251', '新邱区', '', '210903', '1');
INSERT INTO `jun_region` VALUES ('805', '251', '太平区', '', '210904', '1');
INSERT INTO `jun_region` VALUES ('806', '251', '清河门区', '', '210905', '1');
INSERT INTO `jun_region` VALUES ('807', '251', '细河区', '', '210911', '1');
INSERT INTO `jun_region` VALUES ('808', '251', '阜新蒙古族自治县', '', '210921', '1');
INSERT INTO `jun_region` VALUES ('809', '251', '彰武县', '', '210922', '1');
INSERT INTO `jun_region` VALUES ('810', '254', '白塔区', '', '211002', '1');
INSERT INTO `jun_region` VALUES ('811', '254', '文圣区', '', '211003', '1');
INSERT INTO `jun_region` VALUES ('812', '254', '宏伟区', '', '211004', '1');
INSERT INTO `jun_region` VALUES ('813', '254', '弓长岭区', '', '211005', '1');
INSERT INTO `jun_region` VALUES ('814', '254', '太子河区', '', '211011', '1');
INSERT INTO `jun_region` VALUES ('815', '254', '辽阳县', '', '211021', '1');
INSERT INTO `jun_region` VALUES ('816', '254', '灯塔市', '', '211081', '1');
INSERT INTO `jun_region` VALUES ('817', '255', '双台子区', '', '211102', '1');
INSERT INTO `jun_region` VALUES ('818', '255', '兴隆台区', '', '211103', '1');
INSERT INTO `jun_region` VALUES ('819', '255', '大洼县', '', '211121', '1');
INSERT INTO `jun_region` VALUES ('820', '255', '盘山县', '', '211122', '1');
INSERT INTO `jun_region` VALUES ('821', '256', '银州区', '', '211202', '1');
INSERT INTO `jun_region` VALUES ('822', '256', '清河区', '', '211204', '1');
INSERT INTO `jun_region` VALUES ('823', '256', '铁岭县', '', '211221', '1');
INSERT INTO `jun_region` VALUES ('824', '256', '西丰县', '', '211223', '1');
INSERT INTO `jun_region` VALUES ('825', '256', '昌图县', '', '211224', '1');
INSERT INTO `jun_region` VALUES ('826', '256', '调兵山市', '', '211281', '1');
INSERT INTO `jun_region` VALUES ('827', '256', '开原市', '', '211282', '1');
INSERT INTO `jun_region` VALUES ('828', '248', '双塔区', '', '211302', '1');
INSERT INTO `jun_region` VALUES ('829', '248', '龙城区', '', '211303', '1');
INSERT INTO `jun_region` VALUES ('830', '248', '朝阳县', '', '211321', '1');
INSERT INTO `jun_region` VALUES ('831', '248', '建平县', '', '211322', '1');
INSERT INTO `jun_region` VALUES ('832', '248', '喀喇沁左翼蒙古族自治县', '', '211324', '1');
INSERT INTO `jun_region` VALUES ('833', '248', '北票市', '', '211381', '1');
INSERT INTO `jun_region` VALUES ('834', '248', '凌源市', '', '211382', '1');
INSERT INTO `jun_region` VALUES ('835', '252', '连山区', '', '211402', '1');
INSERT INTO `jun_region` VALUES ('836', '252', '龙港区', '', '211403', '1');
INSERT INTO `jun_region` VALUES ('837', '252', '南票区', '', '211404', '1');
INSERT INTO `jun_region` VALUES ('838', '252', '绥中县', '', '211421', '1');
INSERT INTO `jun_region` VALUES ('839', '252', '建昌县', '', '211422', '1');
INSERT INTO `jun_region` VALUES ('840', '252', '兴城市', '', '211481', '1');
INSERT INTO `jun_region` VALUES ('841', '211', '南关区', '', '220102', '1');
INSERT INTO `jun_region` VALUES ('842', '211', '宽城区', '', '220103', '1');
INSERT INTO `jun_region` VALUES ('843', '211', '朝阳区', '', '220104', '1');
INSERT INTO `jun_region` VALUES ('844', '211', '二道区', '', '220105', '1');
INSERT INTO `jun_region` VALUES ('845', '211', '绿园区', '', '220106', '1');
INSERT INTO `jun_region` VALUES ('846', '211', '双阳区', '', '220112', '1');
INSERT INTO `jun_region` VALUES ('847', '211', '农安县', '', '220122', '1');
INSERT INTO `jun_region` VALUES ('848', '211', '九台区', '', '220113', '1');
INSERT INTO `jun_region` VALUES ('849', '211', '榆树市', '', '220182', '1');
INSERT INTO `jun_region` VALUES ('850', '211', '德惠市', '', '220183', '1');
INSERT INTO `jun_region` VALUES ('851', '15', '昌邑区', '', '220202', '1');
INSERT INTO `jun_region` VALUES ('852', '15', '龙潭区', '', '220203', '1');
INSERT INTO `jun_region` VALUES ('853', '15', '船营区', '', '220204', '1');
INSERT INTO `jun_region` VALUES ('854', '15', '丰满区', '', '220211', '1');
INSERT INTO `jun_region` VALUES ('855', '15', '永吉县', '', '220221', '1');
INSERT INTO `jun_region` VALUES ('856', '15', '蛟河市', '', '220281', '1');
INSERT INTO `jun_region` VALUES ('857', '15', '桦甸市', '', '220282', '1');
INSERT INTO `jun_region` VALUES ('858', '15', '舒兰市', '', '220283', '1');
INSERT INTO `jun_region` VALUES ('859', '15', '磐石市', '', '220284', '1');
INSERT INTO `jun_region` VALUES ('860', '216', '铁西区', '', '220302', '1');
INSERT INTO `jun_region` VALUES ('861', '216', '铁东区', '', '220303', '1');
INSERT INTO `jun_region` VALUES ('862', '216', '梨树县', '', '220322', '1');
INSERT INTO `jun_region` VALUES ('863', '216', '伊通满族自治县', '', '220323', '1');
INSERT INTO `jun_region` VALUES ('864', '216', '公主岭市', '', '220381', '1');
INSERT INTO `jun_region` VALUES ('865', '216', '双辽市', '', '220382', '1');
INSERT INTO `jun_region` VALUES ('866', '215', '龙山区', '', '220402', '1');
INSERT INTO `jun_region` VALUES ('867', '215', '西安区', '', '220403', '1');
INSERT INTO `jun_region` VALUES ('868', '215', '东丰县', '', '220421', '1');
INSERT INTO `jun_region` VALUES ('869', '215', '东辽县', '', '220422', '1');
INSERT INTO `jun_region` VALUES ('870', '218', '东昌区', '', '220502', '1');
INSERT INTO `jun_region` VALUES ('871', '218', '二道江区', '', '220503', '1');
INSERT INTO `jun_region` VALUES ('872', '218', '通化县', '', '220521', '1');
INSERT INTO `jun_region` VALUES ('873', '218', '辉南县', '', '220523', '1');
INSERT INTO `jun_region` VALUES ('874', '218', '柳河县', '', '220524', '1');
INSERT INTO `jun_region` VALUES ('875', '218', '梅河口市', '', '220581', '1');
INSERT INTO `jun_region` VALUES ('876', '218', '集安市', '', '220582', '1');
INSERT INTO `jun_region` VALUES ('877', '214', '浑江区', '', '220602', '1');
INSERT INTO `jun_region` VALUES ('878', '214', '江源区', '', '220605', '1');
INSERT INTO `jun_region` VALUES ('879', '214', '抚松县', '', '220621', '1');
INSERT INTO `jun_region` VALUES ('880', '214', '靖宇县', '', '220622', '1');
INSERT INTO `jun_region` VALUES ('881', '214', '长白朝鲜族自治县', '', '220623', '1');
INSERT INTO `jun_region` VALUES ('882', '214', '临江市', '', '220681', '1');
INSERT INTO `jun_region` VALUES ('883', '217', '宁江区', '', '220702', '1');
INSERT INTO `jun_region` VALUES ('884', '217', '前郭尔罗斯蒙古族自治县', '', '220721', '1');
INSERT INTO `jun_region` VALUES ('885', '217', '长岭县', '', '220722', '1');
INSERT INTO `jun_region` VALUES ('886', '217', '乾安县', '', '220723', '1');
INSERT INTO `jun_region` VALUES ('887', '217', '扶余市', '', '220781', '1');
INSERT INTO `jun_region` VALUES ('888', '213', '洮北区', '', '220802', '1');
INSERT INTO `jun_region` VALUES ('889', '213', '镇赉县', '', '220821', '1');
INSERT INTO `jun_region` VALUES ('890', '213', '通榆县', '', '220822', '1');
INSERT INTO `jun_region` VALUES ('891', '213', '洮南市', '', '220881', '1');
INSERT INTO `jun_region` VALUES ('892', '213', '大安市', '', '220882', '1');
INSERT INTO `jun_region` VALUES ('893', '167', '道里区', '', '230102', '1');
INSERT INTO `jun_region` VALUES ('894', '167', '南岗区', '', '230103', '1');
INSERT INTO `jun_region` VALUES ('895', '167', '道外区', '', '230104', '1');
INSERT INTO `jun_region` VALUES ('896', '167', '平房区', '', '230108', '1');
INSERT INTO `jun_region` VALUES ('897', '167', '松北区', '', '230109', '1');
INSERT INTO `jun_region` VALUES ('898', '167', '香坊区', '', '230110', '1');
INSERT INTO `jun_region` VALUES ('899', '167', '呼兰区', '', '230111', '1');
INSERT INTO `jun_region` VALUES ('900', '167', '阿城区', '', '230112', '1');
INSERT INTO `jun_region` VALUES ('901', '167', '依兰县', '', '230123', '1');
INSERT INTO `jun_region` VALUES ('902', '167', '方正县', '', '230124', '1');
INSERT INTO `jun_region` VALUES ('903', '167', '宾县', '', '230125', '1');
INSERT INTO `jun_region` VALUES ('904', '167', '巴彦县', '', '230126', '1');
INSERT INTO `jun_region` VALUES ('905', '167', '木兰县', '', '230127', '1');
INSERT INTO `jun_region` VALUES ('906', '167', '通河县', '', '230128', '1');
INSERT INTO `jun_region` VALUES ('907', '167', '延寿县', '', '230129', '1');
INSERT INTO `jun_region` VALUES ('908', '167', '双城区', '', '230113', '1');
INSERT INTO `jun_region` VALUES ('909', '167', '尚志市', '', '230183', '1');
INSERT INTO `jun_region` VALUES ('910', '167', '五常市', '', '230184', '1');
INSERT INTO `jun_region` VALUES ('911', '176', '龙沙区', '', '230202', '1');
INSERT INTO `jun_region` VALUES ('912', '176', '建华区', '', '230203', '1');
INSERT INTO `jun_region` VALUES ('913', '176', '铁锋区', '', '230204', '1');
INSERT INTO `jun_region` VALUES ('914', '176', '昂昂溪区', '', '230205', '1');
INSERT INTO `jun_region` VALUES ('915', '176', '富拉尔基区', '', '230206', '1');
INSERT INTO `jun_region` VALUES ('916', '176', '碾子山区', '', '230207', '1');
INSERT INTO `jun_region` VALUES ('917', '176', '梅里斯达斡尔族区', '', '230208', '1');
INSERT INTO `jun_region` VALUES ('918', '176', '龙江县', '', '230221', '1');
INSERT INTO `jun_region` VALUES ('919', '176', '依安县', '', '230223', '1');
INSERT INTO `jun_region` VALUES ('920', '176', '泰来县', '', '230224', '1');
INSERT INTO `jun_region` VALUES ('921', '176', '甘南县', '', '230225', '1');
INSERT INTO `jun_region` VALUES ('922', '176', '富裕县', '', '230227', '1');
INSERT INTO `jun_region` VALUES ('923', '176', '克山县', '', '230229', '1');
INSERT INTO `jun_region` VALUES ('924', '176', '克东县', '', '230230', '1');
INSERT INTO `jun_region` VALUES ('925', '176', '拜泉县', '', '230231', '1');
INSERT INTO `jun_region` VALUES ('926', '176', '讷河市', '', '230281', '1');
INSERT INTO `jun_region` VALUES ('927', '172', '鸡冠区', '', '230302', '1');
INSERT INTO `jun_region` VALUES ('928', '172', '恒山区', '', '230303', '1');
INSERT INTO `jun_region` VALUES ('929', '172', '滴道区', '', '230304', '1');
INSERT INTO `jun_region` VALUES ('930', '172', '梨树区', '', '230305', '1');
INSERT INTO `jun_region` VALUES ('931', '172', '城子河区', '', '230306', '1');
INSERT INTO `jun_region` VALUES ('932', '172', '麻山区', '', '230307', '1');
INSERT INTO `jun_region` VALUES ('933', '172', '鸡东县', '', '230321', '1');
INSERT INTO `jun_region` VALUES ('934', '172', '虎林市', '', '230381', '1');
INSERT INTO `jun_region` VALUES ('935', '172', '密山市', '', '230382', '1');
INSERT INTO `jun_region` VALUES ('936', '170', '向阳区', '', '230402', '1');
INSERT INTO `jun_region` VALUES ('937', '170', '工农区', '', '230403', '1');
INSERT INTO `jun_region` VALUES ('938', '170', '南山区', '', '230404', '1');
INSERT INTO `jun_region` VALUES ('939', '170', '兴安区', '', '230405', '1');
INSERT INTO `jun_region` VALUES ('940', '170', '东山区', '', '230406', '1');
INSERT INTO `jun_region` VALUES ('941', '170', '兴山区', '', '230407', '1');
INSERT INTO `jun_region` VALUES ('942', '170', '萝北县', '', '230421', '1');
INSERT INTO `jun_region` VALUES ('943', '170', '绥滨县', '', '230422', '1');
INSERT INTO `jun_region` VALUES ('944', '177', '尖山区', '', '230502', '1');
INSERT INTO `jun_region` VALUES ('945', '177', '岭东区', '', '230503', '1');
INSERT INTO `jun_region` VALUES ('946', '177', '四方台区', '', '230505', '1');
INSERT INTO `jun_region` VALUES ('947', '177', '宝山区', '', '230506', '1');
INSERT INTO `jun_region` VALUES ('948', '177', '集贤县', '', '230521', '1');
INSERT INTO `jun_region` VALUES ('949', '177', '友谊县', '', '230522', '1');
INSERT INTO `jun_region` VALUES ('950', '177', '宝清县', '', '230523', '1');
INSERT INTO `jun_region` VALUES ('951', '177', '饶河县', '', '230524', '1');
INSERT INTO `jun_region` VALUES ('952', '168', '萨尔图区', '', '230602', '1');
INSERT INTO `jun_region` VALUES ('953', '168', '龙凤区', '', '230603', '1');
INSERT INTO `jun_region` VALUES ('954', '168', '让胡路区', '', '230604', '1');
INSERT INTO `jun_region` VALUES ('955', '168', '红岗区', '', '230605', '1');
INSERT INTO `jun_region` VALUES ('956', '168', '大同区', '', '230606', '1');
INSERT INTO `jun_region` VALUES ('957', '168', '肇州县', '', '230621', '1');
INSERT INTO `jun_region` VALUES ('958', '168', '肇源县', '', '230622', '1');
INSERT INTO `jun_region` VALUES ('959', '168', '林甸县', '', '230623', '1');
INSERT INTO `jun_region` VALUES ('960', '168', '杜尔伯特蒙古族自治县', '', '230624', '1');
INSERT INTO `jun_region` VALUES ('961', '179', '伊春区', '', '230702', '1');
INSERT INTO `jun_region` VALUES ('962', '179', '南岔区', '', '230703', '1');
INSERT INTO `jun_region` VALUES ('963', '179', '友好区', '', '230704', '1');
INSERT INTO `jun_region` VALUES ('964', '179', '西林区', '', '230705', '1');
INSERT INTO `jun_region` VALUES ('965', '179', '翠峦区', '', '230706', '1');
INSERT INTO `jun_region` VALUES ('966', '179', '新青区', '', '230707', '1');
INSERT INTO `jun_region` VALUES ('967', '179', '美溪区', '', '230708', '1');
INSERT INTO `jun_region` VALUES ('968', '179', '金山屯区', '', '230709', '1');
INSERT INTO `jun_region` VALUES ('969', '179', '五营区', '', '230710', '1');
INSERT INTO `jun_region` VALUES ('970', '179', '乌马河区', '', '230711', '1');
INSERT INTO `jun_region` VALUES ('971', '179', '汤旺河区', '', '230712', '1');
INSERT INTO `jun_region` VALUES ('972', '179', '带岭区', '', '230713', '1');
INSERT INTO `jun_region` VALUES ('973', '179', '乌伊岭区', '', '230714', '1');
INSERT INTO `jun_region` VALUES ('974', '179', '红星区', '', '230715', '1');
INSERT INTO `jun_region` VALUES ('975', '179', '上甘岭区', '', '230716', '1');
INSERT INTO `jun_region` VALUES ('976', '179', '嘉荫县', '', '230722', '1');
INSERT INTO `jun_region` VALUES ('977', '179', '铁力市', '', '230781', '1');
INSERT INTO `jun_region` VALUES ('978', '173', '向阳区', '', '230803', '1');
INSERT INTO `jun_region` VALUES ('979', '173', '前进区', '', '230804', '1');
INSERT INTO `jun_region` VALUES ('980', '173', '东风区', '', '230805', '1');
INSERT INTO `jun_region` VALUES ('981', '173', '郊区', '', '230811', '1');
INSERT INTO `jun_region` VALUES ('982', '173', '桦南县', '', '230822', '1');
INSERT INTO `jun_region` VALUES ('983', '173', '桦川县', '', '230826', '1');
INSERT INTO `jun_region` VALUES ('984', '173', '汤原县', '', '230828', '1');
INSERT INTO `jun_region` VALUES ('985', '173', '抚远县', '', '230833', '1');
INSERT INTO `jun_region` VALUES ('986', '173', '同江市', '', '230881', '1');
INSERT INTO `jun_region` VALUES ('987', '173', '富锦市', '', '230882', '1');
INSERT INTO `jun_region` VALUES ('988', '175', '新兴区', '', '230902', '1');
INSERT INTO `jun_region` VALUES ('989', '175', '桃山区', '', '230903', '1');
INSERT INTO `jun_region` VALUES ('990', '175', '茄子河区', '', '230904', '1');
INSERT INTO `jun_region` VALUES ('991', '175', '勃利县', '', '230921', '1');
INSERT INTO `jun_region` VALUES ('992', '174', '东安区', '', '231002', '1');
INSERT INTO `jun_region` VALUES ('993', '174', '阳明区', '', '231003', '1');
INSERT INTO `jun_region` VALUES ('994', '174', '爱民区', '', '231004', '1');
INSERT INTO `jun_region` VALUES ('995', '174', '西安区', '', '231005', '1');
INSERT INTO `jun_region` VALUES ('996', '174', '东宁县', '', '231024', '1');
INSERT INTO `jun_region` VALUES ('997', '174', '林口县', '', '231025', '1');
INSERT INTO `jun_region` VALUES ('998', '174', '绥芬河市', '', '231081', '1');
INSERT INTO `jun_region` VALUES ('999', '174', '海林市', '', '231083', '1');
INSERT INTO `jun_region` VALUES ('1000', '174', '宁安市', '', '231084', '1');
INSERT INTO `jun_region` VALUES ('1001', '174', '穆棱市', '', '231085', '1');
INSERT INTO `jun_region` VALUES ('1002', '171', '爱辉区', '', '231102', '1');
INSERT INTO `jun_region` VALUES ('1003', '171', '嫩江县', '', '231121', '1');
INSERT INTO `jun_region` VALUES ('1004', '171', '逊克县', '', '231123', '1');
INSERT INTO `jun_region` VALUES ('1005', '171', '孙吴县', '', '231124', '1');
INSERT INTO `jun_region` VALUES ('1006', '171', '北安市', '', '231181', '1');
INSERT INTO `jun_region` VALUES ('1007', '171', '五大连池市', '', '231182', '1');
INSERT INTO `jun_region` VALUES ('1008', '178', '北林区', '', '231202', '1');
INSERT INTO `jun_region` VALUES ('1009', '178', '望奎县', '', '231221', '1');
INSERT INTO `jun_region` VALUES ('1010', '178', '兰西县', '', '231222', '1');
INSERT INTO `jun_region` VALUES ('1011', '178', '青冈县', '', '231223', '1');
INSERT INTO `jun_region` VALUES ('1012', '178', '庆安县', '', '231224', '1');
INSERT INTO `jun_region` VALUES ('1013', '178', '明水县', '', '231225', '1');
INSERT INTO `jun_region` VALUES ('1014', '178', '绥棱县', '', '231226', '1');
INSERT INTO `jun_region` VALUES ('1015', '178', '安达市', '', '231281', '1');
INSERT INTO `jun_region` VALUES ('1016', '178', '肇东市', '', '231282', '1');
INSERT INTO `jun_region` VALUES ('1017', '178', '海伦市', '', '231283', '1');
INSERT INTO `jun_region` VALUES ('1018', '220', '玄武区', '', '320102', '1');
INSERT INTO `jun_region` VALUES ('1019', '369', '镇沅彝族哈尼族拉祜族自治县', '', '530825', '1');
INSERT INTO `jun_region` VALUES ('1020', '220', '秦淮区', '', '320104', '1');
INSERT INTO `jun_region` VALUES ('1021', '220', '建邺区', '', '320105', '1');
INSERT INTO `jun_region` VALUES ('1022', '220', '鼓楼区', '', '320106', '1');
INSERT INTO `jun_region` VALUES ('1023', '220', '浦口区', '', '320111', '1');
INSERT INTO `jun_region` VALUES ('1024', '220', '栖霞区', '', '320113', '1');
INSERT INTO `jun_region` VALUES ('1025', '220', '雨花台区', '', '320114', '1');
INSERT INTO `jun_region` VALUES ('1026', '220', '江宁区', '', '320115', '1');
INSERT INTO `jun_region` VALUES ('1027', '220', '六合区', '', '320116', '1');
INSERT INTO `jun_region` VALUES ('1028', '220', '溧水区', '', '320117', '1');
INSERT INTO `jun_region` VALUES ('1029', '220', '高淳区', '', '320118', '1');
INSERT INTO `jun_region` VALUES ('1030', '222', '崇安区', '', '320202', '1');
INSERT INTO `jun_region` VALUES ('1031', '222', '南长区', '', '320203', '1');
INSERT INTO `jun_region` VALUES ('1032', '222', '北塘区', '', '320204', '1');
INSERT INTO `jun_region` VALUES ('1033', '222', '锡山区', '', '320205', '1');
INSERT INTO `jun_region` VALUES ('1034', '222', '惠山区', '', '320206', '1');
INSERT INTO `jun_region` VALUES ('1035', '222', '滨湖区', '', '320211', '1');
INSERT INTO `jun_region` VALUES ('1036', '222', '江阴市', '', '320281', '1');
INSERT INTO `jun_region` VALUES ('1037', '222', '宜兴市', '', '320282', '1');
INSERT INTO `jun_region` VALUES ('1038', '229', '鼓楼区', '', '320302', '1');
INSERT INTO `jun_region` VALUES ('1039', '229', '云龙区', '', '320303', '1');
INSERT INTO `jun_region` VALUES ('1040', '369', '景谷傣族彝族自治县', '', '530824', '1');
INSERT INTO `jun_region` VALUES ('1041', '229', '贾汪区', '', '320305', '1');
INSERT INTO `jun_region` VALUES ('1042', '229', '泉山区', '', '320311', '1');
INSERT INTO `jun_region` VALUES ('1043', '229', '丰县', '', '320321', '1');
INSERT INTO `jun_region` VALUES ('1044', '229', '沛县', '', '320322', '1');
INSERT INTO `jun_region` VALUES ('1045', '229', '铜山区', '', '320312', '1');
INSERT INTO `jun_region` VALUES ('1046', '229', '睢宁县', '', '320324', '1');
INSERT INTO `jun_region` VALUES ('1047', '229', '新沂市', '', '320381', '1');
INSERT INTO `jun_region` VALUES ('1048', '229', '邳州市', '', '320382', '1');
INSERT INTO `jun_region` VALUES ('1049', '223', '天宁区', '', '320402', '1');
INSERT INTO `jun_region` VALUES ('1050', '223', '钟楼区', '', '320404', '1');
INSERT INTO `jun_region` VALUES ('1051', '223', '新北区', '', '320411', '1');
INSERT INTO `jun_region` VALUES ('1052', '223', '武进区', '', '320412', '1');
INSERT INTO `jun_region` VALUES ('1053', '223', '溧阳市', '', '320481', '1');
INSERT INTO `jun_region` VALUES ('1054', '223', '金坛区', '', '320413', '1');
INSERT INTO `jun_region` VALUES ('1055', '221', '虎丘区', '', '320505', '1');
INSERT INTO `jun_region` VALUES ('1056', '221', '吴中区', '', '320506', '1');
INSERT INTO `jun_region` VALUES ('1057', '221', '相城区', '', '320507', '1');
INSERT INTO `jun_region` VALUES ('1058', '221', '常熟市', '', '320581', '1');
INSERT INTO `jun_region` VALUES ('1059', '221', '张家港市', '', '320582', '1');
INSERT INTO `jun_region` VALUES ('1060', '221', '昆山市', '', '320583', '1');
INSERT INTO `jun_region` VALUES ('1061', '221', '吴江市', '', '320584', '1');
INSERT INTO `jun_region` VALUES ('1062', '221', '太仓市', '', '320585', '1');
INSERT INTO `jun_region` VALUES ('1063', '226', '崇川区', '', '320602', '1');
INSERT INTO `jun_region` VALUES ('1064', '226', '港闸区', '', '320611', '1');
INSERT INTO `jun_region` VALUES ('1065', '226', '海安县', '', '320621', '1');
INSERT INTO `jun_region` VALUES ('1066', '226', '如东县', '', '320623', '1');

-- ----------------------------
-- Table structure for jun_role
-- ----------------------------
DROP TABLE IF EXISTS `jun_role`;
CREATE TABLE `jun_role` (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `r_name` varchar(20) DEFAULT NULL COMMENT '角色名称',
  `r_remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `r_status` tinyint(1) DEFAULT '1' COMMENT '状态：1开启， 2关闭',
  `r_menu_list` text,
  PRIMARY KEY (`r_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of jun_role
-- ----------------------------
INSERT INTO `jun_role` VALUES ('10', '完全权限', '', '1', '6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31');
INSERT INTO `jun_role` VALUES ('11', '局部权限-1', '用作测试', '1', '6,7,8,9,10,11,12,13,14,15,24,25,26,27');
INSERT INTO `jun_role` VALUES ('12', '局部权限-2', '用作测试', '1', '6,7,16,17,18,19,24,25,26,27');

-- ----------------------------
-- Table structure for jun_structure
-- ----------------------------
DROP TABLE IF EXISTS `jun_structure`;
CREATE TABLE `jun_structure` (
  `s_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `s_name` varchar(30) NOT NULL COMMENT '组织名称',
  `s_pid` char(13) NOT NULL DEFAULT '0' COMMENT '父ID',
  `admin_id` char(13) NOT NULL DEFAULT '0' COMMENT '添加者',
  `add_time` int(5) NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`s_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='组织表';

-- ----------------------------
-- Records of jun_structure
-- ----------------------------
INSERT INTO `jun_structure` VALUES ('1', '公司', '0', '0', '1506074025');
INSERT INTO `jun_structure` VALUES ('3', '产品部', '2', '0', '1506475061');
INSERT INTO `jun_structure` VALUES ('4', '技术部', '2', '0', '1506475072');
INSERT INTO `jun_structure` VALUES ('5', '人事行政部', '2', '0', '1506475094');
INSERT INTO `jun_structure` VALUES ('6', '财务部', '2', '0', '1506475101');
INSERT INTO `jun_structure` VALUES ('7', '客服部', '2', '0', '1506475111');
INSERT INTO `jun_structure` VALUES ('8', '市场部', '2', '0', '1506475115');
INSERT INTO `jun_structure` VALUES ('9', '商务部', '2', '0', '1506475120');
INSERT INTO `jun_structure` VALUES ('2', '总部', '1', '0', '1506475278');
