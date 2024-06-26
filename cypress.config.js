const { defineConfig } = require("cypress");
const fs = require('fs');
const path = require('path');

module.exports = defineConfig({
  defaultCommandTimeout: 60000,

  e2e: {
    setupNodeEvents(on, config) {

      on('task', {
        writeTiming({ result, type }) {

          // verifica se é backup ou snapshot
          let arquivo = 'timeSs.json';
          if (type == 'backup') {
            arquivo = 'timeBk.json';
          };

          // Caminho do arquivo JSON que armazena os valores
          const filePath = path.join(__dirname, 'cypress', 'results', arquivo);

          // Variável para armazenar os resultados da leitura do arquivo
          let timings = [];

          // Processo de ler o arquivo
          try {
            if (fs.existsSync(filePath)) {
              const data = fs.readFileSync(filePath, 'utf-8');
              timings = JSON.parse(data);

              if (!Array.isArray(timings)) {
                timings = [];
              }
            }
          } catch (err) {
            console.error('Erro ao ler o arquivo timings.json:', err);
            timings = [];
          }

          // Adiciona o novo resultado
          timings.push(result);

          // Escreve os resultados atualizados
          try {
            fs.writeFileSync(filePath, JSON.stringify(timings, null, 2), 'utf-8');
          } catch (err) {
            console.error('Erro ao escrever no arquivo timings.json:', err);
            return { error: 'Erro ao escrever no arquivo timings.json' };
          }

          // Calcular a média
          const soma = timings.reduce((total, valor) => total + valor, 0);
          const media = soma / timings.length;

          return { success: true, media: media, type: type };
        },
      });
    },
  },
});
