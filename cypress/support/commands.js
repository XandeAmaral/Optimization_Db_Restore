Cypress.Commands.add('restoreDb', () => {
  const nomeScriptSH = "restoreDb.sh";
  cy.execShellScript(nomeScriptSH);
});

Cypress.Commands.add('execAnyScriptSQL', (nomeScriptSQL, nomeBanco = "") => {
  const nomeScriptSH = "execAnyScriptSQL.sh";
  cy.execShellScript(nomeScriptSH, nomeScriptSQL, nomeBanco);
});

Cypress.Commands.add('execShellScript', (nomeScriptSH, nomeScriptSQL = "", nomeBanco = "", ...params) => {

  const paramsString = params.join(' ');

  cy.exec(`chmod +x cypress/scripts/${nomeScriptSH} \
    && cypress/scripts/${nomeScriptSH} ${nomeScriptSQL} ${nomeBanco} ${paramsString}`,
    { failOnNonZeroExit: false })
    .then((result) => {
      cy.log(result.stdout);
      cy.log(result.stderr);
    });
});
