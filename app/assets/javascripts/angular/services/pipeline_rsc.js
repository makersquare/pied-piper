app.factory("PipelinesRsc", ['$resource', function ($resource) {
    return $resource(
        "/pipelines/:id.json",
        {id: "@id"}
    );
}]);
