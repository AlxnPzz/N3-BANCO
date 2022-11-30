-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.27-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.2.0.6576
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para n3-will
CREATE DATABASE IF NOT EXISTS `n3-will` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `n3-will`;

-- Copiando estrutura para tabela n3-will.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT NULL,
  `TELEFONE` varchar(50) DEFAULT NULL,
  `CIDADE` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela n3-will.cliente: ~3 rows (aproximadamente)
INSERT INTO `cliente` (`ID`, `NOME`, `TELEFONE`, `CIDADE`) VALUES
	(1, 'Alexandre', '66981357184', 'Sinop'),
	(2, 'Carlos', '66974859612', 'Sorriso'),
	(3, 'Eduardo', '66985744563', 'Sinop'),
	(4, 'Emilly', '66912457863', 'Sinop');

-- Copiando estrutura para tabela n3-will.contas_a_pagar
CREATE TABLE IF NOT EXISTS `contas_a_pagar` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_FORNECEDOR` int(11) NOT NULL DEFAULT 0,
  `ID_PRODUTOS` int(11) NOT NULL DEFAULT 0,
  `QUANTIDADE` int(11) NOT NULL DEFAULT 0,
  `DATA` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_FORNECEDOR` (`ID_FORNECEDOR`),
  KEY `ID_PRODUTOS` (`ID_PRODUTOS`),
  CONSTRAINT `ID_FORNECEDOR_A_PAGAR` FOREIGN KEY (`ID_FORNECEDOR`) REFERENCES `fornecedores` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ID_PRODUTO` FOREIGN KEY (`ID_PRODUTOS`) REFERENCES `produto` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela n3-will.contas_a_pagar: ~5 rows (aproximadamente)
INSERT INTO `contas_a_pagar` (`ID`, `ID_FORNECEDOR`, `ID_PRODUTOS`, `QUANTIDADE`, `DATA`) VALUES
	(1, 2, 17, 15, '2022-11-28'),
	(3, 3, 4, 45, '2022-10-18'),
	(4, 1, 8, 78, '2022-12-01'),
	(5, 5, 9, 10, '2022-11-28'),
	(6, 2, 6, 5, '2022-11-28');

-- Copiando estrutura para tabela n3-will.contas_a_receber
CREATE TABLE IF NOT EXISTS `contas_a_receber` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_EVENTO` int(11) NOT NULL DEFAULT 0,
  `QUANTIDADE` int(11) NOT NULL DEFAULT 0,
  `VALOR` double NOT NULL DEFAULT 0,
  `DATA_LANCAMENTO` date DEFAULT NULL,
  `ID_CLIENTE` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_EVENTO` (`ID_EVENTO`),
  KEY `ID_CLIENTE` (`ID_CLIENTE`),
  CONSTRAINT `ID_CLIENTE_A_RECEBER` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ID_EVENTO_A_RECEBER` FOREIGN KEY (`ID_EVENTO`) REFERENCES `evento` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela n3-will.contas_a_receber: ~6 rows (aproximadamente)
INSERT INTO `contas_a_receber` (`ID`, `ID_EVENTO`, `QUANTIDADE`, `VALOR`, `DATA_LANCAMENTO`, `ID_CLIENTE`) VALUES
	(1, 5, 1, 15452, '2022-11-28', 1),
	(2, 1, 2, 45123, '2022-11-28', 3),
	(3, 6, 1, 2546, '2022-11-28', 4),
	(4, 4, 4, 1230, '2022-11-28', 2),
	(5, 2, 1, 4523, '2022-11-28', 3),
	(6, 3, 2, 1562, '2022-11-28', 4);

