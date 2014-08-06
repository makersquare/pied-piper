app.controller('PipelineIndexCtrl',
  ['$scope', '$resource', 'PipelinesRsc',
  function($scope, $resource, PipelinesRsc) {

  $scope.pipelineList = PipelinesRsc.get();


  }]);
