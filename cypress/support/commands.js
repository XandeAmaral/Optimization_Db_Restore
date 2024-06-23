// Custom commands shell script

Cypress.Commands.add('execAnyScriptSQL', (nomeScriptSQL, nomeBanco = "", ...params) => {

  const paramsString = params.join(' ');

  cy.exec(`chmod +x cypress/scripts/execAnyScriptSQL.sh \
    && cypress/scripts/execAnyScriptSQL.sh ${nomeScriptSQL} ${nomeBanco} ${paramsString}`,
    { failOnNonZeroExit: false })
    .then((result) => {
      cy.log(result.stdout);
      cy.log(result.stderr);
      cy.wrap('', { log: false }).then(() => {
        return result;
      });
    });
});

// Restore from backup

Cypress.Commands.add('restoreBackup', () => {
  const nomeScriptSQL = "restoreBackup.sql";

  cy.execAnyScriptSQL(nomeScriptSQL);
});

// Snapshots

const nomeBanco = 'TESTE';
const nomeSnapshot = 'adv_dbss';

Cypress.Commands.add('createSnapshots', () => {
  const nomeScriptSQL = 'createSnapshot.sql';

  cy.execAnyScriptSQL(nomeScriptSQL, nomeBanco, nomeSnapshot);
});

Cypress.Commands.add('restoreSnapshot', () => {
  const nomeScriptSQL = 'restoreSnapshot.sql';

  cy.execAnyScriptSQL(nomeScriptSQL, nomeBanco, nomeSnapshot);
});

Cypress.Commands.add('dropSnapshot', () => {
  const nomeScriptSQL = 'dropSnapshot.sql';

  cy.execAnyScriptSQL(nomeScriptSQL, nomeBanco, nomeSnapshot);
});

// Insert data in dtb

Cypress.Commands.add('insertDatas', () => {
  const nomeScriptSQL = 'insertDatas.sql';

  cy.execAnyScriptSQL(nomeScriptSQL, nomeBanco, nomeSnapshot);
});

Cypress.Commands.add('insertDatas_2', () => {
  const nomeScriptSQL = 'littleDatas.sql';

  cy.execAnyScriptSQL(nomeScriptSQL, nomeBanco, nomeSnapshot);
});

Cypress.Commands.add('insertDatas_3', () => {
  const nomeScriptSQL = 'insertDatas2.sql';

  cy.execAnyScriptSQL(nomeScriptSQL, nomeBanco, nomeSnapshot);
});


// Input the timing result in the json