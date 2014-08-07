app.controller('PipelineIndexCtrl',
  ['$scope', '$resource', 'PipelinesRsc',
  function($scope, $resource, PipelinesRsc) {

    var updatePipes = function(){
      $scope.pipelineList = PipelinesRsc.get();
    }();

    $scope.createNewPipeline = function(){
      var pipeName = prompt('Pipeline Name:');
      var result = PipelinesRsc.createPipe({'name':pipeName},{});
      // we need to redo an new api call to get the updated pipelines
      updatePipes();
    };

  }]);
