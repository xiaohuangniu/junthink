/*
MySQL Database Backup Tools
Server:127.0.0.1:
Database:junthink
Data:2017-09-28 17:46:54
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
INSERT INTO `jun_job` (`j_id`,`j_name`,`s_id`,`r_id`) VALUES ('4','PHP工程师','4','10');
INSERT INTO `jun_job` (`j_id`,`j_name`,`s_id`,`r_id`) VALUES ('5','实习生','4','11');
INSERT INTO `jun_job` (`j_id`,`j_name`,`s_id`,`r_id`) VALUES ('6','部门老大','4','11,12');

