app.controller('PayCtrl',
  ['$routeParams', '$scope', '$http', '$modal', '$log',
  ($routeParams, $scope, $http, $modal, $log)->
    $scope.payload = {}
    $scope.data = {}
    $scope.type = null

    $scope.payCard = ->
      $scope.type = 'cedit'
      balanced.card.create($scope.payload, $scope.handleResponse)

    $scope.payBank = ->
      $scope.type = 'bank'
      balanced.bankAccount.create($scope.payload, $scope.handleResponse)


    $scope.handleResponse = (response)->
      if response.status_code is 201
        fundingInstrument =
          if response.cards isnt null
            response.cards[0]
          else
            response.bank_accounts[0]

        $http.post("/payments/credit",
          uri: fundingInstrument.href
          email: $scope.data.email
          type: $scope.type,
          (r)->
            if r.status is 201
              console.log(r)
            else
              console.log('failure')
        )
      else
        console.log('failure')
  ]
)
