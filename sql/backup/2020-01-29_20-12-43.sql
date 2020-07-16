#
# TABLE STRUCTURE FOR: admin_groups
#

DROP TABLE IF EXISTS `admin_groups`;

CREATE TABLE `admin_groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `admin_groups` (`id`, `name`, `description`) VALUES ('1', 'webmaster', 'Webmaster');
INSERT INTO `admin_groups` (`id`, `name`, `description`) VALUES ('2', 'admin', 'Administrator');
INSERT INTO `admin_groups` (`id`, `name`, `description`) VALUES ('3', 'manager', 'Manager');
INSERT INTO `admin_groups` (`id`, `name`, `description`) VALUES ('4', 'staff', 'Staff');


#
# TABLE STRUCTURE FOR: admin_login_attempts
#

DROP TABLE IF EXISTS `admin_login_attempts`;

CREATE TABLE `admin_login_attempts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: admin_users
#

DROP TABLE IF EXISTS `admin_users`;

CREATE TABLE `admin_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `admin_users` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`) VALUES ('1', '127.0.0.1', 'webmaster', '$2y$08$/X5gzWjesYi78GqeAv5tA.dVGBVP7C1e1PzqnYCVe5s1qhlDIPPES', NULL, NULL, NULL, NULL, NULL, NULL, '1451900190', '1580321405', '1', 'Webmaster', '');
INSERT INTO `admin_users` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`) VALUES ('2', '127.0.0.1', 'admin', '$2y$08$7Bkco6JXtC3Hu6g9ngLZDuHsFLvT7cyAxiz1FzxlX5vwccvRT7nKW', NULL, NULL, NULL, NULL, NULL, NULL, '1451900228', '1465489580', '1', 'Admin', '');
INSERT INTO `admin_users` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`) VALUES ('3', '127.0.0.1', 'manager', '$2y$08$snzIJdFXvg/rSHe0SndIAuvZyjktkjUxBXkrrGdkPy1K6r5r/dMLa', NULL, NULL, NULL, NULL, NULL, NULL, '1451900430', '1465489585', '1', 'Manager', '');
INSERT INTO `admin_users` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`) VALUES ('4', '127.0.0.1', 'staff', '$2y$08$NigAXjN23CRKllqe3KmjYuWXD5iSRPY812SijlhGeKfkrMKde9da6', NULL, NULL, NULL, NULL, NULL, NULL, '1451900439', '1465489590', '1', 'Staff', '');


#
# TABLE STRUCTURE FOR: admin_users_groups
#

DROP TABLE IF EXISTS `admin_users_groups`;

CREATE TABLE `admin_users_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `admin_users_groups` (`id`, `user_id`, `group_id`) VALUES ('1', '1', '1');
INSERT INTO `admin_users_groups` (`id`, `user_id`, `group_id`) VALUES ('2', '2', '2');
INSERT INTO `admin_users_groups` (`id`, `user_id`, `group_id`) VALUES ('3', '3', '3');
INSERT INTO `admin_users_groups` (`id`, `user_id`, `group_id`) VALUES ('4', '4', '4');


#
# TABLE STRUCTURE FOR: api_access
#

DROP TABLE IF EXISTS `api_access`;

CREATE TABLE `api_access` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(40) NOT NULL DEFAULT '',
  `controller` varchar(50) NOT NULL DEFAULT '',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: api_keys
#

DROP TABLE IF EXISTS `api_keys`;

CREATE TABLE `api_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `key` varchar(40) NOT NULL,
  `level` int(2) NOT NULL,
  `ignore_limits` tinyint(1) NOT NULL DEFAULT '0',
  `is_private_key` tinyint(1) NOT NULL DEFAULT '0',
  `ip_addresses` text,
  `date_created` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `api_keys` (`id`, `user_id`, `key`, `level`, `ignore_limits`, `is_private_key`, `ip_addresses`, `date_created`) VALUES ('1', '0', 'anonymous', '1', '1', '0', NULL, '1463388382');


#
# TABLE STRUCTURE FOR: api_limits
#

DROP TABLE IF EXISTS `api_limits`;

CREATE TABLE `api_limits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) NOT NULL,
  `count` int(10) NOT NULL,
  `hour_started` int(11) NOT NULL,
  `api_key` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: api_logs
