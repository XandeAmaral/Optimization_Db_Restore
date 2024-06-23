describe('Data analysis', () => {
  let inicio;
  let fim;

  Cypress._.times(10, () => {
    context('Testes performance inserindo dados', () => {
      it('Restore from Backup', () => {
        cy.step('Drop snapshots');
        cy.dropSnapshot();

        cy.step('Manipulim database');
        // cy.insertDatas();
        // cy.insertDatas_2();
        cy.insertDatas_3();

        cy.step('Restore backup');
        cy.restoreBackup();
      });

      it('Restore from snapshots', () => {
        cy.step('Create snapshots');
        cy.createSnapshots();

        cy.step('Manipulim database');
        // cy.insertDatas();
        // cy.insertDatas_2();
        cy.insertDatas_3();

        cy.step('Restore snapshot');
        cy.restoreSnapshot();
      });
    });
  });
});