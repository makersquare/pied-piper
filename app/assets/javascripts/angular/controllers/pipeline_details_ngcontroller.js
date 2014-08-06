app.controller('PipelineDetailsCtrl',
  ['$scope', '$resource', 'PipelinesRsc', '$routeParams',
  function($scope, $resource, PipelinesRsc, $routeParams) {
    console.log($routeParams.id);
    $scope.editData = false;
    PipelinesRsc.getPipe({Id: $routeParams.id})
      .$promise.then(function(data){
        $scope.data = data;
        $scope.pipeData = data.pipeline;
        $scope.pipeStages = data.pipeline_stages;
        $scope.stageBoxes = data.stage_boxes;
    });

  }]);
