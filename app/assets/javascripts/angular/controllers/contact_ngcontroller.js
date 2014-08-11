app.controller('ContactsCtrl',
  ['$scope', '$resource', 'ContactsRsc',
  function($scope, $resource, ContactsRsc) {
    $scope.contacts = ContactsRsc.query();
    console.log($scope.contacts);
    // Use $scope.contacts.id to GET pipelines
  }]);
