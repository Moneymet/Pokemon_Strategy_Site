SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pokemon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pokemon` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `pokemon` ;

-- -----------------------------------------------------
-- Table `pokemon`.`Bruker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pokemon`.`Bruker` ;

CREATE TABLE IF NOT EXISTS `pokemon`.`Bruker` (
  `idBruker` INT NOT NULL AUTO_INCREMENT,
  `brukernavn` VARCHAR(20) NULL,
  `passord` VARCHAR(45) NULL,
  `dato` DATE NULL,
  `erAdmin` TINYINT(1) NULL,
  `epost` VARCHAR(45) NULL,
  PRIMARY KEY (`idBruker`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`Spill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pokemon`.`Spill` ;

CREATE TABLE IF NOT EXISTS `pokemon`.`Spill` (
  `idSpill` INT NOT NULL AUTO_INCREMENT,
  `spillnavn` VARCHAR(45) NULL,
  `Generasjon` TINYINT NULL,
  PRIMARY KEY (`idSpill`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`Trener`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pokemon`.`Trener` ;

CREATE TABLE IF NOT EXISTS `pokemon`.`Trener` (
  `idTrener` INT NOT NULL AUTO_INCREMENT,
  `trenernavn` VARCHAR(45) NULL,
  `Spill_idSpill` INT NOT NULL,
  PRIMARY KEY (`idTrener`),
  INDEX `fk_Trener_Spill1_idx` (`Spill_idSpill` ASC),
  CONSTRAINT `fk_Trener_Spill1`
    FOREIGN KEY (`Spill_idSpill`)
    REFERENCES `pokemon`.`Spill` (`idSpill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`Strategi`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pokemon`.`Strategi` ;

CREATE TABLE IF NOT EXISTS `pokemon`.`Strategi` (
  `idStrategi` INT NOT NULL AUTO_INCREMENT,
  `strategiTekst` VARCHAR(500) NULL,
  `score` INT NULL,
  `Bruker_idBruker` INT NOT NULL,
  `Trener_idTrener` INT NOT NULL,
  `dato` DATE NULL,
  PRIMARY KEY (`idStrategi`),
  INDEX `fk_Strategi_Bruker_idx` (`Bruker_idBruker` ASC),
  INDEX `fk_Strategi_Trener1_idx` (`Trener_idTrener` ASC),
  CONSTRAINT `fk_Strategi_Bruker`
    FOREIGN KEY (`Bruker_idBruker`)
    REFERENCES `pokemon`.`Bruker` (`idBruker`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Strategi_Trener1`
    FOREIGN KEY (`Trener_idTrener`)
    REFERENCES `pokemon`.`Trener` (`idTrener`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`Har_Stemt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pokemon`.`Har_Stemt` ;

CREATE TABLE IF NOT EXISTS `pokemon`.`Har_Stemt` (
  `Bruker_idBruker` INT NOT NULL,
  `Strategi_idStrategi` INT NOT NULL,
  PRIMARY KEY (`Bruker_idBruker`, `Strategi_idStrategi`),
  INDEX `fk_Bruker_has_Strategi_Strategi1_idx` (`Strategi_idStrategi` ASC),
  INDEX `fk_Bruker_has_Strategi_Bruker1_idx` (`Bruker_idBruker` ASC),
  CONSTRAINT `fk_Bruker_has_Strategi_Bruker1`
    FOREIGN KEY (`Bruker_idBruker`)
    REFERENCES `pokemon`.`Bruker` (`idBruker`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bruker_has_Strategi_Strategi1`
    FOREIGN KEY (`Strategi_idStrategi`)
    REFERENCES `pokemon`.`Strategi` (`idStrategi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`Pokemon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pokemon`.`Pokemon` ;

CREATE TABLE IF NOT EXISTS `pokemon`.`Pokemon` (
  `idPokemon` INT NOT NULL,
  `Navn` VARCHAR(30) NULL,
  `Generasjon` TINYINT NULL,
  PRIMARY KEY (`idPokemon`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`TrenersPokemon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pokemon`.`TrenersPokemon` ;

CREATE TABLE IF NOT EXISTS `pokemon`.`TrenersPokemon` (
  `Trener_idTrener` INT NOT NULL,
  `Pokemon_idPokemon` INT NOT NULL,
  `Move_1` VARCHAR(20) NULL,
  `Move_2` VARCHAR(20) NULL,
  `Move_3` VARCHAR(20) NULL,
  `Move_4` VARCHAR(20) NULL,
  `Hold_Item` VARCHAR(20) NULL,
  PRIMARY KEY (`Trener_idTrener`, `Pokemon_idPokemon`),
  INDEX `fk_Trener_has_Pokemon_Pokemon1_idx` (`Pokemon_idPokemon` ASC),
  INDEX `fk_Trener_has_Pokemon_Trener1_idx` (`Trener_idTrener` ASC),
  CONSTRAINT `fk_Trener_has_Pokemon_Trener1`
    FOREIGN KEY (`Trener_idTrener`)
    REFERENCES `pokemon`.`Trener` (`idTrener`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trener_has_Pokemon_Pokemon1`
    FOREIGN KEY (`Pokemon_idPokemon`)
    REFERENCES `pokemon`.`Pokemon` (`idPokemon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `pokemon` ;

-- -----------------------------------------------------
-- Placeholder table for view `pokemon`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `pokemon`.`view1`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `pokemon`.`view1` ;
DROP TABLE IF EXISTS `pokemon`.`view1`;
USE `pokemon`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

DELETE FROM `spill`;

INSERT INTO `spill` (`idSpill`, `spillnavn`, `Generasjon`) VALUES
(1, 'Pokémon Red and Blue', 1),
(2, 'Pokémon Yellow', 1),
(3, 'Pokémon Gold and Silver', 2),
(4, 'Pokémon Crystal', 2),
(5, 'Pokémon Ruby and Sapphire', 3),
(6, 'Pokémon FireRed and LeafGreen', 3),
(7, 'Pokémon Emerald', 3),
(8, 'Pokémon Diamond and Pearl', 4),
(9, 'Pokémon Platinum', 4),
(10, 'Pokémon HeartGold and SoulSilver', 4),
(11, 'Pokémon Black and White', 5),
(12, 'Pokémon Black 2 and White 2', 5),
(13, 'Pokémon X and Y', 6),
(14, 'Pokémon Omega Ruby and Alpha Sapphire', 6),
(15, 'Pokémon Sun and Moon', 7);

DELETE FROM `pokemon`;

INSERT INTO `pokemon` (`idPokemon`, `Navn`, `Generasjon`) VALUES
(1, 'bulbasaur', 1),
(2, 'ivysaur', 1),
(3, 'venusaur', 1),
(4, 'charmander', 1),
(5, 'charmeleon', 1),
(6, 'charizard', 1),
(7, 'squirtle', 1),
(8, 'wartortle', 1),
(9, 'blastoise', 1),
(10, 'caterpie', 1),
(11, 'metapod', 1),
(12, 'butterfree', 1),
(13, 'weedle', 1),
(14, 'kakuna', 1),
(15, 'beedrill', 1),
(16, 'pidgey', 1),
(17, 'pidgeotto', 1),
(18, 'pidgeot', 1),
(19, 'rattata', 1),
(20, 'raticate', 1),
(21, 'spearow', 1),
(22, 'fearow', 1),
(23, 'ekans', 1),
(24, 'arbok', 1),
(25, 'pikachu', 1),
(26, 'raichu', 1),
(27, 'sandshrew', 1),
(28, 'sandslash', 1),
(29, 'nidoran-f', 1),
(30, 'nidorina', 1),
(31, 'nidoqueen', 1),
(32, 'nidoran-m', 1),
(33, 'nidorino', 1),
(34, 'nidoking', 1),
(35, 'clefairy', 1),
(36, 'clefable', 1),
(37, 'vulpix', 1),
(38, 'ninetales', 1),
(39, 'jigglypuff', 1),
(40, 'wigglytuff', 1),
(41, 'zubat', 1),
(42, 'golbat', 1),
(43, 'oddish', 1),
(44, 'gloom', 1),
(45, 'vileplume', 1),
(46, 'paras', 1),
(47, 'parasect', 1),
(48, 'venonat', 1),
(49, 'venomoth', 1),
(50, 'diglett', 1),
(51, 'dugtrio', 1),
(52, 'meowth', 1),
(53, 'persian', 1),
(54, 'psyduck', 1),
(55, 'golduck', 1),
(56, 'mankey', 1),
(57, 'primeape', 1),
(58, 'growlithe', 1),
(59, 'arcanine', 1),
(60, 'poliwag', 1),
(61, 'poliwhirl', 1),
(62, 'poliwrath', 1),
(63, 'abra', 1),
(64, 'kadabra', 1),
(65, 'alakazam', 1),
(66, 'machop', 1),
(67, 'machoke', 1),
(68, 'machamp', 1),
(69, 'bellsprout', 1),
(70, 'weepinbell', 1),
(71, 'victreebel', 1),
(72, 'tentacool', 1),
(73, 'tentacruel', 1),
(74, 'geodude', 1),
(75, 'graveler', 1),
(76, 'golem', 1),
(77, 'ponyta', 1),
(78, 'rapidash', 1),
(79, 'slowpoke', 1),
(80, 'slowbro', 1),
(81, 'magnemite', 1),
(82, 'magneton', 1),
(83, 'farfetchd', 1),
(84, 'doduo', 1),
(85, 'dodrio', 1),
(86, 'seel', 1),
(87, 'dewgong', 1),
(88, 'grimer', 1),
(89, 'muk', 1),
(90, 'shellder', 1),
(91, 'cloyster', 1),
(92, 'gastly', 1),
(93, 'haunter', 1),
(94, 'gengar', 1),
(95, 'onix', 1),
(96, 'drowzee', 1),
(97, 'hypno', 1),
(98, 'krabby', 1),
(99, 'kingler', 1),
(100, 'voltorb', 1),
(101, 'electrode', 1),
(102, 'exeggcute', 1),
(103, 'exeggutor', 1),
(104, 'cubone', 1),
(105, 'marowak', 1),
(106, 'hitmonlee', 1),
(107, 'hitmonchan', 1),
(108, 'lickitung', 1),
(109, 'koffing', 1),
(110, 'weezing', 1),
(111, 'rhyhorn', 1),
(112, 'rhydon', 1),
(113, 'chansey', 1),
(114, 'tangela', 1),
(115, 'kangaskhan', 1),
(116, 'horsea', 1),
(117, 'seadra', 1),
(118, 'goldeen', 1),
(119, 'seaking', 1),
(120, 'staryu', 1),
(121, 'starmie', 1),
(122, 'mr-mime', 1),
(123, 'scyther', 1),
(124, 'jynx', 1),
(125, 'electabuzz', 1),
(126, 'magmar', 1),
(127, 'pinsir', 1),
(128, 'tauros', 1),
(129, 'magikarp', 1),
(130, 'gyarados', 1),
(131, 'lapras', 1),
(132, 'ditto', 1),
(133, 'eevee', 1),
(134, 'vaporeon', 1),
(135, 'jolteon', 1),
(136, 'flareon', 1),
(137, 'porygon', 1),
(138, 'omanyte', 1),
(139, 'omastar', 1),
(140, 'kabuto', 1),
(141, 'kabutops', 1),
(142, 'aerodactyl', 1),
(143, 'snorlax', 1),
(144, 'articuno', 1),
(145, 'zapdos', 1),
(146, 'moltres', 1),
(147, 'dratini', 1),
(148, 'dragonair', 1),
(149, 'dragonite', 1),
(150, 'mewtwo', 1),
(151, 'mew', 1),
(152, 'chikorita', 2),
(153, 'bayleef', 2),
(154, 'meganium', 2),
(155, 'cyndaquil', 2),
(156, 'quilava', 2),
(157, 'typhlosion', 2),
(158, 'totodile', 2),
(159, 'croconaw', 2),
(160, 'feraligatr', 2),
(161, 'sentret', 2),
(162, 'furret', 2),
(163, 'hoothoot', 2),
(164, 'noctowl', 2),
(165, 'ledyba', 2),
(166, 'ledian', 2),
(167, 'spinarak', 2),
(168, 'ariados', 2),
(169, 'crobat', 2),
(170, 'chinchou', 2),
(171, 'lanturn', 2),
(172, 'pichu', 2),
(173, 'cleffa', 2),
(174, 'igglybuff', 2),
(175, 'togepi', 2),
(176, 'togetic', 2),
(177, 'natu', 2),
(178, 'xatu', 2),
(179, 'mareep', 2),
(180, 'flaaffy', 2),
(181, 'ampharos', 2),
(182, 'bellossom', 2),
(183, 'marill', 2),
(184, 'azumarill', 2),
(185, 'sudowoodo', 2),
(186, 'politoed', 2),
(187, 'hoppip', 2),
(188, 'skiploom', 2),
(189, 'jumpluff', 2),
(190, 'aipom', 2),
(191, 'sunkern', 2),
(192, 'sunflora', 2),
(193, 'yanma', 2),
(194, 'wooper', 2),
(195, 'quagsire', 2),
(196, 'espeon', 2),
(197, 'umbreon', 2),
(198, 'murkrow', 2),
(199, 'slowking', 2),
(200, 'misdreavus', 2),
(201, 'unown', 2),
(202, 'wobbuffet', 2),
(203, 'girafarig', 2),
(204, 'pineco', 2),
(205, 'forretress', 2),
(206, 'dunsparce', 2),
(207, 'gligar', 2),
(208, 'steelix', 2),
(209, 'snubbull', 2),
(210, 'granbull', 2),
(211, 'qwilfish', 2),
(212, 'scizor', 2),
(213, 'shuckle', 2),
(214, 'heracross', 2),
(215, 'sneasel', 2),
(216, 'teddiursa', 2),
(217, 'ursaring', 2),
(218, 'slugma', 2),
(219, 'magcargo', 2),
(220, 'swinub', 2),
(221, 'piloswine', 2),
(222, 'corsola', 2),
(223, 'remoraid', 2),
(224, 'octillery', 2),
(225, 'delibird', 2),
(226, 'mantine', 2),
(227, 'skarmory', 2),
(228, 'houndour', 2),
(229, 'houndoom', 2),
(230, 'kingdra', 2),
(231, 'phanpy', 2),
(232, 'donphan', 2),
(233, 'porygon2', 2),
(234, 'stantler', 2),
(235, 'smeargle', 2),
(236, 'tyrogue', 2),
(237, 'hitmontop', 2),
(238, 'smoochum', 2),
(239, 'elekid', 2),
(240, 'magby', 2),
(241, 'miltank', 2),
(242, 'blissey', 2),
(243, 'raikou', 2),
(244, 'entei', 2),
(245, 'suicune', 2),
(246, 'larvitar', 2),
(247, 'pupitar', 2),
(248, 'tyranitar', 2),
(249, 'lugia', 2),
(250, 'ho-oh', 2),
(251, 'celebi', 2),
(252, 'treecko', 3),
(253, 'grovyle', 3),
(254, 'sceptile', 3),
(255, 'torchic', 3),
(256, 'combusken', 3),
(257, 'blaziken', 3),
(258, 'mudkip', 3),
(259, 'marshtomp', 3),
(260, 'swampert', 3),
(261, 'poochyena', 3),
(262, 'mightyena', 3),
(263, 'zigzagoon', 3),
(264, 'linoone', 3),
(265, 'wurmple', 3),
(266, 'silcoon', 3),
(267, 'beautifly', 3),
(268, 'cascoon', 3),
(269, 'dustox', 3),
(270, 'lotad', 3),
(271, 'lombre', 3),
(272, 'ludicolo', 3),
(273, 'seedot', 3),
(274, 'nuzleaf', 3),
(275, 'shiftry', 3),
(276, 'taillow', 3),
(277, 'swellow', 3),
(278, 'wingull', 3),
(279, 'pelipper', 3),
(280, 'ralts', 3),
(281, 'kirlia', 3),
(282, 'gardevoir', 3),
(283, 'surskit', 3),
(284, 'masquerain', 3),
(285, 'shroomish', 3),
(286, 'breloom', 3),
(287, 'slakoth', 3),
(288, 'vigoroth', 3),
(289, 'slaking', 3),
(290, 'nincada', 3),
(291, 'ninjask', 3),
(292, 'shedinja', 3),
(293, 'whismur', 3),
(294, 'loudred', 3),
(295, 'exploud', 3),
(296, 'makuhita', 3),
(297, 'hariyama', 3),
(298, 'azurill', 3),
(299, 'nosepass', 3),
(300, 'skitty', 3),
(301, 'delcatty', 3),
(302, 'sableye', 3),
(303, 'mawile', 3),
(304, 'aron', 3),
(305, 'lairon', 3),
(306, 'aggron', 3),
(307, 'meditite', 3),
(308, 'medicham', 3),
(309, 'electrike', 3),
(310, 'manectric', 3),
(311, 'plusle', 3),
(312, 'minun', 3),
(313, 'volbeat', 3),
(314, 'illumise', 3),
(315, 'roselia', 3),
(316, 'gulpin', 3),
(317, 'swalot', 3),
(318, 'carvanha', 3),
(319, 'sharpedo', 3),
(320, 'wailmer', 3),
(321, 'wailord', 3),
(322, 'numel', 3),
(323, 'camerupt', 3),
(324, 'torkoal', 3),
(325, 'spoink', 3),
(326, 'grumpig', 3),
(327, 'spinda', 3),
(328, 'trapinch', 3),
(329, 'vibrava', 3),
(330, 'flygon', 3),
(331, 'cacnea', 3),
(332, 'cacturne', 3),
(333, 'swablu', 3),
(334, 'altaria', 3),
(335, 'zangoose', 3),
(336, 'seviper', 3),
(337, 'lunatone', 3),
(338, 'solrock', 3),
(339, 'barboach', 3),
(340, 'whiscash', 3),
(341, 'corphish', 3),
(342, 'crawdaunt', 3),
(343, 'baltoy', 3),
(344, 'claydol', 3),
(345, 'lileep', 3),
(346, 'cradily', 3),
(347, 'anorith', 3),
(348, 'armaldo', 3),
(349, 'feebas', 3),
(350, 'milotic', 3),
(351, 'castform', 3),
(352, 'kecleon', 3),
(353, 'shuppet', 3),
(354, 'banette', 3),
(355, 'duskull', 3),
(356, 'dusclops', 3),
(357, 'tropius', 3),
(358, 'chimecho', 3),
(359, 'absol', 3),
(360, 'wynaut', 3),
(361, 'snorunt', 3),
(362, 'glalie', 3),
(363, 'spheal', 3),
(364, 'sealeo', 3),
(365, 'walrein', 3),
(366, 'clamperl', 3),
(367, 'huntail', 3),
(368, 'gorebyss', 3),
(369, 'relicanth', 3),
(370, 'luvdisc', 3),
(371, 'bagon', 3),
(372, 'shelgon', 3),
(373, 'salamence', 3),
(374, 'beldum', 3),
(375, 'metang', 3),
(376, 'metagross', 3),
(377, 'regirock', 3),
(378, 'regice', 3),
(379, 'registeel', 3),
(380, 'latias', 3),
(381, 'latios', 3),
(382, 'kyogre', 3),
(383, 'groudon', 3),
(384, 'rayquaza', 3),
(385, 'jirachi', 3),
(386, 'deoxys-normal', 3),
(387, 'turtwig', 4),
(388, 'grotle', 4),
(389, 'torterra', 4),
(390, 'chimchar', 4),
(391, 'monferno', 4),
(392, 'infernape', 4),
(393, 'piplup', 4),
(394, 'prinplup', 4),
(395, 'empoleon', 4),
(396, 'starly', 4),
(397, 'staravia', 4),
(398, 'staraptor', 4),
(399, 'bidoof', 4),
(400, 'bibarel', 4),
(401, 'kricketot', 4),
(402, 'kricketune', 4),
(403, 'shinx', 4),
(404, 'luxio', 4),
(405, 'luxray', 4),
(406, 'budew', 4),
(407, 'roserade', 4),
(408, 'cranidos', 4),
(409, 'rampardos', 4),
(410, 'shieldon', 4),
(411, 'bastiodon', 4),
(412, 'burmy', 4),
(413, 'wormadam-plant', 4),
(414, 'mothim', 4),
(415, 'combee', 4),
(416, 'vespiquen', 4),
(417, 'pachirisu', 4),
(418, 'buizel', 4),
(419, 'floatzel', 4),
(420, 'cherubi', 4),
(421, 'cherrim', 4),
(422, 'shellos', 4),
(423, 'gastrodon', 4),
(424, 'ambipom', 4),
(425, 'drifloon', 4),
(426, 'drifblim', 4),
(427, 'buneary', 4),
(428, 'lopunny', 4),
(429, 'mismagius', 4),
(430, 'honchkrow', 4),
(431, 'glameow', 4),
(432, 'purugly', 4),
(433, 'chingling', 4),
(434, 'stunky', 4),
(435, 'skuntank', 4),
(436, 'bronzor', 4),
(437, 'bronzong', 4),
(438, 'bonsly', 4),
(439, 'mime-jr', 4),
(440, 'happiny', 4),
(441, 'chatot', 4),
(442, 'spiritomb', 4),
(443, 'gible', 4),
(444, 'gabite', 4),
(445, 'garchomp', 4),
(446, 'munchlax', 4),
(447, 'riolu', 4),
(448, 'lucario', 4),
(449, 'hippopotas', 4),
(450, 'hippowdon', 4),
(451, 'skorupi', 4),
(452, 'drapion', 4),
(453, 'croagunk', 4),
(454, 'toxicroak', 4),
(455, 'carnivine', 4),
(456, 'finneon', 4),
(457, 'lumineon', 4),
(458, 'mantyke', 4),
(459, 'snover', 4),
(460, 'abomasnow', 4),
(461, 'weavile', 4),
(462, 'magnezone', 4),
(463, 'lickilicky', 4),
(464, 'rhyperior', 4),
(465, 'tangrowth', 4),
(466, 'electivire', 4),
(467, 'magmortar', 4),
(468, 'togekiss', 4),
(469, 'yanmega', 4),
(470, 'leafeon', 4),
(471, 'glaceon', 4),
(472, 'gliscor', 4),
(473, 'mamoswine', 4),
(474, 'porygon-z', 4),
(475, 'gallade', 4),
(476, 'probopass', 4),
(477, 'dusknoir', 4),
(478, 'froslass', 4),
(479, 'rotom', 4),
(480, 'uxie', 4),
(481, 'mesprit', 4),
(482, 'azelf', 4),
(483, 'dialga', 4),
(484, 'palkia', 4),
(485, 'heatran', 4),
(486, 'regigigas', 4),
(487, 'giratina-altered', 4),
(488, 'cresselia', 4),
(489, 'phione', 4),
(490, 'manaphy', 4),
(491, 'darkrai', 4),
(492, 'shaymin-land', 4),
(493, 'arceus', 4),
(494, 'victini', 5),
(495, 'snivy', 5),
(496, 'servine', 5),
(497, 'serperior', 5),
(498, 'tepig', 5),
(499, 'pignite', 5),
(500, 'emboar', 5),
(501, 'oshawott', 5),
(502, 'dewott', 5),
(503, 'samurott', 5),
(504, 'patrat', 5),
(505, 'watchog', 5),
(506, 'lillipup', 5),
(507, 'herdier', 5),
(508, 'stoutland', 5),
(509, 'purrloin', 5),
(510, 'liepard', 5),
(511, 'pansage', 5),
(512, 'simisage', 5),
(513, 'pansear', 5),
(514, 'simisear', 5),
(515, 'panpour', 5),
(516, 'simipour', 5),
(517, 'munna', 5),
(518, 'musharna', 5),
(519, 'pidove', 5),
(520, 'tranquill', 5),
(521, 'unfezant', 5),
(522, 'blitzle', 5),
(523, 'zebstrika', 5),
(524, 'roggenrola', 5),
(525, 'boldore', 5),
(526, 'gigalith', 5),
(527, 'woobat', 5),
(528, 'swoobat', 5),
(529, 'drilbur', 5),
(530, 'excadrill', 5),
(531, 'audino', 5),
(532, 'timburr', 5),
(533, 'gurdurr', 5),
(534, 'conkeldurr', 5),
(535, 'tympole', 5),
(536, 'palpitoad', 5),
(537, 'seismitoad', 5),
(538, 'throh', 5),
(539, 'sawk', 5),
(540, 'sewaddle', 5),
(541, 'swadloon', 5),
(542, 'leavanny', 5),
(543, 'venipede', 5),
(544, 'whirlipede', 5),
(545, 'scolipede', 5),
(546, 'cottonee', 5),
(547, 'whimsicott', 5),
(548, 'petilil', 5),
(549, 'lilligant', 5),
(550, 'basculin-red-striped', 5),
(551, 'sandile', 5),
(552, 'krokorok', 5),
(553, 'krookodile', 5),
(554, 'darumaka', 5),
(555, 'darmanitan-standard', 5),
(556, 'maractus', 5),
(557, 'dwebble', 5),
(558, 'crustle', 5),
(559, 'scraggy', 5),
(560, 'scrafty', 5),
(561, 'sigilyph', 5),
(562, 'yamask', 5),
(563, 'cofagrigus', 5),
(564, 'tirtouga', 5),
(565, 'carracosta', 5),
(566, 'archen', 5),
(567, 'archeops', 5),
(568, 'trubbish', 5),
(569, 'garbodor', 5),
(570, 'zorua', 5),
(571, 'zoroark', 5),
(572, 'minccino', 5),
(573, 'cinccino', 5),
(574, 'gothita', 5),
(575, 'gothorita', 5),
(576, 'gothitelle', 5),
(577, 'solosis', 5),
(578, 'duosion', 5),
(579, 'reuniclus', 5),
(580, 'ducklett', 5),
(581, 'swanna', 5),
(582, 'vanillite', 5),
(583, 'vanillish', 5),
(584, 'vanilluxe', 5),
(585, 'deerling', 5),
(586, 'sawsbuck', 5),
(587, 'emolga', 5),
(588, 'karrablast', 5),
(589, 'escavalier', 5),
(590, 'foongus', 5),
(591, 'amoonguss', 5),
(592, 'frillish', 5),
(593, 'jellicent', 5),
(594, 'alomomola', 5),
(595, 'joltik', 5),
(596, 'galvantula', 5),
(597, 'ferroseed', 5),
(598, 'ferrothorn', 5),
(599, 'klink', 5),
(600, 'klang', 5),
(601, 'klinklang', 5),
(602, 'tynamo', 5),
(603, 'eelektrik', 5),
(604, 'eelektross', 5),
(605, 'elgyem', 5),
(606, 'beheeyem', 5),
(607, 'litwick', 5),
(608, 'lampent', 5),
(609, 'chandelure', 5),
(610, 'axew', 5),
(611, 'fraxure', 5),
(612, 'haxorus', 5),
(613, 'cubchoo', 5),
(614, 'beartic', 5),
(615, 'cryogonal', 5),
(616, 'shelmet', 5),
(617, 'accelgor', 5),
(618, 'stunfisk', 5),
(619, 'mienfoo', 5),
(620, 'mienshao', 5),
(621, 'druddigon', 5),
(622, 'golett', 5),
(623, 'golurk', 5),
(624, 'pawniard', 5),
(625, 'bisharp', 5),
(626, 'bouffalant', 5),
(627, 'rufflet', 5),
(628, 'braviary', 5),
(629, 'vullaby', 5),
(630, 'mandibuzz', 5),
(631, 'heatmor', 5),
(632, 'durant', 5),
(633, 'deino', 5),
(634, 'zweilous', 5),
(635, 'hydreigon', 5),
(636, 'larvesta', 5),
(637, 'volcarona', 5),
(638, 'cobalion', 5),
(639, 'terrakion', 5),
(640, 'virizion', 5),
(641, 'tornadus-incarnate', 5),
(642, 'thundurus-incarnate', 5),
(643, 'reshiram', 5),
(644, 'zekrom', 5),
(645, 'landorus-incarnate', 5),
(646, 'kyurem', 5),
(647, 'keldeo-ordinary', 5),
(648, 'meloetta-aria', 5),
(649, 'genesect', 5),
(650, 'chespin', 6),
(651, 'quilladin', 6),
(652, 'chesnaught', 6),
(653, 'fennekin', 6),
(654, 'braixen', 6),
(655, 'delphox', 6),
(656, 'froakie', 6),
(657, 'frogadier', 6),
(658, 'greninja', 6),
(659, 'bunnelby', 6),
(660, 'diggersby', 6),
(661, 'fletchling', 6),
(662, 'fletchinder', 6),
(663, 'talonflame', 6),
(664, 'scatterbug', 6),
(665, 'spewpa', 6),
(666, 'vivillon', 6),
(667, 'litleo', 6),
(668, 'pyroar', 6),
(669, 'flabebe', 6),
(670, 'floette', 6),
(671, 'florges', 6),
(672, 'skiddo', 6),
(673, 'gogoat', 6),
(674, 'pancham', 6),
(675, 'pangoro', 6),
(676, 'furfrou', 6),
(677, 'espurr', 6),
(678, 'meowstic-male', 6),
(679, 'honedge', 6),
(680, 'doublade', 6),
(681, 'aegislash-shield', 6),
(682, 'spritzee', 6),
(683, 'aromatisse', 6),
(684, 'swirlix', 6),
(685, 'slurpuff', 6),
(686, 'inkay', 6),
(687, 'malamar', 6),
(688, 'binacle', 6),
(689, 'barbaracle', 6),
(690, 'skrelp', 6),
(691, 'dragalge', 6),
(692, 'clauncher', 6),
(693, 'clawitzer', 6),
(694, 'helioptile', 6),
(695, 'heliolisk', 6),
(696, 'tyrunt', 6),
(697, 'tyrantrum', 6),
(698, 'amaura', 6),
(699, 'aurorus', 6),
(700, 'sylveon', 6),
(701, 'hawlucha', 6),
(702, 'dedenne', 6),
(703, 'carbink', 6),
(704, 'goomy', 6),
(705, 'sliggoo', 6),
(706, 'goodra', 6),
(707, 'klefki', 6),
(708, 'phantump', 6),
(709, 'trevenant', 6),
(710, 'pumpkaboo-average', 6),
(711, 'gourgeist-average', 6),
(712, 'bergmite', 6),
(713, 'avalugg', 6),
(714, 'noibat', 6),
(715, 'noivern', 6),
(716, 'xerneas', 6),
(717, 'yveltal', 6),
(718, 'zygarde', 6),
(719, 'diancie', 6),
(720, 'hoopa', 6),
(721, 'volcanion', 6);

DELETE FROM `bruker`;

INSERT INTO `bruker` (`idBruker`, `brukernavn`, `passord`, `dato`, `erAdmin`, `epost`) VALUES
(1, 'Admin', '56f491c56340a6fa5c158863c6bfb39f', '2017-04-19', 1, 'admin@gmail.com'),
(2, 'Nettbruker3', '202cb962ac59075b964b07152d234b70', '2017-04-19', 0, 'nett3@gmail.com'),
(3, 'Boksamler', '3bec65f6f8000fd631db1300fd420986', '2017-04-19', 0, 'bok@gmail.com'),
(4, 'Knightowl', '50f8b6c98b0f9a271a562632405ae63d', '2017-04-19', 0, 'owl@gmail.com');

DELETE FROM `trener`;

INSERT INTO `trener` (`idTrener`, `trenernavn`, `Spill_idSpill`) VALUES
(1, 'Rival_1_RB', 1),
(2, 'Brock_RB', 1),
(3, 'Misty_RB', 1),
(4, 'Lt. Surge_RB', 1),
(5, 'Rival_1_GS', 3),
(6, 'Falkner_GS', 3),
(7, 'Rival_2_GS', 3),
(8, 'Bugsy_GS', 3);

DELETE FROM `trenerspokemon`;

INSERT INTO `trenerspokemon` (`Trener_idTrener`, `Pokemon_idPokemon`, `Move_1`, `Move_2`, `Move_3`, `Move_4`, `Hold_Item`) VALUES
(1, 1, 'Tackle', 'Growl', NULL, NULL, NULL),
(2, 74, 'Tackle', 'Defense Curl', NULL, NULL, NULL),
(2, 95, 'Tackle', 'Screech', 'Bide', 'Bind', NULL),
(3, 120, 'Tackle', 'Water Gun', NULL, NULL, NULL),
(3, 121, 'Tackle', 'Water Gun', 'Harden', 'Bubblebeam', NULL),
(4, 25, 'Thundershock', 'Thunder Wave', 'Growl', 'Quick Attack', NULL),
(4, 26, 'Thunderbolt', 'Thundershock', 'Thunder Wave', 'Growl', NULL),
(4, 100, 'Tackle', 'Screech', 'Sonicboom', NULL, NULL),
(5, 152, 'Tackle', 'Growl', NULL, NULL, NULL),
(6, 16, 'Tackle', 'Mud-Slap', NULL, NULL, NULL),
(6, 17, 'Tackle', 'Mud-Slap', 'Gust', NULL, NULL),
(7, 41, 'Leech Life', 'Supersonic', 'Bite', NULL, NULL),
(7, 92, 'Hypnosis', 'Spite', 'Lick', NULL, NULL),
(7, 153, 'Growl', 'Razor Leaf', 'Reflect', 'Poisonpowder', NULL),
(8, 11, 'Tackle', 'String Shot', 'Harden', NULL, NULL),
(8, 14, 'Poison Sting', 'String Shot', 'Harden', NULL, NULL),
(8, 123, 'Quick Attack', 'Leer', 'Fury Cutter', NULL, NULL);

DELETE FROM `strategi`;

INSERT INTO `strategi` (`idStrategi`, `strategiTekst`, `score`, `Bruker_idBruker`, `Trener_idTrener`, `dato`) VALUES
(1, 'Det er en potion i PCen du kan hente.', 0, 2, 1, '2017-04-19'),
(2, 'Velg Bulbasaur eller Squirtle.', 0, 2, 2, '2017-04-19'),
(3, 'Fang Oddish.', 0, 2, 3, '2017-04-19'),
(4, 'Fang Diglett.', 0, 2, 4, '2017-04-19'),
(5, 'Tren i gresset før du slåss.', 0, 2, 5, '2017-04-19'),
(6, 'Bytt Bellsprout med en fyr for hans Onix. ', 0, 2, 6, '2017-04-19'),
(7, 'Bruk Geodude eller Onix.', 0, 4, 8, '2017-04-19'),
(8, 'Skaff deg Butterfree.', 0, 4, 2, '2017-04-19'),
(9, 'Bruk Bulbasaur for mindre skade.', 0, 3, 4, '2017-04-19');

DELIMITER $$
 
DROP PROCEDURE IF EXISTS sisteStrategier $$
 
CREATE PROCEDURE sisteStrategier
(
  OUT tekstVar VARCHAR(500),
  OUT brukernavnVar VARCHAR(20),
  OUT stratidVar INT(11)
)
BEGIN
  SELECT  strategiTekst,
      brukernavn,
      idStrategi
  FROM strategi
  JOIN bruker 
  ON strategi.Bruker_idBruker = bruker.idBruker 
  ORDER BY strategi.dato DESC;
END $$
 
DROP TRIGGER IF EXISTS bruker_b_ins_trg $$
 
CREATE TRIGGER bruker_b_ins_trg
BEFORE INSERT ON bruker
FOR EACH ROW
BEGIN
  SET NEW.brukernavn = CONCAT(SUBSTRING(UPPER(TRIM(NEW.brukernavn)), 1, 1), SUBSTRING(LOWER(TRIM(NEW.brukernavn)), 2));
END $$

DROP TRIGGER IF EXISTS trenerspokemon_b_ins_trg $$
 
CREATE TRIGGER trenerspokemon_b_ins_trg
BEFORE INSERT ON trenerspokemon
FOR EACH ROW
BEGIN
  DECLARE antall INT;
  DECLARE trenerGen INT;
  DECLARE pokemonGen INT;
  SET antall = (SELECT COUNT(*) FROM trenerspokemon WHERE NEW.Trener_idTrener = trenerspokemon.Trener_idTrener);
    IF antall >= 6 
      THEN SIGNAL SQLSTATE '80000'
      SET MESSAGE_TEXT = 'Trener kan ikke ha flere enn 6 Pokémon';
    END IF;

    SET pokemonGen = (SELECT generasjon FROM pokemon
      WHERE pokemon.idPokemon = NEW.Pokemon_idPokemon);

    SET trenerGen = (SELECT generasjon FROM trener
      JOIN spill ON trener.Spill_idSpill = spill.idSpill
      WHERE NEW.Trener_idTrener = trener.idTrener
      );
    IF trenerGen < pokemonGen 
      THEN SIGNAL SQLSTATE '80000'
      SET MESSAGE_TEXT = "Pokémon fra en nyere generasjon enn treneren.";
    END IF;

END 