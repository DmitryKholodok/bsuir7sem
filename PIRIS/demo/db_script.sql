
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

ALTER TABLE `piris`.`Client`
DROP FOREIGN KEY `fk_Client_CitizenShip1`,
DROP FOREIGN KEY `fk_Client_MaritalStatus1`,
DROP FOREIGN KEY `fk_Client_Passport1`;

ALTER TABLE `piris`.`Address`
DROP FOREIGN KEY `fk_Address_City1`;

ALTER TABLE `piris`.`Client`
DROP COLUMN `disability_id`,
DROP COLUMN `passport_id`,
DROP COLUMN `address_id`,
DROP COLUMN `ms_id`,
DROP COLUMN `cs_id`,
ADD COLUMN `cs_id` INT(10) UNSIGNED NOT NULL AFTER `email`,
ADD COLUMN `ms_id` INT(10) UNSIGNED NOT NULL AFTER `cs_id`,
ADD COLUMN `address_id` INT(10) UNSIGNED NOT NULL AFTER `ms_id`,
ADD COLUMN `passport_id` INT(10) UNSIGNED NOT NULL AFTER `address_id`,
ADD COLUMN `disability_id` INT(10) UNSIGNED NOT NULL AFTER `passport_id`,
ADD INDEX `fk_Client_CitizenShip1_idx` (`cs_id` ASC),
ADD INDEX `fk_Client_MaritalStatus1_idx` (`ms_id` ASC),
ADD INDEX `fk_Client_Address1_idx` (`address_id` ASC),
ADD INDEX `fk_Client_Passport1_idx` (`passport_id` ASC),
ADD INDEX `fk_Client_Disability1_idx` (`disability_id` ASC),
DROP INDEX `fk_Client_Disability1_idx` ,
DROP INDEX `fk_Client_Passport1_idx` ,
DROP INDEX `fk_Client_Address1_idx` ,
DROP INDEX `fk_Client_MaritalStatus1_idx` ,
DROP INDEX `fk_Client_CitizenShip1_idx` ;

CREATE TABLE IF NOT EXISTS `piris`.`citizen_ship` (
  `cs_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cs_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `piris`.`marital_status` (
  `ms_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ms_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `piris`.`Address`
DROP COLUMN `city_id`,
ADD COLUMN `city_id` INT(10) UNSIGNED NOT NULL AFTER `tel`,
ADD INDEX `fk_Address_City1_idx` (`city_id` ASC),
DROP INDEX `fk_Address_City1_idx` ;

DROP TABLE IF EXISTS `piris`.`marital_status` ;

DROP TABLE IF EXISTS `piris`.`citizen_ship` ;

ALTER TABLE `piris`.`Client`
DROP FOREIGN KEY `fk_Client_Address1`,
DROP FOREIGN KEY `fk_Client_Disability1`;

ALTER TABLE `piris`.`Client` ADD CONSTRAINT `fk_Client_CitizenShip1`
  FOREIGN KEY (`cs_id`)
  REFERENCES `piris`.`citizen_ship` (`cs_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Client_MaritalStatus1`
  FOREIGN KEY (`ms_id`)
  REFERENCES `piris`.`marital_status` (`ms_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Client_Address1`
  FOREIGN KEY (`address_id`)
  REFERENCES `piris`.`address` (`address_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Client_Passport1`
  FOREIGN KEY (`passport_id`)
  REFERENCES `piris`.`passport` (`passport_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Client_Disability1`
  FOREIGN KEY (`disability_id`)
  REFERENCES `piris`.`disability` (`disability_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `piris`.`Address`
ADD CONSTRAINT `fk_Address_City1`
  FOREIGN KEY (`city_id`)
  REFERENCES `piris`.`city` (`city_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
