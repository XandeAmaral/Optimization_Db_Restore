Cypress.Commands.add('restoreDb', () => {
  cy.exec(`chmod +x cypress/scripts/restoreBd.sh && cypress/scripts/restoreBd.sh`,
    { failOnNonZeroExit: false })
    .then((result) => {
      cy.log(result.stdout);
      cy.log(result.stderr);
    })
});

Cypress.Commands.add('execAnyScript', (nomeArquivoSQL) => {
  cy.exec(`chmod +x cypress/scripts/teste2.sh && cypress/scripts/teste2.sh ${nomeArquivoSQL}`,
    { failOnNonZeroExit: false })
    .then((result) => {
      cy.log(result.stdout);
      cy.log(result.stderr);
    })
});
