app.controller('PipelineCollabCtrl',
  ['$scope', '$resource', 'PipelineCollabRsc', '$routeParams', 'UsersRsc',
  ($scope, $resource, PipelineCollabRsc, $routeParams, UsersRsc) ->
    $scope.allUsers = UsersRsc.query()
    $scope.collabs = PipelineCollabRsc.query(id: $routeParams.id)
    $scope.newUser =
      user: {}
      admin: false

    $scope.addCollab = ->
      PipelineCollabRsc.save(
        id: $routeParams.id
        newUser: $scope.newUser,
        (data)->
          $scope.collabs.push(data)
      )

    $scope.collabFilter = (user)->
      for collab in $scope.collabs
        collab_data = collab
        if collab_data.id is user.id
          false
      true

    $scope.updateCollab = (collab)->
      if collab.admin is "remove"
        PipelineCollabRsc.remove(
          id: $routeParams.id
          user_id: collab.user_id,
          (data)->
          collabIndex = $scope.collabs.indexOf(collab)
          $scope.collabs.splice(collabIndex,1)
        )
      else
        PipelineCollabRsc.update(
          id: $routeParams.id
          user_id: collab.user_id
          pipeline_admin: collab.admin,
          (data)->
            collabIndex = $scope.collabs.indexOf(collab)
          $scope.collabs[collabIndex].admin = data.admin
        )
  ]
)
