app.controller('PipelineIndexCtrl', ['$scope', '$resource',
  function($scope, $resource) {

    $scope.test = "something";
    $scope.pipelineList = $resource('/pipelines.json').query();

  }]);
