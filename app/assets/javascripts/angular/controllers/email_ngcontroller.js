app.controller('EmailCtrl',
  ['$scope', '$resource', '$http',
  '$location', '$routeParams',
  function($scope, $resource, $http,
    $location, $routeParams) {

    // Define the rails path that will be hit by the http requests
    var EmailSettingsQuery = $resource('/users/:user_id/email_settings/:id.json',
      {user_id: '@user_id', id: '@id'},
      { get:       {method:'GET', isArray:true},
        update:    {method:'PUT'}
      }
    );

    // Get all pipeline settings by sending the 'get' request
    $scope.emailSettings = EmailSettingsQuery.get(
      {user_id: $routeParams.user_id}
    );

    // Update the settings by sending the 'update' request
    $scope.saveSettings = function(index, setting){
      EmailSettingsQuery.update(setting);
    };

}]);
