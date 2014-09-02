app.controller('UserDetailsCtrl',
  ['$scope', 'UsersRsc',
  ($scope, UsersRsc)->
    $scope.users = UsersRsc.query()
    $scope.newUser = {}
    $scope.createNewUser = ->
      UsersRsc.save($scope.newUser)
      $scope.users.push($scope.newUser)
      $scope.newUser = {}
  ]
)
