-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrator` (
  `Admin_ID` int NOT NULL,
  `Admin_First_Name` varchar(45) DEFAULT NULL,
  `Admin_Last_Name` varchar(45) DEFAULT NULL,
  `Phone_Num` varchar(45) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Admin_Password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Admin_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `case`
--

DROP TABLE IF EXISTS `case`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case` (
  `Case_ID` int NOT NULL,
  `Admin_ID` int DEFAULT NULL,
  `Location` varchar(45) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Crime_Committed` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Case_ID`),
  KEY `FK_idx` (`Admin_ID`),
  CONSTRAINT `FK` FOREIGN KEY (`Admin_ID`) REFERENCES `administrator` (`Admin_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents` (
  `Document_ID` int NOT NULL,
  `Document_Type` varchar(45) DEFAULT NULL,
  `Date_of_Upload` date DEFAULT NULL,
  `Description_of_Doc` longtext,
  `Admin_ID` int DEFAULT NULL,
  PRIMARY KEY (`Document_ID`),
  KEY `FK8_idx` (`Admin_ID`),
  CONSTRAINT `FK8` FOREIGN KEY (`Admin_ID`) REFERENCES `administrator` (`Admin_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `evidence`
--

DROP TABLE IF EXISTS `evidence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evidence` (
  `Evidence_ID` int NOT NULL,
  `Case_ID` int DEFAULT NULL,
  `Description_Of_Evidence` longtext,
  `Admin_ID` int DEFAULT NULL,
  `Photo_URL` longblob,
  PRIMARY KEY (`Evidence_ID`),
  KEY `FK2_idx` (`Case_ID`),
  KEY `FK3_idx` (`Admin_ID`),
  CONSTRAINT `FK2` FOREIGN KEY (`Case_ID`) REFERENCES `case` (`Case_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK3` FOREIGN KEY (`Admin_ID`) REFERENCES `administrator` (`Admin_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suspect`
--

DROP TABLE IF EXISTS `suspect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suspect` (
  `Suspect_ID` int NOT NULL,
  `Suspect_First_Name` varchar(45) DEFAULT NULL,
  `Suspect_Last_Name` varchar(45) DEFAULT NULL,
  `Suspect_Address` longtext,
  `Admin_ID` int DEFAULT NULL,
  `Case_ID` int DEFAULT NULL,
  PRIMARY KEY (`Suspect_ID`),
  KEY `FK6_idx` (`Admin_ID`),
  KEY `FK7_idx` (`Case_ID`),
  CONSTRAINT `FK6` FOREIGN KEY (`Admin_ID`) REFERENCES `administrator` (`Admin_ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK7` FOREIGN KEY (`Case_ID`) REFERENCES `case` (`Case_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `victim`
--

DROP TABLE IF EXISTS `victim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `victim` (
  `Victim_ID` int NOT NULL,
  `Victim_First_Name` varchar(45) DEFAULT NULL,
  `Victim_Last_Name` varchar(45) DEFAULT NULL,
  `Victim_Phone_Number` varchar(45) DEFAULT NULL,
  `Address` varchar(45) DEFAULT NULL,
  `Admin_ID` int DEFAULT NULL,
  `Case_ID` int DEFAULT NULL,
  PRIMARY KEY (`Victim_ID`),
  KEY `_idx` (`Case_ID`),
  KEY `FK4` (`Admin_ID`),
  CONSTRAINT `FK4` FOREIGN KEY (`Admin_ID`) REFERENCES `administrator` (`Admin_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK5` FOREIGN KEY (`Case_ID`) REFERENCES `case` (`Case_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-04 21:28:59
