
---- INFORMAÇÕES DOS BANCOS
-- SELECT * FROM sys.master_files where database_id NOT IN (1,2,3,4)

-- SELECT database_id, name, physical_name,size FROM sys.master_files where database_id NOT IN (1,2,3,4) and type_desc = 'ROWS';

----- LISTAR TODOS AS BASES
-- SELECT name, database_id, create_date FROM sys.databases; 

----- LISTAR TODOS AS BASES COM EXCEÇÃO DOS PADRÕES DO SISTEMA
-- SELECT * FROM sys.databases WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb');

---- DIFERENÇA ENTRE LISTAR BASES E LISTAR BANCOS
SELECT name FROM sys.databases WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb');
-- SELECT database_id, name, physical_name FROM sys.master_files where database_id NOT IN (1,2,3,4) and type_desc = 'ROWS';

-----------------------------------------------

-- CREATE DATABASE database_snapshot_name
-- ON
-- (
--     NAME = logical_file_name
--     , FILENAME = 'os_file_name'
-- ) [ , ...n ]
-- AS SNAPSHOT OF source_database_name
-- [;]
-- O "database_snapshot_name" é o nome usado para manipular o snapshot.
-- O "logical_file_name" tem que corresponder a um dos nomes listado na coluna "name" do comando: SELECT * FROM sys.master_files.
-- O "os_file_name" é o lugar em que ficara armazenado o arquivo do snapshot.
-- O "source_database_name" é o nome da base que sera feito o snapshot.