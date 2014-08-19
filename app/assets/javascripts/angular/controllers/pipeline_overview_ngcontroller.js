app.controller('PipelineOverviewCtrl', ['$scope', '$resource',
  'PipelinesRsc', 'StagesRsc', 'ContactsBoxRsc',
  function($scope, $resource, PipelinesRsc, StagesRsc, ContactsBoxRsc) {
    // $scope.pipeline_id = $routeParams.id;
    $scope.pipelines = PipelinesRsc.query()

    $scope.stages = StagesRsc.query(
      {pipeline_id: 1}
    );



    // Order array for stages by pipeline_location
    // Add number of contacts per stage
    // Add number of contadcts per pipeline

    // [ { id: "1", name: "Admissions", contacts: "323", stages: [
          // { id: "3", name: "First contact", pipeline_location: "1", contacts: "102" },
          // { id: "2", name: "Interview", pipeline_location: "2", contacts: "89" },
          // { id: "4", name: "Decision", pipeline_location: "3", contacts: "132" }
            // ] },
    // ]

    $scope.contacts = ContactsBoxRsc.query(
      // {pipeline_id: $routeParams.id}
    );

    $scope.stageContacts = {}

    // $scope.stages.$promise.then(function(data) {
    //   for (var stageIndex = 0; stageIndex < data.length; stageIndex++) {
    //     var stage = data[stageIndex];
    //     $scope.stageContacts[stage.id] = [];
    //   };
    //   return $scope.contacts.$promise;
    // })
    // .then(function(data) {
    //   var contacts = data;
    //   for (var contactIndex = 0; contactIndex < contacts.length; contactIndex++) {
    //     var contact = contacts[contactIndex];
    //     var contactStageId = contact.stage_id;
    //     $scope.stageContacts[contactStageId].push(contact);
    //   };
    // });

  }]);
