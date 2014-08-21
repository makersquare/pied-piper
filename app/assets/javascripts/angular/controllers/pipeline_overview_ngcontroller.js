app.controller('PipelineOverviewCtrl', ['$scope', 'PipelinesRsc',
  function($scope, PipelinesRsc) {
    $scope.pipelineName = '';
    $scope.pipelines = PipelinesRsc.query();

    $scope.createNewPipeline = function(){
      event.preventDefault();
      if ($scope.pipelineName.length > 0) {
        PipelinesRsc.save({'name': $scope.pipelineName}, function(data) {
          $scope.newPipeline = false;
          $scope.pipelines.push({'name': $scope.pipelineName, 'id': data.id});
          $scope.pipelineName='';
        });
      }
    };
  }]);
