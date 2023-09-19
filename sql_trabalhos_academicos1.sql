-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DEVDB - AC01 – Type e Variable Table
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* * * * * * INFORMAÇÕES DO GRUPO * * * * *

NOME COMPLETO: Myke Wellington Espanhol				    RA: 
NOME COMPLETO: Gregory Henrique Cavalcanti Alves Leite	RA: 2202566
NOME COMPLETO: Diego Batista dos Santos                 RA: 
*/
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE @contador INT = 1;
SELECT 'Valor Inicial: ' + CAST(@contador AS CHAR(1)) AS resultado;
SET @contador = CAST(@contador as int) * 40000;
SELECT 'Valor Final: ' + CAST(@contador AS CHAR(5)) AS resultado;


DECLARE @DtNascimento smallint = 1900; 
SELECT 'Valor Inicial: ' + CAST(@DtNascimento AS CHAR(4)) AS resultado;
SET @DtNascimento = @DtNascimento + 150
SELECT 'Valor Final: ' + CAST(@DtNascimento AS CHAR(4)) AS resultado;


DECLARE @NumProduto CHAR(9) = 'XR-457-BR'
SELECT 'Valor Inicial: ' + @NumProduto AS Resultado
SELECT 'Valor Final: ' + REPLACE(@NumProduto, '457', '856') AS Resultado


GO

DECLARE @CodProd CHAR(9), @CodRev CHAR(9)
SET @CodProd = 'XR-856-BR'
SET @CodRev = SUBSTRING(@CodProd, 4, 3) + RIGHT(@CodProd, 3) + REVERSE(LEFT(@CodProd, 3))
SELECT @CodProd, @CodRev


CREATE TYPE cpf FROM CHAR(11) NOT NULL

CREATE TYPE cel FROM INT NOT NULL


DECLARE @aluno TABLE 
(
	id SMALLINT IDENTITY (5, 3) PRIMARY KEY (id)
	, nomeAluno VARCHAR(45) UNIQUE CHECK (LEN(nomeAluno) >= 5)
	, ra INT NOT NULL
	, DataNasc DATE NOT NULL CHECK (DATEDIFF(DAY, DataNasc, GETDATE()) >= 5840)
	, CPF cpf CHECK (
        CPF NOT LIKE '000000000%%'
        AND CPF NOT LIKE '%%%%%%%%%99'
        AND CPF LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
	, rg cel UNIQUE CHECK(rg LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    , declaracao TINYINT NOT NULL CHECK (declaracao >= 0 AND declaracao <= 5)
)


INSERT @aluno (nomeAluno, ra, DataNasc, CPF, rg, declaracao)
	VALUES ('Myke Wellington Espanhol', 2202511, '19900113', '37347504821', '347537790', 2)
	,	   ('Gregory Henrique Cavalcanti Alves Leite', 2202566, '19930909', '05819589777', '208866491', 1)
	,      ('Diego Batista dos Santos', 2202833, '20000420', '70315000791', '695302457', 0)


SELECT nomeAluno as 'Nome Completo',
ra as 'RA',
CONVERT(CHAR(10), CAST(DataNasc AS DATE), 103) as 'Data de Nascimento',
CONCAT(SUBSTRING(CPF, 1 ,3), '.', SUBSTRING(CPF, 4, 3), '.', SUBSTRING(CPF, 7, 3),'-', SUBSTRING(CPF, 10, 2)) AS 'CPF',
rg AS 'RG',
CASE
	WHEN declaracao = 0 THEN 'Prefiro Não Responder'
	WHEN declaracao = 1 THEN 'Branca(o)'
	WHEN declaracao = 2 THEN 'Preta(o)'
	WHEN declaracao = 3 THEN 'Amarela(o)'
	WHEN declaracao = 4 THEN 'Parda(o)'
	WHEN declaracao = 5 THEN 'Indígena'
END AS 'Declaração Racial' FROM @aluno




SELECT * FROM @aluno

