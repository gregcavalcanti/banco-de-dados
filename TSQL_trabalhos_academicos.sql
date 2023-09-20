-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DEVDB - AC02 – Transação e Loop
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* * * * * * INFORMAÇÕES DO GRUPO * * * * *

NOME COMPLETO: Gregory Cavalcanti RA:2202566
NOME COMPLETO: Myke Wellington	RA: 2202511
NOME COMPLETO: Diego Batista dos Santos	RA: 2202833
*/

SELECT * INTO AssentosVoo0 FROM AssentosVoo WHERE idVoo = 7
SELECT * INTO ReservaVoo0 FROM ReservaVoo


SELECT * FROM AssentosVoo0
SELECT * FROM ReservaVoo0


DECLARE @ciclo TINYINT = 0
DECLARE @idVoo TINYINT = 7


WHILE 1 = 1
BEGIN
    SET @ciclo = @ciclo + 1
    BEGIN TRANSACTION

        IF EXISTS (
        SELECT 1
        FROM AssentosVoo0
        WHERE idVoo = @idVoo
        AND disponivel = 1
    )
    BEGIN
        
        INSERT INTO ReservaVoo0(idVoo, idCiclo, data)
        VALUES (@idVoo, @ciclo, GETDATE())

        
        UPDATE AssentosVoo0
        SET disponivel = 0
        WHERE idVoo = @idVoo
        AND assento = @ciclo

        COMMIT 
    END
    ELSE
    BEGIN
        
        PRINT('Não encontrou assentos disponíveis no voo 7');

        ROLLBACK 
        BREAK 
    END
END


SELECT *
FROM AssentosVoo0
WHERE idVoo = @idVoo 


SELECT *
FROM ReservaVoo0
WHERE idVoo = @idVoo 

