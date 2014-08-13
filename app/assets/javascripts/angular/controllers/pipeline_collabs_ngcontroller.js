app.controller('PipelineCollabCtrl',
  ['$scope', '$resource', 'PipelineCollabRsc', '$routeParams', 'UsersRsc',
  function($scope, $resource, PipelineCollabRsc, $routeParams, UsersRsc) {
    $scope.allUsers = UsersRsc.query();
    $scope.pipeline_id = $routeParams.id;
    $scope.collabs = PipelineCollabRsc.query({id: $routeParams.id});
    $scope.newUser = {user: {}, admin: false};

    $scope.addCollab = function() {
      PipelineCollabRsc.save({id: $routeParams.id, newUser: $scope.newUser}, function(data) {
        $scope.collabs.push(data)
      });
    };

    $scope.updateCollab = function(collab) {
      if(collab.admin === "remove") {
        PipelineCollabRsc.remove({id: $routeParams.id, user_id: collab.user_id}, function(data){
          var collabIndex = $scope.collabs.indexOf(collab);
          $scope.collabs.splice(collabIndex,1);
        });
      } else {
        PipelineCollabRsc.update({id: $routeParams.id, user_id: collab.user_id, pipeline_admin: collab.admin}, function(data){
          var collabIndex = $scope.collabs.indexOf(collab);
          $scope.collabs[collabIndex].admin = data.admin
        });
      }
    };
  }]);