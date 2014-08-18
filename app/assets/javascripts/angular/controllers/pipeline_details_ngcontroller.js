app.controller('PipelineDetailsCtrl',
  ['$scope', '$routeParams', 'PipelineService', 'BoxService',
  function($scope, $routeParams, PipelineService, BoxService) {

    var pipelineId = $scope.pipeline_id = $routeParams.id;

    /*
     * Use BoxService to grab all Boxes
     * and allow selection, updates, and more
     * We'll be watching the contacts through
     * broadcasts
     */
    $scope.BoxService = BoxService;
    BoxService.setUp($routeParams.id);
    $scope.stageContacts = BoxService.stageContacts;
    $scope.stageSelection = BoxService.stageSelection;
    $scope.allContactsSelection = BoxService.allContactsSelection;

    $scope.$on("stageContacts:updated", function(event, data, id){
      $scope.stageContacts = data;
    });

    $scope.$on("allContactsSelection:updated", function(event, data){
      $scope.allContactsSelection = data;
    });

    $scope.$on("stageSelection:updated", function(event, data){
      $scope.stageSelection = data;
    });

    $scope.updateBoxOnEnter = function(event, contact) {
      if (event.keyCode == 13) {
        BoxService.updateBox(contact);
      };
    };

    /*
     * Grabs information related to the pipeline including
     * stages, fields, pipeline name, and basicFields
     */
    $scope.PipelineService = PipelineService;
    $scope.pipeline = PipelineService.pipeline(pipelineId);
    $scope.fields = PipelineService.fields(pipelineId);
    $scope.stages = PipelineService.stages(pipelineId);
    $scope.basicFields = PipelineService.basicFields;

    $scope.$on('pipeline:updated', function(event, data) {
      $scope.pipeline = data;
    });

  }]);
