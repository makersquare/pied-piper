app.controller('PipelineDetailsCtrl',
  ['$scope', '$resource', '$routeParams','PipelinesRsc',
  function($scope, $resource, $routeParams, PipelinesRsc) {
    $scope.editData = false;

    PipelinesRsc.getPipe({Id: $routeParams.id})
      .$promise.then(function(data){
        $scope.pipeline = data;
        var pipeline_id = data.pipeline.id;

        StagesRsc.get({pipeline_id: pipeline_id}).$promise.then(function(data){
          // name
          // pipeline_location
          // description
          // stage id
          $scope.stages = data;
        });

        BoxesRsc.query({pipeline_id: pipeline_id}).$promise.then(function(data) {
          // contact_id
          // stage_id
          $scope.boxes = data;
        });



        FieldsRsc.query({pipeline_id: pipeline_id}).$promise.then(function(data){
          // field_name
          // field_type
          $scope.fields = data;
        });

        BoxFields.query({}).$promise.then(function(data) {

        });
    });

  }]);
