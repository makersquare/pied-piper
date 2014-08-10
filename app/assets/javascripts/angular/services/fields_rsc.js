app.factory("FieldsRsc", function ($resource) {
    return $resource(
        "/pipelines/:pipeline_id/fields/:id.json",
        {pipeline_id: "@pipeline_id", id: "@id" }
    );
});
