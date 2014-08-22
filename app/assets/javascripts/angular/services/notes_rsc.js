app.factory('NotesRsc', function($resource) {
  return $resource('/pipelines/:pipeline_id/contacts/:contact_id/notes/:id.json', {
    pipeline_id: '@pipeline_id', contact_id: '@contact_id', id: '@id'},
    {update: { method: 'PUT' }}
  );
});