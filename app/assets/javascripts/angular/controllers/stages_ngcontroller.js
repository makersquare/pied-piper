//this custom directive gives functionality to delete buttons on the dom to
//delete stages in the dom and database simultaneously
app.directive('deletestage',
  ['StagesRsc', '$routeParams',
  function(StagesRsc, $routeParams) {
  return function(scope, element) {
    element.bind('click', function(e){
      e.preventDefault();
      StagesRsc.remove({pipeline_id: $routeParams['pipeline_id'], id: this.dataset.id}, element, function(element){
        scope.stages.splice(element.context.dataset.index, 1);
      });
    });
  };
}]);

//this controller gives scope to the dom template "createFields.html" and adds
//functionality for adding stages to the dom and db simultaneously
app.controller('StagesCtrl',
  ['$routeParams', '$scope', '$http', 'StagesRsc',
  function($routeParams, $scope, $http, StagesRsc) {

  $scope.stages = StagesRsc.query({pipeline_id: $routeParams['pipeline_id']});

  $scope.addStage = function() {
    $scope.stage = new StagesRsc();
    $scope.stage.$save({pipeline_id: $routeParams['pipeline_id'], name: $scope.stageName, description: $scope.stageDesc, pipeline_location: $scope.stageLoc},
      function(data) {
        $scope.stages.push({name: $scope.stageName, description: $scope.stageDesc, pipeline_location: $scope.stageLoc, id: data.id});
        $scope.stageName = "";
    });
  };
}]);
