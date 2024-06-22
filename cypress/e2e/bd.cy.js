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

  it('restore Backup', () => {
    cy.restoreDb();
  });

  it('viewDB', () => {
    const nomeScriptSQL = 'viewDB.sql';
    cy.execAnyScriptSQL(nomeScriptSQL);
  });

  it('createSnapshot', () => {
    const nomeScriptSQL = 'createSnapshot.sql';
    const nomeBanco = 'TESTE';
    const nomeSnapshot = 'adv_dbss';

    cy.execAnyScriptSQL(nomeScriptSQL, nomeBanco, nomeSnapshot);
  });

  it('restoreSnapshot', () => {
    const nomeScriptSQL = 'restoreSnapshot.sql';
    const nomeBanco = 'TESTE';
    const nomeSnapshot = 'adv_dbss';
    // const nomeSnapshot = Cypress.env('nomeSnapshot');
    // const nomeBanco = 'adv_dbss1';
    // const nomeSnapshot = 'adv_dbss1';

    cy.execAnyScriptSQL(nomeScriptSQL, nomeBanco, nomeSnapshot);
  });

  it('dropSnapshot', () => {
    const nomeScriptSQL = 'dropSnapshot.sql'
    const nomeBanco = 'TESTE';
    const nomeSnapshot = 'adv_dbss';

    cy.execAnyScriptSQL(nomeScriptSQL, nomeBanco, nomeSnapshot);
  });
});