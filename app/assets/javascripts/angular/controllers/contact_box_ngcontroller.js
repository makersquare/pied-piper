app.controller('ContactBoxCtrl', ['$scope', '$resource', '$http', '$location', '$routeParams',
  function($scope, $resource, $http, $location, $routeParams) {
    console.log("controller hit");
    $scope.cb = null;
    $scope.updateInfo = {name: ''}; // ?

// Define the rails path that will be hit by the http requests
    var ContactBoxRsc = $resource('/pipelines/:pid/contacts/:cid.json',
      {cid: '@cid', pid: '@pid'},
      {
       get: {method: 'GET'},
       update: { method: 'PUT'}
        }
      );

// Send 'get' request
    ContactBoxRsc.get(
      {cid: $routeParams.cid,
        pid: $routeParams.pid
      })
      .$promise.then(function(cb){
        console.log(cb.table);
        $scope.cb = cb.table;
      })

// Update the entry by sending the 'update' request
    $scope.updateEntry = function(){
      console.log($scope.results)
      console.log('updating...')
      entry = ContactBoxRsc.update(
        {cid: $routeParams.cid,
        pid: $routeParams.pid
        },$scope.newEntry)
      console.log(entry)
      // $scope.results.push(entry);
      $scope.newEntry = {};
    }

  }]);
