-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema doses
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema doses
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `doses` DEFAULT CHARACTER SET utf8mb4 ;
USE `doses` ;

-- -----------------------------------------------------
-- Table `doses`.`cumulative_influenza_vaccine_doses_millions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doses`.`cumulative_influenza_vaccine_doses_millions` (
  `WeekStartDate` DATE NULL DEFAULT NULL,
  `WeekEndDate` DATE NULL DEFAULT NULL,
  `Season` VARCHAR(30) NULL DEFAULT NULL,
  `WeekSeasonOrder` INT(11) NULL DEFAULT NULL,
  `CumulativeDoses` FLOAT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
