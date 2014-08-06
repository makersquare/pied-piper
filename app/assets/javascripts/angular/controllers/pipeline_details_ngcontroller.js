app.controller('PipelineDetailsCtrl',
  ['$scope', '$resource', 'Pipelines', '$routeParams',
  function($scope, $resource, Pipelines, $routeParams) {
    console.log($routeParams.id);

    Pipelines.getPipe({Id: $routeParams.id}).$promise.then(function(data){
      $scope.data = data;
      $scope.pipeData = data.pipeline;
      $scope.pipeStages = data.pipeline_stages;
      $scope.stageBoxes = data.stage_boxes;
    });

  }]);
