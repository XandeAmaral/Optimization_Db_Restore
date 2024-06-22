#!/bin/bash

source .env

docker exec $NOME_DOCKER /opt/mssql-tools/bin/sqlcmd \
-U $BD_USER -P $BD_PASS \
-v caminhoArquivoBackup="$CAMINHO_ARQUIVOS/AdventureWorks2022.bak" \
-i "$CAMINHO_ARQUIVOS/scripts/restoreBackup.sql" \
|| echo "Erro ao executar o comando Docker 'restauraBd'"