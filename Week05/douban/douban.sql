/*
SQLyog Ultimate v11.27 (32 bit)
MySQL - 5.7.26 : Database - douban
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`douban` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `douban`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (1,'Can add comments',1,'add_comments'),(2,'Can change comments',1,'change_comments'),(3,'Can delete comments',1,'delete_comments'),(4,'Can view comments',1,'view_comments'),(5,'Can add log entry',2,'add_logentry'),(6,'Can change log entry',2,'change_logentry'),(7,'Can delete log entry',2,'delete_logentry'),(8,'Can view log entry',2,'view_logentry'),(9,'Can add permission',3,'add_permission'),(10,'Can change permission',3,'change_permission'),(11,'Can delete permission',3,'delete_permission'),(12,'Can view permission',3,'view_permission'),(13,'Can add group',4,'add_group'),(14,'Can change group',4,'change_group'),(15,'Can delete group',4,'delete_group'),(16,'Can view group',4,'view_group'),(17,'Can add user',5,'add_user'),(18,'Can change user',5,'change_user'),(19,'Can delete user',5,'delete_user'),(20,'Can view user',5,'view_user'),(21,'Can add content type',6,'add_contenttype'),(22,'Can change content type',6,'change_contenttype'),(23,'Can delete content type',6,'delete_contenttype'),(24,'Can view content type',6,'view_contenttype'),(25,'Can add session',7,'add_session'),(26,'Can change session',7,'change_session'),(27,'Can delete session',7,'delete_session'),(28,'Can view session',7,'view_session');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `auth_user` */

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values (2,'admin','logentry'),(4,'auth','group'),(3,'auth','permission'),(5,'auth','user'),(6,'contenttypes','contenttype'),(1,'movies','comments'),(7,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (1,'contenttypes','0001_initial','2020-10-26 12:57:05.436019'),(2,'auth','0001_initial','2020-10-26 12:57:06.939826'),(3,'admin','0001_initial','2020-10-26 12:57:13.931305'),(4,'admin','0002_logentry_remove_auto_add','2020-10-26 12:57:15.302468'),(5,'admin','0003_logentry_add_action_flag_choices','2020-10-26 12:57:15.369547'),(6,'contenttypes','0002_remove_content_type_name','2020-10-26 12:57:16.303259'),(7,'auth','0002_alter_permission_name_max_length','2020-10-26 12:57:16.965791'),(8,'auth','0003_alter_user_email_max_length','2020-10-26 12:57:17.107682'),(9,'auth','0004_alter_user_username_opts','2020-10-26 12:57:17.153944'),(10,'auth','0005_alter_user_last_login_null','2020-10-26 12:57:17.607946'),(11,'auth','0006_require_contenttypes_0002','2020-10-26 12:57:17.654829'),(12,'auth','0007_alter_validators_add_error_messages','2020-10-26 12:57:17.701725'),(13,'auth','0008_alter_user_username_max_length','2020-10-26 12:57:18.361266'),(14,'auth','0009_alter_user_last_name_max_length','2020-10-26 12:57:19.016288'),(15,'auth','0010_alter_group_name_max_length','2020-10-26 12:57:19.172533'),(16,'auth','0011_update_proxy_permissions','2020-10-26 12:57:19.250679'),(17,'movies','0001_initial','2020-10-26 12:57:19.525837'),(18,'sessions','0001_initial','2020-10-26 12:57:20.064078'),(19,'movies','0002_comments_rating','2020-10-26 15:19:36.664320'),(20,'movies','0003_auto_20201027_0006','2020-10-26 16:06:31.637487');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `django_session` */

/*Table structure for table `movies_comments` */

DROP TABLE IF EXISTS `movies_comments`;

CREATE TABLE `movies_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_content` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pub_date` date NOT NULL,
  `rating` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `movies_comments` */

insert  into `movies_comments`(`id`,`user_name`,`comment_content`,`pub_date`,`rating`) values (1,'犀牛','当年的奥斯卡颁奖礼上，被如日中天的《阿甘正传》掩盖了它的光彩，而随着时间的推移，这部电影在越来越多的人们心中的地位已超越了《阿甘》。每当现实令我疲惫得产生无力感，翻出这张碟，就重获力量。毫无疑问，本片位列男人必看的电影前三名！回顾那一段经典台词：“有的人的羽翼是如此光辉，即使世界上最黑暗的牢狱，也无法长久地将他围困！”','2005-10-28',5),(2,'kingfish','不需要女主角的好电影','2006-03-22',5),(3,'文泽尔','人的生命不过是从一个洞穴通往另一个世界..然后在那个世界的雨中继续颤抖.i hope','2008-01-14',4),(4,'如小果','恐惧让你沦为囚犯，希望让你重获自由。——《肖申克的救赎》','2008-02-27',5),(5,'Eve|Classified','“这是一部男人必看的电影。”人人都这么说。但单纯从性别区分，就会让这电影变狭隘。《肖申克的救赎》突破了男人电影的局限，通篇几乎充满令人难以置信的温馨基调，而电影里最伟大的主题是“希望”。\r\n当我们无奈地遇到了如同肖申克一般囚禁了心灵自由的那种囹圄，我们是无奈的老布鲁克，灰心的瑞德，还是智慧的安迪？运用智慧，信任希望，并且勇敢面对恐惧心理，去打败它？\r\n经典的电影之所以经典，因为他们都在做同一件事——让你从不同的角度来欣赏希望的美好。','2008-05-09',5),(6,'711|湯行運','策划了19年的私奔……','2010-03-27',5),(7,'艾小柯','关于希望最强有力的注释。','2006-06-20',5),(8,'赫克托尔','有种鸟是关不住的.','2007-06-06',5),(9,'寂地','超级喜欢超级喜欢,不看的话人生不圆满.','2006-01-02',5),(10,'xworld','肖申克技术上再完美，也无法掩饰其反动、虚伪的思想实质，再回想历史上那么多倒塌的造神运动和自封为创造大同世界的政权，你就能感觉这部影片是多么的虚假可悲，但更可悲的是事实证明，人民更喜欢精神毒品，喜欢听无法实现的童话故事，你也没办法…………','2009-06-16',1),(11,'影志','Fear Can Hold You Prisoner, Hope Can Set You Free','2006-02-04',5),(12,'游牧人·芳汀','墙里的人老是喊自由，可是墙外的我们真正得到了吗？','2010-10-06',4),(13,'葱','这样的男人谁会舍得背叛。。。','2012-05-28',5),(14,'理想多钱一斤啊','Hope is a good thing, and maybe the best thing of all.','2009-10-07',4),(15,'veronique','一部没有爱情与美女的电影,却光芒四射','2006-06-15',5),(16,'珍妮的肖像','没有人会不喜欢吧！书和电影都好。','2006-11-13',5),(17,'私享史','因为1994年台湾引进了一部比较卖座的老片The Sting，被错译成了《刺激》。到了1995年本片上映时，片商觉得其剧情与《刺激》有类似的地方（大概都属于高智商的复仇？），因此被译成了《刺激1995》，1998年又有一部片子Return To Paradise因为含有牢狱情节，被译成《刺激1998》！','2005-10-08',5),(18,'挽梦忆笙歌','一部没有女主，没有爱情，没有特技的好片子，也是很多大学英语老师喜欢放给学生看的片子，这部片子讲诉的就是一个很纯粹的故事，一次的救赎，换回了自由，也是一种信念驱使他这么做，这部片子是感人的，它也让很多人成长。','2018-01-13',5),(19,'眠去','hope is a good thing','2007-02-20',5),(20,'小海','这部电影没什么好说的，史上最完美的电影，没有一秒尿尿时间！','2010-01-28',5),(21,'小耳朵图吗','越狱我感觉就是改编自这个','2007-08-21',5),(22,'快乐人生','不愧是好莱坞大片，一环扣一环，没想到最后不但逃生生天还偷偷把典狱长的贪污转移了出来，证据也送达了出去，帮助了曾经关心过自己的人，情节安排的巧妙，演员演绎的也好，是美国的，有爱国情节的我给打四分','2018-01-04',4),(23,'朝暮雪','“你知道，有些鸟儿是注定不会被关在牢笼里的，它们的每一片羽毛都闪耀着自由的光辉。”\n一部经得起时间检验的电影，豆瓣、时光网、IMDb各大电影网站都排名第一的电影。','2012-08-07',5),(24,'九尾黑猫','真的不喜欢，不好看，没感觉','2008-03-19',2),(25,'平凡的人','简洁是艺术的灵魂，冗长是肤浅的藻饰。对于这部电影，不论什么时候，我都会感恶心，我就是这么自我。','2014-06-10',1),(26,'南笙','对不起，我戒酒了。','2012-01-06',5),(27,'毛利','看完让人很振奋','2006-11-21',5),(28,'乐安蓝','明修栈道，暗渡陈仓','2008-03-02',5),(29,'小易甫','在我的心目中,它一直都是最被高估的电影。','2008-06-08',3),(30,'叶荣添','大众经典我从不感冒，为什么？我欣赏水平不行？','2011-02-21',2),(31,'A天涯任我行','可以说这是越狱系列影片的鼻祖，故事情节细腻紧凑，从被迫入狱，在狱中斗智斗勇，夹缝中求生存，以及对重获自由的极度渴望，凭借超高的智商和过人的勇气，一次次化险为夷，最终和狱友成功逃离，获得自由。侧面揭露的社会黑暗及腐败不堪入眼的一面，值得深思回味','2018-01-11',4),(32,'苏多多','这是我每年都要回顾的一部片子，每当心情低落，人生低谷的时候，或者随便什时候打开，听着摩根弗里曼低沉的声音娓娓道来故事，就会感觉好了很多。好的电影是好的人生陪伴','2018-01-20',5),(33,'橘猫爱吃鱼','这是一部关于自由、友情、正义的电影!“信念不灭，希望永存”。这其实是他们全体人的救赎，只是选择的方式不同而已。','2018-01-12',5),(34,'美好生活','肖申克中生存体制又如当今社会体制，“痛改前非”的人一次次被重新投入黑暗之中，当权者干着肮脏的勾当却会在公众面前宣讲“拯救之道”，似乎只有当性格没有棱角，思想失去火花，被“体制化”的人们习惯逆来顺受的时候才可以平安生存','2016-11-14',5),(35,'遇见彩虹?','何为救赎？只有重燃人们心中的希望才能救赎。有希望才有一切可能。即使环境再恶劣，安迪都没有放弃，坚持不懈的写信为大家换来更好的图书馆，帮助有需要的人拿到高中文凭使他们可以在社会上有生存能力，就算知道会惹怒看守也想让人们都听到美妙的歌声，点燃希望之光。有一种鸟儿是永远也关不住的。','2017-10-25',5),(36,'如是','还记得老brooks上吊自杀时心里有多难过。自由来的太晚，生命早已自行放弃。','2018-03-14',5),(37,'yocofcjx28','太感人的电影！完整看过四遍！安迪从下水道爬出后，在水里在雨中仰天长啸时，就瞬间泪奔！','2016-11-12',5),(38,'老鸡｜扶立','我最喜欢的电影','2008-01-10',5),(39,'雨果','好片，但是远比这部片更好的还很多，大家整天把这部电影稀奇得不行，其实同年的电影我更喜欢阿甘。','2016-12-23',5),(40,'赫恩曼尼','若你试自由如生命，你愿意用20年等来一日的逃脱。','2012-06-29',5),(41,'尽欢','习惯了监狱生活而接受不了正常生活的人，既真实又恐怖。勇敢面对生活，逃离自己的舒适区。','2017-12-26',5),(42,'Doublebitch','绝对是期待过高导致有点失望','2007-12-24',4),(43,'思无邪','任何时候都要坚持，坚持就会成功的，但现实能一直坚持的人是少的。值得一看','2018-01-13',5),(44,'七沐妹妹','怒赞，很难有一部电影能比《肖申克的救赎》更好的诠释梦想与救赎这两个词的关联，电影予人带来心理的洗涤震撼是如此深刻，对比安迪，我们生活中看似无以能迈不过的坎又算什么？当你若能一直心拥梦想，哪怕失败，也定能获得希望的救赎。 ','2018-01-24',5),(45,'徐小花','酣畅淋漓','2006-08-16',5),(46,'壳子','发现自己最近真的是愿意回看经典 尤其是没有女主的经典 自由与希望 多么美好的词汇 可是一个迂腐的人现在才体会到 这两个词如果一年前对我提起 那么我会表示鄙夷 会觉得这两个词太虚无缥缈 假大空 而现在 如果你向我提起 那么我会说 我爱自由和希望','2017-01-03',5),(47,'死鬼','要么忙着活 要么忙着死 人应该对现有生活保持乐观的心态 充满希望 学会享受 而不是得过且过 苟且偷生 这种人生还有什么意义呢？还不如趁早去死 活着也是浪费资源','2018-02-09',5),(48,'谋杀游戏机','高中第一节心理课。“有一种鸟是关不住的，因为它们的每一片羽毛都闪耀着自由的光辉”，但后来不幸成了我的逆反宣言……哈哈哈。','2009-09-11',5),(49,'已注销','几年前看的，看完之后挺久了才回神，第一次因为看了一部电影反思自己。是我心中电影的第一名～','2018-01-24',5),(50,'毛驴哥????','不多说了','2005-12-26',5),(51,'欢乐分裂','#重看#@影城；超越年代的“主流心灵鸡汤”依然灌得眼泪直冒；世上本无希望，若我多行一步即是希望，在绝望黑暗处生出倔强微光，卡夫卡式的悖论；每人都背负着有形无形的肖申克，注定无法被囚禁的鸟儿一定会挣脱桎梏，天才善于做梦；类型片元素大集成，充满匠气的完美作品。','2016-05-14',5),(52,'波波维奇','非常好，可惜那年有阿甘正传，但我个人认为还是这部最佳。','2018-01-20',5),(53,'蝶雨成宣','这部被称为《刺激1995》的影片在中国影迷间也有极好的口碑，可见电影超越国界的神奇之处。','2016-10-31',5),(54,'未注销','人的信念真的太强大，只要想做，而且坚持，总有一天会实现。知识的力量也是很强大的。看完这部电影，感觉自己又对美好的生活充满了向往。','2018-02-25',5),(55,'艾晨','2008年11月28日，第一次看肖申克。那时候观影量还不到五百吧。给五星是见识浅。现在差不多九年过去，我在豆瓣标注看过的已经超过三千，第二次看，还是给了五星。它当然不是最好的片，但是太滴水不漏了。','2017-08-09',5),(56,'厷糸','hope是美好的，每个人都应该存在。真的是一部很好的励志电影。','2018-02-25',5),(57,'顾俏乜','通过下水道逃出去，这真的是太震撼了，不得不说男主对自由的执念克服了一切，即使待在监狱里，因为不断学习，没和外面的世界脱轨，他才能如此从容面对一切，甚至即使是在监狱这小小世界里自己也是主宰，所以说：学习很重要，学到老活到老。','2017-05-03',4),(58,'雨滋味','救赎什么？灵魂？自由？信念？你看看这部电影就有体会了','2018-01-31',4),(59,'与你走天涯','    很多人，可能都有被自己设置的牢笼所禁锢着的时候！没有光明，没有明天，没有希望！可能你会因此沉沦，但也可能会突破它，战胜它，最终赢得自我的升华！这部电影告诉我们的似乎就是如此！\n\n    每一次的观赏，每一次的感动，都能带给我满满的希望！','2018-02-11',5),(60,'婷婷爱八卦','几年前被母亲推荐看的，她很推崇，看过后感觉可以，黑暗是每个国家都存在的，总的来说希望好人一生平安！','2017-12-20',5),(61,'程晴之','很久之前看的了，印象深刻的是一位老人在出狱后不知道如何生活了，外面的一切都是他所不熟悉的，无法正常的工作，交流，生活。最终选择结束了自己的生命。习惯真的是一种极其强大的可怕的力量！','2018-01-16',5),(62,'慕詩','自我救赎才是唯一的出口。感叹于知识改变命运啊。','2016-12-27',5),(63,'ZWW','Hope is a good thing','2017-08-09',5),(64,'公子扶苏.','这部电影好到，含义深刻到我不敢妄自评价……总之，力荐!','2018-01-13',5),(65,'孔雀鱼','这部片子播后，入狱的场景衍生一系列的同人文，教皇般的典狱长，东西两派，同性狎轧成了美国监狱片少不了的场景。当然被人津津乐道的一个场面是，男主角逃脱出狱后迎着风雨呐喊自由的场景。','2016-11-30',5),(66,'百骨金titi','真的很金典，每个人心里都有渴望不一样的自由，却又不得不被现实生活所束缚，很矛盾的个体，希望每个人能像安迪一样找到获得真正的自由。很喜欢摩根弗里曼','2018-01-12',4),(67,'安东妮','点在哪？浅白的励志片诶','2009-05-05',3),(68,'哒哒哒','坚持就是胜利啊 最终在墙上弄了个洞','2016-09-07',5),(69,'美神经','上个学期全班同学一起看的心理电影，下课了依旧不舍的坐在位置上，盯着那屏幕，看到最后，嗯，他活着出来了。信念，满满的充斥着内心，如果是我，可能早就死在那四面铜墙里了，哪还有后来呢。人生，可能就是这样，总是希望伴着绝望，那要看你是想救赎自己还是了结罢了','2017-05-03',5),(70,'我不绝望','有那么好吗？？？？？','2006-10-05',2),(71,'命中注定的爱','电影很励志，感悟很深，最主要的是让我学会坚持，送给在生活中遇到挫折的人！','2018-03-06',5),(72,'考拉小巫','最最最最最好看的电影。没有之一。','2012-07-09',5),(73,'小岩井','任何时候，都不要放弃希望。','2015-12-13',5),(74,'酒鬼一家小迷妹','经典，很久以前看的了。人活着就得有希望。','2018-03-01',5),(75,'甜鱼拌饭酱','当之无愧的无冕之王，绝对的五星，经典不容错过！','2018-03-09',5),(76,'不良生','天下大同。PS：停留在前去相逢的车子远去的背影最好，不必拍出重遇和相拥。','2016-05-18',4),(77,'世界尽头','人性伟大，会软弱，但更多的是坚韧','2017-06-08',5),(78,'秋瞑','好的电影值得所有人反复观看，这就是一部。','2018-02-03',5),(79,'Lycidas','天知道第几次重看。它最伟大可贵的地方大概一方面是多层次嵌套的丰富主题，另一方面则是一种内在的timeless品质和情感表述，因此无论观众身处哪个时代，来自何种背景，抱持怎样的心理状态，都能够有效甚至不由自主地relate其中的某个角色或某段情节。','2016-05-14',5),(80,'花落  思量错','“人活着得有希望”，一点都没有错，当老布自杀的时候我在想他应该回到监狱里度过剩余的日子，可是当安迪终于出去的时候又是那么美好，人啊真的得有希望才能快乐勇敢的活下去。当我失意的时候就想起这个片子，想起他那么努力想尽办法的脱身，觉得我一定也可以冲出重围重新站起来，真的太励志了。','2017-02-07',5),(81,'东篱','经典老电影就是不一样，重温了无数遍呢','2018-01-20',4),(82,'蓝婷飞絮','看完之后，只觉得烧脑。看第二次，我只觉得男主人太厉害了。','2016-12-30',5),(83,'沐梵','对推上神坛的电影总是莫名恐惧，以致雪藏了五六年。看完发现之所以雄踞各类榜首，是因其他至多称作经典，而它却可称作伟大。Fear Can Hold You Prisoner, Hope Can Set You Free 。Hope is a good thing.','2013-11-08',5),(84,'juvenile','救赎每次看都有一种新的感觉，没有什么能够形容我对他的崇拜，人生若是真的能自由自在的在日落的时候喝着沁人的冰啤，那该是多么美好啊。','2018-01-16',5),(85,'摇啊摇','希望有朝一日中国也能拍出这种有深刻人生内涵的电影','2018-02-19',5),(86,'深夜的光','一部没有女主,没有爱情的好电影！不可超越的励志佳片，真的很令人感动的美国电影！炒鸡推荐?五星绝对的！','2018-02-22',5),(87,'张jj','懦怯囚禁人的灵魂，希望可以令你感受自由，强者自救，圣者渡人。经典','2018-02-05',5),(88,'随风飘洋','一开始还疑惑这部片为什么叫肖申克的救赎，原来这是一部自我救赎的故事，要么忙着生，要么忙着死，心存希望就会有奇迹','2017-05-25',5),(89,'豆辛瓜辛','在这世上生存就得有一项特长，再者坚持就是胜利吧。','2018-01-10',4),(90,'炫3D','总觉得美国大片更容易直面人性，直面真实的社会。','2017-03-17',5),(91,'大志的小耳朵','精彩，永远别放弃，即使要很久以后才会成功。每天努力一点点，坚持不懈，总会有收获。','2016-12-28',5),(92,'豆瓣酱','经典是可以反复品味的，安迪对生活和自由充满向往，出狱对他来说是新生;而早已习惯了监狱生活的瑞德，已变得麻木，出狱对他来说就是死亡。','2017-01-08',4),(93,'滚滚的麻麻','重看次数最多的电影','2017-08-15',5),(94,'Paco','几年后，五星改成三星。','2015-06-30',3),(95,'ceci?','真的好好看呀，对得起它那么高的评分，我要找小说来看一遍了','2018-04-05',5),(96,'叫她孙女凯拉走','要么忙着活，要么忙着死。','2017-03-22',5),(97,'?','还是经典的老电影振奋人心，主人公逃出监狱在河流中张开双臂的画面记忆犹新。','2018-01-17',4),(98,'tlmgt','有点好奇这部片为何被过度赞誉到这个地步···','2014-02-01',2),(99,'Vžņotas','虚假的巧合被当作精妙对比，突兀的后果往往使人惊叹而不是受启发，脱离过去过于决绝。','2011-04-10',2),(100,'宇宙塑胶魔怪','史上最有名的烂俗励志片，没有之一','2009-04-25',2),(101,'杨迪','最后那一瞬间啊  ','2009-12-19',5),(102,'铃儿响叮当','好看但这么高的分有点假了吧，如果和越狱比起来，还是越狱好看些！','2017-01-05',3),(103,'潇湘烟雨','很经典的电影，也很励志，人不管身处何种境地永远不要放弃希望','2018-04-05',5),(104,'自然卷要卷毛','我以为是个压抑影片，最后，我发现了希望的光。hope，谁也无法夺走，谁也无法消灭。这部影片，值得一看。','2018-02-17',5),(105,'爱吃糖的猫','It takes a strong man to save himself, and a great man to save another. ','2017-04-03',5),(106,'齐木楠雄','非常触动人心的经典','2016-09-11',5),(107,'七七','肖申克的救赎，这部电影很好看，值得推荐','2018-02-26',4),(108,'然悔悟','很久以前就想看这部剧，今天终于看了。最震撼的就是安迪越狱的那一段，无论是配乐还是色彩或是安迪的动作神态，都掌握的很好！从此以后，他再也不用承担本不是他的惩罚，他，终于自由了！','2017-03-18',5),(109,'八贝勒爷','好多感受不能用语言表达，世界很糟糕也很美好，坚持才有希望','2018-04-04',4),(110,'梦里诗书','很难有一部电影能比《肖申克的救赎》能更好的诠释梦想与救赎这两个词的关联和真谛，电影予人带来心理的震撼与洗涤从未如此的深刻，主角安迪与男二黑人瑞德主辅相成的两条脉络营造了一个关乎追梦自由和心灵救赎最好的诠释，生活其实本就一直有着梦想，哪怕失败，只要能心拥梦想，便定能获得希望的救赎。','2015-08-02',5),(111,'弥彩心','希望总是存在的，黑暗的牢笼锁不住向往自由的灵魂。\n人生的规划可以一步一步来，着眼全局，精密布局，没有困难能够阻拦你。\n第一次看是在一个电影频道，译名为《夜黑高飞》，我觉得这个名字翻译的很好，一个向往自由的人，枷锁是不能阻挡他高飞的，哪怕牵制都做不到。','2017-04-04',5),(112,'小新脸','最喜欢的电影没有之一，看了无数遍','2018-01-19',5),(113,'小痕呀','我知道向往自由是人的本性，在艰苦的环境之中怎样与自己抗争不人云亦云是多么可贵。','2017-01-19',4),(114,'Ada?Wong??','影响自己人生观的一部电影，距离斯蒂芬·金（Stephen King）和德拉邦特（Frank Darabont）们缔造这部伟大的作品已经有十年了。我知道美好的东西想必大家都能感受，但是很抱歉，我的聒噪仍将一如既往。\n\n在我眼里，肖申克的救赎与信念、自由和友谊有关。','2016-01-07',5),(115,'穆青','懦怯囚禁人的灵魂  希望让人自由 强者自救  圣者渡人 ','2017-05-08',5),(116,'sharon','绝望里长出的希望能带来无限的勇气','2017-03-18',5),(117,'偏要勉强','太经典了！值得反复推敲，每看一次都能得到新的体悟！','2018-02-12',5),(118,'妈咪宝贝','一个内心坚强有信念的人','2016-11-05',5),(119,'?','朋友在你的生命中进进出出，好像餐厅中的侍者来来去去一样。可是每当我想起那场梦、想到那两具尸体正用力拖我下水的时候，我就觉得这样也好。有的人会沉沦，如此而已，并不公平，但世事就是这样，有的人会沉沦下去。希望还是要有的，没了希望，怎么行','2017-03-18',5),(120,'美好时光只为你','印象很深的一部电影，虽然很绝望，但永远不要放弃希望。','2017-04-29',5),(121,'请保持高冷','坚韧不拔，逆境中仍闪耀着人性的光辉','2016-08-27',5),(122,'嘻嘻','看到豆瓣排名第一，很好奇去看了这部电影，印象最深的就是图书馆的老爷爷坐50年牢出狱后因为适应不了外面的生活选择上吊自杀，最后男主获得自由，瑞德和男主在海边相遇很暖','2018-05-13',5),(123,'一蓑烟雨任平生','电影塑造了一个充满希望，向往自由的男主人公形象。在身边的人都变得体制化之后，只有他是怀有希望之人。小说里面出现过两个人的旁白，一个是男主的好朋友，一个是看守图书馆的人，以这种别人的视角来诉说，更给人一种悬疑感和真实感。','2018-04-23',5),(124,'?天神的审判','这个电影包含了友谊，艰辛，希望和梦想。之所以它获得了成功因为它感动了你，它给了你希望给了你启示！','2018-05-16',4),(125,'掉线','“hope is a good thing,maybe the best of things,and no good thing ever dies”对这片，没什么好说的吧','2012-04-21',5),(126,'途经一个你','I guess it comes to a simple choice, get busy living, or get busy dying. ','2017-05-15',5),(127,'掉皮点点','该影视简介由豆瓣网专职人员撰写或者由影片官方提供，版权属于豆瓣网，未经许可不得转载或使用整体或任何部分的内容。\n\n20世纪40年代末，小有成就的青年银行家安迪（蒂姆·罗宾斯 Tim Robbins 饰）因涉嫌杀害妻子及她的情人而锒铛入狱。在这座名为肖申克的监狱内，希望','2017-01-06',3),(128,'扌丁月佥','不管怎么说，真的很佩服男主的毅力，在那样的情况下一直没有迷失自己，追求自己向往的自由。','2017-03-22',4),(129,'蒜 | BOY A✎','2002.3.3 DVD \r\n2007.7.27 DVD home\r\n2008.8.2  CCTV6','2008-01-19',5),(130,'蔕','重温，时间只是好电影的又一个证明。二十年前的经典，二十年后还是，同样的题材，有的过去能做到，有的今天也无法领悟，这就是差距。当故事最后两个老友在蔚蓝大海边重聚拥抱的时候，希望，是最好的，美好的事永不消逝。有人问，为何肖申克的救赎备受推崇。因为这部电影并不是在讲越狱，也可以这样说，它不是为了讲越狱。人活在这个世界，或多或少都会如同片中所述，经历“体制化”，磨难，逐渐麻木，看不到希望，如老布。而这部电影最终告诉你，哪怕过去20年、30年、40年，有希望，就会有美好的事，如安迪和瑞德。观众看完这部电影，内心会跟着这部电影走过一个由绝望到希望的历程。这是一场心灵的救赎，是对观众的。这是肖申克的救赎的伟大之处。','2018-11-02',5),(131,'狗富贵','最后奔跑拥抱那里真的好感动。','2017-05-05',5),(132,'啦啦啦','应该再看一遍','2016-08-07',5),(133,'大水冲了龙王庙','经典老片，一看再看。过几天再把书看一遍！','2017-01-01',5),(134,'野生的皮皮鲁','这部影片最好地诠释了人生绝境的自我救赎。','2018-03-09',5),(135,'二十二岛主','什么都不必说，没有语言能来雕琢出这部影片所表现的精神。','2010-12-29',5),(136,'櫛森隅','永远不能失去的是希望。一个交心的挚友，一个聪明优秀的人，一份经年不变的毅力，是一只羽翼丰润，带着你的心飞出牢笼寻找希望的鸟儿。Get busy living,or get busy dying.','2017-09-24',5),(137,'侯二六','縱使《基督山伯爵》與《刺激一九九五》之間，場景與敘事手法的差異可謂不小，《刺激一九九五》卻比很多直接改編自《基督山伯爵》的影劇作品，更能體現《基督山伯爵》的精髓。全文：http://hou26.org/zeta/cristo.htm','2008-03-23',5),(138,'爱的镇魂歌','隐忍布局与一触即发的翻盘，从讨酒、写信和广播几个事件中便能对男主内敛的思绪窥见一斑，全片除精彩外更多是积压一种对自由的渴望，冲破狭隘牢笼得到海阔天空，结局不甚美好。而片中上吊的老爷子，则是早已磨灭希望的消极典型，意在与男主形成对比。','2017-01-24',5),(139,'芊颖','今天才看的，很厉害啊……这种片中国……不得不说男主很厉害啊，聪明，机智……有点心疼老布','2018-06-04',5),(140,'老人家','看分数这么高的份上把电影看了一遍，也的确实至名归！一个鲨堡监狱里面的囚犯和官员似乎是我们这个社会的众生相。比如典狱长平时道貌岸然实则不择手段，残酷阴险贪婪…','2018-03-07',5),(141,'汪金卫','不行了，我必须把五星改成四星！没有史蒂芬金的原著，这电影TMD啥也不是！','2009-11-10',4),(142,'san','应该对现有生活保持乐观的心态，充满希望，学会享受','2018-05-14',5),(143,'Muto','这部标记排名第一的电影被越来越体制化的大众标记为需求，但那虚构的希望恐怕是个偌大的笑话。根深蒂固的资本原则在被掌权者剥夺权利的《第七大陆》上呈现出多端的众生相，资本积累成了人们重返自由和尊严彼岸的唯一途径。因此《肖申克的救赎》最终是代表统治阶级的救赎，它与作为人的人没有任何关系。','2018-05-01',2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
