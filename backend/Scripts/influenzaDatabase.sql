-- MySQL dump 10.13  Distrib 8.2.0, for macos13 (arm64)
--
-- Host: localhost    Database: influenza_database
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `Dimension`
--

DROP TABLE IF EXISTS `Dimension`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Dimension` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(75) NOT NULL,
  `DimensionTypeID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `DimensionTypeID` (`DimensionTypeID`),
  CONSTRAINT `dimension_ibfk_1` FOREIGN KEY (`DimensionTypeID`) REFERENCES `DimensionType` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DimensionType`
--

DROP TABLE IF EXISTS `DimensionType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DimensionType` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Category` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Fips`
--

DROP TABLE IF EXISTS `Fips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fips` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Code` int NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Geography`
--

DROP TABLE IF EXISTS `Geography`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Geography` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(75) NOT NULL,
  `GeographyTypeID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `GeographyTypeID` (`GeographyTypeID`),
  CONSTRAINT `geography_ibfk_1` FOREIGN KEY (`GeographyTypeID`) REFERENCES `GeographyType` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `GeographyType`
--

DROP TABLE IF EXISTS `GeographyType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GeographyType` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Category` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Season`
--

DROP TABLE IF EXISTS `Season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Season` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `StartYear` year NOT NULL,
  `EndYear` year NOT NULL,
  `Month` int NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TEMP`
--

DROP TABLE IF EXISTS `TEMP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TEMP` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Vaccine` varchar(75) NOT NULL,
  `GeoType` varchar(50) NOT NULL,
  `Geo` varchar(75) NOT NULL,
  `Fips` int NOT NULL,
  `monthValue` int NOT NULL,
  `dimType` varchar(50) NOT NULL,
  `dim` varchar(75) NOT NULL,
  `CoverageEstimate` decimal(3,1) NOT NULL,
  `CI` varchar(75) NOT NULL,
  `PopulationSampleSize` int NOT NULL,
  `startYear` year NOT NULL,
  `endYear` year NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Vaccine`
--

DROP TABLE IF EXISTS `Vaccine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vaccine` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `VaccineID` int NOT NULL,
  `GeographyID` int NOT NULL,
  `FipsID` int NOT NULL,
  `SeasonID` int NOT NULL,
  `DimensionID` int NOT NULL,
  `CoverageEstimate` decimal(3,1) NOT NULL,
  `CI` varchar(75) NOT NULL,
  `PopulationSampleSize` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `VaccineID` (`VaccineID`),
  KEY `GeographyID` (`GeographyID`),
  KEY `FipsID` (`FipsID`),
  KEY `SeasonID` (`SeasonID`),
  KEY `DimensionID` (`DimensionID`),
  CONSTRAINT `vaccine_ibfk_1` FOREIGN KEY (`VaccineID`) REFERENCES `Vaccinetype` (`ID`),
  CONSTRAINT `vaccine_ibfk_2` FOREIGN KEY (`GeographyID`) REFERENCES `Geography` (`ID`),
  CONSTRAINT `vaccine_ibfk_3` FOREIGN KEY (`FipsID`) REFERENCES `Fips` (`ID`),
  CONSTRAINT `vaccine_ibfk_4` FOREIGN KEY (`SeasonID`) REFERENCES `Season` (`ID`),
  CONSTRAINT `vaccine_ibfk_5` FOREIGN KEY (`DimensionID`) REFERENCES `Dimension` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=196606 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Vaccinetype`
--

DROP TABLE IF EXISTS `Vaccinetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vaccinetype` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Category` varchar(75) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-18  3:00:51
