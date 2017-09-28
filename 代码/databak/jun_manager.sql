SET FOREIGN_KEY_CHECKS=0;
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
INSERT INTO `jun_manager` (`m_id`,`j_id`,`m_name`,`m_pwd`,`m_nice`,`m_phone`,`m_time`,`m_status`) VALUES ('3','0','admin','e40800c264922d6a22add5fb189a08e0','小黄牛','15992438888','1506418602','1');

