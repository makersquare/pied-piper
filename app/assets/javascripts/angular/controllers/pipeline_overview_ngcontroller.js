app.controller('PipelineOverviewCtrl', ['$scope', 'PipelinesRsc',
  function($scope, PipelinesRsc) {
    $scope.pipelines = PipelinesRsc.query()
  }]);
