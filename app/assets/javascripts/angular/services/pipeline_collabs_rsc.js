app.factory("PipelineCollabRsc", ['$resource', function ($resource) {
  return $resource(
      "/pipelines/:pipeline_id/users/:user_id.json",
      {pipeline_id: "@pipeline_id", user_id: "@user_id"},
      {
          'update':{
            method: 'PUT'
          }
      }
  );
}]);