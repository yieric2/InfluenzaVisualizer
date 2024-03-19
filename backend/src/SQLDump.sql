-- MySQL dump 10.13  Distrib 8.3.0, for Win64 (x86_64)
--
-- Host: localhost    Database: cdc_db
-- ------------------------------------------------------
-- Server version       8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `provider_locations`
--

DROP TABLE IF EXISTS `provider_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_locations` (
  `uniqid` int NOT NULL AUTO_INCREMENT,
  `provider_location_guid` varchar(150) DEFAULT NULL,
  `loc_admin_street1` varchar(100) DEFAULT NULL,
  `tuesday_hours` varchar(100) DEFAULT NULL,
  `thursday_hours` varchar(100) DEFAULT NULL,
  `sunday_hours` varchar(100) DEFAULT NULL,
  `searchable_name` varchar(100) DEFAULT NULL,
  `saturday_hours` varchar(100) DEFAULT NULL,
  `monday_hours` varchar(100) DEFAULT NULL,
  `friday_hours` varchar(100) DEFAULT NULL,
  `loc_store_no` varchar(100) DEFAULT NULL,
  `wednesday_hours` varchar(100) DEFAULT NULL,
  `web_address` varchar(255) DEFAULT NULL,
  `pre_screen` varchar(150) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `loc_admin_street2` varchar(100) DEFAULT NULL,
  `loc_admin_city` varchar(100) DEFAULT NULL,
  `loc_phone` varchar(100) DEFAULT NULL,
  `loc_name` varchar(100) DEFAULT NULL,
  `loc_admin_state` varchar(2) DEFAULT NULL,
  `loc_admin_zip` varchar(10) DEFAULT NULL,
  `insurance_accepted` tinyint(1) DEFAULT NULL,
  `in_stock` tinyint(1) DEFAULT NULL,
  `walkins_accepted` tinyint(1) DEFAULT NULL,
  `provider_notes` text,
  `supply_level` int DEFAULT NULL,
  `geopoint` point DEFAULT NULL,
  `quantity_last_updated` date DEFAULT NULL,
  PRIMARY KEY (`uniqid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_locations`
--

LOCK TABLES `provider_locations` WRITE;
/*!40000 ALTER TABLE `provider_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_locations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-18 21:25:08