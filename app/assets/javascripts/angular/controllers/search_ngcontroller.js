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

    $scope.$watch('Search.searchItem', function(newVal, oldVal, scope){
      scope.searchItem = newVal;
    });

    $scope.$watch('Search.results', function(newVal, oldVal, scope) {
      scope.results = newVal;
    })
  }
])