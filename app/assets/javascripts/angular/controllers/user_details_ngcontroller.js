app.controller('UserDetailsCtrl',
  ['$scope', 'UsersRsc',
  function($scope, UsersRsc) {

    $scope.users = UsersRsc.query();
    $scope.newUser = {};

    $scope.createNewUser = function(){
      UsersRsc.save($scope.newUser);
      $scope.users.push($scope.newUser);
      $scope.newUser = {};
    }
  }
]);
