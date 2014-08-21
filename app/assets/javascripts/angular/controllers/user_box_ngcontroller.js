app.controller('UserBoxCtrl',
  ['$scope', '$resource', '$http', '$location', '$routeParams', 'BoxService',
  function($scope, $resource, $http, $location, $routeParams, BoxService) {

    $scope.cb = null;

    $scope.stageContacts = BoxService.stageContacts;
    $scope.BoxService = BoxService;

    // Define the rails path that will be hit by the http requests
    var ContactBoxRsc = $resource('/pipelines/:pid/contacts/:cid.json',
      {cid: '@cid', pid: '@pid'},
      {
       get: {method: 'GET'},
       update: { method: 'PUT', params: $scope.cb}
        }
      );

    // Send 'get' request
    ContactBoxRsc.get(
      {cid: $routeParams.cid,
        pid: $routeParams.pid
      })
      .$promise.then(function(cb){
        $scope.cb = cb;
        fields_info = [];
        angular.forEach(cb.fields, function(field){
          angular.forEach(cb.field_values,function(value){
            if(field.id === value.field_id){
              fields_info.push({field: field,
                field_value: value});
            };
          });
        });
        $scope.fields_info =fields_info;
        $scope.cb.contact.contact_id = $routeParams.cid;
        $scope.cb.cid = $routeParams.cid;
        $scope.cb.pid = $routeParams.pid;
        $scope.cb.contact_id = $routeParams.cid;
        console.log($scope.cb)

        // $scope.$watch('newNote', function(v){
        //   $scope.updateEntry();
        //   });
      });

  $scope.keyup = function(event, cb) {
    if (event.keyCode == 13) {
      cb.showEdit = !cb.showEdit;
      ContactBoxRsc.update($scope.cb);
    }
  };

  // Update the entry by sending the 'update' request
  $scope.updateEntry = function(){
    entry = ContactBoxRsc.update(
      $scope.cb);
  };
}]);

app.controller('ToggleCtrl', ['$scope', function($scope) {
  $scope.linkItems = {
    "All": "http://google.com",
    "Unread": "http://google.com",
    "Important": "http://google.com",
  };
  $scope.show_email = false;
}]);

app.controller('ToggleDoubleCtrl', ['$scope', function($scope) {
  $scope.show = false;
  $scope.show2 = false;
}]);

app.controller('EmailShowCtrl',['$scope', '$resource', '$http',
  '$location', '$routeParams', function($scope, $resource, $http,
    $location, $routeParams){

    $scope.messages=null;

  var EmailRetrieveRsc = $resource('/contextio/email/:id.json',
      {id: '@id'},
      {
       get: {method: 'GET'},
        }
      );

  EmailRetrieveRsc.get({id: $routeParams.cid})
  .$promise.then(function(messages){
  $scope.messages = messages});
}]);


app.controller('AccordionDemoCtrl',['$scope', function($scope) {
  $scope.oneAtATime = true;

  $scope.addItem = function() {
    var newItemNo = $scope.items.length + 1;
    $scope.items.push('Item ' + newItemNo);
  };

  $scope.status = {
    isFirstOpen: true,
    isFirstDisabled: false
  };
}]);

