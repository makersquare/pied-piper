app.factory("PipelineCollabRsc", ['$resource', function ($resource) {
  return $resource(
      "/pipelines/:id/users/:user_id.json",
      {pipeline_id: "@id", user_id: "@user_id"},
      {
          'update':{
            method: 'PUT'
          }
      }
  );
}]);