CREATE TABLE `Binary` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`data` BLOB,
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Metadata should be stored elsewhere';

CREATE TABLE `Translation` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`key` VARCHAR(250) NOT NULL DEFAULT '',
`group` VARCHAR(250) NOT NULL DEFAULT '',
`language` VARCHAR(250) NOT NULL DEFAULT '',
`text` VARCHAR(250) NOT NULL DEFAULT '',
PRIMARY KEY (`id`),
INDEX (`key`),
INDEX (`group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `Game` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(250) NOT NULL DEFAULT '',
  `scenarioName` VARCHAR(250) NOT NULL DEFAULT '',
  `currentRound` int(11) NOT NULL DEFAULT 0,
  `statusId` ENUM( 'AVAILABLE', 'CALCULATING', 'FINISHED' ) DEFAULT 'CALCULATING',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `LoginUser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` VARCHAR(250) NOT NULL DEFAULT '',
  `password` VARCHAR(250) NOT NULL DEFAULT '',
  `preferredLanguage` VARCHAR(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `Flag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xCoord` int(11) NOT NULL DEFAULT 0,
  `yCoord` int(11) NOT NULL DEFAULT 0,
  `archiveXCoord` int(11) DEFAULT NULL,
  `archiveYCoord` int(11) DEFAULT NULL,
  `game` int(11) NOT NULL DEFAULT 0,
  `orderNumber` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  CONSTRAINT `Flag_Game` FOREIGN KEY `Flag` (`game`) REFERENCES `Game` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `Bot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `damage` int(11) NOT NULL DEFAULT 0,
  `lives` int(11) NOT NULL DEFAULT 3,
  `xCoord` int(11) NOT NULL DEFAULT 0,
  `yCoord` int(11) NOT NULL DEFAULT 0,
  `archiveXCoord` int(11) DEFAULT NULL,
  `archiveYCoord` int(11) DEFAULT NULL,
  `game` int(11) NOT NULL DEFAULT 0,
  `archiveFlag` int(11) DEFAULT NULL,
  `user` int(11) NOT NULL DEFAULT 0,
  `orderNumber` int(11) NOT NULL DEFAULT 0,
  `facingDirection` ENUM( 'NORTH', 'EAST', 'SOUTH', 'WEST' ) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Bot_Game` FOREIGN KEY `Bot` (`game`) REFERENCES `Game` (`id`),
  CONSTRAINT `Bot_archiveFlag` FOREIGN KEY `Bot` (`archiveFlag`) REFERENCES `Flag` (`id`),
  CONSTRAINT `Bot_LoginUser` FOREIGN KEY `Bot` (`user`) REFERENCES `LoginUser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `History` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game` int(11) DEFAULT NULL,
  `round` int(11) NOT NULL DEFAULT 0,
  `phase` int(11) NOT NULL DEFAULT 0,
  `snapshot` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `History_Game` FOREIGN KEY `History` (`game`) REFERENCES `Game` (`id`),
  CONSTRAINT `History_Binary` FOREIGN KEY `History` (`snapshot`) REFERENCES `Binary` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `Event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game` int(11) DEFAULT NULL,
  `round` int(11) NOT NULL DEFAULT 0,
  `phase` int(11) NOT NULL DEFAULT 0,
  `actor` int(11) DEFAULT NULL,
  `victim` int(11) DEFAULT NULL,
  `type` ENUM( 'BOT_PUSHES', 'CONVEYORBELT_STALL', 'BOT_SHOOTS', 'BOARD_SHOOTS', 'BOT_DIES_DAMAGE', 'BOT_DIES_HOLE', 'ARCHIVEMARKER_MOVED', 'POWER_DOWN', 'BOT_HITS_WALL', 'BOT_HITS_UNMOVABLE_BOT' ),
  `optionalText` VARCHAR(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Event_Game` FOREIGN KEY `Event` (`game`) REFERENCES `Game` (`id`),
  CONSTRAINT `Event_Actor` FOREIGN KEY `Event` (`actor`) REFERENCES `Bot` (`id`),
  CONSTRAINT `Event_Victim` FOREIGN KEY `Event` (`actor`) REFERENCES `Bot` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `MovementCard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `round` int(11) NOT NULL DEFAULT 0,
  `phase` int(11) DEFAULT NULL,
  `statusId` ENUM( 'INITIAL', 'FINAL', 'LOCKED', 'FLYWHEEL' ) DEFAULT 'INITIAL',
  `bot` int(11) NOT NULL DEFAULT 0,
  `cardDefinition` ENUM( 'MC_10', 'MC_20', 'MC_30', 'MC_40', 'MC_50', 'MC_60', 'MC_70', 'MC_80','MC_90', 'MC_100', 'MC_110', 'MC_120', 'MC_130', 'MC_140', 'MC_150', 'MC_160', 'MC_170', 'MC_180', 'MC_190', 'MC_200', 'MC_210', 'MC_220', 'MC_230', 'MC_240', 'MC_250', 'MC_260', 'MC_270', 'MC_280', 'MC_290', 'MC_300', 'MC_310', 'MC_320', 'MC_330', 'MC_340', 'MC_350', 'MC_360', 'MC_370', 'MC_380', 'MC_390', 'MC_400', 'MC_410', 'MC_420', 'MC_430', 'MC_440', 'MC_450', 'MC_460', 'MC_470', 'MC_480', 'MC_490', 'MC_500', 'MC_510', 'MC_520', 'MC_530', 'MC_540', 'MC_550', 'MC_560', 'MC_570', 'MC_580', 'MC_590', 'MC_600', 'MC_610', 'MC_620', 'MC_630', 'MC_640', 'MC_650', 'MC_660', 'MC_670', 'MC_680', 'MC_690', 'MC_700', 'MC_710', 'MC_720', 'MC_730', 'MC_740', 'MC_750', 'MC_760', 'MC_770', 'MC_780', 'MC_790', 'MC_800', 'MC_810', 'MC_820', 'MC_830', 'MC_840' ) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `MovementCard_Bot` FOREIGN KEY `MovementCard` (`bot`) REFERENCES `Bot` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
