app.controller('PipelineDetailsCtrl',
  ['$scope', '$resource',
  '$routeParams','PipelinesRsc',
  'ContactsBoxRsc', 'FieldsRsc',
  'StagesRsc',
  function($scope, $resource, $routeParams,
    PipelinesRsc, ContactsBoxRsc, FieldsRsc,
    StagesRsc) {

    $scope.pipeline_id = $routeParams.id;
    $scope.contact = {}
    $scope.contact.showEdit = false;
    // $scope.draggable = true;

    PipelinesRsc.getPipe({Id: $routeParams.id})
      .$promise.then(function(data){
        $scope.pipeline = data;
    });

    $scope.basicFields = [{field_name: "name"}, {field_name: "email"}];
    $scope.fields = FieldsRsc.query({pipeline_id: $routeParams.id});

    $scope.contacts = ContactsBoxRsc.query({pipeline_id: $routeParams.id});

    $scope.stages = StagesRsc.query({pipeline_id: $routeParams.id});

// Edit the entry in the browser by double-clicking the text; press enter to update in the database
    $scope.makeEditable = function(contact) {
      contact.showEdit = !contact.showEdit;
      // $scope.draggable = !$scope.draggable;
    }

    $scope.keyup = function(event, contact) {
      if (event.keyCode == 13) {
        contact.showEdit = !contact.showEdit;
        contact.cid = contact.id;
        contact.contact_id = contact.id;
        contact.pid = $routeParams.id;
        ContactBoxRsc.update(contact);
        // $scope.draggable = !$scope.draggable;
      }
    };

// Update a contact's stage using the dropdown list
  $scope.changeStage = function(contact, stage) {
    contact.stage_id = stage.id
    contact.cid = contact.id;
    contact.contact_id = contact.id;
    contact.pid = $routeParams.id;
    ContactBoxRsc.update(contact)
  }

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

