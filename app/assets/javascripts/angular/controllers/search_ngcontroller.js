app.controller('SearchCtrl', ['$scope', '$location', 'Search',
  function($scope, $location, Search){

    // Keep track of the Search service, and set watches on them
    // The search module will keep track of search results for us
    // We will update searchItem with the typed in key word
    $scope.Search = Search;
    $scope.searchItem = Search.searchItem;
    $scope.results = Search.results;

    $scope.$watch('Search.searchItem', function(newVal, oldVal, scope){
      scope.searchItem = newVal;
    });

    $scope.$watch('Search.results', function(newVal, oldVal, scope) {
      scope.results = newVal;
    })

    // This method will update what is being searched for.
    // It will also keep track of the page you were at before
    //   you searched
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

    // These functions allow the user to redirect to a detailed
    //   page about the search result
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
  }
])