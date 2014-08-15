app.controller('PipelineDetailsCtrl',
  ['$scope', '$resource',
  '$routeParams','PipelinesRsc',
  'ContactsBoxRsc', 'FieldsRsc',
  'StagesRsc',
  function($scope, $resource, $routeParams,
    PipelinesRsc, ContactsBoxRsc, FieldsRsc,
    StagesRsc) {

// Update a contact's stage using the dropdown list
    $scope.changeStage = function(contact, stage) {
        var currentStage = contact.stage_id;
        var contactID = $scope.stageContacts[currentStage].indexOf(contact);
        $scope.stageContacts[currentStage].splice(contactID, 1);
        $scope.stageContacts[stage.id].push(contact);

        contact.stage_id = stage.id;
        contact.cid = contact.id;
        contact.contact_id = contact.id;
        contact.pid = $routeParams.id;
        ContactBoxRsc.update(contact);
    };

    $scope.pipeline_id = $routeParams.id;
    $scope.contact = {};
    $scope.contact.showEdit = false;
    // $scope.draggable = true;

    PipelinesRsc.pipersc.get({Id: $routeParams.id})
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
      for (var contactIndex = 0; contactIndex < contacts.length; contactIndex++) {
        var contact = contacts[contactIndex];
        var contactStageId = contact.stage_id;
        $scope.stageContacts[contactStageId].push(contact);
      };
      console.log($scope.stageContacts);
    });

// Edit the entry in the browser by double-clicking the text; press enter to update in the database
    $scope.makeEditable = function(contact) {
      contact.showEdit = !contact.showEdit;
      // $scope.draggable = !$scope.draggable;
    };

    $scope.keyup = function(event, contact) {
      if (event.keyCode == 13) {
        contact.showEdit = !contact.showEdit;
        contact.cid = contact.id;
        contact.contact_id = contact.id;
        contact.pid = $routeParams.id;
        ContactBoxRsc.update(contact);
        // $scope.draggable = !$scope.draggable;
      };
    };

// Define the rails path that will be hit by the http requests
    var ContactBoxRsc = $resource('/pipelines/:pid/contacts/:cid.json',
      { cid: '@cid', pid: '@pid' },
      {
       get: { method: 'GET' },
       update: { method: 'PUT', params: $scope.cb }
        }
      );

    // $scope.onDropComplete = function(contact, stage) {
    //   console.log($scope.draggable);
    //   console.log(contact);
    //   console.log(stage);
    // }
  }]);

