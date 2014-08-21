app.controller('PipelineIndexCtrl',
  ['$scope', '$resource', 'PipelinesRsc',
  function($scope, $resource, PipelinesRsc) {
    $scope.newPipeline = false;
    $scope.pipelineName = "";

    $scope.pipelineList = PipelinesRsc.query();

    $scope.createNewPipeline = function(){
      if ($scope.pipelineName.length > 0) {
        PipelinesRsc.save({'name': $scope.pipelineName}, function(data) {
          $scope.newPipeline = false;
          $scope.pipelineList.push({'name': $scope.pipelineName, 'id': data.id});
        });
      };
    };
  }]);
