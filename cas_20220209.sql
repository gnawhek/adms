-- MySQL dump 10.13  Distrib 5.6.23, for Win64 (x86_64)
--
-- Host: localhost    Database: cas
-- ------------------------------------------------------
-- Server version	5.6.25-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `t_alg_pwi`
--

DROP TABLE IF EXISTS `t_alg_pwi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_alg_pwi` (
  `c_pwi` varchar(128) NOT NULL,
  `n_pwi` varchar(128) NOT NULL,
  `c_type` varchar(32) NOT NULL,
  `c_parent` varchar(128) DEFAULT NULL,
  `c_alias` varchar(64) NOT NULL,
  `y_child` varchar(1) DEFAULT 'y',
  `i_sort` int(11) NOT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`c_pwi`),
  KEY `c_type` (`c_type`),
  KEY `i_sort` (`i_sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='algorithm pwi config';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_alg_pwi`
--

LOCK TABLES `t_alg_pwi` WRITE;
/*!40000 ALTER TABLE `t_alg_pwi` DISABLE KEYS */;
INSERT INTO `t_alg_pwi` VALUES ('BLOOD','t_alg_pwi.BLOOD','health',NULL,'II_BLOOD','y',3,NULL,'2022-01-14 18:18:32'),('BONE','t_alg_pwi.BONE','health',NULL,'II_BONE','n',6,NULL,'2022-01-14 18:18:32'),('BOWEL','t_alg_pwi.BOWEL','health',NULL,'II_BOWEL','n',11,NULL,'2022-01-14 18:18:33'),('COGNI','t_alg_pwi.COGNI','health',NULL,'II_COGNI','n',10,NULL,'2022-01-14 18:18:33'),('DFSC','t_alg_pwi.DFSC','scalp','scalp','II_DFSC','n',23,NULL,'2022-01-14 18:23:58'),('DIET','t_alg_pwi.DIET','health',NULL,'II_DIET','y',4,NULL,'2022-01-14 18:18:32'),('DM','t_alg_pwi.DM','skin','DRY','I_WATER','n',40,NULL,'2022-01-14 18:39:33'),('DO','t_alg_pwi.DO','skin','DRY','I_OILY','n',41,NULL,'2022-01-14 18:39:33'),('DRY','t_alg_pwi.DRY','skin','skin','II_DRY','y',30,NULL,'2022-01-14 18:28:23'),('DYSC','t_alg_pwi.DYSC','scalp','scalp','II_DYSC','n',20,NULL,'2022-01-14 18:23:50'),('EYE','t_alg_pwi.EYE','health',NULL,'II_EYE','n',8,NULL,'2022-01-14 18:18:32'),('HAIR','t_alg_pwi.HAIR','scalp','scalp','II_HAIR','n',24,NULL,'2022-01-14 18:23:58'),('HORM','t_alg_pwi.HORM','health',NULL,'II_HORM','n',12,NULL,'2022-01-14 18:18:33'),('IMMUN','t_alg_pwi.IMMUN','health',NULL,'II_IMMUN','n',1,NULL,'2022-01-14 18:12:17'),('LIVER','t_alg_pwi.LIVER','health',NULL,'II_LIVER','n',7,NULL,'2022-01-14 18:18:32'),('METAB','t_alg_pwi.METAB','health',NULL,'II_METAB','n',2,NULL,'2022-01-14 18:18:32'),('MUSCLE','t_alg_pwi.MUSCLE','health',NULL,'II_MUSCLE','n',5,NULL,'2022-01-14 18:18:32'),('OA','t_alg_pwi.OA','skin','OILY','I_PIMPLE','n',45,NULL,'2022-01-14 18:39:33'),('OILY','t_alg_pwi.OILY','skin','skin','II_OILY','y',31,NULL,'2022-01-14 18:28:23'),('OS','t_alg_pwi.OS','skin','OILY','I_SEBUM','n',44,NULL,'2022-01-14 18:39:33'),('OYSC','t_alg_pwi.OYSC','scalp','scalp','II_OYSC','n',21,NULL,'2022-01-14 18:23:58'),('PD','t_alg_pwi.PD','skin','PIGMENT','I_PIGMENT','n',47,NULL,'2022-01-14 18:39:34'),('PF','t_alg_pwi.PF','skin','PIGMENT','I_FRECKLE','n',46,NULL,'2022-01-14 18:39:34'),('PIGMENT','t_alg_pwi.PIGMENT','skin','skin','II_PIGMENT','y',33,NULL,'2022-01-14 18:28:23'),('SA','t_alg_pwi.SA','skin','SENSITIVE','I_ALLERGY','n',43,NULL,'2022-01-14 18:39:33'),('SC','t_alg_pwi.SC','skin','SENSITIVE','I_CAPILLARY','n',42,NULL,'2022-01-14 18:39:33'),('SENSITIVE','t_alg_pwi.SENSITIVE','skin','skin','II_SENSITIVE','y',32,NULL,'2022-01-14 18:28:23'),('SLEEP','t_alg_pwi.SLEEP','health',NULL,'II_SLEEP','n',9,NULL,'2022-01-14 18:18:32'),('STSC','t_alg_pwi.STSC','scalp','scalp','II_STSC','n',22,NULL,'2022-01-14 18:23:58'),('WL','t_alg_pwi.WL','skin','WRINKLE','I_EARLY_AGING','n',48,NULL,'2022-01-14 18:39:34'),('WP','t_alg_pwi.WP','skin','WRINKLE','I_INTRINSIC_AGING','n',49,NULL,'2022-01-14 18:39:34'),('WRINKLE','t_alg_pwi.WRINKLE','skin','skin','II_WRINKLE','y',34,NULL,'2022-01-14 18:28:23');
/*!40000 ALTER TABLE `t_alg_pwi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_alg_pwi_elem`
--

DROP TABLE IF EXISTS `t_alg_pwi_elem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_alg_pwi_elem` (
  `c_pwi_elem` varchar(128) NOT NULL,
  `n_pwi_elem` varchar(128) NOT NULL,
  `c_type` varchar(32) NOT NULL,
  `c_ui_result` varchar(128) NOT NULL,
  `y_alz_only` varchar(1) DEFAULT 'n',
  `i_sort` int(11) NOT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`c_pwi_elem`),
  KEY `c_type` (`c_type`),
  KEY `c_ui_result` (`c_ui_result`),
  KEY `i_sort` (`i_sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='algorithm pwi element config';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_alg_pwi_elem`
--

LOCK TABLES `t_alg_pwi_elem` WRITE;
/*!40000 ALTER TABLE `t_alg_pwi_elem` DISABLE KEYS */;
INSERT INTO `t_alg_pwi_elem` VALUES ('I_CONZ_Q10','t_alg.I_CONZ_Q10','dna','dna.skin.scalp','n',14,'2022-01-21 15:36:28');
/*!40000 ALTER TABLE `t_alg_pwi_elem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_alg_pwi_elem_qna`
--

DROP TABLE IF EXISTS `t_alg_pwi_elem_qna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_alg_pwi_elem_qna` (
  `c_pwi_elem` varchar(128) NOT NULL,
  `c_code` varchar(128) NOT NULL COMMENT 'qna code',
  `s_exception` varchar(512) NOT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`c_pwi_elem`,`c_code`),
  KEY `c_pwi_elem` (`c_pwi_elem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='algorithm pwi element to qna tuple';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_alg_pwi_elem_qna`
--

LOCK TABLES `t_alg_pwi_elem_qna` WRITE;
/*!40000 ALTER TABLE `t_alg_pwi_elem_qna` DISABLE KEYS */;
INSERT INTO `t_alg_pwi_elem_qna` VALUES ('I_MB_FAMILY','I_HT15','[30,0,30,70]','super','2022-01-17 20:31:09');
/*!40000 ALTER TABLE `t_alg_pwi_elem_qna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_alg_pwi_elem_tuple`
--

DROP TABLE IF EXISTS `t_alg_pwi_elem_tuple`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_alg_pwi_elem_tuple` (
  `c_pwi` varchar(128) NOT NULL,
  `c_pwi_elem` varchar(128) NOT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`c_pwi`,`c_pwi_elem`),
  KEY `c_pwi` (`c_pwi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='algorithm pwi element tuple';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_alg_pwi_elem_tuple`
--

LOCK TABLES `t_alg_pwi_elem_tuple` WRITE;
/*!40000 ALTER TABLE `t_alg_pwi_elem_tuple` DISABLE KEYS */;
INSERT INTO `t_alg_pwi_elem_tuple` VALUES ('DRY','I_WATER','super','2022-01-17 20:00:25');
/*!40000 ALTER TABLE `t_alg_pwi_elem_tuple` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_alg_qna_template`
--

DROP TABLE IF EXISTS `t_alg_qna_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_alg_qna_template` (
  `c_code` varchar(32) NOT NULL,
  `s_pwi_sex` varchar(32) NOT NULL,
  `s_pwi_age` varchar(128) NOT NULL,
  `s_icon_url` varchar(256) NOT NULL,
  `s_question` varchar(512) NOT NULL,
  `s_ans` varchar(128) NOT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`c_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qna template';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_alg_qna_template`
--

LOCK TABLES `t_alg_qna_template` WRITE;
/*!40000 ALTER TABLE `t_alg_qna_template` DISABLE KEYS */;
INSERT INTO `t_alg_qna_template` VALUES ('I_HT01','M;W','A;B;C;D','http://aaa.col.kr/aaa.png','qna_template.s_question.I_H01','qna_template.s_ans.I_H01','super','2022-01-14 13:20:47'),('I_HT02','M;W','A;B;C;D','http://aaa.col.kr/aaa.png','qna_template.s_question.I_H02','qna_template.s_ans.I_H02','super','2022-01-14 17:31:51');
/*!40000 ALTER TABLE `t_alg_qna_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_alg_qna_tpl`
--

DROP TABLE IF EXISTS `t_alg_qna_tpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_alg_qna_tpl` (
  `c_qna_grp` varchar(128) NOT NULL,
  `c_code` varchar(32) NOT NULL,
  `i_sort` int(11) NOT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`c_qna_grp`,`c_code`),
  KEY `c_qna_grp` (`c_qna_grp`),
  KEY `i_sort` (`i_sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='algorithm qna template tuple';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_alg_qna_tpl`
--

LOCK TABLES `t_alg_qna_tpl` WRITE;
/*!40000 ALTER TABLE `t_alg_qna_tpl` DISABLE KEYS */;
INSERT INTO `t_alg_qna_tpl` VALUES ('BC','I_HT01',1,'super','2022-01-14 14:05:30');
/*!40000 ALTER TABLE `t_alg_qna_tpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_anlz_blood`
--

DROP TABLE IF EXISTS `t_anlz_blood`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_anlz_blood` (
  `i_memid` varchar(16) NOT NULL,
  `i_pcode` varchar(32) NOT NULL,
  `i_immunity` tinyint(4) DEFAULT NULL COMMENT '면역,염증',
  `i_cardiova` tinyint(4) DEFAULT NULL COMMENT '심혈관기능',
  `i_hyperlipid` tinyint(4) DEFAULT NULL COMMENT '고지혈증',
  `i_thyroid` tinyint(4) DEFAULT NULL COMMENT '갑상선',
  `i_liver` tinyint(4) DEFAULT NULL COMMENT '간기능',
  `i_kidney` tinyint(4) DEFAULT NULL COMMENT '신장기능',
  `i_blood` tinyint(4) DEFAULT NULL COMMENT '혈액기능',
  `i_diabetes` tinyint(4) DEFAULT NULL COMMENT '당뇨성향',
  `s_pdfurl` varchar(512) DEFAULT NULL COMMENT 'pdf url',
  `d_created_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`i_memid`,`i_pcode`),
  KEY `i_memid` (`i_memid`),
  KEY `i_pcode` (`i_pcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Blood Info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_anlz_blood`
--

LOCK TABLES `t_anlz_blood` WRITE;
/*!40000 ALTER TABLE `t_anlz_blood` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_anlz_blood` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_anlz_dna`
--

DROP TABLE IF EXISTS `t_anlz_dna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_anlz_dna` (
  `i_dna_sn` varchar(16) NOT NULL,
  `i_memid` varchar(16) NOT NULL,
  `i_sk_ts` decimal(5,2) DEFAULT NULL COMMENT '튼살 및 각질',
  `i_sk_ts_01` decimal(5,2) DEFAULT NULL COMMENT '튼살',
  `i_sk_ts_02` decimal(5,2) DEFAULT NULL COMMENT '각질',
  `i_sk_yd` decimal(5,2) DEFAULT NULL COMMENT '여드름발생',
  `i_sk_yd2` decimal(5,2) DEFAULT NULL COMMENT '피부염증',
  `i_sk_yd2_01` decimal(5,2) DEFAULT NULL COMMENT '접촉성 피부염',
  `i_sk_yd2_02` decimal(5,2) DEFAULT NULL COMMENT '건선',
  `i_sk_yd2_03` decimal(5,2) DEFAULT NULL COMMENT '아토피 피부염',
  `i_sk_yd2_04` decimal(5,2) DEFAULT NULL COMMENT '여드름',
  `i_g2me_sp` decimal(5,2) DEFAULT NULL COMMENT '색소침착',
  `i_sk_sp2` decimal(5,2) DEFAULT NULL COMMENT '기미 주근깨',
  `i_sk_sa` decimal(5,2) DEFAULT NULL COMMENT '피부노화',
  `i_sk_ty` decimal(5,2) DEFAULT NULL COMMENT '태양 노출 후 태닝반응 (광노화)',
  `i_nut_ca` decimal(5,2) DEFAULT NULL COMMENT '칼슘',
  `i_nut_fe` decimal(5,2) DEFAULT NULL COMMENT '철농도',
  `i_nut_vd` decimal(5,2) DEFAULT NULL COMMENT '비타민 D 농도',
  `i_nut_kl` decimal(5,2) DEFAULT NULL COMMENT '칼륨농도',
  `i_g2me_bp` decimal(5,2) DEFAULT NULL COMMENT '혈압',
  `i_nut_fa` decimal(5,2) DEFAULT NULL COMMENT '지방산',
  `i_nut_fa_01` decimal(5,2) DEFAULT NULL COMMENT '오메가 3',
  `i_nut_fa_02` decimal(5,2) DEFAULT NULL COMMENT '오메가 6',
  `i_g2me_vc` decimal(5,2) DEFAULT NULL COMMENT '비타민 C 농도',
  `i_nut_mg` decimal(5,2) DEFAULT NULL COMMENT '마그네슘',
  `i_nut_ay` decimal(5,2) DEFAULT NULL COMMENT '아연농도',
  `i_g2me_bs` decimal(5,2) DEFAULT NULL COMMENT '혈당',
  `i_nut_arg` decimal(5,2) DEFAULT NULL COMMENT '아르기닌 농도',
  `i_nut_arg_01` decimal(5,2) DEFAULT NULL COMMENT 'L-아르기닌',
  `i_nut_arg_02` decimal(5,2) DEFAULT NULL COMMENT 'SDMA',
  `i_conz_q10` decimal(5,2) DEFAULT NULL COMMENT '코엔자임큐텐',
  `i_sleep_hab` decimal(5,2) DEFAULT NULL COMMENT '수면습관',
  `i_g2me_cl` decimal(5,2) DEFAULT NULL COMMENT '콜레스테롤',
  `i_g2me_cl_01` decimal(5,2) DEFAULT NULL COMMENT '총 콜레스테롤',
  `i_g2me_cl_02` decimal(5,2) DEFAULT NULL COMMENT '고밀도 콜레스테롤',
  `i_g2me_cl_03` decimal(5,2) DEFAULT NULL COMMENT '저밀도 콜레스테롤',
  `i_fod_sk` decimal(5,2) DEFAULT NULL COMMENT '식욕',
  `i_g2me_tg` decimal(5,2) DEFAULT NULL COMMENT '중성지방농도',
  `i_hth_cj` decimal(5,2) DEFAULT NULL COMMENT '체지방률',
  `i_fod_pm` decimal(5,2) DEFAULT NULL COMMENT '포만감',
  `i_ob_ty` decimal(5,2) DEFAULT NULL COMMENT '비만',
  `i_g2me_bm` decimal(5,2) DEFAULT NULL COMMENT '체질량지수',
  `i_phy_fit` decimal(5,2) DEFAULT NULL COMMENT '근육발달능력',
  `i_g2me_mb` decimal(5,2) DEFAULT NULL COMMENT '남성형탈모',
  `i_g2me_ht` decimal(5,2) DEFAULT NULL COMMENT '모발굵기',
  `i_g2me_aa` decimal(5,2) DEFAULT NULL COMMENT '원형 탈모',
  `i_ob_abdo` decimal(5,2) DEFAULT NULL COMMENT '복부비만',
  `i_wl_exe` decimal(5,2) DEFAULT NULL COMMENT '운동에 의한 체중감량 효과',
  `i_g2me_b12` decimal(5,2) DEFAULT NULL COMMENT '비타민B12 농도',
  `i_g2me_lutein` decimal(5,2) DEFAULT NULL COMMENT '루테인 지아잔틴 농도',
  `i_g2me_va` decimal(5,2) DEFAULT NULL COMMENT '비타민A 농도',
  `i_vita_e` decimal(5,2) DEFAULT NULL COMMENT '비타민E',
  `i_selenium` decimal(5,2) DEFAULT NULL COMMENT '셀레늄',
  `i_vita_b6` decimal(5,2) DEFAULT NULL COMMENT '비타민B6',
  `s_pdfurl` varchar(512) DEFAULT NULL COMMENT 'pdf url',
  `c_dna_type` varchar(10) DEFAULT NULL COMMENT 'dtc as DTC, ext as 일반질환',
  `y_use` varchar(1) DEFAULT NULL,
  `d_created_dt` datetime NOT NULL,
  PRIMARY KEY (`i_dna_sn`),
  KEY `i_memid` (`i_memid`),
  KEY `d_reg_dt` (`d_created_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='DTC genetic information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_anlz_dna`
--

LOCK TABLES `t_anlz_dna` WRITE;
/*!40000 ALTER TABLE `t_anlz_dna` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_anlz_dna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_anlz_dna_ext`
--

DROP TABLE IF EXISTS `t_anlz_dna_ext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_anlz_dna_ext` (
  `i_dna_sn` varchar(16) NOT NULL,
  `i_memid` varchar(16) NOT NULL,
  `i_atop_derm` decimal(5,2) DEFAULT NULL COMMENT '아토피피부염',
  `i_al_rhinit` decimal(5,2) DEFAULT NULL COMMENT '알레르기비염',
  `i_psoria` decimal(5,2) DEFAULT NULL COMMENT '건선',
  `i_knee_oste` decimal(5,2) DEFAULT NULL COMMENT '골관절염',
  `i_crohn` decimal(5,2) DEFAULT NULL COMMENT '크론병',
  `i_makula` decimal(5,2) DEFAULT NULL COMMENT '황반변성 ',
  `i_asthma` decimal(5,2) DEFAULT NULL COMMENT '천식',
  `i_stroke` decimal(5,2) DEFAULT NULL COMMENT '뇌졸중',
  `i_coro_arte` decimal(5,2) DEFAULT NULL COMMENT '관상동맥',
  `i_cer_aneury` decimal(5,2) DEFAULT NULL COMMENT '뇌동맥류',
  `i_hyper_lipid` decimal(5,2) DEFAULT NULL COMMENT '고지혈증',
  `i_cardiac_inf` decimal(5,2) DEFAULT NULL COMMENT '심근경색',
  `i_dementia` decimal(5,2) DEFAULT NULL COMMENT '치매',
  `i_high_bp` decimal(5,2) DEFAULT NULL COMMENT '고혈압',
  `i_glaucoma` decimal(5,2) DEFAULT NULL COMMENT '녹내장',
  `i_noal_fat_liver` decimal(5,2) DEFAULT NULL COMMENT '비알콜성지방간',
  `i_type2_diab` decimal(5,2) DEFAULT NULL COMMENT '2형당뇨',
  `i_osteopor` decimal(5,2) DEFAULT NULL COMMENT '골다공증',
  `i_gout` decimal(5,2) DEFAULT NULL COMMENT '통풍',
  `i_lupus_ery` decimal(5,2) DEFAULT NULL COMMENT '홍반성 루푸스',
  `i_rheuma_art` decimal(5,2) DEFAULT NULL COMMENT '류마티스관절염',
  `i_vita_a` decimal(5,2) DEFAULT NULL COMMENT '비타민A',
  `i_vita_e` decimal(5,2) DEFAULT NULL COMMENT '비타민E',
  `i_selenium` decimal(5,2) DEFAULT NULL COMMENT '셀레늄',
  `i_vita_b6` decimal(5,2) DEFAULT NULL COMMENT '비타민B6',
  `i_vita_b12` decimal(5,2) DEFAULT NULL COMMENT '비타민B12',
  `i_lutein` decimal(5,2) DEFAULT NULL COMMENT '루테인',
  `s_pdfurl` varchar(512) DEFAULT NULL COMMENT 'pdf url',
  `y_use` varchar(1) DEFAULT NULL,
  `d_created_dt` datetime NOT NULL,
  PRIMARY KEY (`i_dna_sn`),
  KEY `i_memid` (`i_memid`),
  KEY `d_reg_dt` (`d_created_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='extended genetic information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_anlz_dna_ext`
--

LOCK TABLES `t_anlz_dna_ext` WRITE;
/*!40000 ALTER TABLE `t_anlz_dna_ext` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_anlz_dna_ext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_anlz_dna_ext_raw`
--

DROP TABLE IF EXISTS `t_anlz_dna_ext_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_anlz_dna_ext_raw` (
  `i_dna_sn` varchar(16) NOT NULL,
  `i_atop_derm` decimal(5,2) DEFAULT NULL COMMENT '아토피피부염',
  `i_al_rhinit` decimal(5,2) DEFAULT NULL COMMENT '알레르기비염',
  `i_psoria` decimal(5,2) DEFAULT NULL COMMENT '건선',
  `i_knee_oste` decimal(5,2) DEFAULT NULL COMMENT '골관절염',
  `i_crohn` decimal(5,2) DEFAULT NULL COMMENT '크론병',
  `i_makula` decimal(5,2) DEFAULT NULL COMMENT '황반변성 ',
  `i_asthma` decimal(5,2) DEFAULT NULL COMMENT '천식',
  `i_stroke` decimal(5,2) DEFAULT NULL COMMENT '뇌졸중',
  `i_coro_arte` decimal(5,2) DEFAULT NULL COMMENT '관상동맥',
  `i_cer_aneury` decimal(5,2) DEFAULT NULL COMMENT '뇌동맥류',
  `i_hyper_lipid` decimal(5,2) DEFAULT NULL COMMENT '고지혈증',
  `i_cardiac_inf` decimal(5,2) DEFAULT NULL COMMENT '심근경색',
  `i_dementia` decimal(5,2) DEFAULT NULL COMMENT '치매',
  `i_high_bp` decimal(5,2) DEFAULT NULL COMMENT '고혈압',
  `i_glaucoma` decimal(5,2) DEFAULT NULL COMMENT '녹내장',
  `i_noal_fat_liver` decimal(5,2) DEFAULT NULL COMMENT '비알콜성지방간',
  `i_type2_diab` decimal(5,2) DEFAULT NULL COMMENT '2형당뇨',
  `i_osteopor` decimal(5,2) DEFAULT NULL COMMENT '골다공증',
  `i_gout` decimal(5,2) DEFAULT NULL COMMENT '통풍',
  `i_lupus_ery` decimal(5,2) DEFAULT NULL COMMENT '홍반성 루푸스',
  `i_rheuma_art` decimal(5,2) DEFAULT NULL COMMENT '류마티스관절염',
  `i_vita_a` decimal(5,2) DEFAULT NULL COMMENT '비타민A',
  `i_vita_e` decimal(5,2) DEFAULT NULL COMMENT '비타민E',
  `i_selenium` decimal(5,2) DEFAULT NULL COMMENT '셀레늄',
  `i_vita_b6` decimal(5,2) DEFAULT NULL COMMENT '비타민B6',
  `i_vita_b12` decimal(5,2) DEFAULT NULL COMMENT '비타민B12',
  `i_lutein` decimal(5,2) DEFAULT NULL COMMENT '루테인',
  `s_pdfurl` varchar(512) DEFAULT NULL COMMENT 'pdf url',
  `y_use` varchar(1) DEFAULT NULL,
  `d_created_dt` datetime NOT NULL,
  PRIMARY KEY (`i_dna_sn`),
  KEY `d_reg_dt` (`d_created_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Genetic information Extended raw data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_anlz_dna_ext_raw`
--

LOCK TABLES `t_anlz_dna_ext_raw` WRITE;
/*!40000 ALTER TABLE `t_anlz_dna_ext_raw` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_anlz_dna_ext_raw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_anlz_microbiome`
--

DROP TABLE IF EXISTS `t_anlz_microbiome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_anlz_microbiome` (
  `i_microb_sn` varchar(16) NOT NULL,
  `i_memid` varchar(16) NOT NULL,
  `i_in_cons` tinyint(4) DEFAULT NULL COMMENT '변비',
  `i_in_diar` tinyint(4) DEFAULT NULL COMMENT '설사',
  `i_in_abdo` tinyint(4) DEFAULT NULL COMMENT '복부충만감',
  `i_in_sibo` tinyint(4) DEFAULT NULL COMMENT '장내세균과성장',
  `i_ft_life` tinyint(4) DEFAULT NULL COMMENT '삶의만족',
  `i_ft_stress` tinyint(4) DEFAULT NULL COMMENT '스트레스',
  `i_ft_concent` tinyint(4) DEFAULT NULL COMMENT '집중력저하',
  `i_ft_sleep` tinyint(4) DEFAULT NULL COMMENT '수면건강',
  `i_ob_weight` tinyint(4) DEFAULT NULL COMMENT '체중관리',
  `i_ob_blood` tinyint(4) DEFAULT NULL COMMENT '혈액순환',
  `i_ob_alcohol` tinyint(4) DEFAULT NULL COMMENT '알코올분해',
  `i_ob_scfa` tinyint(4) DEFAULT NULL COMMENT '짧은사슬지방산',
  `i_im_value` decimal(4,2) DEFAULT NULL COMMENT '면역',
  `i_mbio_in` decimal(4,2) DEFAULT NULL COMMENT '장건강',
  `i_mbio_fa` decimal(4,2) DEFAULT NULL COMMENT '피로',
  `i_mbio_ob` decimal(4,2) DEFAULT NULL COMMENT '비만',
  `i_mbio_im` decimal(4,2) DEFAULT NULL COMMENT '면역',
  `s_token` varchar(64) DEFAULT NULL,
  `s_pdfurl` varchar(512) DEFAULT NULL COMMENT 'pdf url',
  `d_created_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`i_microb_sn`),
  KEY `i_memid` (`i_memid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='microbiome';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_anlz_microbiome`
--

LOCK TABLES `t_anlz_microbiome` WRITE;
/*!40000 ALTER TABLE `t_anlz_microbiome` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_anlz_microbiome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_anlz_nhis`
--

DROP TABLE IF EXISTS `t_anlz_nhis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_anlz_nhis` (
  `i_memid` varchar(16) NOT NULL COMMENT 'memid',
  `s_checkup_year` varchar(4) NOT NULL COMMENT '검진년도',
  `s_checkup_date` varchar(4) NOT NULL COMMENT '검진일자',
  `s_height` varchar(10) DEFAULT NULL COMMENT '신장',
  `s_weight` varchar(10) DEFAULT NULL COMMENT '체중',
  `s_waist` varchar(10) DEFAULT NULL COMMENT '허리둘레',
  `s_bmi` varchar(10) DEFAULT NULL COMMENT '체질량지수',
  `s_sight` varchar(10) DEFAULT NULL COMMENT '시력',
  `s_hearing` varchar(10) DEFAULT NULL COMMENT '청력',
  `s_blood_pressure` varchar(10) DEFAULT NULL COMMENT '혈압',
  `s_urinary_protein` varchar(10) DEFAULT NULL COMMENT '요단백',
  `s_hemoglobin` varchar(10) DEFAULT NULL COMMENT '혈색소',
  `s_fasting_blood_suger` varchar(10) DEFAULT NULL COMMENT '식전혈당',
  `s_total_cholesterol` varchar(10) DEFAULT NULL COMMENT '총콜레스테롤',
  `s_hdl_cholesterol` varchar(10) DEFAULT NULL COMMENT 'HDL콜레스테롤',
  `s_triglyceride` varchar(10) DEFAULT NULL COMMENT '트리글리세라이드',
  `s_ldl_cholesterol` varchar(10) DEFAULT NULL COMMENT 'LDL콜레스테롤',
  `s_serum_creatinine` varchar(10) DEFAULT NULL COMMENT '혈청크레아티닌',
  `s_gfr` varchar(10) DEFAULT NULL COMMENT '신사규체여과율(GFR)',
  `s_ast` varchar(10) DEFAULT NULL COMMENT 'AST(SGOT)',
  `s_alt` varchar(10) DEFAULT NULL COMMENT 'ALT(SGPT)',
  `s_ygpt` varchar(10) DEFAULT NULL COMMENT '감마지피티(y-GPT)',
  `s_tbchest_disease` varchar(10) DEFAULT NULL COMMENT '폐결핵흉부질환',
  `s_osteoporosis` varchar(10) DEFAULT NULL COMMENT '골다공증',
  `s_judgement` varchar(32) DEFAULT NULL COMMENT '판정',
  `s_org_name` varchar(64) DEFAULT NULL COMMENT '검진기관명',
  `d_analysis_dt` datetime NOT NULL,
  `d_created_dt` datetime NOT NULL,
  PRIMARY KEY (`i_memid`,`s_checkup_year`,`s_checkup_date`),
  KEY `i_memid` (`i_memid`),
  KEY `d_reg_dt` (`d_created_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='NHIS analysis information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_anlz_nhis`
--

LOCK TABLES `t_anlz_nhis` WRITE;
/*!40000 ALTER TABLE `t_anlz_nhis` DISABLE KEYS */;
INSERT INTO `t_anlz_nhis` VALUES ('1000002201070001','2019','0716','171.6','71.6','83.0','24.3','1.0/1.0','정상/정상','122/77','약양성','14.7','79','208','45','116','139','0.8','109','17','11','19','정상','','정B','연세스타내과의원','2019-07-16 00:00:00','2021-03-18 18:32:29');
/*!40000 ALTER TABLE `t_anlz_nhis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_anlz_nhis_val`
--

DROP TABLE IF EXISTS `t_anlz_nhis_val`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_anlz_nhis_val` (
  `i_memid` varchar(16) NOT NULL COMMENT 'memid',
  `s_checkup_year` varchar(4) NOT NULL COMMENT '검진년도',
  `s_checkup_date` varchar(4) NOT NULL COMMENT '검진일자',
  `i_waist` decimal(5,2) DEFAULT NULL COMMENT '허리둘레',
  `i_bmi` decimal(5,2) DEFAULT NULL COMMENT '체질량지수',
  `i_blood_pressure` decimal(5,2) DEFAULT NULL COMMENT '수축기혈압',
  `i_fasting_blood_suger` decimal(5,2) DEFAULT NULL COMMENT '식전혈당',
  `i_total_cholesterol` decimal(5,2) DEFAULT NULL COMMENT '총콜레스테롤',
  `i_hdl_cholesterol` decimal(5,2) DEFAULT NULL COMMENT 'HDL콜레스테롤',
  `i_triglyceride` decimal(5,2) DEFAULT NULL COMMENT '트리글리세라이드',
  `i_ldl_cholesterol` decimal(5,2) DEFAULT NULL COMMENT 'LDL콜레스테롤',
  `i_hemoglobin` decimal(5,2) DEFAULT NULL COMMENT '혈색소',
  `i_ast` decimal(5,2) DEFAULT NULL COMMENT 'AST(SGOT)',
  `i_alt` decimal(5,2) DEFAULT NULL COMMENT 'ALT(SGPT)',
  `i_ygpt` decimal(5,2) DEFAULT NULL COMMENT '감마지피티(y-GPT)',
  `d_analysis_dt` datetime NOT NULL,
  `d_created_dt` datetime NOT NULL,
  PRIMARY KEY (`i_memid`,`s_checkup_year`,`s_checkup_date`),
  KEY `i_memid` (`i_memid`),
  KEY `d_analysis_dt` (`d_analysis_dt`),
  KEY `d_reg_dt` (`d_created_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='NHIS analysis percentage';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_anlz_nhis_val`
--

LOCK TABLES `t_anlz_nhis_val` WRITE;
/*!40000 ALTER TABLE `t_anlz_nhis_val` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_anlz_nhis_val` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_anlz_qna`
--

DROP TABLE IF EXISTS `t_anlz_qna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_anlz_qna` (
  `i_memid` varchar(16) NOT NULL,
  `s_date` varchar(8) NOT NULL,
  `c_qcode` varchar(2) NOT NULL,
  `i_bmi` decimal(5,2) DEFAULT NULL,
  `c_bmicode` varchar(2) DEFAULT NULL,
  `i_height` decimal(5,2) DEFAULT NULL,
  `i_weight` decimal(5,2) DEFAULT NULL,
  `i_bfr` decimal(5,2) DEFAULT NULL COMMENT '전자저울',
  `i_vwc` decimal(5,2) DEFAULT NULL COMMENT '전자저울',
  `i_rom` decimal(5,2) DEFAULT NULL COMMENT '전자저울',
  `c_ver` varchar(32) DEFAULT NULL,
  `s_qna` text,
  `y_fin` varchar(1) NOT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`i_memid`,`s_date`),
  KEY `i_memid` (`i_memid`),
  KEY `s_date` (`s_date`),
  KEY `y_fin` (`y_fin`),
  KEY `d_mod_dt` (`d_mod_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qna document';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_anlz_qna`
--

LOCK TABLES `t_anlz_qna` WRITE;
/*!40000 ALTER TABLE `t_anlz_qna` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_anlz_qna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_channel`
--

DROP TABLE IF EXISTS `t_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_channel` (
  `c_shop` int(11) NOT NULL,
  `n_shop` varchar(50) DEFAULT NULL,
  `cm_id` varchar(30) NOT NULL,
  `c_oper` enum('O','C') NOT NULL COMMENT 'O as in operation, C as closed',
  `y_closed_auth` varchar(1) DEFAULT 'n' COMMENT 'closed authorization',
  `d_reg_dt` datetime DEFAULT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`c_shop`),
  KEY `cm_id` (`cm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='shop info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_channel`
--

LOCK TABLES `t_channel` WRITE;
/*!40000 ALTER TABLE `t_channel` DISABLE KEYS */;
INSERT INTO `t_channel` VALUES (100000,'dma shop','dma','O','n','2022-01-07 07:10:49','super','2022-01-07 07:10:49');
/*!40000 ALTER TABLE `t_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_customer`
--

DROP TABLE IF EXISTS `t_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_customer` (
  `i_memid` varchar(16) NOT NULL COMMENT 'c_shopYYMMDD0001',
  `c_shop` int(11) DEFAULT NULL,
  `d_reg_dt` datetime NOT NULL,
  `y_use` varchar(1) DEFAULT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`i_memid`),
  KEY `c_shop` (`c_shop`),
  KEY `d_reg_dt` (`d_reg_dt`),
  KEY `d_mod_dt` (`d_mod_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='customers in the shop';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_customer`
--

LOCK TABLES `t_customer` WRITE;
/*!40000 ALTER TABLE `t_customer` DISABLE KEYS */;
INSERT INTO `t_customer` VALUES ('1000002201300001',100000,'2022-01-30 01:13:57','y','testid','2022-01-30 01:13:57'),('1000002201300002',100000,'2022-01-30 01:14:07','y','testid','2022-01-30 01:14:07'),('1000002201300003',100000,'2022-01-30 23:51:59','y','testtest','2022-01-30 23:51:59'),('1000002202040001',100000,'2022-02-04 16:06:16','y','234234234','2022-02-04 16:06:16'),('1000002202090001',100000,'2022-02-09 14:22:48','y','mark2dssddf','2022-02-09 14:22:48');
/*!40000 ALTER TABLE `t_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dna_raw`
--

DROP TABLE IF EXISTS `t_dna_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_dna_raw` (
  `i_dna_sn` varchar(16) NOT NULL,
  `i_sk_ts` decimal(5,2) DEFAULT NULL COMMENT '튼살 및 각질',
  `i_sk_ts_01` decimal(5,2) DEFAULT NULL COMMENT '튼',
  `i_sk_ts_02` decimal(5,2) DEFAULT NULL COMMENT '각',
  `i_sk_yd` decimal(5,2) DEFAULT NULL COMMENT '여드름발생',
  `i_sk_yd2` decimal(5,2) DEFAULT NULL COMMENT '피부염증',
  `i_sk_yd2_01` decimal(5,2) DEFAULT NULL COMMENT '접촉성 피부염',
  `i_sk_yd2_02` decimal(5,2) DEFAULT NULL COMMENT '건선',
  `i_sk_yd2_03` decimal(5,2) DEFAULT NULL COMMENT '아토피 피부염',
  `i_sk_yd2_04` decimal(5,2) DEFAULT NULL COMMENT '여드름',
  `i_g2me_sp` decimal(5,2) DEFAULT NULL COMMENT '색소침착',
  `i_sk_sp2` decimal(5,2) DEFAULT NULL COMMENT '기미 주근깨',
  `i_sk_sa` decimal(5,2) DEFAULT NULL COMMENT '피부노화',
  `i_sk_ty` decimal(5,2) DEFAULT NULL COMMENT '태양 노출 후 태닝반응 (광노화)',
  `i_nut_ca` decimal(5,2) DEFAULT NULL COMMENT '칼슘',
  `i_nut_fe` decimal(5,2) DEFAULT NULL COMMENT '철농도',
  `i_nut_vd` decimal(5,2) DEFAULT NULL COMMENT '비타민 D 농도',
  `i_nut_kl` decimal(5,2) DEFAULT NULL COMMENT '칼륨농도',
  `i_g2me_bp` decimal(5,2) DEFAULT NULL COMMENT '혈압',
  `i_nut_fa` decimal(5,2) DEFAULT NULL COMMENT '지방산',
  `i_nut_fa_01` decimal(5,2) DEFAULT NULL COMMENT '오메가 3',
  `i_nut_fa_02` decimal(5,2) DEFAULT NULL COMMENT '오메가 6',
  `i_g2me_vc` decimal(5,2) DEFAULT NULL COMMENT '비타민 C 농도',
  `i_nut_mg` decimal(5,2) DEFAULT NULL COMMENT '마그네슘',
  `i_nut_ay` decimal(5,2) DEFAULT NULL COMMENT '아연농도',
  `i_g2me_bs` decimal(5,2) DEFAULT NULL COMMENT '혈당',
  `i_nut_arg` decimal(5,2) DEFAULT NULL COMMENT '아르기닌 농도',
  `i_nut_arg_01` decimal(5,2) DEFAULT NULL COMMENT 'L-아르기닌',
  `i_nut_arg_02` decimal(5,2) DEFAULT NULL COMMENT 'SDMA',
  `i_conz_q10` decimal(5,2) DEFAULT NULL COMMENT '코엔자임큐텐',
  `i_sleep_hab` decimal(5,2) DEFAULT NULL COMMENT '수면습관',
  `i_g2me_cl` decimal(5,2) DEFAULT NULL COMMENT '콜레스테롤',
  `i_g2me_cl_01` decimal(5,2) DEFAULT NULL COMMENT '총 콜레스테롤',
  `i_g2me_cl_02` decimal(5,2) DEFAULT NULL COMMENT '고밀도 콜레스테롤',
  `i_g2me_cl_03` decimal(5,2) DEFAULT NULL COMMENT '저밀도 콜레스테롤',
  `i_fod_sk` decimal(5,2) DEFAULT NULL COMMENT '식욕',
  `i_g2me_tg` decimal(5,2) DEFAULT NULL COMMENT '중성지방농도',
  `i_hth_cj` decimal(5,2) DEFAULT NULL COMMENT '체지방률',
  `i_fod_pm` decimal(5,2) DEFAULT NULL COMMENT '포만감',
  `i_ob_ty` decimal(5,2) DEFAULT NULL COMMENT '비만',
  `i_g2me_bm` decimal(5,2) DEFAULT NULL COMMENT '체질량지수',
  `i_phy_fit` decimal(5,2) DEFAULT NULL COMMENT '근육발달능력',
  `i_g2me_mb` decimal(5,2) DEFAULT NULL COMMENT '남성형탈모',
  `i_g2me_ht` decimal(5,2) DEFAULT NULL COMMENT '모발굵기',
  `i_g2me_aa` decimal(5,2) DEFAULT NULL COMMENT '원형 탈모',
  `i_ob_abdo` decimal(5,2) DEFAULT NULL COMMENT '복부비만',
  `i_wl_exe` decimal(5,2) DEFAULT NULL COMMENT '운동에 의한 체중감량 효과',
  `i_g2me_b12` decimal(5,2) DEFAULT NULL COMMENT '비타민B12 농도',
  `i_g2me_lutein` decimal(5,2) DEFAULT NULL COMMENT '루테인 지아잔틴 농도',
  `i_g2me_va` decimal(5,2) DEFAULT NULL COMMENT '비타민A 농도',
  `i_vita_e` decimal(5,2) DEFAULT NULL COMMENT '비타민E',
  `i_selenium` decimal(5,2) DEFAULT NULL COMMENT '셀레늄',
  `i_vita_b6` decimal(5,2) DEFAULT NULL COMMENT '비타민B6',
  `s_pdfurl` varchar(512) DEFAULT NULL COMMENT 'pdf url',
  `c_dna_type` varchar(10) DEFAULT NULL,
  `y_use` varchar(1) DEFAULT NULL,
  `d_created_dt` datetime NOT NULL,
  PRIMARY KEY (`i_dna_sn`),
  KEY `d_reg_dt` (`d_created_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='genetic information raw data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dna_raw`
--

LOCK TABLES `t_dna_raw` WRITE;
/*!40000 ALTER TABLE `t_dna_raw` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_dna_raw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_i18n`
--

DROP TABLE IF EXISTS `t_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_i18n` (
  `s_code` varchar(128) NOT NULL,
  `s_locale` varchar(12) NOT NULL,
  `s_desc` text,
  PRIMARY KEY (`s_code`,`s_locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='i18n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_i18n`
--

LOCK TABLES `t_i18n` WRITE;
/*!40000 ALTER TABLE `t_i18n` DISABLE KEYS */;
INSERT INTO `t_i18n` VALUES ('alg.qna.group.BC','ko','혈행'),('alg.qna.group.BONE','ko','뼈건강'),('alg.qna.group.COGNITIVE','ko','인지능력'),('alg.qna.group.DIET','ko','비만'),('alg.qna.group.ENERGY','ko','에너지활력'),('alg.qna.group.EYESTRESS','ko','눈스트레스'),('alg.qna.group.IM','ko','면역'),('alg.qna.group.INDIGEST','ko','장건강'),('alg.qna.group.LIVER','ko','간피로'),('alg.qna.group.MB','ko','대사'),('alg.qna.group.MUSCLE','ko','근감소'),('alg.qna.group.SCALP','ko','두피탈모'),('alg.qna.group.SKIN','ko','피부'),('alg.qna.group.SLEEP','ko','수면건강'),('alg.result.ui','ko','식습관'),('alg.result.ui.blood.8disease','ko','8대 질환'),('alg.result.ui.dna.disease','ko','일반질환'),('alg.result.ui.dna.eating.fitness','ko','식습관 및 운동'),('alg.result.ui.dna.healthcare','ko','건강관리'),('alg.result.ui.dna.nutrition','ko','영양소'),('alg.result.ui.dna.skin.scalp','ko','피부/모발'),('alg.result.ui.microb.bowel','ko','장내환경'),('alg.result.ui.nhis.blood.anemia','ko','빈혈검사'),('alg.result.ui.nhis.blood.pres','ko','고혈압검사'),('alg.result.ui.nhis.body','ko','신체검사'),('alg.result.ui.nhis.diabetes','ko','당뇨검사'),('alg.result.ui.nhis.dyslipidemia','ko','이상지지혈증검사'),('alg.result.ui.nhis.liver','ko','간장질환검사'),('alg.result.ui.qna.eating','ko','식습관'),('alg.result.ui.qna.healthcare','ko','건강관리'),('alg.result.ui.qna.lifestyle','ko','생활습관'),('alg.result.ui.qna.scalp','ko','두피/탈모'),('alg.result.ui.qna.skin','ko','피부'),('i18n.prdt.template.brand_name.A0001','ko','브랜드'),('i18n.prdt.template.product_name.A0001','ko','제품1'),('i18n.pwi.age.A','ko','2세'),('i18n.pwi.age.B','ko','3~5세'),('i18n.pwi.age.C','ko','6~8세'),('i18n.pwi.age.D','ko','9~11세'),('i18n.pwi.age.E','ko','12~13세'),('i18n.pwi.age.L','ko','14~29세'),('i18n.pwi.age.M','ko','30~49세'),('i18n.pwi.age.N','ko','50~64세'),('i18n.pwi.age.O','ko','66~74세'),('i18n.pwi.age.P','ko','75세 이상'),('i18n.sol.template.title.A0001','ko','솔루션'),('I_TEST','en','TEST'),('I_TEST','kr','테스트\0딕\0'),('I_TTT','kr','오합지졸'),('prdt.category.A0001','ko','테스트1'),('prdt.category.A0002','ko','테스트2'),('prdt.category.A0003','ko','테스트3'),('prdt.category.A0223','ko',NULL),('prdt.category.A4444','ko','dsdfdfasdfdsf'),('prdt.category.B0001','ko','12356'),('prdt.category.F5555','ko','gggggg'),('prdt.grp.A0002','ko','group'),('prdt.grp.A0003','ko','ABCDE'),('prdt.grp.A0005','ko','aabdsw323'),('prdt.grp.A0007','ko','aaabbb'),('PRDT.I_TEST','en','ENG'),('qna_template.s_ans.I_H01','ko','{\r\n  \"type\":\"input\",\r\n  \"items\":[\r\n      {\"anskey\":\"1\",\"item\":[\"키\",\"cm\"],\"type\":\"number\"},\r\n    ]\r\n}'),('qna_template.s_ans.I_H02','ko','{\r\n  \"type\":\"input\",\r\n  \"items\":[\r\n      {\"anskey\":\"1\",\"item\":[\"키\",\"cm\"],\"type\":\"number\"},\r\n    ]\r\n}'),('qna_template.s_note.I_H01','ko','당신의 신체에 해당 하는 키를 입력하세요.'),('qna_template.s_note.I_H02','ko','당신의 신체에 해당 하는 키를 입력하세요.aa'),('qna_template.s_question.I_H01','ko','당신의 키(cm), 몸무게(kg)는 얼마입니까?'),('qna_template.s_question.I_H02','ko','당신의 키(cm), 몸무게(kg)는 얼마입니까?aa'),('TEST','ko','테스트'),('TEST.A','en','fff'),('t_alg.I_CONZ_Q10','ko','코엔자임큐텐농도'),('t_alg_pwi.BLOOD','ko','혈행개선'),('t_alg_pwi.BONE','ko','뼈관절·염증'),('t_alg_pwi.BOWEL','ko','소화장건강'),('t_alg_pwi.COGNI','ko','인지능력'),('t_alg_pwi.DFSC','ko','비듬두피'),('t_alg_pwi.DIET','ko','비만·체지방'),('t_alg_pwi.DM','ko','수분부족'),('t_alg_pwi.DO','ko','유분부족'),('t_alg_pwi.DRY','ko','건성피부'),('t_alg_pwi.DYSC','ko','건성두피'),('t_alg_pwi.elem.I_ALLERGY','ko','피부장벽'),('t_alg_pwi.elem.I_ALT','ko','ALT(SGPT)'),('t_alg_pwi.elem.I_AST','ko','AST(SGOT)'),('t_alg_pwi.elem.I_BLOOD_PRESSURE','ko','혈압(최고/최저)'),('t_alg_pwi.elem.I_CAPILLARY','ko','홍조관리'),('t_alg_pwi.elem.I_CONZ_Q10','ko','코엔자임큐텐농도'),('t_alg_pwi.elem.I_EARLY_AGING','ko','피부탄력'),('t_alg_pwi.elem.I_FASTING_BLOOD_SUGER','ko','공복혈당'),('t_alg_pwi.elem.I_FRECKLE','ko','기미관리'),('t_alg_pwi.elem.I_G2ME_AA','ko','원형 탈모'),('t_alg_pwi.elem.I_G2ME_B12','ko','비타민B12농도'),('t_alg_pwi.elem.I_G2ME_HT','ko','모발굵기'),('t_alg_pwi.elem.I_G2ME_MB','ko','남성형탈모'),('t_alg_pwi.elem.I_G2ME_SP','ko','색소침착'),('t_alg_pwi.elem.I_G2ME_VA','ko','비타민A농도'),('t_alg_pwi.elem.I_G2ME_VC','ko','비타민 C 농도'),('t_alg_pwi.elem.I_HDL_CHOLESTEROL','ko','좋은콜레스테롤'),('t_alg_pwi.elem.I_HEIGHT','ko','신장'),('t_alg_pwi.elem.I_HEMOGLOBIN','ko','혈색소'),('t_alg_pwi.elem.I_INTRINSIC_AGING','ko','주름관리'),('t_alg_pwi.elem.I_LDL_CHOLESTEROL','ko','나쁜콜레스테롤'),('t_alg_pwi.elem.I_NHIS_BMI','ko','체질량지수'),('t_alg_pwi.elem.I_NUT_VD','ko','비타민 D 농도'),('t_alg_pwi.elem.I_OILY','ko','유분함유'),('t_alg_pwi.elem.I_PIGMENT','ko','색소차단'),('t_alg_pwi.elem.I_PIMPLE','ko','염증관리'),('t_alg_pwi.elem.I_SEBUM','ko','피지관리'),('t_alg_pwi.elem.I_SK_SA','ko','피부노화'),('t_alg_pwi.elem.I_SK_SP2','ko','기미 주근깨'),('t_alg_pwi.elem.I_SK_TS','ko','각질'),('t_alg_pwi.elem.I_SK_TY','ko','멜라닌생성'),('t_alg_pwi.elem.I_SK_YD','ko','여드름'),('t_alg_pwi.elem.I_SK_YD2','ko','피부염증'),('t_alg_pwi.elem.I_TOTAL_CHOLESTEROL','ko','총콜레스테롤'),('t_alg_pwi.elem.I_TRIGLYCERIDE','ko','중성지방'),('t_alg_pwi.elem.I_VITA_B6','ko','비타민B6농도'),('t_alg_pwi.elem.I_VITA_E','ko','비타민E농도'),('t_alg_pwi.elem.I_WAIST','ko','허리둘레'),('t_alg_pwi.elem.I_WATER','ko','수분함유'),('t_alg_pwi.elem.I_WEIGHT','ko','채중'),('t_alg_pwi.elem.I_YGPT','ko','감마지피티'),('t_alg_pwi.EYE','ko','눈건강'),('t_alg_pwi.HAIR','ko','탈모'),('t_alg_pwi.HORM','ko','호르몬활력'),('t_alg_pwi.IMMUN','ko','면역항산화'),('t_alg_pwi.LIVER','ko','간피로'),('t_alg_pwi.METAB','ko','대사조절'),('t_alg_pwi.MUSCLE','ko','근감소'),('t_alg_pwi.OA','ko','화농성여드름'),('t_alg_pwi.OILY','ko','지성피부'),('t_alg_pwi.OS','ko','피지과다'),('t_alg_pwi.OYSC','ko','지성두피'),('t_alg_pwi.PD','ko','색소침착'),('t_alg_pwi.PF','ko','기미성색소'),('t_alg_pwi.PIGMENT','ko','색소두피'),('t_alg_pwi.SA','ko','트러블'),('t_alg_pwi.SC','ko','홍조'),('t_alg_pwi.SENSITIVE','ko','예민피부'),('t_alg_pwi.SLEEP','ko','수면스트레스'),('t_alg_pwi.STSC','ko','예민두피'),('t_alg_pwi.WL','ko','초기잔주름'),('t_alg_pwi.WP','ko','진행성주름'),('t_alg_pwi.WRINKLE','ko','주름피주'),('t_sol_category.A001','ko','건기식'),('v-aaa-123','ko','this is test');
/*!40000 ALTER TABLE `t_i18n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_json_test`
--

DROP TABLE IF EXISTS `t_json_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_json_test` (
  `i_id` varchar(64) NOT NULL COMMENT 'id',
  `s_json` text COMMENT 'json data',
  PRIMARY KEY (`i_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='JSON TEST';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_json_test`
--

LOCK TABLES `t_json_test` WRITE;
/*!40000 ALTER TABLE `t_json_test` DISABLE KEYS */;
INSERT INTO `t_json_test` VALUES ('A','{\r\n    \"info\": {\r\n        \"phone\": \"01012345678\",\r\n        \"certification\": true,\r\n        \"store_info\": [{\r\n            \"employer\": \"홍길동\",\r\n            \"store_name\": \"우리집맛집 천호점\"\r\n        }, {\r\n            \"employer\": \"홍길동\",\r\n            \"store_name\": \"우리집맛집 합정점\"\r\n        }, {\r\n            \"employer\": \"홍길동\",\r\n            \"store_name\": \"우리집맛집 금정점\"\r\n        }]\r\n    }\r\n}');
/*!40000 ALTER TABLE `t_json_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_login_depot`
--

DROP TABLE IF EXISTS `t_login_depot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_login_depot` (
  `i_memid` varchar(16) NOT NULL COMMENT 'c_shopYYMMDD0001',
  `i_id` varchar(64) NOT NULL,
  `n_name` varchar(60) DEFAULT NULL,
  `i_hp` varchar(50) DEFAULT NULL,
  `s_email` varchar(50) DEFAULT NULL,
  `d_reg_dt` datetime NOT NULL,
  `y_use` varchar(1) DEFAULT 's' COMMENT 'leave by self(e), leave by manager(m), sleep(s)',
  `i_lst` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`i_memid`),
  KEY `d_reg_dt` (`d_reg_dt`),
  KEY `y_use` (`y_use`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='user info depot to delete';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_login_depot`
--

LOCK TABLES `t_login_depot` WRITE;
/*!40000 ALTER TABLE `t_login_depot` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_login_depot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_login_map`
--

DROP TABLE IF EXISTS `t_login_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_login_map` (
  `i_memid` varchar(16) NOT NULL COMMENT 'c_shopYYMMDD0001',
  `i_id` varchar(64) NOT NULL,
  `n_name` varchar(60) DEFAULT NULL,
  `s_pw` char(68) NOT NULL,
  `c_sex` enum('m','w') DEFAULT 'w' COMMENT 'm as man,w as woman',
  `d_birth` date DEFAULT NULL,
  `i_hp` varchar(50) DEFAULT NULL,
  `s_email` varchar(50) DEFAULT NULL,
  `i_zipcode` varchar(6) DEFAULT NULL,
  `s_pic_url` varchar(100) DEFAULT NULL,
  `y_privacy` varchar(1) DEFAULT 'n' COMMENT 'privacy',
  `y_marketing` varchar(1) DEFAULT 'n' COMMENT 'marketing',
  `y_push` varchar(1) DEFAULT 'n' COMMENT 'app push',
  `y_email` varchar(1) DEFAULT 'n' COMMENT 'mail marking',
  `y_verification` varchar(1) DEFAULT 'n' COMMENT 'phone number verification',
  `y_staff` varchar(1) DEFAULT 'n',
  `i_height` decimal(5,2) DEFAULT NULL COMMENT 'height',
  `i_weight` decimal(5,2) DEFAULT NULL COMMENT 'weight',
  `i_level` tinyint(4) DEFAULT '-1',
  `s_date` varchar(8) DEFAULT NULL COMMENT 'yyyymm',
  `c_shop` int(11) DEFAULT NULL COMMENT 'my default shop',
  `i_invited_code` varchar(10) DEFAULT NULL COMMENT 'invite code',
  `i_recomm_code` varchar(10) DEFAULT NULL,
  `d_last_login` datetime DEFAULT NULL,
  `d_reg_dt` datetime NOT NULL,
  `d_mod_dt` datetime NOT NULL,
  `y_use` varchar(1) DEFAULT 'y',
  `i_lst` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`i_memid`),
  KEY `i_memid` (`i_id`),
  KEY `i_invite_code` (`i_invited_code`),
  KEY `i_recomm_code` (`i_recomm_code`),
  KEY `y_staff` (`y_staff`),
  KEY `d_reg_dt` (`d_reg_dt`),
  KEY `d_mod_dt` (`d_mod_dt`),
  KEY `y_use` (`y_use`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='user info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_login_map`
--

LOCK TABLES `t_login_map` WRITE;
/*!40000 ALTER TABLE `t_login_map` DISABLE KEYS */;
INSERT INTO `t_login_map` VALUES ('1000002201070001','mark','MARK','{bcrypt}$2a$10$POG5pgyfAs7/GdOIU4pJlu3IAYKWVxU.iH.gtqO/r47.wGEgEc.VC','m','1971-02-01','01012341000','mkl@test.com','1234','https://www.hindipro.com/wp-content/uploads/2020/12/caption-for-profile.jpg','y','y','n','n','n','y',172.00,170.00,-1,NULL,100000,'mad172657b','mad73f907f','2022-02-09 14:25:17','2022-01-07 07:24:58','2022-02-09 14:24:16','y','super'),('1000002201070002','mark1','MARK1','{bcrypt}$2a$10$BpFmH5C4QesOy5KlyRP3g.Gl/AjtGsAOLNfS/1Urnu.7nIqP9wOC2','m','1971-02-01','01012341001','mkl1@test.com','1234',NULL,'y','y','n','n','n','n',172.00,170.00,-1,NULL,100000,'mad73f907f','mad172657b','2022-01-27 15:41:10','2022-01-07 07:27:15','2022-01-07 07:27:15','y','super'),('1000002201070003','dimmby','DIMMBY','{bcrypt}$2a$10$Tm7Z2nDCIF4NXNKMj1g4BORL.Hq5MWci9O09hYIhe29DoS66EGULu','m','1971-02-01','01012341002','mkl@test.com','1234',NULL,'y','y','n','n','n','y',172.00,170.00,-1,NULL,100000,'mad73f907f','mad73f907k','2022-01-24 13:50:11','2022-01-07 07:24:58','2022-01-07 07:24:58','y','super'),('1000002201300001','testid','홍길동','{bcrypt}$2a$10$sgyK8I/F.zSztFWt0.dli.yjspycxU2kH.UwOmCASNDdMXcmTza1i','m','1999-05-10','12341234123','email@gmail.com','30170',NULL,'y','y','y','y','y','n',123.00,22.30,-1,NULL,100000,NULL,'te1dc98488',NULL,'2022-01-30 01:13:57','2022-01-30 01:13:57','y','testid'),('1000002201300002','testid','홍길동','{bcrypt}$2a$10$I1rN8RSN1xdIIMQfc1JVX.YJd2Ix24pV745xEglcZP3bk03MmphF2','m','1999-05-10','12341234123','email@gmail.com','30170',NULL,'y','y','y','y','y','n',123.00,22.30,-1,NULL,100000,NULL,'te3aa6f20c',NULL,'2022-01-30 01:14:07','2022-01-30 01:14:07','y','testid'),('1000002201300003','testtest','dfsfsdf','{bcrypt}$2a$10$TiSva/vhSvzDcnFcUcHNgeYa3fP0F.9AyY4E2rRud.gQ1vxhicekq','m','2000-02-02','11111111111','wdfsdfsdf@gmail.com','29170',NULL,'y','y','y','y','y','n',111.00,22.30,-1,NULL,100000,NULL,'tecee6c6a5','2022-01-30 23:52:10','2022-01-30 23:51:58','2022-01-30 23:51:58','y','testtest'),('1000002202040001','234234234','ㄴㅇㄹㄴㅇㄹ','{bcrypt}$2a$10$kVP34JYd7vvknpc6pGAAVuSeZ53LmYy89JYjd8mjMnA7sIiYz7nyC','w','2000-02-12','01012341008','mmm@gmail.com','27230','https://www.hindipro.com/wp-content/uploads/2020/12/caption-for-profile.jpg','y','n','n','n','y','n',172.00,72.00,-1,NULL,100000,'mad73f907k','2347bbbeaf',NULL,'2022-02-04 16:06:16','2022-02-04 16:06:16','y','234234234'),('1000002202090001','mark2dssddf','ㄴㅇㄹㄴㅇㄹ','{bcrypt}$2a$10$HGubeOUSp7lXvZwcwskM9.8/GzCt.8s/mXqmrZR9x9QWGohwis5Ue','w','1922-03-12','33333333333','2344234@qq.com','30170','https://www.hindipro.com/wp-content/uploads/2020/12/caption-for-profile.jpg','y','n','y','y','y','n',111.00,111.10,-1,NULL,100000,NULL,'maac682a44',NULL,'2022-02-09 14:22:48','2022-02-09 14:22:48','y','mark2dssddf');
/*!40000 ALTER TABLE `t_login_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_login_map_info`
--

DROP TABLE IF EXISTS `t_login_map_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_login_map_info` (
  `i_memid` varchar(16) NOT NULL COMMENT 'c_shopYYMMDD0001',
  `i_dna_sn` varchar(16) DEFAULT NULL,
  `y_dna` varchar(1) DEFAULT 'n',
  `d_dna` datetime DEFAULT NULL,
  `y_blood` varchar(1) DEFAULT 'n' COMMENT 'r as requested y as completed',
  `d_blood` datetime DEFAULT NULL,
  `i_microb_sn` varchar(16) DEFAULT NULL,
  `y_microb` varchar(1) DEFAULT 'n' COMMENT 'r as requested y as completed',
  `d_microb` datetime DEFAULT NULL,
  `y_nhis` varchar(1) DEFAULT 'n' COMMENT 'r as requested y as completed',
  `d_nhis` datetime DEFAULT NULL,
  `d_qna_last` datetime DEFAULT NULL,
  `d_walk_last` datetime DEFAULT NULL,
  PRIMARY KEY (`i_memid`),
  KEY `y_dna` (`y_dna`),
  KEY `d_dna` (`d_dna`),
  KEY `d_nhis` (`d_nhis`),
  KEY `d_qna_last` (`d_qna_last`),
  KEY `d_walk_last` (`d_walk_last`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='user map info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_login_map_info`
--

LOCK TABLES `t_login_map_info` WRITE;
/*!40000 ALTER TABLE `t_login_map_info` DISABLE KEYS */;
INSERT INTO `t_login_map_info` VALUES ('1000002201070001','123456789','r','2022-01-24 12:02:28','n',NULL,'123456789','r','2022-01-24 13:51:12','n',NULL,NULL,NULL);
/*!40000 ALTER TABLE `t_login_map_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_login_pool`
--

DROP TABLE IF EXISTS `t_login_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_login_pool` (
  `c_shop` int(11) NOT NULL,
  `n_name` varchar(60) DEFAULT NULL,
  `i_hp` varchar(50) NOT NULL,
  `d_reg_dt` datetime NOT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`c_shop`,`i_hp`),
  KEY `d_reg_dt` (`d_reg_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='login pool';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_login_pool`
--

LOCK TABLES `t_login_pool` WRITE;
/*!40000 ALTER TABLE `t_login_pool` DISABLE KEYS */;
INSERT INTO `t_login_pool` VALUES (100000,'테스트','01012341003','2022-01-27 15:41:10',NULL),(100000,'테스트','01012341008','2022-01-27 15:41:10',NULL);
/*!40000 ALTER TABLE `t_login_pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_nhis_val`
--

DROP TABLE IF EXISTS `t_nhis_val`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_nhis_val` (
  `i_memid` varchar(16) NOT NULL COMMENT 'c_shopYYMMDD0001',
  `s_checkup_year` varchar(4) NOT NULL COMMENT '검진년도',
  `s_checkup_date` varchar(4) NOT NULL COMMENT '검진일자',
  `i_waist` decimal(5,2) DEFAULT NULL COMMENT '허리둘레',
  `i_blood_pressure` decimal(5,2) DEFAULT NULL COMMENT '수축기혈압',
  `i_fasting_blood_suger` decimal(5,2) DEFAULT NULL COMMENT '식전혈당',
  `i_total_cholesterol` decimal(5,2) DEFAULT NULL COMMENT '총콜레스테롤',
  `i_hdl_cholesterol` decimal(5,2) DEFAULT NULL COMMENT 'HDL콜레스테롤',
  `i_triglyceride` decimal(5,2) DEFAULT NULL COMMENT '트리글리세라이드',
  `i_ldl_cholesterol` decimal(5,2) DEFAULT NULL COMMENT 'LDL콜레스테롤',
  `i_hemoglobin` decimal(5,2) DEFAULT NULL COMMENT '혈색소',
  `i_ast` decimal(5,2) DEFAULT NULL COMMENT 'AST(SGOT)',
  `i_alt` decimal(5,2) DEFAULT NULL COMMENT 'ALT(SGPT)',
  `i_ygpt` decimal(5,2) DEFAULT NULL COMMENT '감마지피티(y-GPT)',
  `d_created_dt` datetime NOT NULL,
  PRIMARY KEY (`i_memid`,`s_checkup_year`,`s_checkup_date`),
  KEY `i_memid` (`i_memid`),
  KEY `d_reg_dt` (`d_created_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='NHIS INFO';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_nhis_val`
--

LOCK TABLES `t_nhis_val` WRITE;
/*!40000 ALTER TABLE `t_nhis_val` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_nhis_val` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_partner`
--

DROP TABLE IF EXISTS `t_partner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_partner` (
  `cm_id` varchar(30) NOT NULL,
  `n_partner` varchar(50) DEFAULT NULL,
  `y_share_rslt` varchar(1) DEFAULT 'y',
  `d_reg_dt` datetime DEFAULT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`cm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='company info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_partner`
--

LOCK TABLES `t_partner` WRITE;
/*!40000 ALTER TABLE `t_partner` DISABLE KEYS */;
INSERT INTO `t_partner` VALUES ('dma','dma PA','y','2022-01-07 07:14:14','super','2022-01-07 07:14:14'),('dma4','dma PA4','y','2022-01-11 07:14:14','super','2022-01-07 07:14:14'),('dma5','dma PA5','y','2022-01-12 07:14:14','super','2022-01-07 07:14:14'),('dma6','dma PA6','y','2022-01-13 07:14:14','super','2022-01-07 07:14:14'),('dohu','dma PA2','y','2022-01-08 07:14:14','super','2022-01-07 07:14:14'),('pulmuone','dma PA3','y','2022-01-09 07:14:14','super','2022-01-07 07:14:14');
/*!40000 ALTER TABLE `t_partner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_prdt_category`
--

DROP TABLE IF EXISTS `t_prdt_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_prdt_category` (
  `c_code` varchar(32) NOT NULL,
  `n_name` varchar(64) DEFAULT NULL,
  `c_cmid_tpl` varchar(32) NOT NULL,
  `i_sort` int(11) NOT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`c_code`),
  KEY `c_cmid_tpl` (`c_cmid_tpl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='product category';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_prdt_category`
--

LOCK TABLES `t_prdt_category` WRITE;
/*!40000 ALTER TABLE `t_prdt_category` DISABLE KEYS */;
INSERT INTO `t_prdt_category` VALUES ('A0001','prdt.category.A0001','prdt.category.A0001',1,'mark','2022-02-09 14:27:06'),('A0002','prdt.category.A0002','prdt.category.A0002',2,'mark','2022-02-09 14:27:06'),('A0003','prdt.category.A0003','prdt.category.A0003',3,'mark','2022-02-09 14:27:06');
/*!40000 ALTER TABLE `t_prdt_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_prdt_grp`
--

DROP TABLE IF EXISTS `t_prdt_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_prdt_grp` (
  `c_code` varchar(32) NOT NULL,
  `n_name` varchar(64) DEFAULT NULL,
  `c_code_ctgy` varchar(32) NOT NULL,
  `c_cmid_tpl` varchar(256) NOT NULL,
  `i_sort` int(11) NOT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`c_code`),
  KEY `c_cmid_tpl` (`c_cmid_tpl`(255)),
  KEY `c_code_ctgy` (`c_code_ctgy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='product group';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_prdt_grp`
--

LOCK TABLES `t_prdt_grp` WRITE;
/*!40000 ALTER TABLE `t_prdt_grp` DISABLE KEYS */;
INSERT INTO `t_prdt_grp` VALUES ('A0002','prdt.grp.A0002','A0003','prdt.grp.A0002',2,NULL,'2022-02-07 22:46:24'),('A0003','prdt.grp.A0003','A0003','prdt.grp.A0003',3,NULL,'2022-02-08 23:17:57');
/*!40000 ALTER TABLE `t_prdt_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_prdt_grp_tpl`
--

DROP TABLE IF EXISTS `t_prdt_grp_tpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_prdt_grp_tpl` (
  `i_seq` int(11) NOT NULL AUTO_INCREMENT,
  `c_code_grp` varchar(32) NOT NULL,
  `c_code` varchar(32) NOT NULL,
  `i_sort` int(11) NOT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`i_seq`),
  KEY `c_code_grp` (`c_code_grp`),
  KEY `c_code` (`c_code`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='product group template tuple';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_prdt_grp_tpl`
--

LOCK TABLES `t_prdt_grp_tpl` WRITE;
/*!40000 ALTER TABLE `t_prdt_grp_tpl` DISABLE KEYS */;
INSERT INTO `t_prdt_grp_tpl` VALUES (1,'A0002','A0001',1,NULL,'2022-02-08 01:40:49'),(4,'A0002','A0001',2,NULL,'2022-02-08 23:55:09'),(5,'A0002','A0001',3,NULL,'2022-02-08 23:55:12');
/*!40000 ALTER TABLE `t_prdt_grp_tpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_prdt_template`
--

DROP TABLE IF EXISTS `t_prdt_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_prdt_template` (
  `c_code` varchar(32) NOT NULL,
  `n_brand_name` varchar(64) NOT NULL,
  `n_product_name` varchar(64) NOT NULL,
  `s_pwi_sex` varchar(32) NOT NULL,
  `s_pwi_age` varchar(256) NOT NULL,
  `s_pwi` varchar(256) NOT NULL,
  `s_memo` text,
  `s_url` varchar(256) DEFAULT NULL,
  `y_url` varchar(1) NOT NULL DEFAULT 'n',
  `y_icon` varchar(1) NOT NULL DEFAULT 'n',
  `s_icon` varchar(256) DEFAULT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`c_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='assist template';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_prdt_template`
--

LOCK TABLES `t_prdt_template` WRITE;
/*!40000 ALTER TABLE `t_prdt_template` DISABLE KEYS */;
INSERT INTO `t_prdt_template` VALUES ('A0001','i18n.prdt.template.brand_name.A0001','i18n.prdt.template.product_name.A0001','m','A;B;C','fdsf;fff;','{}','http://aaa.co.kr','y','y','https://ipfs.io/ipfs/QmTQo4cxDZ5MoszQAK93JyhFedeMuj7j4x5P7tQnvRi4A5','super','2022-01-13 07:10:31');
/*!40000 ALTER TABLE `t_prdt_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_qna`
--

DROP TABLE IF EXISTS `t_qna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_qna` (
  `i_memid` varchar(16) NOT NULL,
  `s_date` varchar(8) NOT NULL,
  `c_qcode` varchar(2) NOT NULL,
  `i_bmi` decimal(5,2) DEFAULT NULL,
  `c_bmicode` varchar(2) DEFAULT NULL,
  `i_height` decimal(5,2) DEFAULT NULL,
  `i_weight` decimal(5,2) DEFAULT NULL,
  `i_bfr` decimal(5,2) DEFAULT NULL COMMENT '전자저울',
  `i_vwc` decimal(5,2) DEFAULT NULL COMMENT '전자저울',
  `i_rom` decimal(5,2) DEFAULT NULL COMMENT '전자저울',
  `c_ver` varchar(32) DEFAULT NULL,
  `s_qna` text,
  `y_fin` varchar(1) NOT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`i_memid`,`s_date`),
  KEY `i_memid` (`i_memid`),
  KEY `s_date` (`s_date`),
  KEY `y_fin` (`y_fin`),
  KEY `d_mod_dt` (`d_mod_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qna document';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_qna`
--

LOCK TABLES `t_qna` WRITE;
/*!40000 ALTER TABLE `t_qna` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_qna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sol_category`
--

DROP TABLE IF EXISTS `t_sol_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sol_category` (
  `c_code` varchar(32) NOT NULL,
  `c_cmid_tpl` varchar(256) DEFAULT NULL,
  `n_name` varchar(64) DEFAULT NULL,
  `n_name_en` varchar(64) DEFAULT NULL,
  `i_sort` int(11) NOT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`c_code`),
  KEY `c_cmid_tpl` (`c_cmid_tpl`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='solution category';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_sol_category`
--

LOCK TABLES `t_sol_category` WRITE;
/*!40000 ALTER TABLE `t_sol_category` DISABLE KEYS */;
INSERT INTO `t_sol_category` VALUES ('A001','t_sol_category.A001','t_sol_category.A001',NULL,1,'super','2022-01-19 11:03:59');
/*!40000 ALTER TABLE `t_sol_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sol_category_tpl`
--

DROP TABLE IF EXISTS `t_sol_category_tpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sol_category_tpl` (
  `i_seq` int(11) NOT NULL AUTO_INCREMENT,
  `c_code_cgy` varchar(32) NOT NULL,
  `c_code` varchar(32) NOT NULL,
  `i_sort` int(11) NOT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`i_seq`),
  KEY `c_code_cgy` (`c_code_cgy`),
  KEY `c_code` (`c_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='solution category template tuple';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_sol_category_tpl`
--

LOCK TABLES `t_sol_category_tpl` WRITE;
/*!40000 ALTER TABLE `t_sol_category_tpl` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_sol_category_tpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sol_template`
--

DROP TABLE IF EXISTS `t_sol_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sol_template` (
  `c_code` varchar(32) NOT NULL,
  `s_title` varchar(128) NOT NULL,
  `s_pwi_sex` varchar(32) NOT NULL,
  `s_pwi_age` varchar(128) NOT NULL,
  `s_pwi` varchar(256) NOT NULL,
  `y_week` varchar(1) NOT NULL COMMENT 'seach week',
  `s_week` varchar(256) NOT NULL,
  `c_type` varchar(1) DEFAULT 'o' COMMENT 'o object, v video',
  `s_content` text,
  `i_lst` varchar(64) DEFAULT NULL,
  `d_mod_dt` datetime NOT NULL,
  PRIMARY KEY (`c_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='solution template';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_sol_template`
--

LOCK TABLES `t_sol_template` WRITE;
/*!40000 ALTER TABLE `t_sol_template` DISABLE KEYS */;
INSERT INTO `t_sol_template` VALUES ('A0001','i18n.sol.template.title.A0001','m','A;B;C','fdsf;fff;','y','MON;WED','o','{}','super','2022-01-13 07:24:55');
/*!40000 ALTER TABLE `t_sol_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_staff`
--

DROP TABLE IF EXISTS `t_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_staff` (
  `i_id` varchar(64) NOT NULL,
  `c_shop` int(11) NOT NULL,
  `c_level` enum('s','o','m','n') NOT NULL COMMENT 's as super, o as operator, m as master,n as manager',
  `y_adm` varchar(1) DEFAULT NULL COMMENT 'admin',
  `y_onl` varchar(1) DEFAULT NULL COMMENT 'online manager',
  `y_ofl` varchar(1) DEFAULT NULL COMMENT 'offline manager',
  `y_cel` varchar(1) DEFAULT NULL COMMENT 'celloger',
  `d_mod_dt` datetime NOT NULL,
  `i_lst` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`i_id`),
  KEY `c_shop` (`c_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='staff info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_staff`
--

LOCK TABLES `t_staff` WRITE;
/*!40000 ALTER TABLE `t_staff` DISABLE KEYS */;
INSERT INTO `t_staff` VALUES ('dimmby',100000,'n','y','n','n','n','2022-01-07 07:06:57','super'),('mark',100000,'n','y','n','n','n','2022-01-07 07:06:57','super');
/*!40000 ALTER TABLE `t_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sys_cmid_tpl`
--

DROP TABLE IF EXISTS `t_sys_cmid_tpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sys_cmid_tpl` (
  `c_code` varchar(32) NOT NULL,
  `cm_id` varchar(30) NOT NULL,
  PRIMARY KEY (`c_code`,`cm_id`),
  KEY `c_code` (`c_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='system cmid tuple';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_sys_cmid_tpl`
--

LOCK TABLES `t_sys_cmid_tpl` WRITE;
/*!40000 ALTER TABLE `t_sys_cmid_tpl` DISABLE KEYS */;
INSERT INTO `t_sys_cmid_tpl` VALUES ('prdt.category.A0001','dma'),('prdt.category.A0002','dma'),('prdt.category.A0002','dohu'),('prdt.category.A0003','dma'),('prdt.category.A0003','dma4'),('prdt.category.A0003','dohu'),('prdt.category.A0003','pulmuone'),('prdt.category.A0223','dohu'),('prdt.category.A0223','pulmuone'),('prdt.category.A4444','dma'),('prdt.category.B0001','dma'),('prdt.category.B0001','dohu'),('prdt.category.B0001','pulmuone'),('prdt.category.F5555','dma'),('prdt.category.F5555','dma4'),('prdt.category.F5555','dma5'),('prdt.category.F5555','dma6'),('prdt.category.F5555','pulmuone'),('prdt.grp.A0002','dma'),('prdt.grp.A0002','dohu'),('prdt.grp.A0002','pulmuone'),('prdt.grp.A0003','dma5'),('prdt.grp.A0005','dohu'),('prdt.grp.A0005','pulmuone'),('prdt.grp.A0007','dohu'),('prdt.grp.A0007','pulmuone'),('t_sol_category.A001','dma'),('t_sol_category.A001','dohu'),('t_sol_category.A001','pulmuone');
/*!40000 ALTER TABLE `t_sys_cmid_tpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sys_code`
--

DROP TABLE IF EXISTS `t_sys_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sys_code` (
  `c_grp` varchar(32) NOT NULL,
  `c_code` varchar(32) NOT NULL,
  `n_code` varchar(128) DEFAULT NULL,
  `c_extra` varchar(32) NOT NULL,
  `s_comment` varchar(64) NOT NULL,
  `i_sort` tinyint(4) NOT NULL,
  PRIMARY KEY (`c_grp`,`c_code`),
  KEY `c_grp` (`c_grp`),
  KEY `c_code` (`c_code`),
  KEY `i_sort` (`i_sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='system code table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_sys_code`
--

LOCK TABLES `t_sys_code` WRITE;
/*!40000 ALTER TABLE `t_sys_code` DISABLE KEYS */;
INSERT INTO `t_sys_code` VALUES ('alg.age','A','3','','',0),('alg.age','B','6','','',1),('alg.age','C','9','','',2),('alg.age','D','12','','',3),('alg.age','E','14','','',4),('alg.age','L','30','','',5),('alg.age','M','50','','',6),('alg.age','N','65','','',7),('alg.age','O','75','','',8),('alg.age','P','150','','',9),('alg.alert','CAUTION','58','','',1),('alg.alert','DANGER','41','','',0),('alg.alert','GOOD','101','','',3),('alg.alert','NORMAL','67','','',2),('alg.level','level1','41','','알고리즘 레벨',0),('alg.level','level10','101','','',9),('alg.level','level2','50','','알고리즘 레벨',1),('alg.level','level3','55','','',2),('alg.level','level4','58','','',3),('alg.level','level5','61','','',4),('alg.level','level6','64','','',5),('alg.level','level7','67','','',6),('alg.level','level8','71','','',7),('alg.level','level9','80','','',8),('alg.qna.group','BC','alg.qna.group.BC','y','문진그룹',3),('alg.qna.group','BONE','alg.qna.group.BONE','y','',12),('alg.qna.group','COGNITIVE','alg.qna.group.COGNITIVE','y','',9),('alg.qna.group','DIET','alg.qna.group.DIET','y','',4),('alg.qna.group','ENERGY','alg.qna.group.ENERGY','y','',10),('alg.qna.group','EYESTRESS','alg.qna.group.EYESTRESS','y','',5),('alg.qna.group','IM','alg.qna.group.IM','y','',1),('alg.qna.group','INDIGEST','alg.qna.group.INDIGEST','y','',7),('alg.qna.group','LIVER','alg.qna.group.LIVER','y','',6),('alg.qna.group','MB','alg.qna.group.MB','y','',2),('alg.qna.group','MUSCLE','alg.qna.group.MUSCLE','y','',11),('alg.qna.group','SCALP','alg.qna.group.SCALP','y','',14),('alg.qna.group','SKIN','alg.qna.group.SKIN','y','',13),('alg.qna.group','SLEEP','alg.qna.group.SLEEP','y','',8),('alg.result.ui','blood.8disease','alg.result.ui.blood.8disease','blood','분석 결과 UI blood',1),('alg.result.ui','dna.disease','alg.result.ui.dna.disease','dna','분석 결과 UI dna',5),('alg.result.ui','dna.eating.fitness','alg.result.ui.dna.eating.fitness','dna','분석 결과 UI dna',3),('alg.result.ui','dna.healthcare','alg.result.ui.dna.healthcare','dna','분석 결과 UI dna',2),('alg.result.ui','dna.nutrition','alg.result.ui.dna.nutrition','dna','분석 결과 UI dna',1),('alg.result.ui','dna.skin.scalp','alg.result.ui.dna.skin.scalp','dna','분석 결과 UI dna',4),('alg.result.ui','microb.bowel','alg.result.ui.microb.bowel','microb','분석 결과 UI microb',1),('alg.result.ui','nhis.blood.anemia','alg.result.ui.nhis.blood.anemia','nhis','분석 결과 UI nhis',3),('alg.result.ui','nhis.blood.pres','alg.result.ui.nhis.blood.pres','nhis','분석 결과 UI nhis',2),('alg.result.ui','nhis.body','alg.result.ui.nhis.body','nhis','분석 결과 UI nhis',1),('alg.result.ui','nhis.diabetes','alg.result.ui.nhis.diabetes','nhis','분석 결과 UI nhis',4),('alg.result.ui','nhis.dyslipidemia','alg.result.ui.nhis.dyslipidemia','nhis','분석 결과 UI nhis',5),('alg.result.ui','nhis.liver','alg.result.ui.nhis.liver','nhis','분석 결과 UI nhis',6),('alg.result.ui','qna.eating','alg.result.ui.qna.eating','qna','분석 결과 UI qna',1),('alg.result.ui','qna.healthcare','alg.result.ui.qna.healthcare','qna','분석 결과 UI qna',3),('alg.result.ui','qna.lifestyle','alg.result.ui.qna.lifestyle','qna','분석 결과 UI qna',2),('alg.result.ui','qna.scalp','alg.result.ui.qna.scalp','qna','분석 결과 UI qna',5),('alg.result.ui','qna.skin','alg.result.ui.qna.skin','qna','분석 결과 UI qna',4),('alg.sex','M','Male','','',0),('alg.sex','W','Female','','',1),('alg.ts.type','BLOOD','BLOOD','Peno','Transaction Type',3),('alg.ts.type','DNA','DNA','Geno','Transaction Type',1),('alg.ts.type','MICROB','MICROB','Geno','Transaction Type',5),('alg.ts.type','NHIS','NHIS','Peno','Transaction Type',4),('alg.ts.type','QNA','QNA','Peno','Transaction Type',2),('pwi.age','A','i18n.pwi.age.A','','',0),('pwi.age','B','i18n.pwi.age.B','','',1),('pwi.age','C','i18n.pwi.age.C','','',2),('pwi.age','D','i18n.pwi.age.D','','',3),('pwi.age','E','i18n.pwi.age.E','','',4),('pwi.age','L','i18n.pwi.age.L','','',5),('pwi.age','M','i18n.pwi.age.M','','',6),('pwi.age','N','i18n.pwi.age.N','','',7),('pwi.age','O','i18n.pwi.age.O','','',8),('pwi.age','P','i18n.pwi.age.P','','',9),('pwi.type.basic','HEALTH','HEALTH','','',0),('pwi.type.basic','SCALP','SCALP','','',2),('pwi.type.basic','SKIN','SKIN','','',1),('pwi.type.health','BLOOD','BLOOD','','',2),('pwi.type.health','BONE','BONE','','',5),('pwi.type.health','BOWEL','BOWEL','','',10),('pwi.type.health','COGNI','COGNI','','',9),('pwi.type.health','DIET','DIET','','',3),('pwi.type.health','EYE','EYE','','',7),('pwi.type.health','HORM','HORM','','',11),('pwi.type.health','IMMUN','IMMUN','','',0),('pwi.type.health','LIVER','LIVER','','',6),('pwi.type.health','METAB','METAB','','',1),('pwi.type.health','MUSCLE','MUSCLE','','',4),('pwi.type.health','SLEEP','SLEEP','','',8),('pwi.type.scalp','DFSC','DFSC','','',3),('pwi.type.scalp','DYSC','DYSC','','',0),('pwi.type.scalp','HAIR','HAIR','','',4),('pwi.type.scalp','OYSC','OYSC','','',1),('pwi.type.scalp','STSC','STSC','','',2),('pwi.type.skin','DM','DM','','',0),('pwi.type.skin','DO','DO','','',1),('pwi.type.skin','OA','OA','','',5),('pwi.type.skin','OS','OS','','',4),('pwi.type.skin','PD','PD','','',7),('pwi.type.skin','PF','PF','','',6),('pwi.type.skin','SA','SA','','',3),('pwi.type.skin','SC','SC','','',2),('pwi.type.skin','WL','WL','','',8),('pwi.type.skin','WP','WP','','',9),('sys','qna.version','0.0.1','','Qna Version',0),('sys.default.shop','c_shop','100000','','Deafult Shop',0);
/*!40000 ALTER TABLE `t_sys_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sys_numbers`
--

DROP TABLE IF EXISTS `t_sys_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sys_numbers` (
  `n` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='system numbers to use functions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_sys_numbers`
--

LOCK TABLES `t_sys_numbers` WRITE;
/*!40000 ALTER TABLE `t_sys_numbers` DISABLE KEYS */;
INSERT INTO `t_sys_numbers` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),(31),(32),(33),(34),(35),(36),(37),(38),(39),(40),(41),(42),(43),(44),(45),(46),(47),(48),(49),(50);
/*!40000 ALTER TABLE `t_sys_numbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_zipcode`
--

DROP TABLE IF EXISTS `t_zipcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_zipcode` (
  `i_zip` int(11) NOT NULL,
  `n_state` varchar(50) DEFAULT NULL,
  `n_city` varchar(50) DEFAULT NULL,
  `i_start` int(11) DEFAULT NULL,
  `i_end` int(11) DEFAULT NULL,
  PRIMARY KEY (`i_zip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='zip code';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_zipcode`
--

LOCK TABLES `t_zipcode` WRITE;
/*!40000 ALTER TABLE `t_zipcode` DISABLE KEYS */;
INSERT INTO `t_zipcode` VALUES (11,'서울특별시',NULL,1000,8866),(26,'부산광역시',NULL,46000,49527),(27,'대구광역시',NULL,41000,43024),(28,'인천광역시',NULL,21000,23136),(29,'광주광역시',NULL,61000,62466),(30,'대전광역시',NULL,34000,35428),(31,'울산광역시',NULL,44000,45015),(36,'세종특별자치시',NULL,30000,30154),(41,'경기도',NULL,10000,18635),(42,'강원도',NULL,24000,26509),(43,'충청북도',NULL,27000,29167),(44,'충청남도',NULL,31000,33677),(45,'전라북도',NULL,54000,56469),(46,'전라남도',NULL,57000,59792),(47,'경상북도',NULL,36000,40240),(48,'경상남도',NULL,50000,53337),(50,'제주특별자치도',NULL,63000,63644),(11110,'서울특별시','종로구',3000,3198),(11140,'서울특별시','중구',4500,4637),(11170,'서울특별시','용산구',4300,4428),(11200,'서울특별시','성동구',4700,4809),(11215,'서울특별시','광진구',4900,5120),(11230,'서울특별시','동대문구',2400,2646),(11260,'서울특별시','중랑구',2001,2263),(11290,'서울특별시','성북구',2700,2880),(11305,'서울특별시','강북구',1000,1237),(11320,'서울특별시','도봉구',1300,1489),(11350,'서울특별시','노원구',1600,1914),(11380,'서울특별시','은평구',3300,3506),(11410,'서울특별시','서대문구',3600,3789),(11440,'서울특별시','마포구',3900,4214),(11470,'서울특별시','양천구',7900,8111),(11500,'서울특별시','강서구',7501,7811),(11530,'서울특별시','구로구',8200,8395),(11545,'서울특별시','금천구',8500,8657),(11560,'서울특별시','영등포구',7200,7448),(11590,'서울특별시','동작구',6900,7074),(11620,'서울특별시','관악구',8700,8866),(11650,'서울특별시','서초구',6500,6806),(11680,'서울특별시','강남구',6000,6378),(11710,'서울특별시','송파구',5500,5857),(11740,'서울특별시','강동구',5200,5413),(26110,'부산광역시','중구',48900,48984),(26140,'부산광역시','서구',49200,49277),(26170,'부산광역시','동구',48700,48822),(26200,'부산광역시','영도구',49000,49128),(26230,'부산광역시','부산진구',47100,47398),(26260,'부산광역시','동래구',47700,47906),(26290,'부산광역시','남구',48400,48595),(26320,'부산광역시','북구',46500,46653),(26350,'부산광역시','해운대구',48000,48120),(26380,'부산광역시','사하구',49300,49527),(26410,'부산광역시','금정구',46200,46335),(26440,'부산광역시','강서구',46700,46771),(26470,'부산광역시','연제구',47500,47616),(26500,'부산광역시','수영구',48200,48318),(26530,'부산광역시','사상구',46900,47055),(26710,'부산광역시','기장군',46000,46084),(27110,'대구광역시','중구',41900,41978),(27140,'대구광역시','동구',41000,41269),(27170,'대구광역시','서구',41700,41872),(27200,'대구광역시','남구',42400,42515),(27230,'대구광역시','북구',41400,41599),(27260,'대구광역시','수성구',42000,42288),(27290,'대구광역시','달서구',42600,42842),(27710,'대구광역시','달성군',42900,43024),(28110,'인천광역시','중구',22300,22410),(28140,'인천광역시','동구',22500,22575),(28177,'인천광역시','미추홀구',22100,22243),(28185,'인천광역시','연수구',21900,22031),(28200,'인천광역시','남동구',21500,21700),(28237,'인천광역시','부평구',21300,21460),(28245,'인천광역시','계양구',21000,21129),(28260,'인천광역시','서구',22600,22858),(28710,'인천광역시','강화군',23000,23062),(28720,'인천광역시','옹진군',23100,23136),(29110,'광주광역시','동구',61400,61514),(29140,'광주광역시','서구',61900,62078),(29155,'광주광역시','남구',61600,61768),(29170,'광주광역시','북구',61000,61273),(29200,'광주광역시','광산구',62200,62466),(30110,'대전광역시','동구',34500,34712),(30140,'대전광역시','중구',34800,35086),(30170,'대전광역시','서구',35200,35428),(30200,'대전광역시','유성구',34000,34232),(30230,'대전광역시','대덕구',34300,34445),(31110,'울산광역시','중구',44400,44553),(31140,'울산광역시','남구',44600,44787),(31170,'울산광역시','동구',44000,44115),(31200,'울산광역시','북구',44200,44264),(31710,'울산광역시','울주군',44900,45015),(36110,'세종특별자치시',NULL,30000,30154),(41111,'경기도','수원시 장안구',16200,16421),(41113,'경기도','수원시 권선구',16364,16683),(41115,'경기도','수원시 팔달구',16230,16622),(41117,'경기도','수원시 영통구',16222,16713),(41131,'경기도','성남시 수정구',13100,13647),(41133,'경기도','성남시 중원구',13149,13501),(41135,'경기도','성남시 분당구',13381,13638),(41150,'경기도','의정부시',11600,11816),(41171,'경기도','안양시 만안구',13900,14098),(41173,'경기도','안양시 동안구',13915,14128),(41190,'경기도','부천시',14400,14790),(41210,'경기도','광명시',14200,14354),(41220,'경기도','평택시',17700,18001),(41250,'경기도','동두천시',11300,11366),(41271,'경기도','안산시 상록구',15200,15635),(41273,'경기도','안산시 단원구',15208,15658),(41281,'경기도','고양시 덕양구',10262,10599),(41285,'경기도','고양시 일산동구',10245,10457),(41287,'경기도','고양시 일산서구',10200,10426),(41290,'경기도','과천시',13800,13841),(41310,'경기도','구리시',11900,11962),(41360,'경기도','남양주시',12000,12285),(41370,'경기도','오산시',18100,18151),(41390,'경기도','시흥시',14900,15119),(41410,'경기도','군포시',15800,15892),(41430,'경기도','의왕시',16000,16109),(41450,'경기도','하남시',12900,13029),(41461,'경기도','용인시 처인구',16884,17183),(41463,'경기도','용인시 기흥구',16834,17114),(41465,'경기도','용인시 수지구',16800,16944),(41480,'경기도','파주시',10800,10955),(41500,'경기도','이천시',17300,17424),(41550,'경기도','안성시',17500,17609),(41570,'경기도','김포시',10000,10136),(41590,'경기도','화성시',18200,18635),(41610,'경기도','광주시',12700,12819),(41630,'경기도','양주시',11400,11525),(41650,'경기도','포천시',11100,11192),(41670,'경기도','여주시',12600,12668),(41800,'경기도','연천군',11000,11050),(41820,'경기도','가평군',12400,12474),(41830,'경기도','양평군',12500,12585),(42110,'강원도','춘천시',24200,24471),(42130,'강원도','원주시',26300,26509),(42150,'강원도','강릉시',25400,25646),(42170,'강원도','동해시',25700,25822),(42190,'강원도','태백시',26000,26053),(42210,'강원도','속초시',24800,24904),(42230,'강원도','삼척시',25900,25961),(42720,'강원도','홍천군',25100,25171),(42730,'강원도','횡성군',25200,25273),(42750,'강원도','영월군',26200,26248),(42760,'강원도','평창군',25300,25384),(42770,'강원도','정선군',26100,26157),(42780,'강원도','철원군',24000,24065),(42790,'강원도','화천군',24100,24161),(42800,'강원도','양구군',24500,24564),(42810,'강원도','인제군',24600,24668),(42820,'강원도','고성군',24701,24770),(42830,'강원도','양양군',25000,25061),(43111,'충청북도','청주시 상당구',28186,28806),(43112,'충청북도','청주시 서원구',28178,28805),(43113,'충청북도','청주시 흥덕구',28100,28644),(43114,'충청북도','청주시 청원구',28100,28540),(43130,'충청북도','충주시',27300,27502),(43150,'충청북도','제천시',27100,27226),(43720,'충청북도','보은군',28900,28966),(43730,'충청북도','옥천군',29000,29064),(43740,'충청북도','영동군',29100,29167),(43745,'충청북도','증평군',27900,27950),(43750,'충청북도','진천군',27800,27876),(43760,'충청북도','괴산군',28000,28065),(43770,'충청북도','음성군',27600,27740),(43800,'충청북도','단양군',27000,27029),(44131,'충청남도','천안시 동남구',31062,31261),(44133,'충청남도','천안시 서북구',31000,31181),(44150,'충청남도','공주시',32500,32626),(44180,'충청남도','보령시',33400,33522),(44200,'충청남도','아산시',31400,31584),(44210,'충청남도','서산시',31900,32030),(44230,'충청남도','논산시',32900,33028),(44250,'충청남도','계룡시',32800,32842),(44270,'충청남도','당진시',31700,31817),(44710,'충청남도','금산군',32700,32762),(44760,'충청남도','부여군',33100,33232),(44770,'충청남도','서천군',33600,33677),(44790,'충청남도','청양군',33300,33368),(44800,'충청남도','홍성군',32200,32299),(44810,'충청남도','예산군',32400,32457),(44825,'충청남도','태안군',32100,32172),(45111,'전라북도','전주시 완산구',54877,55144),(45113,'전라북도','전주시 덕진구',54800,55151),(45130,'전라북도','군산시',54000,54179),(45140,'전라북도','익산시',54500,54679),(45180,'전라북도','정읍시',56100,56216),(45190,'전라북도','남원시',55700,55805),(45210,'전라북도','김제시',54300,54426),(45710,'전라북도','완주군',55300,55368),(45720,'전라북도','진안군',55400,55460),(45730,'전라북도','무주군',55500,55563),(45740,'전라북도','장수군',55600,55662),(45750,'전라북도','임실군',55900,55957),(45770,'전라북도','순창군',56000,56059),(45790,'전라북도','고창군',56400,56469),(45800,'전라북도','부안군',56300,56349),(46110,'전라남도','목포시',58600,58763),(46130,'전라남도','여수시',59600,59792),(46150,'전라남도','순천시',57900,58035),(46170,'전라남도','나주시',58200,58330),(46230,'전라남도','광양시',57700,57817),(46710,'전라남도','담양군',57300,57393),(46720,'전라남도','곡성군',57500,57562),(46730,'전라남도','구례군',57600,57662),(46770,'전라남도','고흥군',59500,59572),(46780,'전라남도','보성군',59400,59475),(46790,'전라남도','화순군',58100,58165),(46800,'전라남도','장흥군',59300,59366),(46810,'전라남도','강진군',59200,59269),(46820,'전라남도','해남군',59000,59067),(46830,'전라남도','영암군',58400,58467),(46840,'전라남도','무안군',58500,58580),(46860,'전라남도','함평군',57100,57167),(46870,'전라남도','영광군',57000,57069),(46880,'전라남도','장성군',57200,57257),(46890,'전라남도','완도군',59100,59170),(46900,'전라남도','진도군',58900,58958),(46910,'전라남도','신안군',58800,58866),(47111,'경상북도','포항시 남구',37653,37947),(47113,'경상북도','포항시 북구',37500,37948),(47130,'경상북도','경주시',38000,38221),(47150,'경상북도','김천시',39500,39698),(47170,'경상북도','안동시',36600,36760),(47190,'경상북도','구미시',39100,39459),(47210,'경상북도','영주시',36000,36175),(47230,'경상북도','영천시',38800,38913),(47250,'경상북도','상주시',37100,37276),(47280,'경상북도','문경시',36900,37003),(47290,'경상북도','경산시',38400,38698),(47720,'경상북도','군위군',39000,39066),(47730,'경상북도','의성군',37300,37375),(47750,'경상북도','청송군',37400,37465),(47760,'경상북도','영양군',36500,36564),(47770,'경상북도','영덕군',36400,36464),(47820,'경상북도','청도군',38300,38368),(47830,'경상북도','고령군',40100,40166),(47840,'경상북도','성주군',40000,40066),(47850,'경상북도','칠곡군',39800,39915),(47900,'경상북도','예천군',36800,36867),(47920,'경상북도','봉화군',36200,36273),(47930,'경상북도','울진군',36300,36371),(47940,'경상북도','울릉군',40200,40240),(48121,'경상남도','창원시 의창구',51100,51446),(48123,'경상남도','창원시 성산구',51411,51712),(48125,'경상남도','창원시 마산합포구',51251,51797),(48127,'경상남도','창원시 마산회원구',51203,51366),(48129,'경상남도','창원시 진해구',51578,51703),(48170,'경상남도','진주시',52600,52859),(48220,'경상남도','통영시',53000,53104),(48240,'경상남도','사천시',52500,52571),(48250,'경상남도','김해시',50800,51025),(48270,'경상남도','밀양시',50400,50467),(48310,'경상남도','거제시',53200,53337),(48330,'경상남도','양산시',50500,50658),(48720,'경상남도','의령군',52100,52160),(48730,'경상남도','함안군',52000,52073),(48740,'경상남도','창녕군',50300,50367),(48820,'경상남도','고성군',52900,52963),(48840,'경상남도','남해군',52400,52455),(48850,'경상남도','하동군',52300,52355),(48860,'경상남도','산청군',52200,52264),(48870,'경상남도','함양군',50000,50057),(48880,'경상남도','거창군',50100,50153),(48890,'경상남도','합천군',50200,50253),(50110,'제주특별자치도','제주시',63000,63365),(50130,'제주특별자치도','서귀포시',63500,63644);
/*!40000 ALTER TABLE `t_zipcode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'cas'
--

--
-- Dumping routines for database 'cas'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_age` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_age`(d_birth  DATETIME, s_year DATETIME) RETURNS int(11)
BEGIN 

    DECLARE i_age INT; 

	SELECT YEAR(s_year)-YEAR(d_birth)+1 INTO i_age;

    RETURN i_age; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_calorie_starndard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_calorie_starndard`(c_sex_param VARCHAR(1), i_age_param INT,i_height_param INT, i_weight_param FLOAT) RETURNS int(11)
BEGIN 

	DECLARE i_calorie INT;

    -- 남자 19세 이하

	IF UPPER(c_sex_param) = 'M' AND i_age_param < 19 THEN  SET i_calorie = 68-43.3*i_age_param+712*(i_height_param/100)+19.2*i_weight_param;

    -- 남자 성인

    ELSEIF UPPER(c_sex_param) = 'M' THEN SET i_calorie = 204-4.00*i_age_param+450.5*(i_height_param/100)+11.69*i_weight_param;

    -- 여자 19세 이하

    ELSEIF i_age_param < 19 THEN SET i_calorie = 189-17.6*i_age_param+625*(i_height_param/100)+7.9*i_weight_param;

    -- 여자 성인

	ELSE SET i_calorie = 255-2.35*i_age_param+361.6*(i_height_param/100)+9.39*i_weight_param;

	END IF;



    RETURN i_calorie; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_default_shop` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_default_shop`() RETURNS int(11)
BEGIN 

    DECLARE I_RET INT;

    

    SELECT n_code INTO I_RET FROM t_sys_code

	WHERE c_grp = 'sys.default.shop'

	LIMIT 1;

      

    RETURN I_RET; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_gen_i18n` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_gen_i18n`(s_code_param varchar(128),s_locale_param varchar(12),s_desc_param text) RETURNS varchar(128) CHARSET utf8
BEGIN 

    DECLARE S_RET varchar(128);

    set S_RET = s_code_param;

    

    INSERT INTO t_i18n(s_code,s_locale,s_desc)

    VALUES

     (s_code_param,s_locale_param,s_desc_param)

    ON DUPLICATE KEY

    UPDATE

      s_code = s_code_param,

      s_locale = s_locale_param,

      s_desc = s_desc_param;

      

    RETURN S_RET; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getVal2Pct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_getVal2Pct`(v float, v1 float, v2 float, p1 float, p2 float) RETURNS float(4,1)
BEGIN 

    DECLARE pctValue FLOAT(4,1);



    IF v > v2 THEN SET pctValue = p2;

    ELSEIF v < v1 THEN SET pctValue = p1;

    ELSE SET pctValue = (p2-p1)/(v2-v1) * (v-v1) + p1;

    END IF;

   

    RETURN pctValue; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_get_cmid_tpl` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_get_cmid_tpl`(s_code_param varchar(128)) RETURNS text CHARSET utf8
BEGIN 

    DECLARE S_RET text;

    set S_RET = s_code_param;

   

	SELECT GROUP_CONCAT(cm_id separator ';') INTO S_RET

	FROM t_sys_cmid_tpl

	WHERE c_code  = s_code_param;

      

    RETURN S_RET; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_get_i18n` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_get_i18n`(s_code_param varchar(128),s_locale_param varchar(12)) RETURNS text CHARSET utf8
BEGIN 

    DECLARE S_RET TEXT;

    

    SELECT s_desc INTO S_RET

    FROM t_i18n

    WHERE

      s_code = s_code_param  AND s_locale = s_locale_param;

      

    RETURN S_RET; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_invite_code` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_invite_code`(i_id_param varchar(64)) RETURNS varchar(10) CHARSET utf8
BEGIN 

    DECLARE S_RET VARCHAR(10);

    

    SELECT LOWER(CONCAT(LEFT(i_id_param,2), SUBSTRING(MD5(RAND()) FROM 1 FOR 8))) INTO S_RET;

      

    RETURN S_RET; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_memid_new` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_memid_new`(c_shop_param int) RETURNS varchar(16) CHARSET utf8
BEGIN 

    DECLARE S_RET VARCHAR(16);

    

    SELECT CONCAT(c_shop_param,DATE_FORMAT(NOW(), '%y%m%d'), LPAD(IFNULL(MAX(RIGHT(I_MEMID,4)),'0')+1,4,'0')) INTO S_RET

    FROM t_login_map

      WHERE LEFT(I_MEMID,LENGTH(CONCAT(c_shop_param,DATE_FORMAT(NOW(), '%y%m%d')))) = CONCAT(c_shop_param,DATE_FORMAT(NOW(), '%y%m%d'));

      

    RETURN S_RET; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_nhis_ALT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_nhis_ALT`(i_alt_param INT) RETURNS int(11)
BEGIN 

	DECLARE i_ret INT;



	IF i_alt_param < 36 THEN  SET i_ret = fn_getVAl2Pct(i_alt_param,5,35,getAlertValue('GOOD','R'),getAlertValue('GOOD','L'));

    ELSEIF i_alt_param < 46 THEN  SET i_ret = fn_getVAl2Pct(i_alt_param,36,45,getAlertValue('NORMAL','R'),getAlertValue('CAUTION','L'));

	ELSE SET i_ret = fn_getVAl2Pct(i_alt_param,46,70,getAlertValue('DANGER','R'),getAlertValue('DANGER','L'));	

	END IF;



    RETURN i_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_nhis_AST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_nhis_AST`(i_ast_param INT) RETURNS int(11)
BEGIN 

	DECLARE i_ret INT;



	IF i_ast_param < 41 THEN  SET i_ret = fn_getVAl2Pct(i_ast_param,10,40,getAlertValue('GOOD','R'),getAlertValue('GOOD','L'));

    ELSEIF i_ast_param < 51 THEN  SET i_ret = fn_getVAl2Pct(i_ast_param,41,50,getAlertValue('NORMAL','R'),getAlertValue('CAUTION','L'));

	ELSE SET i_ret = fn_getVAl2Pct(i_ast_param,51,60,getAlertValue('DANGER','R'),getAlertValue('DANGER','L'));	

	END IF;



    RETURN i_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_nhis_BP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_nhis_BP`(i_val_param varchar(32)) RETURNS int(11)
BEGIN 

	DECLARE i_ret INT;

    DECLARE i_high_val INT;

    DECLARE i_low_val INT;



	SET i_high_val = SUBSTRING_INDEX(i_val_param,'/',1);

	SET i_low_val = SUBSTRING_INDEX(i_val_param,'/',-1);	



	IF i_high_val < 90 THEN  SET i_high_val = fn_getVAl2Pct(i_high_val,60,89,getAlertValue('CAUTION','L'),getAlertValue('NORMAL','R'));

    ELSEIF i_high_val < 120 THEN  SET i_high_val = fn_getVAl2Pct(i_high_val,90,119,getAlertValue('GOOD','R'),getAlertValue('GOOD','L'));

    ELSEIF i_high_val < 140 THEN  SET i_high_val = fn_getVAl2Pct(i_high_val,120,139,getAlertValue('NORMAL','R'),getAlertValue('CAUTION','L'));

	ELSE  SET i_high_val = fn_getVAl2Pct(i_high_val,140,200,getAlertValue('DANGER','R'),getAlertValue('DANGER','L'));

	END IF;



	IF i_low_val < 60 THEN  SET i_low_val = fn_getVAl2Pct(i_low_val,40,59,getAlertValue('CAUTION','L'),getAlertValue('NORMAL','R'));

    ELSEIF i_low_val < 80 THEN  SET i_low_val = fn_getVAl2Pct(i_low_val,60,79,getAlertValue('GOOD','R'),getAlertValue('GOOD','L'));

    ELSEIF i_low_val < 90 THEN  SET i_low_val = fn_getVAl2Pct(i_low_val,80,89,getAlertValue('NORMAL','R'),getAlertValue('CAUTION','L'));

	ELSE  SET i_low_val = fn_getVAl2Pct(i_low_val,90,100,getAlertValue('DANGER','R'),getAlertValue('DANGER','L'));

	END IF;



	IF i_high_val < i_low_val THEN SET i_ret = i_high_val;

	ELSE SET i_ret = i_low_val;

	END IF;



    RETURN i_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_nhis_Cholestrol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_nhis_Cholestrol`(i_val_param INT) RETURNS int(11)
BEGIN 

	DECLARE i_ret INT;



	IF i_val_param < 200 THEN  SET i_ret = fn_getVAl2Pct(i_val_param,150,199,getAlertValue('GOOD','R'),getAlertValue('GOOD','L'));

    ELSEIF i_val_param < 240 THEN  SET i_ret = fn_getVAl2Pct(i_val_param,200,239,getAlertValue('NORMAL','R'),getAlertValue('CAUTION','L'));

	ELSE  SET i_ret = fn_getVAl2Pct(i_val_param,240,270,getAlertValue('DANGER','R'),getAlertValue('DANGER','L'));

	END IF;



    RETURN i_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_nhis_fastingBloodSugar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_nhis_fastingBloodSugar`(i_fbs_param INT) RETURNS int(11)
BEGIN 

	DECLARE i_ret INT;



	IF i_fbs_param < 100 THEN  SET i_ret = fn_getVAl2Pct(i_fbs_param,80,99,getAlertValue('GOOD','R'),getAlertValue('GOOD','L'));

    ELSEIF i_fbs_param < 126 THEN  SET i_ret = fn_getVAl2Pct(i_fbs_param,100,125,getAlertValue('NORMAL','R'),getAlertValue('CAUTION','L'));

	ELSE  SET i_ret = fn_getVAl2Pct(i_fbs_param,126,140,getAlertValue('DANGER','R'),getAlertValue('DANGER','L'));

	END IF;



    RETURN i_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_nhis_HDL` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_nhis_HDL`(i_val_param INT) RETURNS int(11)
BEGIN 

	DECLARE i_ret INT;



	IF i_val_param >= 60 THEN  SET i_ret = fn_getVAl2Pct(i_val_param,60,80,getAlertValue('GOOD','L'),getAlertValue('GOOD','R'));

    ELSEIF i_val_param >= 40 THEN  SET i_ret = fn_getVAl2Pct(i_val_param,40,59,getAlertValue('CAUTION','L'),getAlertValue('NORMAL','R'));

	ELSE SET i_ret = fn_getVAl2Pct(i_val_param,30,39,getAlertValue('DANGER','L'),getAlertValue('DANGER','R'));

	END IF;



    RETURN i_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_nhis_Hemoglobin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_nhis_Hemoglobin`(c_sex_param varchar(1), i_val_param FLOAT) RETURNS int(11)
BEGIN 

	DECLARE i_ret INT;



	IF UPPER(c_sex_param)='M' AND i_val_param >= 13 THEN  SET i_ret = fn_getVAl2Pct(i_val_param,13,16.5,getAlertValue('GOOD','L'),getAlertValue('GOOD','R'));

    ELSEIF UPPER(c_sex_param)='M' AND i_val_param >= 12 THEN  SET i_ret = fn_getVAl2Pct(i_val_param,12,13,getAlertValue('CAUTION','L'),getAlertValue('NORMAL','R'));

	ELSEIF UPPER(c_sex_param)='M' THEN SET i_ret = fn_getVAl2Pct(i_val_param,5,12.9,getAlertValue('DANGER','L'),getAlertValue('DANGER','R'));

	ELSEIF i_val_param >= 12 THEN  SET i_ret = fn_getVAl2Pct(i_val_param,12,15.5,getAlertValue('GOOD','L'),getAlertValue('GOOD','R'));

    ELSEIF i_val_param >= 10 THEN  SET i_ret = fn_getVAl2Pct(i_val_param,10,11.9,getAlertValue('CAUTION','L'),getAlertValue('NORMAL','R'));

	ELSE SET i_ret = fn_getVAl2Pct(i_val_param,4,9.9,getAlertValue('DANGER','L'),getAlertValue('DANGER','R'));

	END IF;



    RETURN i_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_nhis_LDL` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_nhis_LDL`(i_val_param INT) RETURNS int(11)
BEGIN 

	DECLARE i_ret INT;



	IF i_val_param < 130 THEN  SET i_ret = fn_getVAl2Pct(i_val_param,80,129,getAlertValue('GOOD','R'),getAlertValue('GOOD','L'));

    ELSEIF i_val_param < 160 THEN  SET i_ret = fn_getVAl2Pct(i_val_param,130,159,getAlertValue('NORMAL','R'),getAlertValue('CAUTION','L'));

	ELSE  SET i_ret = fn_getVAl2Pct(i_val_param,160,189,getAlertValue('DANGER','R'),getAlertValue('DANGER','L'));

	END IF;



    RETURN i_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_nhis_Triglyceride` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_nhis_Triglyceride`(i_val_param INT) RETURNS int(11)
BEGIN 

	DECLARE i_ret INT;



	IF i_val_param < 150 THEN  SET i_ret = fn_getVAl2Pct(i_val_param,100,149,getAlertValue('GOOD','R'),getAlertValue('GOOD','L'));

    ELSEIF i_val_param < 200 THEN  SET i_ret = fn_getVAl2Pct(i_val_param,150,199,getAlertValue('NORMAL','R'),getAlertValue('CAUTION','L'));

	ELSE  SET i_ret = fn_getVAl2Pct(i_val_param,200,399,getAlertValue('DANGER','R'),getAlertValue('DANGER','L'));

	END IF;



    RETURN i_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_nhis_waist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_nhis_waist`(c_sex_param VARCHAR(1), i_waist_param FLOAT) RETURNS int(11)
BEGIN 

	DECLARE i_ret INT;

    -- 남자

	IF UPPER(c_sex_param) = 'M' AND i_waist_param < 90 THEN  SET i_ret = 70;

    ELSEIF UPPER(c_sex_param) = 'M' THEN  SET i_ret = 30;

    -- 여자

    ELSEIF i_waist_param < 85 THEN SET i_ret = 70;

	ELSE  SET i_ret = 30;

	END IF;



    RETURN i_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_nhis_yGPT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_nhis_yGPT`(c_sex_param varchar(1),i_ygpt_param INT) RETURNS int(11)
BEGIN 

	DECLARE i_ret INT;



	IF UPPER(c_sex_param) = 'M' AND i_ygpt_param < 64 THEN  SET i_ret = fn_getVAl2Pct(i_ygpt_param,11,63,getAlertValue('GOOD','R'),getAlertValue('GOOD','L'));

    ELSEIF UPPER(c_sex_param) = 'M' AND  i_ygpt_param < 78 THEN  SET i_ret = fn_getVAl2Pct(i_ygpt_param,64,77,getAlertValue('NORMAL','R'),getAlertValue('CAUTION','L'));

	ELSEIF UPPER(c_sex_param) = 'M' THEN SET i_ret = fn_getVAl2Pct(i_ygpt_param,78,90,getAlertValue('DANGER','R'),getAlertValue('DANGER','L'));

    ELSEIF i_ygpt_param < 36 THEN  SET i_ret = fn_getVAl2Pct(i_ygpt_param,8,35,getAlertValue('GOOD','R'),getAlertValue('GOOD','L'));

    ELSEIF i_ygpt_param < 46 THEN  SET i_ret = fn_getVAl2Pct(i_ygpt_param,36,45,getAlertValue('NORMAL','R'),getAlertValue('CAUTION','L'));

	ELSE SET i_ret = fn_getVAl2Pct(i_ygpt_param,46,70,getAlertValue('DANGER','R'),getAlertValue('DANGER','L'));	

	END IF;



    RETURN i_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_set_cmid_tpl` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_set_cmid_tpl`(s_code_param varchar(128),s_val_param text) RETURNS varchar(128) CHARSET utf8
BEGIN 

    DECLARE S_RET varchar(128);

    set S_RET = s_code_param;

   

    DELETE FROM t_sys_cmid_tpl WHERE c_code = s_code_param;

    

	INSERT INTO t_sys_cmid_tpl(c_code,cm_id)

	SELECT

	  s_code_param,SUBSTRING_INDEX(SUBSTRING_INDEX(t.name, ';', numbers.n), ';', -1) name

	FROM

	  t_sys_numbers numbers 

	  INNER JOIN (SELECT s_val_param AS name) t

	  ON CHAR_LENGTH(t.name)

	     -CHAR_LENGTH(REPLACE(t.name, ';', ''))>=numbers.n-1;

      

    RETURN S_RET; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_set_i18n` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_set_i18n`(s_code_param varchar(128),s_locale_param varchar(12),s_desc_param text) RETURNS varchar(128) CHARSET utf8
BEGIN 

    DECLARE S_RET varchar(128);

    set S_RET = s_code_param;

    

    INSERT INTO t_i18n(s_code,s_locale,s_desc)

    VALUES

     (s_code_param,s_locale_param,s_desc_param)

    ON DUPLICATE KEY

    UPDATE

      s_code = s_code_param,

      s_locale = s_locale_param,

      s_desc = s_desc_param;

      

    RETURN S_RET; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_set_i18n_sb` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_set_i18n_sb`(s_code_param varchar(128), s_sub_param varchar(128), s_locale_param varchar(12), s_desc_param text) RETURNS varchar(128) CHARSET utf8
BEGIN 

    DECLARE S_RET varchar(128);

    set S_RET = concat(s_code_param,'.',s_sub_param);

    

    INSERT INTO t_i18n(s_code,s_locale,s_desc)

    VALUES

     (S_RET,s_locale_param,s_desc_param)

    ON DUPLICATE KEY

    UPDATE

      s_code = S_RET,

      s_locale = s_locale_param,

      s_desc = s_desc_param;

      

    RETURN S_RET; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_shop_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_shop_name`(c_shop_param INT) RETURNS varchar(30) CHARSET utf8
BEGIN 

    DECLARE s_ret VARCHAR(30);

    

	SELECT N_SHOP INTO s_ret

    FROM t_channel

    WHERE C_SHOP = c_shop_param;

    

    RETURN s_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_shop_new` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_shop_new`() RETURNS int(11)
BEGIN 

    DECLARE I_RET INT;

    

    SELECT IFNULL(MAX(C_SHOP)+1,100000) INTO I_RET

    FROM t_channel;

      

    RETURN I_RET; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_weight_standard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `fn_weight_standard`(i_height_param  INT) RETURNS float(5,2)
BEGIN 

	DECLARE i_weight FLOAT(5,2);

	IF i_height_param < 130 THEN SET i_weight = NULL;

	ELSE SET i_weight = (i_height_param-100)*0.9;

	END IF;

    RETURN i_weight; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getAlertValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `getAlertValue`(c_alert_param varchar(32),c_type_param varchar(1)) RETURNS int(11)
BEGIN 

	DECLARE i_ret INT;



	IF UPPER(c_alert_param) = 'GOOD' AND UPPER(c_type_param) = 'L' THEN  SET i_ret = 67;

    ELSEIF UPPER(c_alert_param) = 'GOOD' AND UPPER(c_type_param) = 'R' THEN  SET i_ret = 85;

    ELSEIF UPPER(c_alert_param) = 'NORMAL' AND UPPER(c_type_param) = 'L' THEN  SET i_ret = 58;

    ELSEIF UPPER(c_alert_param) = 'NORMAL' AND UPPER(c_type_param) = 'R' THEN  SET i_ret = 66;

    ELSEIF UPPER(c_alert_param) = 'CAUTION' AND UPPER(c_type_param) = 'L' THEN  SET i_ret = 41;

    ELSEIF UPPER(c_alert_param) = 'CAUTION' AND UPPER(c_type_param) = 'R' THEN  SET i_ret = 57;

    ELSEIF UPPER(c_alert_param) = 'DANGER' AND UPPER(c_type_param) = 'L' THEN  SET i_ret = 15;

    ELSEIF UPPER(c_alert_param) = 'DANGER' AND UPPER(c_type_param) = 'R' THEN  SET i_ret = 40;

	ELSE  SET i_ret = NULL;

	END IF;



    RETURN i_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getBmi2Pct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `getBmi2Pct`(i_height smallint(3), i_weight float(5,2)) RETURNS float(4,1)
BEGIN 

    DECLARE i_bmi FLOAT(4.1);

    DECLARE pctValue FLOAT(4.1);

	SET i_bmi = ROUND(i_weight/((i_height/100)*(i_height/100)),1);

	

	IF i_bmi < 15 THEN SET pctValue = 30.0;

	ELSEIF i_bmi < 18.5 THEN  SET pctValue = fn_getVal2Pct(i_bmi,15,18.4,58,66);

	ELSEIF i_bmi < 23 THEN SET pctValue = fn_getVal2Pct(i_bmi,18.5,22.9,90,67);

	ELSEIF i_bmi < 25 THEN SET pctValue = fn_getVal2Pct(i_bmi,23,24.9,66,58);

	ELSEIF i_bmi < 30 THEN SET pctValue = fn_getVal2Pct(i_bmi,25,29.0,57,39);

	ELSEIF i_bmi < 35 THEN SET pctValue = fn_getVal2Pct(i_bmi,30,35,40,15);

	ELSE SET pctValue = 15;

	END IF;

        

    RETURN pctValue;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getBmiCode` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `getBmiCode`(i_height smallint(3), i_weight float(5,2)) RETURNS varchar(10) CHARSET utf8
BEGIN 

    DECLARE bmiCode VARCHAR(10);

    DECLARE i_bmi FLOAT(4.1);

	SELECT ROUND(i_weight/((i_height/100)*(i_height/100)),1) INTO i_bmi;

	

    IF i_bmi < 18.5 THEN  SET  bmiCode = 'uw';

    ELSEIF i_bmi < 23 THEN SET  bmiCode = 'nw';

    ELSEIF i_bmi < 25 THEN SET  bmiCode = 'ow';

    ELSEIF i_bmi < 30 THEN SET  bmiCode = 'ob';

    ELSE SET  bmiCode = 'eo';

    END IF;

        

    RETURN bmiCode; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getQCode` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `getQCode`(i_age INT,c_sex VARCHAR(1)) RETURNS varchar(2) CHARSET utf8
BEGIN 

    DECLARE s_ret VARCHAR(2);

    

	SELECT CONCAT(CASE WHEN i_age<3 THEN 'A'

                       WHEN i_age<6 THEN 'B'

                       WHEN i_age<9 THEN 'C'

                       WHEN i_age<12 THEN 'D'

                       WHEN i_age<14 THEN 'E'

                       WHEN i_age<30 THEN 'L' 

                       WHEN i_age<50 THEN 'M'

                       WHEN i_age<65 THEN 'N'

                       WHEN i_age<75 THEN 'O'

                       ELSE 'P' END ,UPPER(c_sex)) INTO s_ret;

    RETURN s_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getQCodeMemid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `getQCodeMemid`(i_memid_param VARCHAR(16)) RETURNS varchar(2) CHARSET utf8
BEGIN 

    DECLARE s_ret VARCHAR(2);

   

    SELECT getQCode(fn_age(d_birth ,NOW()),c_sex) INTO s_ret FROM t_login_map tlm WHERE i_memid = i_memid_param;

    RETURN s_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getSexMemid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `getSexMemid`(i_memid_param VARCHAR(16)) RETURNS varchar(1) CHARSET utf8
BEGIN 

    DECLARE s_ret VARCHAR(1);

   

    SELECT c_sex INTO s_ret FROM t_login_map tlm WHERE i_memid = i_memid_param;

    RETURN s_ret; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-09 16:14:46
