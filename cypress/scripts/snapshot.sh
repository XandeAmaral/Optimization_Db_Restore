#!/bin/bash

source .env

docker exec $NOME_DOCKER /opt/mssql-tools/bin/sqlcmd \
-U $BD_USER -P $BD_PASS \
-v caminhoArquivoBackup="/mnt/host_machine/AdventureWorks2022.bak" \
-i "/scripts/restoreBackup.sql" \
|| echo "Erro ao executar o comando Docker 'restauraBd'