#

DROP TABLE IF EXISTS `api_logs`;

CREATE TABLE `api_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) NOT NULL,
  `method` varchar(6) NOT NULL,
  `params` text,
  `api_key` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `time` int(11) NOT NULL,
  `rtime` float DEFAULT NULL,
  `authorized` varchar(1) NOT NULL,
  `response_code` smallint(3) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: comment
#

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id` int(200) NOT NULL AUTO_INCREMENT,
  `post_id` int(200) NOT NULL,
  `user_id` int(200) NOT NULL,
  `friend_id` int(200) NOT NULL,
  `comment` text NOT NULL,
  `is_like` int(11) NOT NULL,
  `reply` text NOT NULL,
  `friend_id_reply` int(11) NOT NULL,
  `created_at` varchar(100) NOT NULL,
  `updated_at` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

INSERT INTO `comment` (`id`, `post_id`, `user_id`, `friend_id`, `comment`, `is_like`, `reply`, `friend_id_reply`, `created_at`, `updated_at`) VALUES ('1', '1', '2', '4', '97CxFqH74vaGn2gVywkABy4ChaeOHU51DJ6DyXPXnoJ2V3tz0i3w3TFZ9vBM9bra.jpg', '0', 'amaing picture', '7', '1550226954', '1550226954');
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `friend_id`, `comment`, `is_like`, `reply`, `friend_id_reply`, `created_at`, `updated_at`) VALUES ('2', '4', '31', '3', 'nice work guys', '0', 'hey !!', '5', '1550228603', '1550228603');
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `friend_id`, `comment`, `is_like`, `reply`, `friend_id_reply`, `created_at`, `updated_at`) VALUES ('3', '1', '2', '4', '97CxFqH74vaGn2gVywkABy4ChaeOHU51DJ6DyXPXnoJ2V3tz0i3w3TFZ9vBM9bra.jpg', '0', 'grt view', '16', '155029380', '155029380');


#
# TABLE STRUCTURE FOR: device_information
#

DROP TABLE IF EXISTS `device_information`;

CREATE TABLE `device_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_token` varchar(200) NOT NULL,
  `device_type` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('5', 'sdadfdsdssafwffafqqdw2d', 'iOS', '17');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('6', 'sdadfdsdssafwffafqqdw2d', 'iOS', '19');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('7', 'sdadfdsdssafwffafqqdw2d', 'iOS', '20');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('8', 'sdadfdsdssafwffafqqdw2d', 'iOS', '21');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('9', 'jksajhjkhjj', 'iOS', '22');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('10', 'sdadfdsdssafwffafqqdw2d', 'iOS', '23');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('11', 'sdadfdsdssafwffafqqdw2d', 'iOS', '24');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('12', 'sdadfdsdssafwffafqqdw2d', 'iOS', '25');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('13', 'asjjkjdkj', 'iOS', '26');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('14', 'jksjk', 'android', '2');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('15', 'sadaf', 'iOS', '2');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('21', 'string', 'string', '36');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('23', 'string', 'pOS', '29');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('26', 'shjd', 'android', '40');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('31', 'gvjhvgh', 'ios', '47');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('32', 'gvjhvgh', 'android', '48');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('33', 'string', 'android', '50');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('34', 'dsffsd', 'android', '51');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('35', 'anajhkjsdroid', 'android', '51');
INSERT INTO `device_information` (`id`, `device_token`, `device_type`, `user_id`) VALUES ('36', 'klajskls', 'ios', '53');


#
# TABLE STRUCTURE FOR: group
#

DROP TABLE IF EXISTS `group`;

