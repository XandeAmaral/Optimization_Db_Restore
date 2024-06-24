USE MASTER
-- PRINT 2
-- PRINT "$(caminhoArquivoBackup)"
-- RESTORE DATABASE TESTE FROM DISK = '$(caminhoArquivoBackup)' WITH FILE = 1, NOUNLOAD,  REPLACE,  STATS = 5

RESTORE DATABASE teste
FROM DISK = '$(caminhoArquivoBackup)'
WITH
    MOVE 'AdventureWorks2022' TO '/var/opt/mssql/data/AdventureWorks2022.mdf',
    MOVE 'AdventureWorks2022_log' TO '/var/opt/mssql/data/AdventureWorks2022_log.ldf',
    FILE = 1,
    NOUNLOAD,
    REPLACE,
    STATS = 5;