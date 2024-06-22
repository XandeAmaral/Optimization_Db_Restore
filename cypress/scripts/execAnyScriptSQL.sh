#!/bin/bash

source .env
nomeScriptSQL=$1
nomeBanco=$2

caminhoCompleto="$CAMINHO_ARQUIVOS/scripts/$nomeScriptSQL"


if [[ -z $nomeBanco ]]; then
  docker exec -u "root" $NOME_DOCKER /opt/mssql-tools/bin/sqlcmd \
  -U $BD_USER -P $BD_PASS \
  -v caminhoArquivoBackup="$CAMINHO_ARQUIVOS/AdventureWorks2022.bak" \
  -i "$caminhoCompleto" \
  || echo "Erro ao executar o script 'teste2.sh'"
else
  docker exec -u "root" $NOME_DOCKER /opt/mssql-tools/bin/sqlcmd \
  -U $BD_USER -P $BD_PASS \
  -d $nomeBanco \
  -v caminhoArquivoBackup="$CAMINHO_ARQUIVOS/AdventureWorks2022.bak" \
  -i "$caminhoCompleto" \
  || echo "Erro ao executar o script 'teste2.sh'"
fi
