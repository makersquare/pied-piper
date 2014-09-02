app.controller('SearchCtrl', ['$scope', '$location', 'Search',
  ($scope, $location, Search)->

    # Keep track of the Search service, and set watches on them
    # The search module will keep track of search results for us
    # We will update searchItem with the typed in key word
    $scope.Search = Search
    $scope.searchItem = Search.searchItem
    $scope.results = Search.results

    $scope.$watch('Search.searchItem',
      (newVal, oldVal, scope)->
        scope.searchItem = newVal
    )

    $scope.$watch('Search.results',
      (newVal, oldVal, scope)->
        scope.results = newVal
    )

    # This method will update what is being searched for.
    # It will also keep track of the page you were at before
    #   you searched
    $scope.search = ->
      if $location.path() isnt "/search"
        Search.lastPath = $location.path()
        $location.path("/search")
      else if $scope.searchItem is ""
        $location.path(Search.lastPath)
        return
      Search.searchItem = $scope.searchItem
      Search.updateResults()

    # These functions allow the user to redirect to a detailed
    #   page about the search result
    $scope.pipelinePath = (result)->
      $location.path("/pipeline/" + result.id)

    $scope.stagePath = (result)->
      $location.path("/pipeline/" + result.pipeline_id)

    $scope.contactPath = (result)->
      $location.path("/contacts/" + result.id)

    $scope.fieldPath = (result)->
      $location.path("/pipeline/" + result.pipeline_id)

    $scope.boxPath = (result)->
      $location.path("/pipeline/" + result.pipeline.id + "/contact/" + result.contact.id)
  ]
)



