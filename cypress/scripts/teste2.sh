#!/bin/bash

source .env
nomeArquivoSQL=$1

caminhoCompleto="$CAMINHO_ARQUIVOS/scripts/$nomeArquivoSQL.sql"

docker exec $NOME_DOCKER /opt/mssql-tools/bin/sqlcmd \
-U $BD_USER -P $BD_PASS \
-v caminhoArquivoBackup="$CAMINHO_ARQUIVOS/AdventureWorks2022.bak" \
-i "$caminhoCompleto" \
|| echo "Erro ao executar o script 'teste2.sh'"