CREATE TABLE `group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `group` (`id`, `name`, `description`) VALUES ('1', 'members', 'General User');


#
# TABLE STRUCTURE FOR: like
#

DROP TABLE IF EXISTS `like`;

CREATE TABLE `like` (
  `id` int(200) NOT NULL AUTO_INCREMENT,
  `user_id` int(200) NOT NULL,
  `post_id` int(200) NOT NULL,
  `is_like` int(11) NOT NULL,
  `friend_id_like_comment` int(200) NOT NULL,
  `friend_id_like_post` int(200) NOT NULL,
  `created_at` varchar(200) NOT NULL,
  `updated_at` int(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

INSERT INTO `like` (`id`, `user_id`, `post_id`, `is_like`, `friend_id_like_comment`, `friend_id_like_post`, `created_at`, `updated_at`) VALUES ('1', '31', '4', '1', '9', '34', '1549443016', '1549453145');
INSERT INTO `like` (`id`, `user_id`, `post_id`, `is_like`, `friend_id_like_comment`, `friend_id_like_post`, `created_at`, `updated_at`) VALUES ('2', '2', '1', '1', '0', '16', '1549443016', '1549443016');
INSERT INTO `like` (`id`, `user_id`, `post_id`, `is_like`, `friend_id_like_comment`, `friend_id_like_post`, `created_at`, `updated_at`) VALUES ('3', '31', '4', '1', '4', '0', '1549443034', '1549443034');
INSERT INTO `like` (`id`, `user_id`, `post_id`, `is_like`, `friend_id_like_comment`, `friend_id_like_post`, `created_at`, `updated_at`) VALUES ('4', '31', '4', '1', '24', '18', '', '0');


#
# TABLE STRUCTURE FOR: login_attempts
#

DROP TABLE IF EXISTS `login_attempts`;

CREATE TABLE `login_attempts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: user
#

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `google_id` varchar(200) NOT NULL,
  `google_access_tk` varchar(300) NOT NULL,
  `google_image` varchar(200) NOT NULL,
  `facebook_id` varchar(200) NOT NULL,
  `fb_access_tk` varchar(300) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `dob` text NOT NULL,
  `accesskey` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('2', '', NULL, '$2y$10$6m0mfXPJcm7qVLqDAq8qMudv/iH6dbq9jTWUR55JiyQPfFFEM1dSa', NULL, 'm@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1547804808', NULL, NULL, 'ritika', 'jaiswal', NULL, NULL, '1534888800', 'tmaU0V3Ho2DkqB6R');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('3', '', NULL, '$2y$10$La2xuzOUzYr2bJKy5bH7v.3cmD0V3/OIZ2j/WD/G4a.IYiXvRs14G', NULL, 's@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1547804871', NULL, NULL, 'sharran', 'karwal', NULL, NULL, '1534888800', '6TR0Qp92oGHnaBYg');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('4', '', NULL, '', NULL, '', '', '', '', '274089803437692', 'EAAETgcj98PIBAHfc0X8myLtA0bgX1ixZBmXEtQSSessiWaBMTjyJTMmrLjA3USswozhaLwPcoeLRm7MqqGyv21hZAhQQsKYMEUFKMZA1oFa2IWZADoVQZBYOkDTZAUdkHomf9fUgTcZAb6JiwXrZBDsoxsPnGq2Sy1e3ZCS1pmlWQhH4ukzZBZAxhltCiiZBry3LOs4', NULL, NULL, NULL, NULL, '1547808165', NULL, NULL, 'Nikhil', 'Onj', NULL, NULL, '', '');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('5', '', NULL, '', NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548007153', NULL, NULL, 'nikhil', NULL, NULL, NULL, '', '');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('9', '', NULL, '', NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548006991', NULL, NULL, 'parul', 'gupta', NULL, NULL, '', '');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('16', '', NULL, '$2y$10$4j5XGw12GJIrwG51UMxqkepelAIYNq4x.Ja/WJ3zN2vVglEbw0ZIa', NULL, 'string@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548421838', NULL, NULL, 'mili', 'chauhan', NULL, NULL, '1548370800', 'jsN8xJkzrHOgZ6XBbURiuYty2f1hI7Tp');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('25', '', NULL, '', NULL, 'koolmili100@gmail.com', '', '', '', '2069513776401981', 'EAARCYSCicToBADyhfojQFqjvkg4hIDAJxXkh3InEwr6zezEY6g0ZBHNXZCoMlnPpzLV01pl6yQRiBz6N7F5Puh8zULpVuk0lbbmlROaE6KSCZAcA7PnZAWMf0yKiCXMICrJU7Dtmx99GTBHRnKZAeytiRGB33I2jzMkns6ycjYgZDZD', NULL, NULL, NULL, NULL, '1548681836', NULL, NULL, 'Mallika', 'Chauhan', NULL, NULL, '', 'pMk4vornZaPOCyA5GE6Dq2jSNKhdJbBY');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('28', '', NULL, '$2y$10$HO5IoZeQxPzy8Wcx0sNe.uZsz0uliaXGEvvyEC1nnLy2Lfyx1Zj.q', NULL, 'mallika@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548422077', NULL, NULL, 'mili', 'chauhan', NULL, NULL, '1548370800', 'wmQuzsy8eR2G7W9SfrcNI6H1UYF0JCjb');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('29', '', NULL, '$2y$10$G2tDzttP7Gmmckkj6QTDYuZcmZuGZF5nlfej.MthM85qfrNSF4WVq', NULL, 'mili@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548650803', NULL, NULL, 'mili', 'chauhan', NULL, NULL, '794444400', '4OUHDP6glbi0E1dojT2w3snAhvzYFmyf');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('30', '', NULL, '$2y$10$cG2Sl9Spb6KpnhfmFGWByOgOmBIqe8Op/01IbqlYrWOXm9yoYkQoK', NULL, 'string1@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548651188', NULL, NULL, 'string', 'string', NULL, NULL, '1548630000', '8CWjN5QytSo3KIPqHbns7z1kL42MTYwF');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('31', '', NULL, '$2y$10$nmJ2pNZucHXYRf253TwyKuOtByJJNPWl.NTlQUIUDRKRrMxP8C6zS', NULL, 'string2@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548651253', NULL, NULL, 'mallika', 'string', NULL, NULL, '1548630000', '1uT8ghNGPvHlMr6AfpkB4EzStmVjRs9Z');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('32', '', NULL, '$2y$10$Q16XJsexqgfyQrjf9XJy/.kNwCVBnei0MAT0Z5.ctUcrnCYwnMXNO', NULL, 'string4@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548651364', NULL, NULL, 'string', 'string', NULL, NULL, '1548630000', 'TEx92UHhAtSNg5Ga6R18lskuz4fcrmCb');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('33', '', NULL, '$2y$10$3x9kti4Fhbm9D9GqO1LgjuU/vC4pc3kukqBsFcvmH5qRSBgtg9Y2m', NULL, 'string5@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548651400', NULL, NULL, 'string', 'string', NULL, NULL, '1548630000', 'Ag5WUNTYJ642ljGpxVXHCweZmR8Bkq3P');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('34', '', NULL, '$2y$10$Qu6kQvV30NnM13.bgSlbW.KxDROaNoq6rWUszO1Pc4todGZNKPje2', NULL, 'string6@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548651425', NULL, NULL, 'string', 'string', NULL, NULL, '1548630000', '7e62Dk41CbYESnTqgL83OQ5VpolZsRBM');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('35', '', NULL, '$2y$10$56kgEdFp8aquBZKqyziPgegocORhnayo/SN1qjwklxuNBShkBmGim', NULL, 'string7@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548651438', NULL, NULL, 'string', 'string', NULL, NULL, '1548630000', 'KWSLroDQz9d4GPnY3xei7RBcf0VtJTa1');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('36', '', NULL, '$2y$10$b5kELmOztnOFvbliAy4qKeQhFtstYrb01CHn66uGX0xB9f33phMQ.', NULL, 'string8@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548651459', NULL, NULL, 'string', 'string', NULL, NULL, '1548630000', 'Pao4NA6EnXrj1RuTU0i5MwtKFx8kdCcS');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('37', '', NULL, '$2y$10$z8qjpt6zKdLv83BnQF8tIOT7n98Xjiet.k49VoXcUzMDGTDvQNWyS', NULL, 'a@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548678527', NULL, NULL, 'string', 'string', NULL, NULL, '1548630000', 'VdSuBHAj8i95JC7frWEQTncXsDveomgI');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('38', '', NULL, '$2y$10$/LqXYCA3B8d0BDXlC.g4AusCvNHPd988e4V9llPPGRy50IYqr90BS', NULL, 'ab@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548678561', NULL, NULL, 'string', 'string', NULL, NULL, '1548630000', '9n0utVes8JvpHNIQ3ljU2DciSBZ5o4Km');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('39', '', NULL, '$2y$10$Sa3f0COncQGs8h/CCfbczuDn15a05DCPOm36kZpTGghYxTuqGV/EC', NULL, 'abc@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548678605', NULL, NULL, 'string', 'string', NULL, NULL, '1548630000', 'IQxKrkTtpLhaq82sugofSPwHBYZdJ50l');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('40', '', NULL, '$2y$10$R.UxmD5isSHyLHNDuY4au.H/mR1xWkA1g/J3rJ2zdmuJsTdKmuNiy', NULL, 'abcd@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548678627', NULL, NULL, 'string', 'string', NULL, NULL, '1548630000', 'Cui5912ex7RVsBtLypPgoAlkwWrK0Ym8');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('41', '', NULL, '$2y$10$J7qpiikId4yLlAM6aqQV9OGneAnvTqYZUL5tRMx/zDwfEsMCEfP1a', NULL, 'jbjb@t.c', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548679346', NULL, NULL, 'jhkj', 'hjmh', NULL, NULL, '0', 'L1yND7jpkRo0TcAfsl8eBgOZIHY2rWUS');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('42', '', NULL, '$2y$10$s/I8tH4tIMJbjAEtxieWwu5fX9FdT0062kyGyGU4F6j6wyBjojNJi', NULL, 'jbjbjugj@t.c', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548679409', NULL, NULL, 'jhkj', 'hjmh', NULL, NULL, '0', 'TiUI0e5B8pLhPw712OcFSmyrvYgQWfJ4');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('43', '', NULL, '$2y$10$WXq4IMEFJKFE4JXdc2mphOBz8R/F4QFdD2wRaPW1LWb/qGA9O2pOK', NULL, 'jbjbjugjkkk@t.c', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548679448', NULL, NULL, 'jhkj', 'hjmh', NULL, NULL, '0', 'qxsgStBX0zlAh2Ene6oGRUOY7N4a9Drv');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('44', '', NULL, '$2y$10$49vCijyKQ7L9WdQpNSD.E.k5ITF4wBJcJ6XY22C3V8ObdvVJyMKAi', NULL, 'as@t.c', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548679652', NULL, NULL, 'jhkj', 'hjmh', NULL, NULL, '1548630000', 'bMgICEDc79AhjmfRUkKpJPt8LHlz51Wi');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('45', '', NULL, '$2y$10$W98oP5poqKzLhFIaRegWz.XKEkDvl.28orLZqJURT0Yjt095PbshW', NULL, 'asb@t.c', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548679835', NULL, NULL, 'miley', 'hjmh', NULL, NULL, '1233433', 'c9QH2s1GUa8yN06JMzZjVtLrDwO3iopA');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('46', '', NULL, '$2y$10$vZkYWkI9m5SCTI0Dz14gzu.QE7fh9.cLDaQuhf6OzdriZ1HD/M7Ay', NULL, 'asbd@t.c', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548680163', NULL, NULL, 'miley', 'hjmh', NULL, NULL, '1233433', '4Pcvkg3ezXj1sIw9WOBENKtlHSCoR28m');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('47', '', NULL, '$2y$10$FYDLWigUKYubPeJvR2F9oOoFcH4muLebRnTBfvfIg/lSBIOWspG3G', NULL, 'asbdef@t.c', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548680764', NULL, NULL, 'miley', 'hjmh', NULL, NULL, '1233433', 'lIvpkXKE4ZUMDy7VaQmu1ht0zNw8F2i5');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('48', '', NULL, '$2y$10$vOyIMnhhfh.ydI0RwoQrO.VAndEyiyH1o3uOlRB6Aa19oJ809fwv2', NULL, 'aef@t.c', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548680783', NULL, NULL, 'miley', 'hjmh', NULL, NULL, '1233433', 'CPLUf1c0kSBQ7agHlYyiNJedsMxrIt8F');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('49', '', NULL, '$2y$10$E3V6r9y/3o3cxJ6MVkxe4eVEWozw7cVcx1ubcPIJDvc6hUKSFHCFy', NULL, 'string123@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548681008', NULL, NULL, 'mil', 'string', NULL, NULL, '1819929', 'Sg0Xlr2i1oHjeRUJcK498EMkZnwxYDAN');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('50', '', NULL, '$2y$10$.yKlq6zRzRO8KxndO.de1uLxhMo1aYR/nLRd/tfr4Th/.noiVx/qu', NULL, 'string123hghj@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548681128', NULL, NULL, 'mil', 'string', NULL, NULL, '1819929', 'va7J3dZGhmye6l0gD19BpcibVjYfwqQI');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('51', '', NULL, '$2y$10$tzAdBc5AMw.RiaM5EIzV8ey3.xIQ4x7iAGCiaj5dq036FpkXvXbQS', NULL, 'string10@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1548844119', NULL, NULL, 'mallika', 'string', NULL, NULL, '1291829', 'SaA6i7sUTckP0e4bhXHMLnmNRgx3lGwz');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('52', '', NULL, '$2y$10$pr2F5om1xfzfzSpj2WIpIu6OOYJX9UVns4l1w.MtTDaqr1aCbBRS2', NULL, 'mail@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1549374530', NULL, NULL, 'mallika', 'ch', NULL, NULL, '219092', '0gSGWUctrBLhiua8qVe2AF7oYRsx3lJM');
