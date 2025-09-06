-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 26 nov. 2024 à 14:48
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ul_film_cinema`
--

-- --------------------------------------------------------

--
-- Structure de la table `cinema`
--

DROP TABLE IF EXISTS `cinema`;
CREATE TABLE IF NOT EXISTS `cinema` (
  `idCinema` int NOT NULL AUTO_INCREMENT,
  `NomCinema` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Adresse` varchar(250) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`idCinema`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `cinema`
--

INSERT INTO `cinema` (`idCinema`, `NomCinema`, `Adresse`) VALUES
(1, 'le renoir', '13100 Aix-en-Provence'),
(2, 'Le Fontenelle', '78160 Marly-le-Roi'),
(3, 'Gaumont ilson', '31000 Toulouse'),
(4, 'Espace Ciné', '93800 Epinay-sur-Seine');

-- --------------------------------------------------------

--
-- Structure de la table `film`
--

DROP TABLE IF EXISTS `film`;
CREATE TABLE IF NOT EXISTS `film` (
  `idFilm` int NOT NULL AUTO_INCREMENT,
  `idRealisateur` int NOT NULL,
  `titre` varchar(80) COLLATE utf8mb4_general_ci NOT NULL,
  `genre` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `annee` int NOT NULL,
  PRIMARY KEY (`idFilm`),
  KEY `idRealisateur` (`idRealisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `film`
--

INSERT INTO `film` (`idFilm`, `idRealisateur`, `titre`, `genre`, `annee`) VALUES
(1, 15, 'Crash', 'Drame', 1996),
(2, 15, 'Faux-semblants', 'Epouvante', 1988),
(3, 14, 'Pulp Fiction', 'Policier', 1994),
(4, 13, 'Breaking the waves', 'Drame', 1996),
(5, 13, 'Dogville', 'Drame', 2002),
(6, 12, 'Alamo', 'Western', 1960),
(7, 18, 'Dangereusement votre', 'Espionnage', 1985),
(8, 19, 'Chasseur blanc, coeur noir', 'Drame', 1989),
(9, 19, 'Minuit dans le jardin du bien et du mal', 'Policier', 1997),
(10, 21, 'American Beauty', 'Drame', 1999),
(11, 19, 'L\'échange', '', 2008);

-- --------------------------------------------------------

--
-- Structure de la table `jouer`
--

DROP TABLE IF EXISTS `jouer`;
CREATE TABLE IF NOT EXISTS `jouer` (
  `idActeur` int NOT NULL,
  `idFilm` int NOT NULL,
  `role` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`idActeur`,`idFilm`),
  KEY `idActeur` (`idActeur`),
  KEY `idFilm` (`idFilm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `jouer`
--

INSERT INTO `jouer` (`idActeur`, `idFilm`, `role`) VALUES
(1, 5, 'Grace'),
(2, 5, 'Tom Edison'),
(3, 4, 'Bess'),
(4, 4, 'Jan'),
(4, 5, 'Chuck'),
(5, 3, 'Vincent Vega'),
(6, 3, 'Jules Winnfield'),
(7, 3, 'Butch Coolidge'),
(8, 2, 'Beverly & Elliot Mantle'),
(9, 1, 'James Ballard'),
(10, 1, 'Helen Remington'),
(11, 1, 'Gabrielle'),
(16, 7, 'May Day'),
(19, 8, 'John Wilson'),
(20, 9, 'Jim Williams'),
(20, 10, 'Lester Burnham');

-- --------------------------------------------------------

--
-- Structure de la table `personne`
--

DROP TABLE IF EXISTS `personne`;
CREATE TABLE IF NOT EXISTS `personne` (
  `idPersonne` int NOT NULL AUTO_INCREMENT,
  `Nom` varchar(25) COLLATE utf8mb4_general_ci NOT NULL,
  `Prenom` varchar(25) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`idPersonne`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `personne`
--

INSERT INTO `personne` (`idPersonne`, `Nom`, `Prenom`) VALUES
(1, 'Kindman', 'Nicole'),
(2, 'Bettany', 'Paul'),
(3, 'Watson', 'Emily'),
(4, 'Skarsgard', 'Stellan'),
(5, 'Travolta', 'John'),
(6, 'L. Jackson', 'Samuel'),
(7, 'Willis', 'Bruce'),
(8, 'Irons', 'Jeremy'),
(9, 'Spader', 'James'),
(10, 'Hunter', 'Holly'),
(11, 'Arquette', 'Rosanna'),
(12, 'Wayne', 'John'),
(13, 'von Trier', 'Lars'),
(14, 'Taantino', 'Quentin'),
(15, 'Cronenberg', 'David'),
(16, 'Mazursky', 'Paul'),
(17, 'Jones', 'Grace'),
(18, 'Glen', 'John'),
(19, 'Eastwood', 'Clint'),
(20, 'Spacey', 'Kevin'),
(21, 'Mendes', 'Samuel'),
(22, 'Jolie', 'Angelina');

-- --------------------------------------------------------

--
-- Structure de la table `projection`
--

DROP TABLE IF EXISTS `projection`;
CREATE TABLE IF NOT EXISTS `projection` (
  `idCinema` int NOT NULL,
  `idFilm` int NOT NULL,
  `jour` date NOT NULL,
  PRIMARY KEY (`idCinema`,`idFilm`),
  KEY `idFilm` (`idFilm`),
  KEY `idCinema` (`idCinema`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `projection`
--

INSERT INTO `projection` (`idCinema`, `idFilm`, `jour`) VALUES
(1, 1, '1996-05-07'),
(1, 2, '1988-03-12'),
(1, 3, '1994-03-02'),
(1, 4, '1996-08-02'),
(1, 6, '1980-07-05'),
(2, 1, '1997-05-11'),
(2, 2, '1990-12-08'),
(2, 3, '1994-07-05'),
(2, 4, '1996-12-02'),
(2, 5, '2002-05-01'),
(2, 6, '2002-08-01'),
(2, 7, '1985-05-09'),
(2, 8, '1989-02-01'),
(2, 9, '2008-12-02'),
(2, 10, '2000-10-03'),
(2, 11, '2004-03-02'),
(3, 3, '1994-11-05'),
(3, 6, '1960-11-09'),
(4, 3, '1994-11-06'),
(4, 6, '2002-08-01');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `film`
--
ALTER TABLE `film`
  ADD CONSTRAINT `film_ibfk_1` FOREIGN KEY (`idRealisateur`) REFERENCES `personne` (`idPersonne`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `jouer`
--
ALTER TABLE `jouer`
  ADD CONSTRAINT `jouer_ibfk_1` FOREIGN KEY (`idActeur`) REFERENCES `personne` (`idPersonne`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `jouer_ibfk_2` FOREIGN KEY (`idFilm`) REFERENCES `film` (`idFilm`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `projection`
--
ALTER TABLE `projection`
  ADD CONSTRAINT `projection_ibfk_1` FOREIGN KEY (`idCinema`) REFERENCES `cinema` (`idCinema`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `projection_ibfk_2` FOREIGN KEY (`idFilm`) REFERENCES `film` (`idFilm`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
