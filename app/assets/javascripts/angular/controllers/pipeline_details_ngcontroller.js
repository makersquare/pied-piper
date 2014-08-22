app.controller('PipelineDetailsCtrl',
  ['$scope', '$routeParams', 'PipelineService', 'BoxService', 'SingleBoxService',
  function($scope, $routeParams, PipelineService, BoxService, SingleBoxService) {

    var pipelineId = $scope.pipeline_id = $routeParams.id;



    /*
     * Use BoxService to grab all Boxes
     * and allow selection, updates, and more
     * We'll be watching the contacts through
     * broadcasts
     */
    $scope.SingleBoxService = SingleBoxService;

    $scope.changeContact = function(event, contact_id){
      $scope.cb = SingleBoxService.retrieveBox(contact_id, pipelineId);
      $scope.notes = SingleBoxService.retrieveNotes(contact_id, pipelineId);
      $scope.emails = SingleBoxService.retrieveEmails(contact_id);
    };

    $scope.keyup = function(event, cb) {
      if (event.keyCode == 13) {
        // SingleBoxService.updateBox(cb)
        cb.showEdit = !cb.showEdit;
        BoxService.ContactsBoxRsc.update($scope.cb);
        }
    };

    // Update the entry by sending the 'update' request
    $scope.updateEntry = function(){
      BoxService.ContactsBoxRsc.update(
        $scope.cb);
    };

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
      }
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

  // app.controller('EmailShowCtrl',['$scope', '$resource', '$http',
  //   '$location', '$routeParams', function($scope, $resource, $http,
  //     $location, $routeParams){

  //     $scope.messages=null;

  //   var EmailRetrieveRsc = $resource('/contextio/email/:id.json',
  //       {id: '@id'},
  //       {
  //        get: {method: 'GET'},
  //         }
  //       );

  //   EmailRetrieveRsc.get({id: $routeParams.cid})
  //   .$promise.then(function(messages){
  //   $scope.messages = messages;});
  // }]);
