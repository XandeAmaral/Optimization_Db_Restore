-- USE TESTE
-- update Person.Address set AddressLine1="Meu valor" where AddressID = 1;
-- select AddressID, AddressLine1 from Person.Address where AddressID = 1;

-- USE [master];
-- RESTORE DATABASE $(nomeBanco) FROM DATABASE_SNAPSHOT = '$(nomeSnapshot)';

-- PRINT 'FUNCIONOU'

-- USE TESTE
-- select AddressID, AddressLine1 from Person.Address where AddressID = 1

-- ---------------------------------

IF EXISTS (SELECT database_id FROM sys.databases WHERE name = '$(nomeSnapshot)')
  BEGIN
    BEGIN TRY
      USE [master];
      ALTER DATABASE $(nomeBanco) SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        RESTORE DATABASE $(nomeBanco) from DATABASE_SNAPSHOT = '$(nomeSnapshot)';
        PRINT 'SUCCESS RESTORE';
      ALTER DATABASE $(nomeBanco) SET MULTI_USER;
    END TRY
    BEGIN CATCH
      DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
      PRINT 'Falha ao tentar restaurar o snapshot. Detalhes do erro:';
      PRINT 'Mensagem de erro: ' + @ErrorMessage;
      PRINT 'Linha com erro: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
    END CATCH;
  END;
ELSE
  BEGIN
    PRINT 'O snapshot ainda não foi criado, portanto não é possível executar a tarefa de restaurar';
  END;