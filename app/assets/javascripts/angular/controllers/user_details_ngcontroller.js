
app.controller('UserDetailsCtrl',
  ['$scope', 'UsersRsc',
  function($scope, UsersRsc) {

    $scope.allUsers = UsersRsc.query();
    console.log($scope.allUsers)

    $scope.createNewUser = UsersRsc.save();

  }
]);
