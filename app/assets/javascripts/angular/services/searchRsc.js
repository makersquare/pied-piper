app.factory("Search", ['$resource',
  function($resource) {
    // Returns an object that keeps track of the search term,
    //   the results, and a resource that can make the HTTP
    //   request. updateResults grabs the new results
    return {
      searchItem: "",
      SearchRsc: $resource('/search'),
      results: {},
      updateResults: function(){
        this.results = this.SearchRsc.get({query: this.searchItem});
      }
    }
  }
])
