describe('Data analysis', () => {
  let inicio;
  let fim;

  Cypress._.times(1, () => {
    context('Testes performance inserindo dados', () => {
      it('Restore from Backup', () => {
        cy.step('Drop snapshots');
        cy.dropSnapshot();

        cy.step('Manipulim database');
        // cy.insertDatas();
        // cy.insertDatas_2();
        cy.insertDatas_3();

        cy.step('Restore backup');
        cy.wrap('', { log: false }).then(() => {
          inicio = performance.now();
        });

        cy.restoreBackup();

        cy.wrap('').then(() => {
          fim = performance.now();
          const result = fim - inicio;

          cy.task('writeTiming', { result, type: 'backup' }).then((response) => {
            if (response.error) {
              console.error(response.error);
            } else {
              console.log('Tempo registrado com sucesso');
              console.log(`A média dos tempos de ${response.type} é de ${response.media} milissegundos`);
            }
          });
        });
      });

      it('Restore from snapshots', () => {
        cy.step('Create snapshots');
        cy.createSnapshots();

        cy.step('Manipulim database');
        // cy.insertDatas();
        // cy.insertDatas_2();
        cy.insertDatas_3();

        cy.step('Restore snapshot');
        cy.wrap('', { log: false }).then(() => {
          inicio = performance.now();
        });

        cy.restoreSnapshot();

        cy.wrap('', { log: false }).then(() => {
          fim = performance.now();
          const result = fim - inicio;

          cy.task('writeTiming', { result, type: 'snapshot' }).then((response) => {
            if (response.error) {
              console.error(response.error);
            } else {
              console.log('Tempo registrado com sucesso');
              console.log(`A média dos tempos de ${response.type} é de ${response.media} milissegundos`);
            }
          });
        });
      });
    });
  });
});