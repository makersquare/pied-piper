app.controller('PipelineDetailsCtrl',
  ['$scope', '$routeParams', 'PipelinesRsc', 'FieldsRsc',
    'StagesRsc', 'BoxService',
  function($scope, $routeParams, PipelinesRsc, FieldsRsc,
    StagesRsc, BoxService) {

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

    $scope.pipeline_id = $routeParams.id;
    $scope.contact = {};
    $scope.contact.showEdit = false;

    PipelinesRsc.get({id: $routeParams.id})
      .$promise.then(function(data){
        $scope.pipeline = data;
    });

    $scope.basicFields = [{field_name: "name"}, {field_name: "email"}];
    $scope.fields = FieldsRsc.query({pipeline_id: $routeParams.id});

    $scope.stages = StagesRsc.query({pipeline_id: $routeParams.id});

    $scope.stages.$promise.then(function(data) {
      for (var stageIndex = 0; stageIndex < data.length; stageIndex++) {
        var stage = data[stageIndex];
      };
    })
  }]);
