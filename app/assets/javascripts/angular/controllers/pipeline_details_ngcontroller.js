app.controller('PipelineDetailsCtrl',
  ['$scope', '$resource',
  '$routeParams','PipelinesRsc',
  'ContactsBoxRsc', 'FieldsRsc',
  function($scope, $resource, $routeParams,
    PipelinesRsc, ContactsBoxRsc, FieldsRsc) {
    $scope.editData = false;

    PipelinesRsc.getPipe({Id: $routeParams.id})
      .$promise.then(function(data){
        console.log($routeParams.id);
        $scope.pipeline = data;
    });

    $scope.fields = FieldsRsc.query({pipeline_id: $routeParams.id});

    $scope.contacts = ContactsBoxRsc.query({pipeline_id: $routeParams.id});

      // .$promise.then(function(contact_data){
      //   console.log(contact_data);
      //   $scope.fields = contact_data.meta;
      //   $scope.contacts = contact_data.contacts;
      // });

  }]);
