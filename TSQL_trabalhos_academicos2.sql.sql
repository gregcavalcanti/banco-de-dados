-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DEVDB - AC03 - PROGRAMAÇÃO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* * * * * * INFORMAÇÕES DO GRUPO * * * * *
NOME COMPLETO:	Myke Wellington Espanhol                  RA: 2202511
NOME COMPLETO:	Igor Gomes Silva                          RA: 2203109
NOME COMPLETO:	Gregory Henrique Cavalcanti	Alves Leite   RA: 2202566
*/
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------- 2. Exercício --------------------

DECLARE @contadorid INT = 0;
DECLARE @nAleatorio TINYINT;

WHILE EXISTS (SELECT * FROM ClienteAc03 WHERE id > @contadorid)
BEGIN
    SELECT @contadorid = MIN(id) FROM ClienteAc03 WHERE id > @contadorid;
    SET @nAleatorio = CAST(RAND() * 100 AS TINYINT);

    UPDATE ClienteAc03 
    SET data = 
        CASE
            WHEN @nAleatorio % 2 = 0 THEN DATEADD(DAY, @nAleatorio, '20230101')
            ELSE DATEADD(DAY, -@nAleatorio, '20230101') 
        END
    WHERE id = @contadorid; 
END
 
-------------------- 3. Exercício --------------------

CREATE TABLE SandMotoca(
    DataCorrente DATE PRIMARY KEY,
    NumeroDia TINYINT,
    NumeroMes TINYINT,
    NomeMes VARCHAR(15),
    NumeroAno SMALLINT,
    NumeroDiaSemana TINYINT,
    NomeDiaSemana VARCHAR(8),
    NumeroBimestre TINYINT,
    NumeroSemestre TINYINT
);

SELECT * FROM SandMotoca

-------------------- 4. Exercício --------------------

DECLARE @DataCorrente DATE;
DECLARE @MenorData DATE;
DECLARE @MaiorData DATE;

SELECT @MenorData = MIN(data), @MaiorData = MAX(data) FROM ClienteAc03;
SET @DataCorrente = @MenorData;

WHILE @DataCorrente <= @MaiorData
BEGIN
    
    INSERT INTO SandMotoca(DataCorrente, NumeroDia, NumeroMes, NomeMes, NumeroAno, NumeroDiaSemana, NomeDiaSemana, NumeroBimestre, NumeroSemestre)
    VALUES (
        @DataCorrente,
        DAY(@DataCorrente),
        MONTH(@DataCorrente),
		CASE
			WHEN MONTH(@DataCorrente) = 1  THEN 'Janeiro'
			WHEN MONTH(@DataCorrente) = 2  THEN 'Fevereiro'
			WHEN MONTH(@DataCorrente) = 3  THEN 'Março'
			WHEN MONTH(@DataCorrente) = 4  THEN 'Abril'
			WHEN MONTH(@DataCorrente) = 5  THEN 'Maio'
			WHEN MONTH(@DataCorrente) = 6  THEN 'Junho'
			WHEN MONTH(@DataCorrente) = 7  THEN 'Julho'
			WHEN MONTH(@DataCorrente) = 8  THEN 'Agosto'
			WHEN MONTH(@DataCorrente) = 9  THEN 'Setembro'
			WHEN MONTH(@DataCorrente) = 10 THEN 'Outubro'
			WHEN MONTH(@DataCorrente) = 11 THEN 'Novembro'
			WHEN MONTH(@DataCorrente) = 12 THEN 'Dezembro'
		END,
        YEAR(@DataCorrente),
        DATEPART(WEEKDAY, @DataCorrente),
		CASE 
			WHEN DATEPART(WEEKDAY, @DataCorrente) = 1 THEN 'Domingo'
			WHEN DATEPART(WEEKDAY, @DataCorrente) = 2 THEN '2a.Feira'
			WHEN DATEPART(WEEKDAY, @DataCorrente) = 3 THEN '3a.Feira'
			WHEN DATEPART(WEEKDAY, @DataCorrente) = 4 THEN '4a.Feira'
			WHEN DATEPART(WEEKDAY, @DataCorrente) = 5 THEN '5a.Feira'
			WHEN DATEPART(WEEKDAY, @DataCorrente) = 6 THEN '6a.Feira'
			WHEN DATEPART(WEEKDAY, @DataCorrente) = 7 THEN 'Sábado'
		END,			
        CASE
            WHEN MONTH(@DataCorrente) IN (1, 2)   THEN 1
            WHEN MONTH(@DataCorrente) IN (3, 4)   THEN 2
            WHEN MONTH(@DataCorrente) IN (5, 6)   THEN 3
            WHEN MONTH(@DataCorrente) IN (7, 8)   THEN 4
            WHEN MONTH(@DataCorrente) IN (9, 10)  THEN 5
            WHEN MONTH(@DataCorrente) IN (11, 12) THEN 6
        END,
        CASE
            WHEN MONTH(@DataCorrente) IN (1, 2, 3, 4, 5, 6)    THEN 1
            WHEN MONTH(@DataCorrente) IN (7, 8, 9, 10, 11, 12) THEN 2
        END
    );
    
    SET @DataCorrente = DATEADD(DAY, 1, @DataCorrente);
END;

SELECT * FROM SandMotoca









    
 



