app.controller('PipelineOverviewCtrl', ['$scope', '$resource',
  '$routeParams','PipelinesRsc', 'StagesRsc', 'ContactsBoxRsc',
  function($scope, $routeParams, $resource, PipelinesRsc, StagesRsc, ContactsBoxRsc) {
    $scope.pipeline_id = $routeParams.id;
    // $scope.pipelines = PipelinesRsc.query()

    
    $scope.stages = StagesRsc.query({pipeline_id: $routeParams.id});
    $scope.contacts = ContactsBoxRsc.query({pipeline_id: $routeParams.id});
    $scope.stageContacts = {}

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
    });

  }]);