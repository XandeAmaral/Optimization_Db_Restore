describe('Data analysis', () => {
  let inicio;
  let fim;

  it.only('Restore from Backup', () => {
    cy.step('Drop snapshots');
    cy.dropSnapshot();

    cy.step('Manipulim database');
    // cy.insertDatas();
    // cy.insertDatas_2();
    cy.insertDatas_3();

    cy.step('Restore backup');
    cy.wrap('').then(() => {
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
    cy.wrap('', c).then(() => {
      console.time('timeSnapshot');
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
        }
      });
    });
  });
});