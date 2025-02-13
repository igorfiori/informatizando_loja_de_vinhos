-----------------------------------------------------------------------------------
Informatizando Loja de Vinhos 
-----------------------------------------------------------------------------------

-- Definindo variáveis de configuração
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Criando mydb
CREATE SCHEMA IF NOT EXISTS `vinciola_somativa_02` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `vinciola_somativa_02`;

-- Tabela Vinicola
CREATE TABLE IF NOT EXISTS `vinciola_somativa_02`.`Vinicola` (
  `idVinicola` BIGINT NOT NULL AUTO_INCREMENT,
  `nomeVinicola` VARCHAR(100) NOT NULL,
  `descricaoVinicola` TEXT NULL,
  `foneVinicola` VARCHAR(15) NULL,
  `emailVinicola` VARCHAR(50) NULL,
  `Regiao_idRegiao` BIGINT NOT NULL,
  PRIMARY KEY (`idVinicola`),
  CONSTRAINT `fk_Vinicola_Regiao1`
    FOREIGN KEY (`Regiao_idRegiao`)
    REFERENCES `vinciola_somativa_02`.`Regiao` (`idRegiao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Tabela Vinho
CREATE TABLE IF NOT EXISTS `vinciola_somativa_02`.`Vinho` (
  `idVinho` BIGINT NOT NULL AUTO_INCREMENT,
  `nomeVinho` VARCHAR(50) NOT NULL,
  `tipoVinho` VARCHAR(30) NOT NULL,
  `anoVinho` INT NOT NULL,
  `descricaoVinho` TEXT NULL,
  `Vinicola_idVinicola` BIGINT NOT NULL,
  PRIMARY KEY (`idVinho`),
  CONSTRAINT `fk_Vinho_Vinicola`
    FOREIGN KEY (`Vinicola_idVinicola`)
    REFERENCES `vinciola_somativa_02`.`Vinicola` (`idVinicola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Tabela Regiao
CREATE TABLE IF NOT EXISTS `mydb`.`Regiao` (
  `idRegiao` BIGINT NOT NULL AUTO_INCREMENT,
  `nomeRegiao` VARCHAR(100) NOT NULL,
  `descricaoRegiao` TEXT NULL,
  PRIMARY KEY (`idRegiao`)
) ENGINE = InnoDB;

-- Inserir registros na tabela Regiao
INSERT INTO Regiao (nomeRegiao, descricaoRegiao) VALUES
('Vale dos Vinhedos', 'Região conhecida pela produção de vinhos de alta qualidade'),
('Campanha Gaúcha', 'Região de clima temperado propício para a viticultura'),
('Serra Gaúcha', 'Região montanhosa famosa por seus vinhos espumantes'),
('Pampa Gaúcho', 'Região de planície com clima seco adequado para o cultivo de uvas'),
('Litoral Norte', 'Região litorânea com influência marítima nas vinícolas');

-- Inserir registros na tabela Vinicola
INSERT INTO Vinicola (nomeVinicola, descricaoVinicola, foneVinicola, emailVinicola, Regiao_idRegiao) VALUES
('Vinícola Aurora', 'Uma das maiores e mais antigas vinícolas do Brasil', '5432123456', 'contato@vinicolaaurora.com.br', 1),
('Miolo Wine Group', 'Grupo de vinícolas renomadas com foco em vinhos premium', '5432123456', 'contato@miolo.com.br', 2),
('Salton Vinhos', 'Tradição familiar em produção de vinhos desde 1910', '5432123456', 'contato@salton.com.br', 3),
('Pizzato Vinhas e Vinhos', 'Vinícola boutique especializada em vinhos de terroir', '5432123456', 'contato@pizzato.com.br', 4),
('Casa Valduga', 'Vinícola premiada internacionalmente por seus espumantes', '5432123456', 'contato@casavalduga.com.br', 5);

-- Inserir registros na tabela Vinho
INSERT INTO Vinho (nomeVinho, tipoVinho, anoVinho, descricaoVinho, Vinicola_idVinicola) VALUES
('Aurora Reserva Merlot', 'Tinto', 2015, 'Um Merlot encorpado com notas de frutas vermelhas e especiarias.', 1),
('Lote 43', 'Tinto', 2016, 'Um corte de Cabernet Sauvignon e Merlot com envelhecimento em carvalho francês.', 2),
('Espumante Salton Intenso Brut', 'Espumante', 2018, 'Um espumante Brut refrescante com notas cítricas e toques de maçã verde.', 3),
('Pizzato Fausto Merlot', 'Tinto', 2017, 'Um Merlot elegante com taninos macios e aromas de frutas negras.', 4),
('Casa Valduga Raízes Cabernet Franc', 'Tinto', 2019, 'Um Cabernet Franc vibrante com boa acidez e notas de especiarias.', 5);


-- Restaurando configurações antigas
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


 -- Criar o usuário Sommelier
CREATE USER 'Sommelier'@'localhost' IDENTIFIED BY '010203';

-- Conceder permissões de SELECT na tabela Vinho
GRANT SELECT ON mydb.Vinho TO 'Sommelier'@'localhost';

-- Conceder permissões de SELECT nas colunas codVinicola e nomeVinicola da tabela Vinicola
GRANT SELECT (codVinicola, nomeVinicola) ON mydb.Vinicola TO 'Sommelier'@'localhost';

-- Limitar o número de consultas por hora para 40
ALTER USER 'Sommelier'@'localhost' WITH MAX_QUERIES_PER_HOUR 40;   

-- Consulta nomeVinho, anoVinho, nomeVinicola, nomeRegiao
SELECT 
    v.nomeVinho,
    v.anoVinho,
    vi.nomeVinicola,
    r.nomeRegiao
FROM 
    Vinho v
INNER JOIN 
    Vinicola vi ON v.Vinicola_idVinicola = vi.idVinicola
INNER JOIN 
    Regiao r ON vi.Regiao_idRegiao = r.idRegiao;