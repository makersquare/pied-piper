
app.controller('UserDetailsCtrl',
  ['$scope', 'UsersRsc',
  function($scope, UsersRsc) {

    $scope.users = UsersRsc.query();
    console.log($scope.users)

    // $scope.createNewUser = UsersRsc.save();

  }
]);
