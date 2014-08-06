app.factory('BoxesAPI', function($resource) {
  return $resource('/pipelines/:pipeline_id/fields/:id.json', { pipeline_id: '@pipeline_id', field_id: "@id"}, {
    update: {
      method: 'PUT' // this method issues a PUT request
    }
  });
});

app.directive('deletefield', function(BoxesAPI, $routeParams) {
  return function(scope, element) {
    element.bind('click', function(e){
      e.preventDefault();
      BoxesAPI.remove({pipeline_id: $routeParams['pipeline_id'], id: this.dataset.id}, element, function(element) {
        scope.fields.splice(element.context.dataset.index, 1);
      });
    })
  }
});

app.controller('CreateFieldsCtrl', function($routeParams, $scope, $http, BoxesAPI) {
  $scope.fields = BoxesAPI.query({pipeline_id: $routeParams['pipeline_id']});
  $scope.fieldName = "";

  $scope.addField = function() {
    $scope.field = new BoxesAPI();
    $scope.field.$save({pipeline_id: $routeParams['pipeline_id'], field_name: $scope.fieldName, field_type: 'string'}, function(data) {
      $scope.fields.push({field_name: $scope.fieldName, id: data.id});
      $scope.fieldName = "";
    });
  }
});


