#!/bin/bash

source .env
nomeScriptSQL=$1
nomeBanco=$2
nomeSnapshot=$3

caminhoCompleto="$CAMINHO_ARQUIVOS/scripts/$nomeScriptSQL"

caminhoArquivoBackup="$CAMINHO_ARQUIVOS/AdventureWorks2022_Large.bak"

if [[ -z $nomeBanco ]]; then
  docker exec -u "root" $NOME_DOCKER /opt/mssql-tools/bin/sqlcmd \
  -U $BD_USER -P $BD_PASS \
  -v caminhoArquivoBackup="$caminhoArquivoBackup" \
  -i "$caminhoCompleto" \
  || echo "Erro ao executar o script 'execAnyScriptSQL.sh'"
else
  docker exec -u "root" $NOME_DOCKER /opt/mssql-tools/bin/sqlcmd \
  -U $BD_USER -P $BD_PASS \
  -d $nomeBanco \
  -v caminhoArquivoBackup="$caminhoArquivoBackup" \
  -v nomeBanco="$nomeBanco" \
  -v nomeSnapshot="$nomeSnapshot" \
  -i "$caminhoCompleto" \
  || echo "Erro ao executar o script 'execAnyScriptSQL.sh'"
fi
