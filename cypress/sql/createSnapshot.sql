-- IF EXISTS (SELECT database_id FROM sys.databases WHERE name='$(nomeSnapshot)')
--   BEGIN
--     DROP DATABASE $(nomeSnapshot);
--     PRINT 'SUCCESS DROP';
--   END;
--   CREATE DATABASE $(nomeSnapshot) ON  ( 
--     NAME = AdventureWorks2022,
--     FILENAME = '/snaps/adv_db.ss'
--   ) AS SNAPSHOT OF TESTE;
--   PRINT 'SUCCESS CREATE';


BEGIN TRY
  USE [master];
  ALTER DATABASE $(nomeBanco) SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  IF EXISTS (SELECT database_id FROM sys.databases WHERE name = '$(nomeSnapshot)')
  BEGIN
    DROP DATABASE $(nomeSnapshot);
    PRINT 'SUCCESS DROP';
  END;

  CREATE DATABASE $(nomeSnapshot) ON  (
    NAME = AdventureWorks2022,
    FILENAME = '/snaps/adv_db.ss'
  ) AS SNAPSHOT OF $(nomeBanco);
  PRINT 'SUCCESS CREATE';
  ALTER DATABASE $(nomeBanco) SET MULTI_USER;
END TRY
BEGIN CATCH
  DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
  PRINT 'Falha ao executar o script de controle de arquivos snaps. Detalhes do erro:';
  PRINT 'Mensagem de erro: ' + @ErrorMessage;
  PRINT 'Linha com erro: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
END CATCH;