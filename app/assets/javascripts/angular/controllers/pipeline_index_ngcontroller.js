app.controller('PipelineIndexCtrl',
  ['$scope', '$resource', 'Pipelines',
  function($scope, $resource, Pipelines) {

  $scope.pipelineList = Pipelines.get();


  }]);
