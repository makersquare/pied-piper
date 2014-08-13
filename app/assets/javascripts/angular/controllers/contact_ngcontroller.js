//this controller gives scope to the dom template "contacts.html" and adds
//functionality for manually adding contacts to the dom and db simultaneously
app.controller('ContactsCtrl',
  ['$scope', '$resource', 'ContactsRsc',
  function($scope, $resource, ContactsRsc) {
    $scope.buttonClicked = false;
    $scope.showContactForm = function(){
      $scope.buttonClicked = true;
    };
    $scope.hideContactForm = function(){
      $scope.buttonClicked = false;
    };
    $scope.contacts = ContactsRsc.query();
    $scope.newContact = {};
    $scope.addNewContact = function(){
      ContactsRsc.save($scope.newContact, function(contact) {
        $scope.contacts.unshift(contact);
        $scope.newContact = {};
      });
    };


  }]);
