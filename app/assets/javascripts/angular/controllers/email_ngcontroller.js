'use strict';

// app.controller('EmailCtrl', ['$scope', '$resource', '$http', '$location', '$routeParams',
//   function($scope, $resource, $http, $location, $routeParams) {
//     var EmailSettingsQuery = $resource('/users/:user_id/email_settings/:id', {id: '@id', user_id: '@user_id'});
//     $scope.emailSettings = [{user_id: 2, pipeline_name: "Career Services", setting: "Realtime", id: 5},
//                             {user_id: 2, pipeline_name: "Admissions", setting: "Dailydigest", id: 8}];
//     $scope.saveSettings = function () {
//       // emailSettingsQuery.update(emailSettings)
//       console.log($scope.emailSettings);
//     }
    // { 'get':       {method:'GET'},
    //   'update':    {method:'POST', params:{'@id'}} });

//  // $scope.emailSettings = emailSettingsQuery.query()

//  // $scope.items = [
//  //    { id: 1, name: 'Foo' },
//  //    { id: 2, name: 'Bar' }
//  //  ];

//  //  $scope.selectedItem = $scope.items[0];

// }]);

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

    // $scope.emailSettings = EmailSettingsQuery.query(
    //   {user_id: $routeParams.user_id}
    // )

    $scope.emailSettings = EmailSettingsQuery.get(
      {user_id: $routeParams.user_id}
    )

    // $scope.emailSettings = emailSettingsQuery.query()

    // EmailSettingsQuery.get({user_id: 2})

    // Update the settings by sending the 'update' request
    $scope.saveSettings = function(){
      console.log($scope.emailSettings)
      // var settings = EmailSettingsQuery.update(
        // {}
      // )
    }

  }]);
