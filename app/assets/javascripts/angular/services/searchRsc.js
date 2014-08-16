app.factory("Search", ['$resource',
  function($resource) {
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