'use strict';

app.controller('EmailCtrl', ['$scope', '$resource', '$http', '$location', '$routeParams',
  function($scope, $resource, $http, $location, $routeParams) {

    // $scope.emailSettings = [{user_id: 2, pipeline_name: "Career Services", setting: "Realtime", id: 5},
    //                         {user_id: 2, pipeline_name: "Admissions", setting: "Dailydigest", id: 8}];

// Define the rails path that will be hit by the http requests
    var EmailSettingsQuery = $resource('/users/:user_id/email_settings/:id.json', {user_id: '@user_id'},
      { get:       {method:'GET', isArray:true},
        query:     {method:'GET'},
        update:    {method:'POST'}
      }
    );

    $scope.emailSettings = EmailSettingsQuery.get(
      {user_id: $routeParams.user_id}
    )

    // Update the settings by sending the 'update' request
    $scope.saveSettings = function(){
      console.log($scope.emailSettings)
      // var settings = EmailSettingsQuery.update(
        // {}
      // )
    }

  }]);
