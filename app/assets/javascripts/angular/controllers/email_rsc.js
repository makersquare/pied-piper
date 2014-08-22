app.factory('EmailsRsc', function($resource) {
  return $resource(
    '/contextio/email/:id.json',
    {id: '@id'}
  )
});