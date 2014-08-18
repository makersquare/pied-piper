app.factory("ContactsBoxRsc", ['$resource', function ($resource) {
    return $resource(
        "/pipelines/:pipeline_id/contacts/:id.json",
        {pipeline_id: '@pipeline_id', id: '@id'},
        { update: { method: 'PUT'} }
    );
}]);
