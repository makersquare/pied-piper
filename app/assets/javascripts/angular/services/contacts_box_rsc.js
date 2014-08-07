app.factory("ContactsBoxRsc", function ($resource) {
    return $resource(
        "/pipelines/:pid/contacts/:cid.json",
        {cid: '@cid', pid: '@pid'},
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
