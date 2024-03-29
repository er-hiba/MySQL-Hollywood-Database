mysql> create database hollywood;
Query OK, 1 row affected (0.01 sec)

mysql> use hollywood;
Database changed
mysql> create table acteur(
    -> nomActeur varchar(15),
    -> prenomActeur varchar(15),
    -> dateNaissance date,
    -> poids double,
    -> taille smallint,
    -> primary key (nomActeur, prenomActeur));
Query OK, 0 rows affected (0.05 sec)

mysql> desc acteur;
+---------------+-------------+------+-----+---------+-------+
| Field         | Type        | Null | Key | Default | Extra |
+---------------+-------------+------+-----+---------+-------+
| nomActeur     | varchar(15) | NO   | PRI | NULL    |       |
| prenomActeur  | varchar(15) | NO   | PRI | NULL    |       |
| dateNaissance | date        | YES  |     | NULL    |       |
| poids         | double      | YES  |     | NULL    |       |
| taille        | smallint    | YES  |     | NULL    |       |
+---------------+-------------+------+-----+---------+-------+
5 rows in set (0.00 sec)

mysql> create table revenue(
    -> ID_Revenue smallint primary key,
    -> cachet double,
    -> pourcentage double,
    -> anneeRevenue year,
    -> nomActeur varchar(15),
    -> prenomActeur varchar(15),
    -> foreign key (nomActeur, prenomActeur) references acteur(nomActeur, prenomActeur));
Query OK, 0 rows affected (0.08 sec)

mysql> desc revenue;
+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| ID_Revenue   | smallint    | NO   | PRI | NULL    |       |
| cachet       | double      | YES  |     | NULL    |       |
| pourcentage  | double      | YES  |     | NULL    |       |
| anneeRevenue | year        | YES  |     | NULL    |       |
| nomActeur    | varchar(15) | YES  | MUL | NULL    |       |
| prenomActeur | varchar(15) | YES  |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+
6 rows in set (0.01 sec)

mysql> show create table revenue;
+---------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table   | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
+---------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| revenue | CREATE TABLE `revenue` (
  `ID_Revenue` smallint NOT NULL,
  `cachet` double DEFAULT NULL,
  `pourcentage` double DEFAULT NULL,
  `anneeRevenue` year DEFAULT NULL,
  `nomActeur` varchar(15) DEFAULT NULL,
  `prenomActeur` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`ID_Revenue`),
  KEY `nomActeur` (`nomActeur`,`prenomActeur`),
  CONSTRAINT `revenue_ibfk_1` FOREIGN KEY (`nomActeur`, `prenomActeur`) REFERENCES `acteur` (`nomActeur`, `prenomActeur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+---------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.01 sec)

mysql> show create table acteur;
+--------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table  | Create Table                                                                                                                                                                                                                                                                                                           |
+--------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| acteur | CREATE TABLE `acteur` (
  `nomActeur` varchar(15) NOT NULL,
  `prenomActeur` varchar(15) NOT NULL,
  `dateNaissance` date DEFAULT NULL,
  `poids` double DEFAULT NULL,
  `taille` smallint DEFAULT NULL,
  PRIMARY KEY (`nomActeur`,`prenomActeur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+--------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> create table film(
    -> ID_Film smallint primary key,
    -> titre varchar(30),
    -> realisateur varchar(30),
    -> scenariste varchar(30),
    -> anneeMiseCirculation year,
    -> ID_FilmOriginal smallint,
    -> foreign key (ID_FilmOriginal) references film(ID_Film));
Query OK, 0 rows affected (0.08 sec)

mysql> create table Producteur(
    -> nomProducteur varchar(30) primary key,
    -> adresse text);
Query OK, 0 rows affected (0.04 sec)

mysql> show create table film;
+-------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
+-------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| film  | CREATE TABLE `film` (
  `ID_Film` smallint NOT NULL,
  `titre` varchar(30) DEFAULT NULL,
  `realisateur` varchar(30) DEFAULT NULL,
  `scenariste` varchar(30) DEFAULT NULL,
  `anneeMiseCirculation` year DEFAULT NULL,
  `ID_FilmOriginal` smallint DEFAULT NULL,
  PRIMARY KEY (`ID_Film`),
  KEY `ID_FilmOriginal` (`ID_FilmOriginal`),
  CONSTRAINT `film_ibfk_1` FOREIGN KEY (`ID_FilmOriginal`) REFERENCES `film` (`ID_Film`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+-------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> show create table producteur;
+------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table      | Create Table                                                                                                                                                                             |
+------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| producteur | CREATE TABLE `producteur` (
  `nomProducteur` varchar(30) NOT NULL,
  `adresse` text,
  PRIMARY KEY (`nomProducteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> create table acteur_film(
    -> nomActeur varchar(15),
    -> prenomActeur varchar(15),
    -> ID_Film smallint,
    -> foreign key (nomActeur, prenomActeur) references acteur (nomActeur, prenomActeur),
    -> foreign key (ID_Film) references film(ID_Film),
    -> primary key (nomActeur, prenomActeur, ID_Film));
Query OK, 0 rows affected (0.09 sec)

mysql> show create table acteur_film;
+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table       | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| acteur_film | CREATE TABLE `acteur_film` (
  `nomActeur` varchar(15) NOT NULL,
  `prenomActeur` varchar(15) NOT NULL,
  `ID_Film` smallint NOT NULL,
  PRIMARY KEY (`nomActeur`,`prenomActeur`,`ID_Film`),
  KEY `ID_Film` (`ID_Film`),
  CONSTRAINT `acteur_film_ibfk_1` FOREIGN KEY (`nomActeur`, `prenomActeur`) REFERENCES `acteur` (`nomActeur`, `prenomActeur`),
  CONSTRAINT `acteur_film_ibfk_2` FOREIGN KEY (`ID_Film`) REFERENCES `film` (`ID_Film`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> desc acteur_film;
+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| nomActeur    | varchar(15) | NO   | PRI | NULL    |       |
| prenomActeur | varchar(15) | NO   | PRI | NULL    |       |
| ID_Film      | smallint    | NO   | PRI | NULL    |       |
+--------------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> create table investir(
    -> nomProducteur varchar(30),
    -> ID_Film smallint,
    -> montant double,
    -> foreign key (nomProducteur) references producteur(nomProducteur),
    -> foreign key (ID_Film) references film(ID_Film),
    -> primary key (nomProducteur, ID_Film));
Query OK, 0 rows affected (0.08 sec)

mysql> show create table investir;
+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table    | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| investir | CREATE TABLE `investir` (
  `nomProducteur` varchar(30) NOT NULL,
  `ID_Film` smallint NOT NULL,
  `montant` double DEFAULT NULL,
  PRIMARY KEY (`nomProducteur`,`ID_Film`),
  KEY `ID_Film` (`ID_Film`),
  CONSTRAINT `investir_ibfk_1` FOREIGN KEY (`nomProducteur`) REFERENCES `producteur` (`nomProducteur`),
  CONSTRAINT `investir_ibfk_2` FOREIGN KEY (`ID_Film`) REFERENCES `film` (`ID_Film`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> show tables;
+---------------------+
| Tables_in_hollywood |
+---------------------+
| acteur              |
| acteur_film         |
| film                |
| investir            |
| producteur          |
| revenue             |
+---------------------+
6 rows in set (0.00 sec)

mysql>
