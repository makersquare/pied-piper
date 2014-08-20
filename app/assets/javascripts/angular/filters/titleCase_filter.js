// this function can be used to titleCase a normal string as well without underscores
app.filter('titleCase', function(){
  return function(input){
    result = '';
    // this might seem unnecessary but it allows us to sanitize underscores prior to the
    // desired result effect being applied.  The first replace might not even apply but it wont
    // have an ill effect.
    input.replace(/_/g," ").replace(/\w\S*/g,
      function(str){
        result += " " + str.charAt(0).toUpperCase() + str.substr(1).toLowerCase();
      });
    return result.trim();
  };
});
