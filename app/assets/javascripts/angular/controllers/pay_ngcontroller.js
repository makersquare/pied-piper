app.controller('PayCtrl', function($routeParams, $scope, $http, $modal, $log) {
    console.log('we be paying');
    $scope.tabs = [
      { title:"Dynamic Title 1", content:"Dynamic content 1" },
      { title:"Dynamic Title 2", content:"Dynamic content 2" }
    ];

    $scope.open = function () {

      var modalInstance = $modal.open({
        templateUrl: 'myModalContent.html',
        controller: 'ModalInstanceCtrl',
        resolve: {
          items: function () {
            return $scope.items;
          }
        }
      });
    $('.reveal-modal').css('max-height', $('html').height() - 110 + 'px');
    }
});


