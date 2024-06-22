#!/bin/bash

source .env

# diretoria_atual=$(pwd)
# script_path=$(dirname "$0")

# echo "Diretorio atual: $diretoria_atual"


docker exec $NOME_DOCKER /opt/mssql-tools/bin/sqlcmd \
-U $BD_USER -P $BD_PASS \
-q "select name from master.sys.databases;"

# docker exec sqlo /opt/mssql-tools/bin/sqlcmd -U "SA" -P "SQL2017express" -q "select name from master.sys.databases;"
