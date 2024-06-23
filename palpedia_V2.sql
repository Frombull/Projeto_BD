-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8;
USE `mydb`;

-- -----------------------------------------------------
-- Table `mydb`.`Pal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pal` (
  `ID` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `ATK` INT NOT NULL,
  `DEF` INT NOT NULL,
  `Sexo` BIT NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Jogador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jogador` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Level` INT NOT NULL,
  `EstaVivo` SMALLINT(1) NOT NULL DEFAULT 1,
  `CriadoEm` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Sexo` BIT NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Bola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bola` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Potencia` INT NOT NULL,
  `Pal_ID` INT NOT NULL,
  `Jogador_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Bola_Pal_idx` (`Pal_ID` ASC) VISIBLE,
  INDEX `fk_Bola_Jogador1_idx` (`Jogador_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Bola_Pal`
    FOREIGN KEY (`Pal_ID`)
    REFERENCES `mydb`.`Pal` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bola_Jogador1`
    FOREIGN KEY (`Jogador_ID`)
    REFERENCES `mydb`.`Jogador` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------
-- Table `mydb`.`Tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tipo` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NOT NULL,
  `Descricao` TEXT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Habilidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Habilidade` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `ATK` INT NOT NULL,
  `Descricao` TEXT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Pal_has_Habilidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pal_has_Habilidade` (
  `Pal_ID` INT NOT NULL,
  `Habilidade_ID` INT NOT NULL,
  PRIMARY KEY (`Pal_ID`, `Habilidade_ID`),
  INDEX `fk_Pal_has_Habilidade_Habilidade1_idx` (`Habilidade_ID` ASC) VISIBLE,
  INDEX `fk_Pal_has_Habilidade_Pal1_idx` (`Pal_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Pal_has_Habilidade_Pal1`
    FOREIGN KEY (`Pal_ID`)
    REFERENCES `mydb`.`Pal` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pal_has_Habilidade_Habilidade1`
    FOREIGN KEY (`Habilidade_ID`)
    REFERENCES `mydb`.`Habilidade` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Item` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Preco` FLOAT NOT NULL,
  `Descricao` TEXT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Jogador_has_Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jogador_has_Item` (
  `Jogador_ID` INT NOT NULL,
  `Item_ID` INT NOT NULL,
  PRIMARY KEY (`Jogador_ID`, `Item_ID`),
  INDEX `fk_Jogador_has_Item_Item1_idx` (`Item_ID` ASC) VISIBLE,
  INDEX `fk_Jogador_has_Item_Jogador1_idx` (`Jogador_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Jogador_has_Item_Jogador1`
    FOREIGN KEY (`Jogador_ID`)
    REFERENCES `mydb`.`Jogador` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogador_has_Item_Item1`
    FOREIGN KEY (`Item_ID`)
    REFERENCES `mydb`.`Item` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Pal_has_Tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pal_has_Tipo` (
  `Pal_ID` INT NOT NULL,
  `Tipo_ID` INT NOT NULL,
  PRIMARY KEY (`Pal_ID`, `Tipo_ID`),
  INDEX `fk_Pal_has_Tipo_Tipo1_idx` (`Tipo_ID` ASC) VISIBLE,
  INDEX `fk_Pal_has_Tipo_Pal1_idx` (`Pal_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Pal_has_Tipo_Pal1`
    FOREIGN KEY (`Pal_ID`)
    REFERENCES `mydb`.`Pal` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pal_has_Tipo_Tipo1`
    FOREIGN KEY (`Tipo_ID`)
    REFERENCES `mydb`.`Tipo` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- --------------------------------------------------------------------------

-- Inserindo alguns dados nas tabelas
INSERT INTO Pal (ID, Nome, ATK, DEF, Sexo) VALUES
(1, 'Chillet', 50, 40, 1),
(2, 'Foxparks', 60, 50, 0);

INSERT INTO Jogador (Nome, Level, EstaVivo, Sexo) VALUES
('Marco', 10, 1, 1),
('Matheus', 10, 1, 1);

INSERT INTO Bola (Nome, Potencia, Pal_ID, Jogador_ID) VALUES
('Mega', 100, 1, 1),
('Giga', 200, 2, 2);

INSERT INTO Tipo (Tipo, Descricao) VALUES
('Fogo', 'Ataques de fogo'),
('Agua', 'Ataques de agua');

INSERT INTO Habilidade (Nome, ATK, Descricao) VALUES
('Fogaum', 70, 'Ataque de fogo com muito fogo!'),
('Hidro Bomba', 80, 'Ataque de agua com muuuuita agua!');

-- Associando Pals a Habilidades
INSERT INTO Pal_has_Habilidade (Pal_ID, Habilidade_ID) VALUES
(1, 1),
(2, 2);

INSERT INTO Item (Nome, Preco, Descricao) VALUES
('Pot HP', 100, 'Recupera vida'),
('Super Pot HP', 700, 'Recupera muuuuuita vida');

-- Associando Jogadores a Itens
INSERT INTO Jogador_has_Item (Jogador_ID, Item_ID) VALUES
(1, 1),
(1, 2);

-- --------------------------------------------------------------------------

-- pals capturados por um Jogador e bolas usadas p capturar
SELECT j.Nome AS Jogador, p.Nome AS Pal, b.Nome AS Bola
FROM Jogador j
JOIN Bola b ON j.ID = b.Jogador_ID
JOIN Pal p ON b.Pal_ID = p.ID
WHERE j.ID = 1;

-- habilidades de um terminado pal
SELECT p.Nome AS Pal, h.Nome AS Habilidade, h.ATK, h.Descricao
FROM Pal p
JOIN Pal_has_Habilidade ph ON p.ID = ph.Pal_ID
JOIN Habilidade h ON ph.Habilidade_ID = h.ID
WHERE p.ID = 1;

-- tipos de um pal 
SELECT p.Nome AS Pal, t.Tipo, t.Descricao
FROM Pal p
JOIN Pal_has_Tipo pt ON p.ID = pt.Pal_ID
JOIN Tipo t ON pt.Tipo_ID = t.ID
WHERE p.ID = 1;

-- itens do Jogador
SELECT j.Nome AS Jogador, i.Nome AS Item, i.Preco, i.Descricao
FROM Jogador j
JOIN Jogador_has_Item ji ON j.ID = ji.Jogador_ID
JOIN Item i ON ji.Item_ID = i.ID
WHERE j.ID = 1;

-- pals e suas habilidades
SELECT p.Nome AS Pal, GROUP_CONCAT(h.Nome) AS Habilidades
FROM Pal p
JOIN Pal_has_Habilidade ph ON p.ID = ph.Pal_ID
JOIN Habilidade h ON ph.Habilidade_ID = h.ID
GROUP BY p.Nome;

-- jogadores e Pals q capturaram
SELECT j.Nome AS Jogador, GROUP_CONCAT(p.Nome) AS Pals
FROM Jogador j
JOIN Bola b ON j.ID = b.Jogador_ID
JOIN Pal p ON b.Pal_ID = p.ID
GROUP BY j.Nome;

-- pals e tipos
SELECT p.Nome AS Pal, GROUP_CONCAT(t.Tipo) AS Tipos
FROM Pal p
JOIN Pal_has_Tipo pt ON p.ID = pt.Pal_ID
JOIN Tipo t ON pt.Tipo_ID = t.ID
GROUP BY p.Nome;


-- P completar o CRUD

-- Update
UPDATE Pal
SET Nome = 'Chillet Upado', ATK = 99, DEF = 84, Sexo = 1
WHERE ID = 1;

-- Delete
DELETE FROM Bola WHERE Pal_ID = 2;
DELETE FROM Pal WHERE ID = 2;

SELECT * FROM Pal
