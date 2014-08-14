app.factory("StagesRsc", ['$resource', function ($resource) {
    return $resource(
        "/pipelines/:pipeline_id/stages/:id.json",
        {pipeline_id: "@pipeline_id", id: "@id" }
    );
}]);