-- Copiando estrutura para tabela n3-will.evento
CREATE TABLE IF NOT EXISTS `evento` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRICAO` varchar(50) NOT NULL DEFAULT '0',
  `DATA_EVENTO` date DEFAULT NULL,
  `ID_CLIENTE` int(11) NOT NULL DEFAULT 0,
  `ID_ITEM_EVENTO` int(11) NOT NULL DEFAULT 0,
  `VALOR_EVENTO` double NOT NULL DEFAULT 0,
  `ID_INGRESSO` int(11) NOT NULL DEFAULT 0,
  `DESPESAS` int(11) NOT NULL DEFAULT 0,
  `RECEITAS` int(11) NOT NULL DEFAULT 0,
  `LUCRO` double DEFAULT NULL,
  `PARTICIPANTES` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_INGRESSO` (`ID_INGRESSO`),
  KEY `ID_CLIENTE_EVENTO` (`ID_CLIENTE`),
  KEY `ID_ITEM_EVENTO` (`ID_ITEM_EVENTO`),
  KEY `PARTICIPANTES` (`PARTICIPANTES`),
  CONSTRAINT `ID_CLIENTE_EVENTO` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ID_INGRESSO_EVENTO` FOREIGN KEY (`ID_INGRESSO`) REFERENCES `ingresso` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ID_ITEM_EVENTO` FOREIGN KEY (`ID_ITEM_EVENTO`) REFERENCES `itens_evento` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `QTD_PARTICIPANTE` FOREIGN KEY (`PARTICIPANTES`) REFERENCES `ingresso` (`QUANTIDADE`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela n3-will.evento: ~6 rows (aproximadamente)
INSERT INTO `evento` (`ID`, `DESCRICAO`, `DATA_EVENTO`, `ID_CLIENTE`, `ID_ITEM_EVENTO`, `VALOR_EVENTO`, `ID_INGRESSO`, `DESPESAS`, `RECEITAS`, `LUCRO`, `PARTICIPANTES`) VALUES
	(1, 'ILUSIONISE E ZAC', '2022-12-28', 1, 2, 45740, 1, 45740, 58450, NULL, 12),
	(2, 'LIU E GABE', '2022-11-29', 2, 3, 21564, 2, 21564, 29854, NULL, 15),
	(3, 'VINTAGE E KESSIE', '2023-01-10', 4, 1, 15658, 1, 15658, 17540, NULL, 26),
	(4, 'DOM DOLLA', '2022-12-02', 3, 4, 19560, 3, 19560, 25601, NULL, 20),
	(5, 'CURTIEZOR', '2022-12-15', 1, 1, 45650, 4, 45650, 58654, NULL, 26),
	(6, 'DESTRAIN', '2022-12-14', 3, 3, 85987, 1, 85987, 102856, NULL, 12);

-- Copiando estrutura para tabela n3-will.financeiro
CREATE TABLE IF NOT EXISTS `financeiro` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_CONTAS_RECEBER` int(11) NOT NULL DEFAULT 0,
  `ID_CONTAS_PAGAR` int(11) NOT NULL DEFAULT 0,
  `ID_EVENTOS` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  KEY `ID_EVENTOS` (`ID_EVENTOS`),
  KEY `ID_CONTAS_RECEBER` (`ID_CONTAS_RECEBER`),
  KEY `ID_CONTAS_A_PAGAR` (`ID_CONTAS_PAGAR`),
  CONSTRAINT `ID_CONTAS_A_PAGAR` FOREIGN KEY (`ID_CONTAS_PAGAR`) REFERENCES `contas_a_pagar` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ID_CONTAS_A_RECEBER` FOREIGN KEY (`ID_CONTAS_RECEBER`) REFERENCES `contas_a_receber` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ID_EVENTOS_FINANCEIRO` FOREIGN KEY (`ID_EVENTOS`) REFERENCES `evento` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela n3-will.financeiro: ~5 rows (aproximadamente)
INSERT INTO `financeiro` (`ID`, `ID_CONTAS_RECEBER`, `ID_CONTAS_PAGAR`, `ID_EVENTOS`) VALUES
	(1, 1, 1, 6),
	(2, 2, 3, 2),
	(3, 5, 5, 3),
	(4, 4, 4, 3),
	(5, 6, 6, 4);

-- Copiando estrutura para tabela n3-will.fornecedores
CREATE TABLE IF NOT EXISTS `fornecedores` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) NOT NULL DEFAULT '0',
  `ENDERECO` varchar(50) NOT NULL DEFAULT '0',
  `TELEFONE` varchar(50) NOT NULL DEFAULT '0',
  `EMAIL` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela n3-will.fornecedores: ~4 rows (aproximadamente)
INSERT INTO `fornecedores` (`ID`, `NOME`, `ENDERECO`, `TELEFONE`, `EMAIL`) VALUES
	(1, 'SOS Distribuidora de bebidas', 'Rua das petunias, 525', '66985746541', 'contato@SOS.com.br'),
	(2, 'Carpendim - Alimentos', 'Rua das figueiras, 645', '66965742541', 'carpedim@suporte.com.br'),
	(3, 'Solare ', 'Avenida dos Tarumãns, 1956', '66932145698', 'contato.solare@gmail.com'),
	(4, 'Adesti', 'Rua dos coqueiros, 1000', '66978451263', 'adest.contato@gmail.com'),
	(5, 'Itamarati', 'Rua das embaubas', '66932547896', 'itamarati@gmail.com');

-- Copiando estrutura para tabela n3-will.ingresso
CREATE TABLE IF NOT EXISTS `ingresso` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRICAO` varchar(50) DEFAULT NULL,
  `VALOR` double DEFAULT NULL,
  `QUANTIDADE` int(11) DEFAULT NULL,
  `VENDIDOS` int(11) DEFAULT NULL,
  `ID_CLIENTE` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_CLIENTE` (`ID_CLIENTE`),
  KEY `QUANTIDADE` (`QUANTIDADE`),
  CONSTRAINT `ID_CLIENTE_INGRESSO` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela n3-will.ingresso: ~4 rows (aproximadamente)
INSERT INTO `ingresso` (`ID`, `DESCRICAO`, `VALOR`, `QUANTIDADE`, `VENDIDOS`, `ID_CLIENTE`) VALUES
	(1, 'PISTA', 160, 20, 20, 1),
	(2, 'BACK STANGE', 110, 26, 23, 3),
	(3, 'CAMAROTE', 210, 15, 12, 2),
	(4, 'BANGALO', 190, 12, 12, 4);

-- Copiando estrutura para tabela n3-will.itens_evento
CREATE TABLE IF NOT EXISTS `itens_evento` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `QUANTIDADE` varchar(50) NOT NULL DEFAULT '0',
  `ID_PRODUTOS` int(11) NOT NULL DEFAULT 0,
  `ID_EVENTO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_PRODUTOS` (`ID_PRODUTOS`),
  KEY `ID_EVENTO` (`ID_EVENTO`),
  CONSTRAINT `ID)EVENTO_ITEM` FOREIGN KEY (`ID_EVENTO`) REFERENCES `evento` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ID_PRODUTOS` FOREIGN KEY (`ID_PRODUTOS`) REFERENCES `produto` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela n3-will.itens_evento: ~6 rows (aproximadamente)
