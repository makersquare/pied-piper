app.filter('uppercase', function() {
  return function(input) {
    if (input!=null)
      return input.toUpperCase();
  }
});
