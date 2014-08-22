
app.controller('UserDetailsCtrl',
  ['$scope', 'UsersRsc',
  function($scope, UsersRsc) {

    $scope.users = UsersRsc.query();
    $scope.newUser = {};

    $scope.createNewUser = function(){
      UsersRsc.save($scope.newUser, function(user){
        $scope.users.unshift(user);
        $scope.newUser = {};
      })
      console.log($scope.newUser)
    }
  }
]);