INSERT INTO `itens_evento` (`ID`, `QUANTIDADE`, `ID_PRODUTOS`, `ID_EVENTO`) VALUES
	(1, '20', 12, 1),
	(2, '45', 15, 3),
	(3, '10', 14, 2),
	(4, '23', 4, 1),
	(5, '85', 16, 6),
	(6, '25', 7, 3),
	(9, '78', 4, 1);

-- Copiando estrutura para tabela n3-will.produto
CREATE TABLE IF NOT EXISTS `produto` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRICAO` varchar(50) NOT NULL DEFAULT '0',
  `PRECO` double NOT NULL DEFAULT 0,
  `QUANTIDADE` varchar(50) NOT NULL DEFAULT '0',
  `ID_FORNECEDOR` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_FORNECEDOR` (`ID_FORNECEDOR`),
  CONSTRAINT `ID_FORNECEDOR` FOREIGN KEY (`ID_FORNECEDOR`) REFERENCES `fornecedores` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela n3-will.produto: ~18 rows (aproximadamente)
INSERT INTO `produto` (`ID`, `DESCRICAO`, `PRECO`, `QUANTIDADE`, `ID_FORNECEDOR`) VALUES
	(1, 'VODKA', 95, '20', 1),
	(2, 'BUCHANANS DELUXE', 195, '10', 1),
	(3, 'ROYAL SALUTE', 985, '5', 1),
	(4, 'OLD PAR', 210, '20', 1),
	(5, 'ÁGUA MINERAL', 5, '160', 5),
	(6, 'GELO EM CUBO', 10, '45', 4),
	(7, 'ÁGUA DE COCO', 8, '90', 2),
	(8, 'RED BULL ', 15, '130', 1),
	(9, 'ENERGÉTICO 1L', 25, '70', 5),
	(10, 'GELO DE ÁGUA DE COCO', 5, '100', 2),
	(11, 'PIRULITOS', 2, '160', 2),
	(12, 'CERVEJA LATA', 5, '200', 3),
	(13, 'CHOPP ', 8, '150', 3),
	(14, 'VEIPERS', 95, '30', 5),
	(15, 'SCHWEPPES - CITROS', 12, '80', 2),
	(16, 'SCHWEPPES - ÁGUA TÔNICA', 10, '20', 3),
	(17, 'H2O - LIMONETA', 8, '45', 1),
	(18, 'JOHNNIE WALKER BLUE LABEL', 260, '13', 2);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