INSERT INTO `user` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `google_id`, `google_access_tk`, `google_image`, `facebook_id`, `fb_access_tk`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `dob`, `accesskey`) VALUES ('53', '', NULL, '$2y$10$mS/yhMl7ZUs7NcDJS4yI2.jY2EyujS0EDJ3eIxMb9qe9CWc2ctLby', NULL, 'mail1@gmail.com', '', '', '', '', '', NULL, NULL, NULL, NULL, '1549374579', NULL, NULL, 'mallika', 'ch', NULL, NULL, '219092', 'HQpMDRP9tBlaoIwFk6yifEZ5TcJAhUjG');


#
# TABLE STRUCTURE FOR: users_groups
#

DROP TABLE IF EXISTS `users_groups`;

CREATE TABLE `users_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `users_groups` (`id`, `user_id`, `group_id`) VALUES ('1', '1', '1');


#
# TABLE STRUCTURE FOR: wall_post
#

DROP TABLE IF EXISTS `wall_post`;

CREATE TABLE `wall_post` (
  `post_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `text` text NOT NULL,
  `audio` varchar(200) NOT NULL,
  `image` varchar(200) NOT NULL,
  `video` varchar(200) NOT NULL,
  `privacy` int(11) NOT NULL,
  `latitude` varchar(100) NOT NULL,
  `longitude` varchar(100) NOT NULL,
  `created_at` int(100) NOT NULL,
  `updated_at` int(100) NOT NULL,
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

INSERT INTO `wall_post` (`post_id`, `user_id`, `text`, `audio`, `image`, `video`, `privacy`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES ('1', '2', 'mallika', '', 'I8u42L5ufMSgB5Rj4a4iMsCoRSOd8z77JmZ5xY8EXnBFdnLDF1eQm1kGF4mRG2sx.jpg', '', '0', '0', '0', '1549443016', '1549453145');
INSERT INTO `wall_post` (`post_id`, `user_id`, `text`, `audio`, `image`, `video`, `privacy`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES ('4', '31', 'New favpurite song', 'VSCZ7611ZWzeN7nxqlwgJFU3ByD1DentW9B7M04ZXaOvPgDrWXi30f8IZ5rZ99Cy.mp3', 'X44TeXYVhOARfLejI94MvnIPY716xY4Blv4JKjzHK44B522bf14UJ1mtZ91eSC25.JPG', 'y4489M5yZUrY0o5NOKbcmPi0u34yw4NRE0c4S0IBn0iANvqyFq5iY2h47cqFh0mn.mp4', '0', '0', '0', '1549449594', '1549452792');


