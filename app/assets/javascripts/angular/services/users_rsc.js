app.factory("UsersRsc", ['$resource', function ($resource) {
  return $resource(
      "/users/:user_id.json",
      {user_id: "@user_id"}
  );
}]);