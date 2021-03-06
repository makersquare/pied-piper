app.controller('PayCtrl',
  ['$routeParams', '$scope', '$http', '$modal', '$log',
  function($routeParams, $scope, $http, $modal, $log) {
  $scope.payload = {};
  $scope.data = {};
  $scope.type = null;

  $scope.payCard = function() {
    $scope.type = 'cedit';
    balanced.card.create($scope.payload, $scope.handleResponse);
  }

  $scope.payBank = function() {
    $scope.type = 'bank';
    balanced.bankAccount.create($scope.payload, $scope.handleResponse);
  }

  $scope.handleResponse = function(response) {
    console.log(response);
    if (response.status_code === 201) {
      var fundingInstrument = response.cards != null ? response.cards[0] : response.bank_accounts[0];
      $http.post("/payments/credit", {uri: fundingInstrument.href, email: $scope.data.email, type: $scope.type},
        function(r) {
          if (r.status === 201) {
            console.log(r)
          } else {
            console.log('failure')
          }
        });
    } else {
      console.log('failure');
    }
  }
}]);
