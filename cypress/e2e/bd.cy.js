describe('Snapshot first tests', () => {

  it('tests shell scripts', () => {
    cy.exec(`echo "Teste"`);
    cy.exec(`chmod +x cypress/scripts/teste.sh && cypress/scripts/teste.sh`,
      { failOnNonZeroExit: false })
      .then((result) => {
        cy.log(result.stdout);
        cy.log(result.stderr);
      })
    //   .its('stdout')
  });

  it('tests conection with database', () => {
    const nomeScriptSQL = 'testes.sql';
    const nomeScriptSQL2 = 'validaSS.sql';
    const nomeBanco = "TESTE";
    const nomeBanco2 = "adv_dbss1";

    cy.step('Banco principal');
    cy.execAnyScriptSQL(nomeScriptSQL, nomeBanco);

    cy.step('Snapshot');
    cy.execAnyScriptSQL(nomeScriptSQL2, nomeBanco2);
  });

  it('Restore from Backup', () => {
    cy.restoreDb();
  });

  it('viewDB', () => {
    const nomeScriptSQL = 'viewDB.sql';
    cy.execAnyScriptSQL(nomeScriptSQL);
  });

  it('Criação dos snapshots', () => {
    cy.createSnapshots();
  });

  it('Restore from snapshot', () => {
    cy.restoreSnapshot();
  });

  it('Drop snapshot', () => {
    cy.dropSnapshot();
  });

  it('Test snapshots life cicle', () => {
    cy.step('View before create snapshot')
    const nomeScriptSQL = 'viewDB.sql';
    cy.execAnyScriptSQL(nomeScriptSQL)
      .should((result) => {
        expect(result.stdout).contain('TESTE');
        expect(result.stdout).not.contain('adv_dbss');
      });

    cy.step('Create a snapshot');
    cy.createSnapshots()
      .should((result) => {
        expect(result.stdout).contain('SUCCESS CREATE');
      });

    cy.step('View after create snapshot');
    cy.execAnyScriptSQL(nomeScriptSQL)
      .should((result) => {
        expect(result.stdout).contain('TESTE');
        expect(result.stdout).contain('adv_dbss');
      });

    cy.step('Restore snapshot');
    cy.restoreSnapshot()
      .should((result) => {
        expect(result.stdout).contain('SUCCESS RESTORE');
      });;

    cy.step('Drop snapshot');
    cy.dropSnapshot()
      .should((result) => {
        expect(result.stdout).contain('SUCCESS DROP');
      });;

    cy.step('View after create snapshot');
    cy.execAnyScriptSQL(nomeScriptSQL)
      .should((result) => {
        expect(result.stdout).contain('TESTE');
        expect(result.stdout).not.contain('adv_dbss');
      });
  });
});