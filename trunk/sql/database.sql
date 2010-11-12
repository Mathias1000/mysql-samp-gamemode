/*
MySQL Data Transfer
Source Host: localhost
Source Database: gta
Target Host: localhost
Target Database: gta
Date: 04.10.2010 08:20:25
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for blizter
-- ----------------------------
CREATE TABLE `blizter` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `pos_x` varchar(50) DEFAULT NULL,
  `pos_y` varchar(50) DEFAULT NULL,
  `pos_z` varchar(50) DEFAULT NULL,
  `speed` int(32) NOT NULL DEFAULT '0',
  `radius` int(32) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for object
-- ----------------------------
CREATE TABLE `object` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `modelid` int(32) NOT NULL,
  `pos_x` varchar(50) DEFAULT NULL,
  `pos_y` varchar(50) DEFAULT NULL,
  `pos_z` varchar(50) DEFAULT NULL,
  `pos_rx` varchar(50) DEFAULT NULL,
  `pos_ry` varchar(50) DEFAULT NULL,
  `pos_rz` varchar(50) DEFAULT NULL,
  `interior` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=686 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for playerclass
-- ----------------------------
CREATE TABLE `playerclass` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `skin` int(32) NOT NULL,
  `pos_x` varchar(50) DEFAULT NULL,
  `pos_y` varchar(50) DEFAULT NULL,
  `pos_z` varchar(50) DEFAULT NULL,
  `pos_r` varchar(50) DEFAULT NULL,
  `weapon1` int(32) NOT NULL,
  `weapon1_ammo` int(32) NOT NULL,
  `weapon2` int(32) NOT NULL,
  `weapon2_ammo` int(32) NOT NULL,
  `weapon3` int(32) NOT NULL,
  `weapon3_ammo` int(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for players
-- ----------------------------
CREATE TABLE `players` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Password` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Money` bigint(20) NOT NULL DEFAULT '500',
  `Kills` int(11) NOT NULL DEFAULT '0',
  `Deaths` int(11) NOT NULL DEFAULT '0',
  `Autoschein` int(11) NOT NULL DEFAULT '0',
  `AdminLevel` int(11) NOT NULL DEFAULT '0',
  `Bootschein` int(11) NOT NULL DEFAULT '0',
  `Flugschein` int(11) NOT NULL DEFAULT '0',
  `Lastwagenschein` int(11) NOT NULL DEFAULT '0',
  `Motorradschein` int(11) NOT NULL DEFAULT '0',
  `skin` int(11) NOT NULL DEFAULT '0',
  `pos_x` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `pos_y` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `pos_z` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `pos_r` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Team` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `weapon1` int(32) NOT NULL,
  `weapon1_ammo` int(32) NOT NULL,
  `weapon2` int(32) NOT NULL,
  `weapon2_ammo` int(32) NOT NULL,
  `weapon3` int(32) NOT NULL,
  `weapon3_ammo` int(32) NOT NULL,
  `weapon4` int(32) NOT NULL,
  `weapon4_ammo` int(32) NOT NULL,
  `weapon5` int(32) NOT NULL,
  `weapon5_ammo` int(32) NOT NULL,
  `weapon6` int(32) NOT NULL,
  `weapon6_ammo` int(32) NOT NULL,
  `weapon7` int(32) NOT NULL,
  `weapon7_ammo` int(32) NOT NULL,
  `weapon8` int(32) NOT NULL,
  `weapon8_ammo` int(32) NOT NULL,
  `weapon9` int(32) NOT NULL,
  `weapon9_ammo` int(32) NOT NULL,
  `weapon10` int(32) NOT NULL,
  `weapon10_ammo` int(32) NOT NULL,
  `weapon11` int(32) NOT NULL,
  `weapon11_ammo` int(32) NOT NULL,
  `weapon12` int(32) NOT NULL,
  `weapon12_ammo` int(32) NOT NULL,
  `weapon13_ammo` int(32) NOT NULL,
  `weapon13` int(32) NOT NULL,
  `interiorid` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for vehicles
-- ----------------------------
CREATE TABLE `vehicles` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `interrior` int(32) NOT NULL DEFAULT '0',
  `modelid` int(32) NOT NULL,
  `pos_x` varchar(50) DEFAULT NULL,
  `pos_y` varchar(50) DEFAULT NULL,
  `pos_z` varchar(50) DEFAULT NULL,
  `pos_r` varchar(50) DEFAULT NULL,
  `color1` int(32) NOT NULL DEFAULT '0',
  `color2` int(32) NOT NULL DEFAULT '0',
  `spawntime` varchar(50) DEFAULT NULL,
  `type` int(32) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `object` VALUES ('685', '973', '-2090.4437', '-131.7508', '34.5854', '0.0', '0.0', '270.0', null);
INSERT INTO `object` VALUES ('684', '973', '-2090.4212', '-141.0174', '34.6105', '0.0', '0.0', '270.0', null);
INSERT INTO `object` VALUES ('683', '973', '-2090.4537', '-150.0378', '34.6105', '0.0', '0.0', '270.0', null);
INSERT INTO `object` VALUES ('682', '973', '-2090.5167', '-158.2357', '34.5854', '0.0', '0.0', '270.0', null);
INSERT INTO `object` VALUES ('681', '973', '-2057.2186', '-108.1958', '35.1586', '0.0', '0.0', '270.0', null);
INSERT INTO `object` VALUES ('680', '973', '-2067.043', '-122.8625', '34.7459', '0.0', '0.0', '180.0', null);
INSERT INTO `object` VALUES ('679', '973', '-2076.2747', '-122.8679', '34.7168', '0.0', '0.0', '180.0', null);
INSERT INTO `object` VALUES ('586', '1422', '-2055.1795', '-182.1198', '34.7379', '0.0', '0.0', '', '0');
INSERT INTO `object` VALUES ('678', '973', '-2061.855', '-118.0621', '34.5905', '0.0', '0.0', '180.0', null);
INSERT INTO `object` VALUES ('677', '973', '-2075.4629', '-118.3242', '34.6424', '0.0', '0.0', '180.0', null);
INSERT INTO `object` VALUES ('676', '973', '2082.4405', '-118.3147', '34.6605', '0.0', '0.0', '180.0', null);
INSERT INTO `object` VALUES ('675', '973', '-2079.3001', '-145.33', '34.6605', '0.0', '0.0', '90.0', null);
INSERT INTO `object` VALUES ('587', '1422', '-2082.0599', '-132.9525', '34.7308', '0.0', '0.0', '0.0', '0');
INSERT INTO `object` VALUES ('588', '1422', '-2084.897', '-133.8987', '34.7309', '0.0', '0.0', '45.0', '0');
INSERT INTO `object` VALUES ('589', '1422', '-2079.7745', '-161.9202', '34.7308', '0.0', '0.0', '90.0', '0');
INSERT INTO `object` VALUES ('590', '1422', '-2080.4971', '-165.7738', '34.7308', '0.0', '0.0', '67.5', '0');
INSERT INTO `object` VALUES ('591', '1422', '-2082.6595', '-168.104', '34.7308', '0.0', '0.0', '33.75', '0');
INSERT INTO `object` VALUES ('592', '1422', '-2086.1451', '-169.5583', '34.7308', '0.0', '0.0', '11.25', '0');
INSERT INTO `object` VALUES ('593', '1422', '-2089.2005', '-168.7228', '34.7308', '0.0', '0.0', '315.0', '0');
INSERT INTO `object` VALUES ('594', '1422', '-2090.6429', ' -165.5582', '34.7308', '0.0', '0.0', '281.25', '0');
INSERT INTO `object` VALUES ('595', '1422', '-2082.9405', '-123.4397', '34.7308', '0.0', '0.0', '22.5', '0');
INSERT INTO `object` VALUES ('596', '1422', '-2057.553', '-2057.553', '34.7327', '0.0', '0.0', '146.25', '0');
INSERT INTO `object` VALUES ('597', '1422', '-2060.2833', '-123.2023', '34.7347', '0.0', '0.0', '157.5', '0');
INSERT INTO `object` VALUES ('598', '1422', '-2047.0569', '-125.3778', '34.6799', '0.0', '0.0', '146.25', '0');
INSERT INTO `object` VALUES ('599', '1422', '-2050.1756', '-123.4868', '34.6775', '0.0', '0.0', '157.5', '0');
INSERT INTO `object` VALUES ('600', '1422', '-2053.1031', ' -121.059', '34.7003', '0.0', '0.0', '123.7499', '0');
INSERT INTO `object` VALUES ('601', '1422', '-2055.606', '-118.4816', '34.7207', '0.0', '0.0', '146.25', '0');
INSERT INTO `object` VALUES ('602', '1422', '-2090.4659', '-125.5248', '34.7308', '0.0', '0.0', '90.0', '0');
INSERT INTO `object` VALUES ('603', '1422', '-2090.1512', '-122.241', '34.7308', '0.0', '0.0', '78.75', '0');
INSERT INTO `object` VALUES ('604', '1422', '-2088.918', '-119.4772', '34.7308', '0.0', '0.0', '56.25', '0');
INSERT INTO `object` VALUES ('605', '1422', '-2066.4952', '-136.3779', '34.7308', '0.0', '0.0', '303.75', '0');
INSERT INTO `object` VALUES ('606', '1422', '-2068.326', '-185.5294', '34.7308', '0.0', '0.0', '247.5', '0');
INSERT INTO `object` VALUES ('607', '1422', '-2067.6851', '-188.4045', '34.7308', '0.0', '0.0', '315.0', '0');
INSERT INTO `object` VALUES ('608', '1422', '-2068.5291', '-192.7786', '34.7308', '0.0', '0.0', '348.75', '0');
INSERT INTO `object` VALUES ('609', '1422', '-2071.4739', '-191.6574', '34.7308', '0.0', '0.0', '315.0', '0');
INSERT INTO `object` VALUES ('610', '1422', '-2030.9671', '-151.7182', '34.7308', '0.0', '0.0', '281.25', '0');
INSERT INTO `object` VALUES ('611', '1422', '-2030.8022', '-155.4419', '34.7309', '0.0', '0.0', '258.75', '0');
INSERT INTO `object` VALUES ('612', '1422', '-2031.5464', '-158.6096', '34.7309', '0.0', '0.0', '247.5', '0');
INSERT INTO `object` VALUES ('613', '1422', '-2032.936', '-161.6816', '34.7308', '0.0', '0.0', '236.2501', '0');
INSERT INTO `object` VALUES ('614', '1422', '-2075.3826', '-201.0971', '34.7308', '0.0', '0.0', '348.75', '0');
INSERT INTO `object` VALUES ('615', '1422', '-2078.448', '-199.7313', '34.7308', '0.0', '0.0', '326.25', '0');
INSERT INTO `object` VALUES ('616', '1422', '-2080.7012', '-197.2106', '34.7308', '0.0', '0.0', '292.5', '0');
INSERT INTO `object` VALUES ('617', '1422', '-2035.1248', '-201.1731', '34.7308', '0.0', '0.0', '22.5', '0');
INSERT INTO `object` VALUES ('618', '1422', '-2080.4175', '-175.6887', '34.7308', '0.0', '0.0', '56.25', '0');
INSERT INTO `object` VALUES ('619', '1422', '-2077.8453', '-173.3464', '34.7308', '0.0', '0.0', '33.75', '0');
INSERT INTO `object` VALUES ('620', '1422', '-2075.4395', '-171.105', '34.7308', '0.0', '0.0', '56.25', '0');
INSERT INTO `object` VALUES ('621', '1422', '-2034.6045', '-189.3325', '34.7308', '0.0', '0.0', '315.0', '0');
INSERT INTO `object` VALUES ('622', '1422', '-2075.7549', '-140.5499', '34.7308', '0.0', '0.0', '315.0', '0');
INSERT INTO `object` VALUES ('623', '1422', '-2078.18', '-139.6397', '34.7308', '0.0', '0.0', '22.5', '0');
INSERT INTO `object` VALUES ('624', '1422', '-2055.4573', '-178.7338', '34.7308', '0.0', '0.0', '247.5', '0');
INSERT INTO `object` VALUES ('625', '973', '-2071.639', '-186.0808', '34.6355', '0.0', '0.0', '78.75', '0');
INSERT INTO `object` VALUES ('626', '973', '-2070.0767', '-178.3745', '34.6355', '0.0', '0.0', '78.75', '0');
INSERT INTO `object` VALUES ('627', '973', '-2067.4415', '-169.6084', '34.6355', '0.0', '0.0', '67.5', '0');
INSERT INTO `object` VALUES ('628', '973', '-2065.6099', '-160.6735', '34.6105', '0.0', '0.0', '90.0', '0');
INSERT INTO `object` VALUES ('629', '973', '-2065.5933', '-152.1536', '34.6355', '0.0', '0.0', '90.0', '0');
INSERT INTO `object` VALUES ('630', '973', '-2065.5687', '-143.5137', '34.6355', '0.0', '0.0', '90.0', '0');
INSERT INTO `object` VALUES ('631', '973', '-2041.808', '-130.367', '34.604', '0.0', '0.0', '135.0', '0');
INSERT INTO `object` VALUES ('632', '973', '-2036.7068', '-138.005', '34.5913', '0.0', '0.0', '112.5', '0');
INSERT INTO `object` VALUES ('633', '973', '-2033.438', '-145.937', '34.5854', '0.0', '0.0', '112.5', '0');
INSERT INTO `object` VALUES ('634', '973', '-2061.6688', '-190.6572', '34.6105', '0.0', '0.0', '348.75', '0');
INSERT INTO `object` VALUES ('635', '973', '-2054.847', '-192.0091', '34.6175', '0.0', '0.0', '348.75', '0');
INSERT INTO `object` VALUES ('636', '973', '-2045.8388', '-193.7904', '34.6175', '0.0', '0.0', '348.75', '0');
INSERT INTO `object` VALUES ('637', '973', '-2046.053', '-194.7271', '34.5925', '0.0', '0.0', '180.0', '0');
INSERT INTO `object` VALUES ('638', '973', '-2052.9244', '-194.7842', '34.6175', '0.0', '0.0', '180.0', '0');
INSERT INTO `object` VALUES ('639', '973', '-2062.1778', '-193.8759', '34.6355', '0.0', '0.0', '168.7498', '0');
INSERT INTO `object` VALUES ('640', '973', '-2059.3475', '-137.4072', '34.6105', '0.0', '0.0', '303.75', '0');
INSERT INTO `object` VALUES ('641', '973', '-2054.5972', '-144.4534', '34.6105', '0.0', '0.0', '303.75', '0');
INSERT INTO `object` VALUES ('642', '973', '-2050.2935', '-152.5725', '34.6175', '0.0', '0.0', '292.5', '0');
INSERT INTO `object` VALUES ('643', '973', '-2047.6185', '-161.3811', '34.6355', '0.0', '0.0', '281.25', '0');
INSERT INTO `object` VALUES ('644', '973', '-2050.5508', '-168.4679', '34.5854', '0.0', '0.0', '213.75', '0');
INSERT INTO `object` VALUES ('645', '973', '-2058.273', '-173.6534', '34.6105', '0.0', '0.0', '213.75', '0');
INSERT INTO `object` VALUES ('646', '973', '-2064.7691', '-180.171', '34.6105', '0.0', '0.0', '236.2501', '0');
INSERT INTO `object` VALUES ('647', '973', '-2079.2908', '-154.4857', '34.6605', '0.0', '0.0', '90.0', '0');
INSERT INTO `object` VALUES ('648', '973', '-2085.47', '-157.4542', '34.5604', '0.0', '0.0', '90.0', '0');
INSERT INTO `object` VALUES ('649', '973', '-2085.4212', '-149.2699', '34.5604', '0.0', '0.0', '90.0', '0');
INSERT INTO `object` VALUES ('650', '973', '-2085.4759', '-140.5194', '34.5854', '0.0', '0.0', '90.0', '0');
INSERT INTO `object` VALUES ('651', '973', '-2066.4058', '-133.2131', '34.6105', '0.0', '0.0', '0.0', '0');
INSERT INTO `object` VALUES ('652', '973', '-2075.2769', '-133.2272', '34.5854', '0.0', '0.0', '0.0', '0');
INSERT INTO `object` VALUES ('653', '973', '-2074.233', '-164.9235', '34.5854', '0.0', '0.0', '270.0', '0');
INSERT INTO `object` VALUES ('654', '973', '-2074.2142', '-155.9924', '34.6355', '0.0', '0.0', '270.0', '0');
INSERT INTO `object` VALUES ('655', '973', '-2074.17', '-146.933', '34.6105', '0.0', '0.0', '270.0', '0');
INSERT INTO `object` VALUES ('656', '973', '-2080.9847', '-190.4316', '34.7355', '0.0', '0.0', '270.0', '0');
INSERT INTO `object` VALUES ('657', '973', '-2081.0032', '-181.6764', '34.7105', '0.0', '0.0', '270.0', '0');
INSERT INTO `object` VALUES ('658', '973', '-2038.1836', '-166.2553', '34.6175', '0.0', '0.0', '33.75', '0');
INSERT INTO `object` VALUES ('659', '973', '-2043.9173', '-170.0784', '34.6355', '0.0', '0.0', '33.75', '0');
INSERT INTO `object` VALUES ('660', '973', '-2050.7906', '-174.6727', '34.6355', '0.0', '0.0', '33.75', '0');
INSERT INTO `object` VALUES ('661', '973', '-2049.661', '-184.9521', '34.6605', '0.0', '0.0', '168.7498', '0');
INSERT INTO `object` VALUES ('662', '973', '-2040.5813', '-186.7105', '34.6105', '0.0', '0.0', '168.7498', '0');
INSERT INTO `object` VALUES ('663', '973', '-2033.0986', '-195.2337', '34.6355', '0.0', '0.0', '90.0', '0');
INSERT INTO `object` VALUES ('664', '973', '-2041.9562', '-201.5278', '34.5604', '0.0', '0.0', '0.0', '0');
INSERT INTO `object` VALUES ('665', '973', '-2051.0535', '-201.5268', '34.5925', '0.0', '0.0', '0.0', '0');
INSERT INTO `object` VALUES ('666', '973', '-2059.7059', '-201.5256', '34.6105', '0.0', '0.0', '0.0', '0');
INSERT INTO `object` VALUES ('667', '973', '-2068.5972', '-201.495', '34.5854', '0.0', '0.0', '0.0', '0');
INSERT INTO `playerclass` VALUES ('1', '10', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('11', '14', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('12', '101', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('13', '12', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('14', '13', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('15', '14', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('16', '136', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('17', '142', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('18', '143', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('19', '144', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('20', '151', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('21', '15', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('22', '17', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('23', '170', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('24', '180', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('25', '169', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('26', '168', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('27', '19', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('28', '182', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('29', '183', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('30', '54', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('31', '184', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('32', '263', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('33', '75', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('34', '186', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('35', '185', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('36', '188', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('37', '216', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `playerclass` VALUES ('38', '20', '821.1600', '-1759.1697', '13.6484', '128.6720', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicles` VALUES ('1', '1', '571', '-2062.2825', '-108.2518', '34.6077', null, '1', '1', null, '2');
INSERT INTO `vehicles` VALUES ('14', '1', '510', '846.707702', '-1798.933349', '13.840503', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('15', '0', '510', '846.671813', '-1801.041748', '13.835906', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('16', '0', '510', '846.337829', '-1804.416992', '13.516443', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('17', '0', '510', '846.206481', '-1807.561157', '13.249277', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('18', '0', '510', '846.021545', '-1811.263549', '12.944944', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('19', '0', '510', '844.674499', '-1815.089721', '12.396476', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('20', '0', '510', '853.204223', '-1829.621582', '12.259037', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('21', '0', '510', '852.706176', '-1832.116210', '12.334656', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('22', '0', '510', '852.944274', '-1833.499877', '12.375213', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('23', '0', '510', '852.537048', '-1836.044677', '12.449804', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('24', '0', '510', '852.080932', '-1838.616943', '12.525200', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('25', '0', '510', '851.564575', '-1841.204101', '12.601034', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('26', '0', '510', '851.159973', '-1842.851074', '12.649308', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('27', '0', '510', '820.650756', '-1844.779174', '12.746999', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('28', '0', '510', '821.044311', '-1842.121826', '12.687262', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('29', '0', '510', '821.923706', '-1839.967529', '12.630483', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('30', '0', '510', '821.711364', '-1836.276000', '12.558807', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('31', '0', '510', '822.312011', '-1834.264770', '12.509083', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('32', '0', '510', '823.090026', '-1832.120483', '12.454017', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('33', '0', '510', '820.413269', '-1826.723388', '12.411422', null, '1', '1', null, '0');
INSERT INTO `vehicles` VALUES ('34', '0', '510', '852.461669', '-1871.480346', '12.867187', null, '1', '1', null, '0');
