app.factory("PipelineCollabRsc", function ($resource) {
  return $resource(
      "/pipelines/:id/users/:user_id.json",
      {id: "@id", user_id: "@user_id"},
      {
          'update':{
            method: 'PUT'
          }
      }
  );
});

//These methods aren't needed as they are built into angular
