app.controller('PipelineCollabCtrl',
  ['$scope', '$resource', 'PipelineCollabRsc', '$routeParams', 'UsersRsc',
  function($scope, $resource, PipelineCollabRsc, $routeParams, UsersRsc) {
    var collabs = PipelineCollabRsc.query({id: $routeParams.id})
    $scope.allUsers = UsersRsc.query()
    $scope.pipeline_id = $routeParams.id;
    $scope.collabs = collabs;
    $scope.newUser = {user: {}, admin: false};

    $scope.addCollab = function() {
      PipelineCollabRsc.addCollab({id: $routeParams.id, newUser: $scope.newUser}, function(data) {
        console.log(data);
      });
    };

    // $scope.removeCollab = function() {
    //   PipelineCollabRsc.removeCollab({id: $routeParams.id, user_id: });
    // };

    // $scope.updateCollab = function() {
    //   PipelineCollabRsc.removeCollab({id: $routeParams.id, user_id: , admin: });
    // };
  }]);