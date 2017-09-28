/*
MySQL Database Backup Tools
Server:127.0.0.1:
Database:junthink
Data:2017-09-28 17:47:01
*/
SET FOREIGN_KEY_CHECKS=0;
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
INSERT INTO `jun_structure` (`s_id`,`s_name`,`s_pid`,`admin_id`,`add_time`) VALUES ('1','公司','0','0','1506074025');
INSERT INTO `jun_structure` (`s_id`,`s_name`,`s_pid`,`admin_id`,`add_time`) VALUES ('3','产品部','2','0','1506475061');
INSERT INTO `jun_structure` (`s_id`,`s_name`,`s_pid`,`admin_id`,`add_time`) VALUES ('4','技术部','2','0','1506475072');
INSERT INTO `jun_structure` (`s_id`,`s_name`,`s_pid`,`admin_id`,`add_time`) VALUES ('5','人事行政部','2','0','1506475094');
INSERT INTO `jun_structure` (`s_id`,`s_name`,`s_pid`,`admin_id`,`add_time`) VALUES ('6','财务部','2','0','1506475101');
INSERT INTO `jun_structure` (`s_id`,`s_name`,`s_pid`,`admin_id`,`add_time`) VALUES ('7','客服部','2','0','1506475111');
INSERT INTO `jun_structure` (`s_id`,`s_name`,`s_pid`,`admin_id`,`add_time`) VALUES ('8','市场部','2','0','1506475115');
INSERT INTO `jun_structure` (`s_id`,`s_name`,`s_pid`,`admin_id`,`add_time`) VALUES ('9','商务部','2','0','1506475120');
INSERT INTO `jun_structure` (`s_id`,`s_name`,`s_pid`,`admin_id`,`add_time`) VALUES ('2','总部','1','0','1506475278');

