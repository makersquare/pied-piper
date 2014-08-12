app.controller('PipelineDetailsCtrl',
  ['$scope', '$resource',
  '$routeParams','PipelinesRsc',
  'ContactsBoxRsc', 'FieldsRsc',
  'StagesRsc',
  function($scope, $resource, $routeParams,
    PipelinesRsc, ContactsBoxRsc, FieldsRsc,
    StagesRsc) {

    $scope.pipeline_id = $routeParams.id;
    $scope.editData = false;

    PipelinesRsc.getPipe({Id: $routeParams.id})
      .$promise.then(function(data){
        $scope.pipeline = data;
    });

    $scope.basicFields = [{field_name: "name"}, {field_name: "email"}];
    $scope.fields = FieldsRsc.query({pipeline_id: $routeParams.id});

    $scope.contacts = ContactsBoxRsc.query({pipeline_id: $routeParams.id});

    $scope.stages = StagesRsc.query({pipeline_id: $routeParams.id});

    $scope.onDropComplete = function(contact, stage) {
      console.log(contact);
      console.log(stage);
    }

  }]);
