docker run --name=sqlo -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=SQL2017express" -p 1433:144 -v C:/Users/alexa/Downloads:/mnt/host_machine -d mssql:2022-latest 

docker run --name sqlo -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=SQL2017express' -e MSSQL_COLLATION="Latin1_General_CI_AI" -e TZ=America/Sao_Paulo -v C:/Users/alexa/Downloads:/mnt/host_machine -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest


/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "SQL2017express" -q "select name from master.sys.databases;"

/opt/mssql-tools/bin/sqlcmd -U SA -P SQL2017express -i "/scripts/teste.sql"

/opt/mssql-tools/bin/sqlcmd -U SA -P 'SQL2017express' -v caminhoArquivoBackup="/mnt/host_machine/AdventureWorks2022.bak" -i "/scripts/restoreBackup.sql" || echo "Erro ao executar o comando Docker 'restauraBackup' que esta na pasta global.sh. Servidor: $servidorBanco Banco: $nomeBanco"

----- Script sql

/opt/mssql-tools/bin/sqlcmd -U SA -P SQL2017express -d "TESTE" -q "SELECT * FROM sys.databases"

/opt/mssql-tools/bin/sqlcmd -U SA -P SQL2017express -q "RESTORE FILELISTONLY FROM DISK = '/mnt/host_machine/AdventureWorks2022.bak';"

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


------- Reservas

docker exec sql-novinho /opt/mssql-tools/bin/sqlcmd -S $servidorBanco -U SA -P SQL2017express -i "/scripts/teste.sql"


docker exec sql-novinho /opt/mssql-tools/bin/sqlcmd \
      -S $servidorBanco  \
      -U SA -P SQL2017express \
      -i "/mnt/host_machine/$CAMINHO_LOCAL_ARQUIVO_SCRIPT_SQL/restoreBackup.sql" \
      -v caminhoArquivoBackup="$/mnt/host_machine/AdventureWorks2022.bak" \
      -v nomeBase="$nomeBanco" \
      || echo "Erro ao executar o comando Docker 'restauraBackup' que esta na pasta global.sh. Servidor: $servidorBanco Banco: $nomeBanco"

ALTER DATABASE MASTER SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE FROM  DISK = '$caminhoArquivoBackup' WITH  FILE = 1, NOUNLOAD,  REPLACE,  STATS = 5
ALTER DATABASE MASTER SET MULTI_USER