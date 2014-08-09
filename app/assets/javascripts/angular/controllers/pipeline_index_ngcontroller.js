app.controller('PipelineIndexCtrl',
  ['$scope', '$resource', 'PipelinesRsc',
  function($scope, $resource, PipelinesRsc) {
    $scope.newPipeline = false;
    $scope.pipelineName = "";

    var updatePipes = function(){
      $scope.pipelineList = PipelinesRsc.get();
    };
    updatePipes();

    $scope.namePipeline = function() {
      $scope.newPipeline = true;
    };

    $scope.createNewPipeline = function(){
      if ($scope.pipelineName.length > 0) {
        var result = PipelinesRsc.createPipe({'name': $scope.pipelineName}, function(data) {
          $scope.newPipeline = false;
          $scope.pipelineList.push({'name': $scope.pipelineName, 'id': data.id});
        });
      }
    };

  }]);
