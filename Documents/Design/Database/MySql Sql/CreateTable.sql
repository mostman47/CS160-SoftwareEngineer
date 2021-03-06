SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `Siquoia` ;
CREATE SCHEMA IF NOT EXISTS `Siquoia` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
DROP SCHEMA IF EXISTS `siquoia` ;
CREATE SCHEMA IF NOT EXISTS `siquoia` DEFAULT CHARACTER SET utf8 ;
USE `Siquoia` ;

-- -----------------------------------------------------
-- Table `Siquoia`.`User`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`User` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Username` VARCHAR(45) NOT NULL ,
  `Password` VARCHAR(20) NOT NULL ,
  `Type` VARCHAR(45) NOT NULL ,
  `Point` INT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Siquoia`.`Topic`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`Topic` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Description` VARCHAR(100) NULL ,
  `Parent_ID` BIGINT NULL ,
  `Level` INT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Topic_Topic1_idx` (`Parent_ID` ASC) ,
  CONSTRAINT `fk_Topic_Topic1`
    FOREIGN KEY (`Parent_ID` )
    REFERENCES `Siquoia`.`Topic` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Siquoia`.`Multimedia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`Multimedia` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Description` VARCHAR(500) NULL ,
  `Type` VARCHAR(45) NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Siquoia`.`Question`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`Question` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Description` VARCHAR(500) NOT NULL ,
  `Answer_C` VARCHAR(300) NULL ,
  `Answer_W1` VARCHAR(300) NULL ,
  `Answer_W2` VARCHAR(300) NULL ,
  `Answer_W3` VARCHAR(300) NULL ,
  `Ranking` INT NOT NULL ,
  `Topic_ID` BIGINT NOT NULL ,
  `Multimedia_ID` BIGINT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Question_Topic1_idx` (`Topic_ID` ASC) ,
  INDEX `fk_Question_Multimedia1_idx` (`Multimedia_ID` ASC) ,
  CONSTRAINT `fk_Question_Topic1`
    FOREIGN KEY (`Topic_ID` )
    REFERENCES `Siquoia`.`Topic` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Question_Multimedia1`
    FOREIGN KEY (`Multimedia_ID` )
    REFERENCES `Siquoia`.`Multimedia` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Siquoia`.`Token`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`Token` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Code` VARCHAR(45) NOT NULL ,
  `Description` VARCHAR(500) NULL ,
  `Status` VARCHAR(45) NULL ,
  `NumberQuestion` INT NOT NULL ,
  `User_ID` BIGINT NULL ,
  `Topic_ID` BIGINT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Token_User1_idx` (`User_ID` ASC) ,
  INDEX `fk_Token_Topic1_idx` (`Topic_ID` ASC) ,
  CONSTRAINT `fk_Token_User1`
    FOREIGN KEY (`User_ID` )
    REFERENCES `Siquoia`.`User` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Token_Topic1`
    FOREIGN KEY (`Topic_ID` )
    REFERENCES `Siquoia`.`Topic` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Siquoia`.`Point_History`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`Point_History` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT ,
  `DateTime` DATETIME NOT NULL ,
  `PointEarned` INT NULL ,
  `PointUsed` INT NULL ,
  `User_ID` BIGINT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Point_User1_idx` (`User_ID` ASC) ,
  CONSTRAINT `fk_Point_User1`
    FOREIGN KEY (`User_ID` )
    REFERENCES `Siquoia`.`User` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Siquoia`.`Purchase`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`Purchase` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT ,
  `DateTime` DATETIME NOT NULL ,
  `Description` VARCHAR(500) NULL ,
  `User_ID` BIGINT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Purchase_User1_idx` (`User_ID` ASC) ,
  CONSTRAINT `fk_Purchase_User1`
    FOREIGN KEY (`User_ID` )
    REFERENCES `Siquoia`.`User` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `siquoia` ;

-- -----------------------------------------------------
-- Table `siquoia`.`multimedia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `siquoia`.`multimedia` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `Description` VARCHAR(500) NULL DEFAULT NULL ,
  `Type` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `siquoia`.`user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `siquoia`.`user` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `Username` VARCHAR(45) NOT NULL ,
  `Password` VARCHAR(20) NOT NULL ,
  `Type` VARCHAR(45) NOT NULL ,
  `Point` INT(11) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `siquoia`.`point_history`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `siquoia`.`point_history` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `DateTime` DATETIME NOT NULL ,
  `PointEarned` INT(11) NULL DEFAULT NULL ,
  `PointUsed` INT(11) NULL DEFAULT NULL ,
  `User_ID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Point_User1_idx` (`User_ID` ASC) ,
  CONSTRAINT `fk_Point_User1`
    FOREIGN KEY (`User_ID` )
    REFERENCES `siquoia`.`user` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `siquoia`.`purchase`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `siquoia`.`purchase` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `DateTime` DATETIME NOT NULL ,
  `Description` VARCHAR(500) NULL DEFAULT NULL ,
  `User_ID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Purchase_User1_idx` (`User_ID` ASC) ,
  CONSTRAINT `fk_Purchase_User1`
    FOREIGN KEY (`User_ID` )
    REFERENCES `siquoia`.`user` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `siquoia`.`topic`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `siquoia`.`topic` (
  `Topic_ID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `Description` VARCHAR(100) NULL DEFAULT NULL ,
  `Parent_ID` BIGINT(20) NULL DEFAULT NULL ,
  `Level` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`Topic_ID`) ,
  INDEX `fk_Topic_Topic1_idx` (`Parent_ID` ASC) ,
  CONSTRAINT `fk_Topic_Topic1`
    FOREIGN KEY (`Parent_ID` )
    REFERENCES `siquoia`.`topic` (`Topic_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `siquoia`.`question`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `siquoia`.`question` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `Description` VARCHAR(500) NOT NULL ,
  `Answer_C` VARCHAR(300) NULL DEFAULT NULL ,
  `Answer_W1` VARCHAR(300) NULL DEFAULT NULL ,
  `Answer_W2` VARCHAR(300) NULL DEFAULT NULL ,
  `Answer_W3` VARCHAR(300) NULL DEFAULT NULL ,
  `Ranking` INT(11) NOT NULL ,
  `Topic_ID` BIGINT(20) NOT NULL ,
  `Multimedia_ID` BIGINT(20) NULL DEFAULT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Question_Topic1_idx` (`Topic_ID` ASC) ,
  INDEX `fk_Question_Multimedia1_idx` (`Multimedia_ID` ASC) ,
  CONSTRAINT `fk_Question_Topic1`
    FOREIGN KEY (`Topic_ID` )
    REFERENCES `siquoia`.`topic` (`Topic_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Question_Multimedia1`
    FOREIGN KEY (`Multimedia_ID` )
    REFERENCES `siquoia`.`multimedia` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 435
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `siquoia`.`token`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `siquoia`.`token` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `Code` VARCHAR(45) NOT NULL ,
  `Description` VARCHAR(500) NULL DEFAULT NULL ,
  `Status` VARCHAR(45) NULL DEFAULT NULL ,
  `NumberQuestion` INT(11) NOT NULL ,
  `User_ID` BIGINT(20) NULL DEFAULT NULL ,
  `Topic_ID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Token_User1_idx` (`User_ID` ASC) ,
  INDEX `fk_Token_Topic1_idx` (`Topic_ID` ASC) ,
  CONSTRAINT `fk_Token_User1`
    FOREIGN KEY (`User_ID` )
    REFERENCES `siquoia`.`user` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Token_Topic1`
    FOREIGN KEY (`Topic_ID` )
    REFERENCES `siquoia`.`topic` (`Topic_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;

USE `Siquoia` ;
USE `siquoia` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
