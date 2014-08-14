app.controller('PayCtrl', function($routeParams, $scope, $http, $modal, $log) {
  $scope.payload = {};
  $scope.data = {};

  $scope.payCard = function() {
    balanced.card.create($scope.payload, $scope.handleResponse);
  }

  $scope.payBank = function() {
    balanced.bankAccount.create($scope.payload, $scope.handleResponse);
  }

  $scope.handleResponse = function(response) {
    console.log(response);
    if (response.status_code === 201) {
      var fundingInstrument = response.cards != null ? response.cards[0] : response.bank_accounts[0];
      $http.post("/payments/credit", {uri: fundingInstrument.href, email: $scope.data.email},
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
});
