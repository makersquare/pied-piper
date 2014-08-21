app.directive('bsActiveLink', ['$location', function($location) {
  return {
    restrict: 'A', //use as attribute
    replace: false,
    link: function(scope, elem) {
        //after the route has changed
        scope.$on("$routeChangeSuccess", function () {
            var selectors = ['li > [href="#' + $location.path() + '"]',
                             'li > [href="/#' + $location.path() + '"]', //html5: false
                             'li > [href="' + $location.path() + '"]']; //html5: true
            // FIXME: Because foundation uses nested uls in the navbar we need to account for this
            //find the matching link
            $(elem).find(selectors.join(','))
            //add active class to the matching element
            .parent('li').addClass('active')
            //remove it from the sibling elements
            .siblings('li').removeClass('active');
        });
     }
  };
}]);
