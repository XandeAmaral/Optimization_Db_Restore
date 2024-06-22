describe('template spec', () => {
  it('test', () => {
    cy.exec(`echo "Teste"`);
    cy.exec(`chmod +x cypress/scripts/teste.sh && cypress/scripts/teste.sh`,
      { failOnNonZeroExit: false })
      .then((result) => {
        cy.log(result.stdout);
        cy.log(result.stderr);
      })
    //   .its('stdout')
  });

  it('real', () => {
    cy.restoreDb();
  });

  it.only('testSql', () => {
    cy.execAnyScript('testes');
  })
});