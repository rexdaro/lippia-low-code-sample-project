Feature: project

  @postNewProject
  Scenario: Add a new project
    Given  call Workspace.feature@getAllWorkspaces
    And base url https://api.clockify.me
    And endpoint /api/v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
    And header Content-Type = application/json
    And body jsons/bodies/addNewProject.json
    When execute method POST
    Then the status code should be 201
    * define idProject = $.id
    * define nameProject = $.name

  @getProjectById
  Scenario: find a project by id
    Given call Project.feature@postNewProject
    And base url https://api.clockify.me
    And endpoint /api/v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header x-api-key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
    When execute method GET
    Then the status code should be 200
    * print response

  @putDeactivateProject
  Scenario: deactivate project
    Given call Project.feature@postNewProject
    And base url https://api.clockify.me
    And endpoint /api/v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header x-api-key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
    And header Content-Type = application/json
    And body jsons/bodies/deactivateProject.json
    When execute method PUT
    Then the status code should be 200


  @deleteProject
  Scenario: delete project
    Given call Project.feature@putDeactivateProject
    And base url https://api.clockify.me
    And endpoint /api/v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header x-api-key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
    When execute method DELETE
    Then the status code should be 200


  @editProjectAndValidate
  Scenario: edit project
    Given call Project.feature@postNewProject
    And base url https://api.clockify.me
    And endpoint /api/v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header x-api-key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
    And header Content-Type = application/json
    And body jsons/bodies/editProject.json
    When execute method PUT
    Then the status code should be 200
    And response should be name = Edited
    And call Project.feature@eliminarProyecto


  @getAllProjects
  Scenario: Get all projects in workspace (Happy Path)
    Given call Project.feature@postNewProject
    And base url https://api.clockify.me
    And endpoint /api/v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
    When execute method GET
    Then the status code should be 200
    # Validación: Debe ser una lista/array (Lippia lo maneja automáticamente)
    # y el proyecto que creamos debe estar presente:
    And response should be $[0].name contains {{nameProject}}
    * print response
    And call Project.feature@eliminarProyecto

#   ----------------------- Casos de error ----------------------------------

  @getAllProjectsUnauthorized
  Scenario: Get all projects - Unauthorized (401)
    Given  call Workspace.feature@getAllWorkspaces
    And base url https://api.clockify.me
    And endpoint /api/v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = invalidKey
    When execute method GET
    Then the status code should be 401


  @getProjectNotFound
  Scenario: find a project by id not found - 400 Bad Request
    Given call Project.feature@postNewProject
    And base url https://api.clockify.me
    And endpoint /api/v1/workspaces/{{idWorkspace}}/projects/invalidId
    And header x-api-key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
    When execute method GET
    Then the status code should be 400
    And call Project.feature@eliminarProyecto


  @postProjectBadRequest
  Scenario: Add a new project not found - 400 Bad Request
    Given  call Workspace.feature@getAllWorkspaces
    And base url https://api.clockify.me
    And endpoint /api/v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
    And header Content-Type = application/json
    And body jsons/bodies/newProjectBadRequest.json
    When execute method POST
    Then the status code should be 400



#    ---------------------- Casos para hacer limpieza -----------------------
    @desactivarProyecto
    Scenario: desactivar un proyecto sin hacer calls
      Given base url https://api.clockify.me
      And endpoint /api/v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
      And header x-api-key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
      And header Content-Type = application/json
      And body jsons/bodies/deactivateProject.json
      When execute method PUT
      Then the status code should be 200

    @eliminarProyecto
    Scenario: eliminar proyecto sin hacer calls
      Given call Project.feature@desactivarProyecto
      And base url https://api.clockify.me
      And endpoint /api/v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
      And header x-api-key = NzE0NmMwODItOWYxNi00YzMzLWEyNjUtYjliNzkyYTg1MjYx
      When execute method DELETE
      Then the status code should be 200

