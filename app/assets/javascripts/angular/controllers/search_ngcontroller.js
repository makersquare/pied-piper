app.controller('SearchCtrl', ['$scope', '$location', 'Search',
  function($scope, $location, Search){
    $scope.Search = Search;
    $scope.searchItem = Search.searchItem;
    $scope.results = Search.results;

    $scope.search = function() {
      if ($scope.searchItem == "") {
        $location.path(Search.lastPath);
        return;
      } else if ($location.path() != "/search") {
        Search.lastPath = $location.path();
        $location.path("/search");
      }

      Search.searchItem = $scope.searchItem;

      Search.updateResults();
    };

    $scope.pipelinePath = function(result) {
      $location.path("/pipeline/" + result.id);
    };

    $scope.stagePath = function(result) {
      $location.path("/pipeline/" + result.pipeline_id);
    };

    $scope.contactPath = function(result) {
      $location.path("/contacts/" + result.id);
    };

    $scope.fieldPath = function(result) {
      $location.path("/pipeline/" + result.pipeline_id);
    };

    $scope.boxPath = function(result) {
      $location.path("/pipeline/" + result.pipeline.id + "/contact/" + result.contact.id);
    };

    $scope.$watch('Search.searchItem', function(newVal, oldVal, scope){
      scope.searchItem = newVal;
    });

    $scope.$watch('Search.results', function(newVal, oldVal, scope) {
      scope.results = newVal;
    })
  }
])