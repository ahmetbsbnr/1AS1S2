-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 17 déc. 2024 à 13:28
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
-- Base de données : `2024-but-bibliotheques`
--

-- --------------------------------------------------------

--
-- Structure de la table `abonne`
--

DROP TABLE IF EXISTS `abonne`;
CREATE TABLE IF NOT EXISTS `abonne` (
  `id_abonne` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `date_naissance` date NOT NULL,
  `date_adhesion` date NOT NULL,
  PRIMARY KEY (`id_abonne`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `abonne`
--

INSERT INTO `abonne` (`id_abonne`, `nom`, `date_naissance`, `date_adhesion`) VALUES
(1, 'Dupond', '1973-05-15', '2010-10-09'),
(2, 'Schmidt', '1959-04-01', '2011-10-01'),
(3, 'Thomas', '1964-02-29', '2012-01-20');

-- --------------------------------------------------------

--
-- Structure de la table `auteur`
--

DROP TABLE IF EXISTS `auteur`;
CREATE TABLE IF NOT EXISTS `auteur` (
  `id_auteur` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `prénom` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_auteur`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `auteur`
--

INSERT INTO `auteur` (`id_auteur`, `nom`, `prénom`) VALUES
(1, 'Franquin', 'André'),
(2, 'Eddings', 'David'),
(3, 'Volkoff', 'Vladimir'),
(4, 'Bond', 'Edward'),
(5, 'Hugo', 'Victor'),
(6, 'Brumark', 'Annika');

-- --------------------------------------------------------

--
-- Structure de la table `correspond`
--

DROP TABLE IF EXISTS `correspond`;
CREATE TABLE IF NOT EXISTS `correspond` (
  `id_genre` int NOT NULL,
  `id_livre` int NOT NULL,
  PRIMARY KEY (`id_genre`,`id_livre`),
  KEY `id_genre` (`id_genre`),
  KEY `id_livre` (`id_livre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `correspond`
--

INSERT INTO `correspond` (`id_genre`, `id_livre`) VALUES
(1, 1),
(1, 7),
(2, 2),
(2, 4),
(2, 8),
(2, 9),
(2, 12),
(3, 3),
(3, 10),
(4, 1),
(4, 4),
(4, 5),
(4, 6),
(5, 11),
(8, 8);

-- --------------------------------------------------------

--
-- Structure de la table `decrit`
--

DROP TABLE IF EXISTS `decrit`;
CREATE TABLE IF NOT EXISTS `decrit` (
  `id_motcle` int NOT NULL,
  `id_livre` int NOT NULL,
  PRIMARY KEY (`id_motcle`,`id_livre`),
  KEY `id_motcle` (`id_motcle`),
  KEY `id_livre` (`id_livre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `decrit`
--

INSERT INTO `decrit` (`id_motcle`, `id_livre`) VALUES
(2, 1),
(2, 4),
(2, 5),
(2, 6),
(2, 8),
(2, 9),
(3, 3),
(3, 10),
(3, 11),
(3, 12),
(4, 2),
(4, 7);

-- --------------------------------------------------------

--
-- Structure de la table `ecrit`
--

DROP TABLE IF EXISTS `ecrit`;
CREATE TABLE IF NOT EXISTS `ecrit` (
  `id_auteur` int NOT NULL,
  `id_livre` int NOT NULL,
  PRIMARY KEY (`id_auteur`,`id_livre`),
  KEY `id_auteur` (`id_auteur`),
  KEY `id_livre` (`id_livre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ecrit`
--

INSERT INTO `ecrit` (`id_auteur`, `id_livre`) VALUES
(1, 1),
(2, 4),
(2, 6),
(2, 11),
(3, 2),
(3, 5),
(3, 7),
(4, 3),
(5, 8),
(5, 9),
(5, 10),
(6, 12);

-- --------------------------------------------------------

--
-- Structure de la table `editeur`
--

DROP TABLE IF EXISTS `editeur`;
CREATE TABLE IF NOT EXISTS `editeur` (
  `id_editeur` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `adresse` varchar(250) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_editeur`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `editeur`
--

INSERT INTO `editeur` (`id_editeur`, `nom`, `adresse`) VALUES
(1, 'Fluide Glacial', '33 avenue du Maine, Paris15'),
(2, 'Livre de Poche', '43 quai de Grenelle, Paris 15'),
(3, 'Fallois', '22 rue de la Boétie, Paris 8'),
(4, 'Presses Pocket', '12 avenue d\'Italie, Paris 13'),
(5, 'Lombard', '15-27 rue Moussorgski, Paris 18'),
(6, 'Arche', '6 rue Bonaparte, Paris 6'),
(7, 'Casterman', '66 rue Bonaparte, Paris 6'),
(8, 'Anne Carrière', '66 rue Bonaparte, Paris 6'),
(9, 'IRMA', '22 rue du Soleillet, Paris 20');

-- --------------------------------------------------------

--
-- Structure de la table `emprunte`
--

DROP TABLE IF EXISTS `emprunte`;
CREATE TABLE IF NOT EXISTS `emprunte` (
  `id_abonne` int NOT NULL AUTO_INCREMENT,
  `id_exemplaire` int NOT NULL,
  `date_retour` date NOT NULL,
  PRIMARY KEY (`id_abonne`),
  KEY `id_exemplaire` (`id_exemplaire`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `emprunte`
--

INSERT INTO `emprunte` (`id_abonne`, `id_exemplaire`, `date_retour`) VALUES
(1, 9, '2019-12-25'),
(2, 7, '2019-12-25'),
(3, 12, '2019-12-25'),
(4, 8, '2019-01-10'),
(5, 11, '2019-01-10');

-- --------------------------------------------------------

--
-- Structure de la table `exemplaire`
--

DROP TABLE IF EXISTS `exemplaire`;
CREATE TABLE IF NOT EXISTS `exemplaire` (
  `id_exemplaire` int NOT NULL AUTO_INCREMENT,
  `date_acquisition` int NOT NULL,
  `annee_edition` int NOT NULL,
  `id_livre` int NOT NULL,
  `id_editeur` int NOT NULL,
  PRIMARY KEY (`id_exemplaire`),
  KEY `id_livre` (`id_livre`),
  KEY `id_editeur` (`id_editeur`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `exemplaire`
--

INSERT INTO `exemplaire` (`id_exemplaire`, `date_acquisition`, `annee_edition`, `id_livre`, `id_editeur`) VALUES
(1, 1995, 1990, 4, 4),
(2, 1995, 1991, 6, 4),
(3, 1995, 1963, 5, 4),
(4, 1996, 1995, 2, 3),
(5, 1997, 1997, 2, 2),
(6, 1999, 1998, 3, 6),
(7, 2000, 1996, 7, 5),
(8, 2001, 1987, 10, 2),
(9, 2002, 2001, 1, 1),
(10, 2003, 2002, 8, 2),
(11, 2003, 2002, 9, 2),
(12, 2003, 2002, 9, 7),
(13, 2004, 2003, 11, 9),
(14, 2000, 2000, 12, 8);

-- --------------------------------------------------------

--
-- Structure de la table `genre`
--

DROP TABLE IF EXISTS `genre`;
CREATE TABLE IF NOT EXISTS `genre` (
  `id_genre` int NOT NULL AUTO_INCREMENT,
  `nomGenre` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_genre`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `genre`
--

INSERT INTO `genre` (`id_genre`, `nomGenre`) VALUES
(1, 'BD'),
(2, 'roman'),
(3, 'théâtre'),
(4, 'SF'),
(5, 'guide'),
(6, 'technique'),
(7, 'policier'),
(8, 'biographie'),
(9, 'poésie');

-- --------------------------------------------------------

--
-- Structure de la table `livre`
--

DROP TABLE IF EXISTS `livre`;
CREATE TABLE IF NOT EXISTS `livre` (
  `id_livre` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `dateCreation` int NOT NULL,
  PRIMARY KEY (`id_livre`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `livre`
--

INSERT INTO `livre` (`id_livre`, `titre`, `dateCreation`) VALUES
(1, 'Idées noires', 1931),
(2, 'Le grand tsar blanc', 1912),
(3, 'Lear / La mer', 1953),
(4, 'Le pion blanc des présages', 1895),
(5, 'Métro pour l\'enfer', 1964),
(6, 'La reine des sortilèges', 1845),
(7, 'Alexandre Nevsky', 1820),
(8, 'L\'homme qui rit', 2001),
(9, 'Les travailleurs de la mer', 1842),
(10, 'Hernani', 1830),
(11, 'Le réseau', 1974),
(12, 'Le réseau', 1982);

-- --------------------------------------------------------

--
-- Structure de la table `mot_cle`
--

DROP TABLE IF EXISTS `mot_cle`;
CREATE TABLE IF NOT EXISTS `mot_cle` (
  `id_motcle` int NOT NULL AUTO_INCREMENT,
  `motcle` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_motcle`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `mot_cle`
--

INSERT INTO `mot_cle` (`id_motcle`, `motcle`) VALUES
(1, 'mathématiques'),
(2, 'fiction'),
(3, 'théorie'),
(4, 'univers'),
(5, 'statistiques'),
(6, 'cinéma');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `correspond`
--
ALTER TABLE `correspond`
  ADD CONSTRAINT `correspond_ibfk_1` FOREIGN KEY (`id_genre`) REFERENCES `genre` (`id_genre`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `correspond_ibfk_2` FOREIGN KEY (`id_livre`) REFERENCES `livre` (`id_livre`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `decrit`
--
ALTER TABLE `decrit`
  ADD CONSTRAINT `decrit_ibfk_1` FOREIGN KEY (`id_livre`) REFERENCES `livre` (`id_livre`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `decrit_ibfk_2` FOREIGN KEY (`id_motcle`) REFERENCES `mot_cle` (`id_motcle`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `ecrit`
--
ALTER TABLE `ecrit`
  ADD CONSTRAINT `ecrit_ibfk_1` FOREIGN KEY (`id_auteur`) REFERENCES `auteur` (`id_auteur`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ecrit_ibfk_2` FOREIGN KEY (`id_livre`) REFERENCES `livre` (`id_livre`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `emprunte`
--
ALTER TABLE `emprunte`
  ADD CONSTRAINT `emprunte_ibfk_1` FOREIGN KEY (`id_exemplaire`) REFERENCES `exemplaire` (`id_exemplaire`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `exemplaire`
--
ALTER TABLE `exemplaire`
  ADD CONSTRAINT `exemplaire_ibfk_1` FOREIGN KEY (`id_editeur`) REFERENCES `editeur` (`id_editeur`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `exemplaire_ibfk_2` FOREIGN KEY (`id_livre`) REFERENCES `livre` (`id_livre`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
