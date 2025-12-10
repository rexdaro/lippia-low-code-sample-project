Feature: Workspace

  @getAllWorkspaces
  Scenario: Get all my workspaces
    Given  base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    And  header X-Api-Key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $[0]id

    @GetWorkspaceInfo
   Scenario: Get Workspace Info
    Given call Workspace.feature@getAllWorkspaces
    And  base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idWorkspace}}
    And  header X-Api-Key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
    When execute method GET
    Then the status code should be 200
    * print response
    And response should be $.name = crowdar
    And response should be $.id = 68fed0a5c8d82f768ec80392

