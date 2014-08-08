app.controller('ContactsCtrl',
  ['$scope', '$resource', 'ContactsRsc',
  function($scope, $resource, ContactsRsc) {
    $scope.contacts = ContactsRsc.query();
  }]);
