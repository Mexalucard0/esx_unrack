# This will be used to store data on stored weapons for PD



CREATE TABLE IF NOT EXISTS `rack_weapons` (
`id` INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
`owner` varchar(22) NOT NULL,
`stored` varchar(22) NOT NULL DEFAULT `0`,
`weapon` varchar(22) NOT NULL,
`flashlight` varchar(22) NOT NULL DEFAULT '0',
`mag` varchar(22) NOT NULL DEFAULT '0',
`scope` varchar(22) NOT NULL DEFAULT '0',
)
