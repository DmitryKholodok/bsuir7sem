SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema piris
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema piris
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `piris` DEFAULT CHARACTER SET utf8 ;
USE `piris` ;

-- -----------------------------------------------------
-- Table `piris`.`citizen_ship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `piris`.`citizen_ship` (
  `cs_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cs_id`))
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `piris`.`marital_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `piris`.`marital_status` (
  `ms_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ms_id`))
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `piris`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `piris`.`city` (
  `city_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`city_id`))
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `piris`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `piris`.`address` (
  `address_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NOT NULL,
  `tel` VARCHAR(45) NULL,
  `city_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_Address_City1_idx` (`city_id` ASC),
  CONSTRAINT `fk_Address_City1`
  FOREIGN KEY (`city_id`)
  REFERENCES `piris`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `piris`.`passport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `piris`.`passport` (
  `passport_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `series` CHAR(2) NOT NULL,
  `number` VARCHAR(45) NOT NULL,
  `number_id` VARCHAR(45) NOT NULL,
  `issued_by` VARCHAR(45) NOT NULL,
  `issue_date` DATE NOT NULL,
  `reg_addr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`passport_id`))
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `piris`.`disability`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `piris`.`disability` (
  `disability_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`disability_id`))
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `piris`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `piris`.`client` (
  `client_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `patronymic` VARCHAR(45) NOT NULL,
  `sex` CHAR(1) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `is_pensioner` TINYINT NOT NULL,
  `monthly_income` INT UNSIGNED NULL,
  `place_of_birth` VARCHAR(45) NOT NULL,
  `mob_tel` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `cs_id` INT UNSIGNED NOT NULL,
  `ms_id` INT UNSIGNED NOT NULL,
  `address_id` INT UNSIGNED NOT NULL,
  `passport_id` INT UNSIGNED NOT NULL,
  `disability_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`client_id`),
  INDEX `fk_Client_CitizenShip1_idx` (`cs_id` ASC),
  INDEX `fk_Client_MaritalStatus1_idx` (`ms_id` ASC),
  INDEX `fk_Client_Address1_idx` (`address_id` ASC),
  INDEX `fk_Client_Passport1_idx` (`passport_id` ASC),
  INDEX `fk_Client_Disability1_idx` (`disability_id` ASC),
  CONSTRAINT `fk_Client_CitizenShip1`
  FOREIGN KEY (`cs_id`)
  REFERENCES `piris`.`citizen_ship` (`cs_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_MaritalStatus1`
  FOREIGN KEY (`ms_id`)
  REFERENCES `piris`.`marital_status` (`ms_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_Address1`
  FOREIGN KEY (`address_id`)
  REFERENCES `piris`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_Passport1`
  FOREIGN KEY (`passport_id`)
  REFERENCES `piris`.`passport` (`passport_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_Disability1`
  FOREIGN KEY (`disability_id`)
  REFERENCES `piris`.`disability` (`disability_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
