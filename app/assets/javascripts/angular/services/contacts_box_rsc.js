app.factory("ContactsBoxRsc", function ($resource) {
    return $resource(
        "/pipelines/:pipeline_id/contacts/:id.json",
        {pipeline_id: '@pipeline_id', id: '@id'},
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
