app.controller('ContactBoxCtrl',
  ['$scope', '$resource', '$http',
  '$location', '$routeParams',
  function($scope, $resource, $http,
    $location, $routeParams) {

    $scope.cb = null;

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
        $scope.cb = cb.table;
        $scope.cb.contact.contact_id = $routeParams.cid;
        $scope.cb.cid = $routeParams.cid;
        $scope.cb.pid = $routeParams.pid;
        $scope.cb.contact_id = $routeParams.cid;
        console.log($scope.cb);
      });

// Update the entry by sending the 'update' request
    $scope.updateEntry = function(){
      // console.log($scope.results)
      console.log('updating...');
      console.log($scope.cb);
      entry = ContactBoxRsc.update(
        $scope.cb);
      console.log(entry);
      // $scope.results.push(entry);
      // $scope.newEntry = {};
    };

}]);
