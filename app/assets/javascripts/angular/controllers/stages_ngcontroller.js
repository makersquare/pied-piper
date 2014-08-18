//This factory establishes a restful http api that talks to the stages controller in rails
app.factory('StagesAPI', function($resource) {
  return $resource('/pipelines/:pipeline_id/stages/:id.json',
    {pipeline_id: '@pipeline_id', stage_id: '@id'}, {
    update: {
          method: 'PUT'
        }
    });
});

//this custom directive gives functionality to delete buttons on the dom to
//delete stages in the dom and database simultaneously
app.directive('deletestage', function(StagesAPI, $routeParams) {
  return function(scope, element) {
    element.bind('click', function(e){
      e.preventDefault();
      StagesAPI.remove({pipeline_id: $routeParams['pipeline_id'], id: this.dataset.id}, element, function(element){
        scope.stages.splice(element.context.dataset.index, 1);
      });
    });
  };
});

//this controller gives scope to the dom template "createFields.html" and adds
//functionality for adding stages to the dom and db simultaneously
app.controller('StagesCtrl',
  ['$routeParams', '$scope', '$http', 'StagesAPI',
  function($routeParams, $scope, $http, StagesAPI) {

  $scope.stages = StagesAPI.query({pipeline_id: $routeParams['pipeline_id']});

  $scope.addStage = function() {
    $scope.stage = new StagesAPI();
    $scope.stage.$save({pipeline_id: $routeParams['pipeline_id'], name: $scope.stageName, description: $scope.stageDesc, pipeline_location: $scope.stageLoc},
      function(data) {
        $scope.stages.push({name: $scope.stageName, description: $scope.stageDesc, pipeline_location: $scope.stageLoc});
        $scope.stageName = "";
    });
  };
}]);
