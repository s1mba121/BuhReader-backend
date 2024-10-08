-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: soundwave
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albums` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `releaseDate` date NOT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `artistId` int DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `artistId` (`artistId`),
  CONSTRAINT `albums_ibfk_1` FOREIGN KEY (`artistId`) REFERENCES `artists` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
INSERT INTO `albums` VALUES (1,'╨б╤В╨░╤П','2022-12-16','uploads/albums/staya_albom.jpg',1,'2024-08-21 21:14:04','2024-08-21 21:14:04'),(2,'The Best','2019-01-01','uploads/albums/Scrabin_TheBest.jpg',2,'2024-08-21 21:52:16','2024-08-21 21:52:16'),(3,'Donker Mag','2014-01-01','uploads/albums/Die Antwoord_Albom_Donker Mag.jpg',3,'2024-08-21 22:10:43','2024-08-21 22:10:43');
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artists`
--

DROP TABLE IF EXISTS `artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `bio` text,
  `photo` varchar(255) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artists`
--

LOCK TABLES `artists` WRITE;
/*!40000 ALTER TABLE `artists` DISABLE KEYS */;
INSERT INTO `artists` VALUES (1,'╨Ф╨Ф╨в','?╨Ф╨Ф╨в? ? ╤Б╨╛╨▓╨╡╤В╤Б╨║╨░╤П ╨╕ ╤А╨╛╤Б╤Б╨╕╨╣╤Б╨║╨░╤П ╤А╨╛╨║-╨│╤А╤Г╨┐╨┐╨░, ╨╛╤Б╨╜╨╛╨▓╨░╨╜╨╜╨░╤П ╨╗╨╡╤В╨╛╨╝ 1980 ╨│╨╛╨┤╨░ ╨▓ ╨г╤Д╨╡. ╨Ы╨╕╨┤╨╡╤А╨╛╨╝ ╨│╤А╤Г╨┐╨┐╤Л, ╨░╨▓╤В╨╛╤А╨╛╨╝ ╨▒╨╛╨╗╤М╤И╨╕╨╜╤Б╤В╨▓╨░ ╨┐╨╡╤Б╨╡╨╜ ╨╕ ╨╡╨┤╨╕╨╜╤Б╤В╨▓╨╡╨╜╨╜╤Л╨╝ ╨▒╨╡╤Б╤Б╨╝╨╡╨╜╨╜╤Л╨╝ ╤Г╤З╨░╤Б╤В╨╜╨╕╨║╨╛╨╝ ╤П╨▓╨╗╤П╨╡╤В╤Б╤П ╨о╤А╨╕╨╣ ╨и╨╡╨▓╤З╤Г╨║. ╨Э╨░╨╖╨▓╨░╨╜╨╕╨╡ ╨│╤А╤Г╨┐╨┐╤Л ╨┐╤А╨╛╨╕╤Б╤Е╨╛╨┤╨╕╤В ╨╛╤В ╤Е╨╕╨╝╨╕╤З╨╡╤Б╨║╨╛╨│╨╛ ╨▓╨╡╤Й╨╡╤Б╤В╨▓╨░ ╨Ф╨╕╤Е╨╗╨╛╤А╨┤╨╕╤Д╨╡╨╜╨╕╨╗╤В╤А╨╕╤Е╨╗╨╛╤А╤Н╤В╨░╨╜, ╨║╨╛╤В╨╛╤А╨╛╨╡ ╨▓ ╨▓╨╕╨┤╨╡ ╨┐╨╛╤А╨╛╤И╨║╨░ ╨╕╤Б╨┐╨╛╨╗╤М╨╖╨╛╨▓╨░╨╗╨╛╤Б╤М ╨┐╤А╨╕ ╨▒╨╛╤А╤М╨▒╨╡ ╤Б ╨▓╤А╨╡╨┤╨╜╤Л╨╝╨╕ ╨╜╨░╤Б╨╡╨║╨╛╨╝╤Л╨╝╨╕. ╨Ю╨▒╤Й╨╡╨╕╨╖╨▓╨╡╤Б╤В╨╜╤Л ╨┐╨╡╤Б╨╜╨╕ 1980-╤Е ╨│╨╛╨┤╨╛╨▓, 1990-╤Е ╨│╨╛╨┤╨╛╨▓, 2000-╤Е ╨│╨╛╨┤╨╛╨▓. ╨Ю╤Б╨╜╨╛╨▓╨╜╨╛╨╣ ╤В╨╡╨╝╨░╤В╨╕╨║╨╛╨╣ ╤В╨▓╨╛╤А╤З╨╡╤Б╤В╨▓╨░ ╨│╤А╤Г╨┐╨┐╤Л ╨╕ ╨╡╤С ╨╗╨╕╨┤╨╡╤А╨░ ╨и╨╡╨▓╤З╤Г╨║╨░ ╤П╨▓╨╗╤П╨╡╤В╤Б╤П ╨│╤А╨░╨╢╨┤╨░╨╜╤Б╤В╨▓╨╡╨╜╨╜╨╛-╨┐╨░╤В╤А╨╕╨╛╤В╨╕╤З╨╡╤Б╨║╨░╤П ╨╗╨╕╤А╨╕╨║╨░, ╨┐╤А╨╕╨╖╤Л╨▓ ╨║ ╨╜╤А╨░╨▓╤Б╤В╨▓╨╡╨╜╨╜╨╛╨╝╤Г ╤Б╨░╨╝╨╛╤Б╨╛╨▓╨╡╤А╤И╨╡╨╜╤Б╤В╨▓╨╛╨▓╨░╨╜╨╕╤О, ╨╛╤В╨║╨░╨╖╤Г ╨╛╤В ╨╜╨░╤Б╨╕╨╗╨╕╤П ╨╕ ╨┐╤А╨╡╨╛╨┤╨╛╨╗╨╡╨╜╨╕╤О ╨╜╨╡╨╜╨░╨▓╨╕╤Б╤В╨╕, ╨░ ╤В╨░╨║╨╢╨╡ ╤Б╨╛╤Ж╨╕╨░╨╗╤М╨╜╨░╤П ╤Б╨░╤В╨╕╤А╨░ ╨╕ ╨┐╤А╨╛╤В╨╡╤Б╤В.','uploads/artists/DDT_Cover.jpg','2024-08-21 21:03:43','2024-08-21 21:03:43'),(2,'╨б╨║╤А╤П╨▒?╨╜','╨б╨Ъ╨а╨п╨С?╨Э - ╨╛╨┤╨╕╨╜ ╨╖ ╨╜╨░╨╣╨▓?╨┤╨╛╨╝?╤И╨╕╤Е ╤Г╨║╤А╨░╤Ч╨╜╤Б╤М╨║╨╕╤Е ╤А╨╛╨║-╨│╤Г╤А╤В?╨▓ ╨г╨║╤А╨░╤Ч╨╜╨╕. ╨Щ╨╛╨│╨╛ ╨╖╨░╤Б╨╜╨╛╨▓╨╜╨╕╨║ - ╨╗╨╡╨│╨╡╨╜╨┤╨░╤А╨╜╨╕╨╣ ╨Р╨╜╨┤╤А?╨╣ ╨Ъ╤Г╨╖╤М╨╝╨╡╨╜╨║╨╛ (╨Ъ╤Г╨╖╤М╨╝╨░ ╨б╨║╤А╤П╨▒?╨╜) ? ╨▓╨╕╨┤╨░╤В╨╜╨░ ╨╛╤Б╨╛╨▒╨╕╤Б╤В?╤Б╤В╤М, ╨║╤Г╨╝╨╕╤А ╨╝?╨╗╤М╨╣╨╛╨╜?╨▓ ╤Г╨║╤А╨░╤Ч╨╜╤Ж?╨▓. ╨Э╨░╨╢╨░╨╗╤М, ╨╢╨╕╤В╤В╤П ╨░╤А╤В╨╕╤Б╤В╨░ ╤Г 2015 ╤А╨╛╤Ж? ╨┐╨╡╤А╨╡╤А╨▓╨░╨╗╨░ ╤В╤А╨░╨│?╤З╨╜╨░ ╨Ф╨в╨Я. ╨Щ╨╛╨│╨╛ ╨┐?╤Б╨╜? ╤Б╤М╨╛╨│╨╛╨┤╨╜? ╤Б╨┐?╨▓╨░╤Ф ╨▓╤Б╤П ╨║╤А╨░╤Ч╨╜╨░. ','uploads/artists/Scrabin.jpg','2024-08-21 21:48:31','2024-08-21 21:48:31'),(3,'Die Antwoord','Die Antwoord ? ╤Е╨╕╨┐-╤Е╨╛╨┐ ╨│╤А╤Г╨┐╨┐╨░, ╨╛╨▒╤А╨░╨╖╨╛╨▓╨░╨╜╨╜╨░╤П ╨▓ 2008 ╨│╨╛╨┤╤Г ╨▓ ╨Ъ╨╡╨╣╨┐╤В╨░╤Г╨╜╨╡. ╨У╤А╤Г╨┐╨┐╨░ ╤Б╨╛╤Б╤В╨╛╨╕╤В ╨╕╨╖ ╨┤╨▓╤Г╤Е ╨╝╤Г╨╖╤Л╨║╨░╨╜╤В╨╛╨▓: ╨г╨╛╤В╨║╨╕╨╜ ╨в╤О╨┤╨╛╤А ?Ninja? ╨Ф╨╢╨╛╨╜╤Б ╨╕ ╨Щ╨╛╨╗╨░╨╜╨┤╨╕ ╨д╨╕╤Б╤Б╨╡╤А. ╨в╨░╨║╨╢╨╡ ╨▓ ╤Б╨╛╤Б╤В╨░╨▓╨╡ ╨│╤А╤Г╨┐╨┐╤Л ╨┤╨╛ 2011 ╨▓╤Л╤Б╤В╤Г╨┐╨░╨╗ ╨Ы╨╡╨╛╨╜ ╨С╨╛╤В╨░ ╨┐╨╛╨┤ ╨┐╤Б╨╡╨▓╨┤╨╛╨╜╨╕╨╝╨╛╨╝ DJ Hi-Tek.','Die Antwoord.jpg','2024-08-21 22:09:12','2024-08-21 22:09:12');
/*!40000 ALTER TABLE `artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `downloads`
--

DROP TABLE IF EXISTS `downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `downloads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `track_id` int DEFAULT NULL,
  `download_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `track_id` (`track_id`),
  CONSTRAINT `downloads_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `downloads_ibfk_2` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `downloads`
--

LOCK TABLES `downloads` WRITE;
/*!40000 ALTER TABLE `downloads` DISABLE KEYS */;
/*!40000 ALTER TABLE `downloads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist_tracks`
--

DROP TABLE IF EXISTS `playlist_tracks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist_tracks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `playlist_id` int DEFAULT NULL,
  `track_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `playlist_id` (`playlist_id`),
  KEY `track_id` (`track_id`),
  CONSTRAINT `playlist_tracks_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlists` (`id`),
  CONSTRAINT `playlist_tracks_ibfk_2` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist_tracks`
--

LOCK TABLES `playlist_tracks` WRITE;
/*!40000 ALTER TABLE `playlist_tracks` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlist_tracks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlists`
--

DROP TABLE IF EXISTS `playlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `user_id` int DEFAULT NULL,
  `cover_image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `playlists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlists`
--

LOCK TABLES `playlists` WRITE;
/*!40000 ALTER TABLE `playlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracks`
--

DROP TABLE IF EXISTS `tracks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tracks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `artist` varchar(255) DEFAULT NULL,
  `artistId` int DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `lyrics` text,
  `cover` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `album` varchar(255) DEFAULT NULL,
  `albumId` int DEFAULT NULL,
  `filePath` varchar(255) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `artistId` (`artistId`),
  KEY `albumId` (`albumId`),
  CONSTRAINT `tracks_ibfk_1` FOREIGN KEY (`artistId`) REFERENCES `artists` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tracks_ibfk_2` FOREIGN KEY (`albumId`) REFERENCES `albums` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracks`
--

LOCK TABLES `tracks` WRITE;
/*!40000 ALTER TABLE `tracks` DISABLE KEYS */;
INSERT INTO `tracks` VALUES (3,'Clocks','Coldplay',NULL,252,NULL,'uploads/covers/clocks.jpg','2024-08-17 16:10:42','A Rush of Blood to the Head',NULL,'uploads/tracks/123456-clocks.mp3','2024-08-17 19:10:42','2024-08-17 19:10:42'),(4,'╨б╤В╨░╤П',NULL,1,254,NULL,'uploads/covers/staya_albom.jpg','2024-08-21 18:44:09',NULL,1,'uploads/tracks/DDT_Staya.mp3','2024-08-21 18:44:09','2024-08-21 18:44:09'),(5,'╨Ъ╨╛╨╗╤М╨╛╤А╨╛╨▓╨░',NULL,2,174,NULL,'uploads/tracks/Scrabin_TheBest.jpg','2024-08-21 19:00:59',NULL,2,'uploads/tracks/Kolorova.mp3','2024-08-21 19:00:58','2024-08-21 19:00:58'),(6,'╨Ь╨╛╤А╨╡ (╨Э╨░╨╣ ╤Ж╤Ц╨╗╨╕╨╣ ╤Б╨▓╤Ц╤В ╨┐╤А╨╛╨┐╨░╨┤╨╡)',NULL,2,253,NULL,'uploads/tracks/Scrabin_TheBest.jpg','2024-08-21 19:00:59',NULL,2,'uploads/tracks/More.mp3','2024-08-21 19:00:58','2024-08-21 19:00:58'),(7,'╨в╨░╨╜╨╡╤Ж╤М ╨┐╤Ц╨╜╨│╨▓╤Ц╨╜╨░',NULL,2,275,NULL,'uploads/tracks/Scrabin_TheBest.jpg','2024-08-21 19:00:59',NULL,2,'uploads/tracks/TancePingvina.mp3','2024-08-21 19:00:58','2024-08-21 19:00:58'),(8,'╨Ь╨░╤А╤И╤А╤Г╤В╨║╨░',NULL,2,183,NULL,'uploads/tracks/Scrabin_TheBest.jpg','2024-08-21 19:00:59',NULL,2,'uploads/tracks/Marshrutka.mp3','2024-08-21 19:00:58','2024-08-21 19:00:58'),(9,'╨Э╨╡ ╨┤╨░╤Ф╤И',NULL,2,264,NULL,'uploads/tracks/Scrabin_TheBest.jpg','2024-08-21 19:00:59',NULL,2,'uploads/tracks/NeDaeSh.mp3','2024-08-21 19:00:58','2024-08-21 19:00:58'),(10,'╨Ь╤Г╨╝╤Ц╤В╤А╨╛╨╗╤М',NULL,2,228,NULL,'uploads/tracks/Scrabin_TheBest.jpg','2024-08-21 19:00:59',NULL,2,'uploads/tracks/Mumitrol.mp3','2024-08-21 19:00:58','2024-08-21 19:00:58'),(11,'╨У╨╗╨░╨╝╤Г╤А',NULL,2,206,NULL,'uploads/tracks/Scrabin_TheBest.jpg','2024-08-21 19:00:59',NULL,2,'uploads/tracks/Glamur.mp3','2024-08-21 19:00:58','2024-08-21 19:00:58'),(12,'╨и╨╝╨░╤В╨░',NULL,2,252,NULL,'uploads/tracks/Scrabin_TheBest.jpg','2024-08-21 19:00:59',NULL,2,'uploads/tracks/Shmata.mp3','2024-08-21 19:00:58','2024-08-21 19:00:58'),(13,'╨Ъ╨╕╨╜╤Г╨╗╨╕',NULL,2,194,NULL,'uploads/tracks/Scrabin_TheBest.jpg','2024-08-21 19:00:59',NULL,2,'uploads/tracks/Kinuli.mp3','2024-08-21 19:00:58','2024-08-21 19:00:58'),(14,'╨Ъ╨╛╤А╨░╨▒╨╗╤Ц',NULL,2,253,NULL,'uploads/tracks/Scrabin_TheBest.jpg','2024-08-21 19:00:59',NULL,2,'uploads/tracks/Korabli.mp3','2024-08-21 19:00:58','2024-08-21 19:00:58'),(15,'Ugly Boy',NULL,3,214,NULL,'uploads/covers/Die Antwoord_Albom_Donker Mag.jpg','2024-08-21 19:14:45',NULL,3,'uploads/tracks/UglyBoy.mp3','2024-08-21 19:14:45','2024-08-21 19:14:45'),(16,'Cookie Thumper!',NULL,3,201,NULL,'uploads/covers/Die Antwoord_Albom_Donker Mag.jpg','2024-08-21 19:14:45',NULL,3,'uploads/tracks/CookieThumper.mp3','2024-08-21 19:14:45','2024-08-21 19:14:45'),(17,'Pitbull Terrier',NULL,3,221,NULL,'uploads/covers/Die Antwoord_Albom_Donker Mag.jpg','2024-08-21 19:14:45',NULL,3,'uploads/tracks/PitbullTerrier.mp3','2024-08-21 19:14:45','2024-08-21 19:14:45');
/*!40000 ALTER TABLE `tracks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `user_type` enum('regular','premium') DEFAULT 'regular',
  `is_verified` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Test User','test@example.com','$2a$10$fixOqFUUmmzZADdBNCgLq.nFLenXuR0IAkzQxUEdso3wHUnApGHSu','regular',0,'2024-08-17 13:22:09','2024-08-17 18:58:20','2024-08-17 18:58:24'),(2,'Arg Steam','arg.steam121@gmail.com','$2a$10$MZSdCO/wnbVmIqL5SPfWWO3YK.y48HRVabNAH722drJvQ5Mf1ikoC','regular',1,'2024-08-17 13:22:53','2024-08-17 18:58:20','2024-08-17 18:58:24');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-10 20:35:48
