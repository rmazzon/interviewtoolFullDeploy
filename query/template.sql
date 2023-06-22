
INSERT INTO `template` VALUES (1,'2022-11-22 16:23:09',10,900,12,5,300,10,'Template sviluppo backend (junior)',55),(2,'2022-11-22 16:33:47',10,900,15,2,200,12,'Template sviluppo backend (middle)',60),(3,'2022-11-22 16:25:49',20,1000,20,1,60,15,'Template sviluppo backend (senior)',70),(5,'2022-11-22 16:37:00',10,900,12,5,300,10,'Template sicurezza (junior)',55),(6,'2022-11-22 16:38:20',10,900,15,12,200,12,'Template sicurezza (middle)',60),(7,'2022-11-22 17:26:38',20,1000,20,1,60,15,'Template sicurezza (senior)',70),(15,'2023-01-26 18:29:22',10,600,15,1,120,12,'Template Demo',60),(16,'2023-03-17 10:41:14',3,30,10,1,10,5,'test',50);

INSERT INTO `allowed_topics` VALUES (1,1,1),(2,3,1),(3,5,1),(4,8,1),(5,1,2),(6,3,2),(7,5,2),(9,8,2),(10,1,3),(11,3,3),(12,5,3),(14,7,3),(15,8,3),(16,2,5),(17,5,5),(18,8,5),(19,2,6),(20,5,6),(22,8,6),(28,2,7),(29,3,7),(30,5,7),(32,8,7),(66,1,15),(67,2,15),(68,3,15),(69,5,15),(70,7,15),(71,2,16),(72,1,16);

 

 

DROP TABLE IF EXISTS `allowed_types`;



CREATE TABLE `allowed_types` (
  `allowed_types_id` int NOT NULL AUTO_INCREMENT,
  `type_id` tinyint DEFAULT NULL,
  `template_id` int DEFAULT NULL,
  PRIMARY KEY (`allowed_types_id`),
  KEY `FKyetm7av5gl1hp5ij3nyxhjxx` (`template_id`),
  CONSTRAINT `FKyetm7av5gl1hp5ij3nyxhjxx` FOREIGN KEY (`template_id`) REFERENCES `template` (`template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



INSERT INTO `allowed_types` VALUES (1,1,1),(2,2,1),(3,3,1),(4,0,2),(5,1,2),(6,2,2),(7,3,2),(8,0,3),(9,1,3),(10,2,3),(11,3,3),(12,4,3),(13,1,5),(14,2,5),(15,3,5),(16,0,6),(17,1,6),(18,2,6),(19,3,6),(20,0,7),(21,1,7),(22,2,7),(23,3,7),(24,4,7),(61,0,15),(62,1,15),(63,2,15),(64,3,15),(65,0,16),(66,1,16);