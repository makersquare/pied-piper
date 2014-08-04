app.controller('ContactBoxCtrl', ['$scope', '$resource', '$routeParams',
  function($scope, $resource, $routeParams) {
    console.log("controller hit");

    var ContactBox = $resource("/pipelines/:pid/contacts/:cid.to_json", {pid: $routeParams.pid, cid: $routeParams.cid}, {update: {method: "GET"}});
    var results = ContactBox.query;

  }]);
