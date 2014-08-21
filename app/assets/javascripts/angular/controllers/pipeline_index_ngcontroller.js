// FIXME: This can be deleted i think
// pipeline_overview_ngcontroller replaces this... i think?
app.controller('PipelineIndexCtrl',
  ['$scope', '$resource', 'PipelinesRsc',
  function($scope, $resource, PipelinesRsc) {
    $scope.newPipeline = false;
    $scope.pipelineName = "";

    $scope.pipelineList = PipelinesRsc.query();


  }]);
