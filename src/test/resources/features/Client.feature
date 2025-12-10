Feature: client

  @postNewClient
  Scenario: Add a new client
    Given call Workspace.feature@getAllWorkspaces
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idWorkspace}}/clients
    And header x-api-key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
    And header Content-Type = application/json
    And body jsons/bodies/addNewClient.json
    When execute method POST
    Then the status code should be 201
    * print response
    * define idClient = $.id


  @getAllClients
  Scenario: GetAllClients
    Given call Workspace.feature@getAllWorkspaces
    And  base url https://api.clockify.me
    And endpoint /api/v1/workspaces/{{idWorkspace}}/clients
    And header x-api-key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
    When execute method GET
    Then the status code should be 200
    * print response




  @deleteClient
  Scenario: Delete Client
    Given call Client.feature@postNewClient
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idWorkspace}}/clients/{{idClient}}
    And header x-api-key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
    When execute method DELETE
    Then the status code should be 200
    * print response

