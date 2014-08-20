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
    $scope.stageContacts = BoxService.stageContacts;
    $scope.stageSelection = BoxService.stageSelection;
    $scope.allContactsSelection = BoxService.allContactsSelection;

    $scope.$on("stageContacts:updated", function(event, data, id){
      $scope.stageContacts = data;
    });

// Update a contact's stage using the dropdown list
    $scope.changeStage = function(contact, stage) {
        var currentStage = contact.stage_id;
        var contactID = $scope.stageContacts[currentStage].indexOf(contact);
        $scope.stageContacts[currentStage].splice(contactID, 1);
        $scope.stageContacts[stage.id].push(contact);

        contact.stage_id = stage.id;
        ContactsBoxRsc.update({id: contact.id, pipeline_id:
          $routeParams.id, contact: contact, stage_id: contact.stage_id});
    };

    // This function runs to select all contacts in a given
    // Stage
    $scope.selectAllFromStage = function (stage) {
      $scope.contactSelector.markAll(
        $scope.stageContacts[stage.id],
        stage.selected
      );
    }

    // The function will toggle between selecting all
    // contacts, and deselecting them.
    // It will use the helper 'selectAllFromStage' to
    // propogate the call.
    $scope.toggleSelectAll = function() {
      // var value = true;
      var value = $scope.selectAll = !$scope.selectAll;
      console.log(value);
      for (var i = 0; i < $scope.stages.length; i++) {
        var stage = $scope.stages[i];
        stage.selected = value;
        $scope.contactSelector.markAll(
          $scope.stageContacts[stage.id],
          stage.selected
        );
      }
    }

    $scope.pipeline_id = $routeParams.id;
    $scope.contact = {};
    $scope.contact.showEdit = false;
    // $scope.draggable = true;

    PipelinesRsc.get({id: $routeParams.id})
      .$promise.then(function(data){
        $scope.pipeline = data;
    });

    $scope.basicFields = [{field_name: "name"}, {field_name: "email"}];
    $scope.fields = FieldsRsc.query({pipeline_id: $routeParams.id});

    $scope.contacts = ContactsBoxRsc.query({pipeline_id: $routeParams.id});

    $scope.stageContacts = {}

    $scope.stages = StagesRsc.query({pipeline_id: $routeParams.id});

    $scope.stages.$promise.then(function(data) {
      for (var stageIndex = 0; stageIndex < data.length; stageIndex++) {
        var stage = data[stageIndex];
        $scope.stageContacts[stage.id] = [];
      };
      return $scope.contacts.$promise;
    })
    .then(function(data) {
      var contacts = data;
      // Once contacts are loaded, set up ability
      // to select/deselect contacts
      $scope.contactSelector = ContactSelector;
      $scope.contactSelector.deselectAll($scope.contacts);

      for (var contactIndex = 0; contactIndex < contacts.length; contactIndex++) {
        var contact = contacts[contactIndex];
        var contactStageId = contact.stage_id;
        $scope.stageContacts[contactStageId].push(contact);
      };
    });

// Edit the entry in the browser by double-clicking the text; press enter to update in the database
    $scope.makeEditable = function(contact) {
      contact.showEdit = !contact.showEdit;
    };

    $scope.keyup = function(event, contact) {
      if (event.keyCode == 13) {
        contact.showEdit = !contact.showEdit;
        ContactsBoxRsc.update({pipeline_id: $routeParams.id, id: contact.id, contact: contact});
      };
    };
  }]);

