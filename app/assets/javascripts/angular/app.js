// This is the main Angular application page.
// The Config function is run before the injector and before the RUN function
//  The run function is run after the config function.
//  An example of this is the config provides a route while the run function
// provides user authentication for the routes.
var app = angular.module('crmApp', ['ngResource', 'ngRoute'])

// Inject necessary dependencies inside of this function below
.config(['$routeProvider',function($routeProvider){
// constants first

//providers second
  $routeProvider.when('/test/:name', {
    // when using url parameters, to access them in the controller we
    // must, in the controller, inject the dependency $routeParams
    templateUrl: './templates/test.html',
    controller: 'PipelineCtrl',
    // there is a third necessary option here
    // resolve sends the http request and fills the data field
    // the data field is then injected into the controller and accessible there
    resolve: {
      'data':['$http', function($http){
        return $http.get('/api').then(
          function success(resp){return resp.data;},
          function error(reason){return false;}
          );
      }]
    }
  });



}])

.run(function(){
// User authentication should go here
// When the angular route is changed the ng event
// $routeChangeSuccess OR $routeChanseError is fired
  console.log("route changed");


});
