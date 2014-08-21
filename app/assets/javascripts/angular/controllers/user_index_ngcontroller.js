app.controller('UserIndexCtrl',
  ['$scope', 'UsersRsc'
  function($scope, UsersRsc){

    $scope.allUsers = UsersRsc.query();
    console.log($scope.allUsers)

    // $scope.addNewUser = UsersRsc.save();

}]);
