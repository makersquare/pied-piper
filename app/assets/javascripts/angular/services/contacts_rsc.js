app.factory("ContactsRsc", function ($resource) {
    return $resource(
        "/contacts/:id.json",
        {id: '@id'},
        {
          get: {
            method: 'GET'
          },
          update: {
            method: 'PUT'
            // params: $scope.cb
          }
        }
    );
});

// contacts = ContactRsc.query(); get /contacts
// contacts = []

// ContactRsc.get({id: 'blah'}) get /contacts/blah
// contact = ContactRsc.get({id: 'blah'}).$promise.then(function(data){
//   $scope.contact = data
// })
