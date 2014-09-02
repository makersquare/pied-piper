app.controller('PipelineDetailsCtrl',
  ['$scope', '$routeParams', 'PipelineService', 'BoxService',
  ($scope, $routeParams, PipelineService, BoxService)->
    pipelineId = $scope.pipeline_id = $routeParams.id
    # /*
    #  * Use BoxService to grab all Boxes
    #  * and allow selection, updates, and more
    #  * We'll be watching the contacts through
    #  * broadcasts
    #  */
    $scope.showContact =false
    $scope.changeContact = (event, contact_id)->
      BoxService.ContactsBoxRsc.get(
        pipeline_id: $routeParams.id
        id: contact_id).$promise.then(
          (cb)->
            $scope.cb = cb
            fields_info = []
            angular.forEach(cb.fields,
              (field)->
                angular.forEach(cb.field_values,
                (value)->
                  if field.id is value.field_id
                    fields_info.push(
                      field: field
                      field_value: value
                    )
                )
            )
            $scope.fields_info =fields_info
            $scope.cb.contact.contact_id = $routeParams.id
            $scope.cb.cid = $routeParams.id
            $scope.cb.pid = $routeParams.pipeline_id
            $scope.cb.contact_id = $routeParams.id

        # // $scope.$watch('newNote', function(v){
        # //   $scope.updateEntry()
        # //   })
        )
      $scope.showContactInfo = ->
        if $scope.showContact is true
          $scope.showContact = !$scope.showContact
          $scope.showContact = !$scope.showContact

        else
          $scope.showContact = !$scope.showContact

        $scope.hideContactInfo =->
          $scope.showContact = false

        $scope.keyup = (event, cb)->
          if event.keyCode is 13
            cb.showEdit = !cb.showEdit
            BoxService.ContactsBoxRsc.update($scope.cb)

      # // Update the entry by sending the 'update' request
        $scope.updateEntry = ->
          BoxService.ContactsBoxRsc.update($scope.cb)


      $scope.BoxService = BoxService
      BoxService.setUp($routeParams.id)
      $scope.stageContacts = BoxService.stageContacts
      $scope.stageSelection = BoxService.stageSelection
      $scope.allContactsSelection = BoxService.allContactsSelection

      $scope.$on("stageContacts:updated",
        (event, data, id)->
          $scope.stageContacts = data
      )

      $scope.$on("allContactsSelection:updated",
        (event, data)->
          $scope.allContactsSelection = data
      )

      $scope.$on("stageSelection:updated",
        (event, data)->
          $scope.stageSelection = data
      )

      $scope.updateBoxOnEnter = (event, contact) ->
        if event.keyCode is 13
          BoxService.updateBox(contact)


    # /*
    #  * Grabs information related to the pipeline including
    #  * stages, fields, pipeline name, and basicFields
    #  */
      $scope.PipelineService = PipelineService
      $scope.pipeline = PipelineService.pipeline(pipelineId)
      $scope.fields = PipelineService.fields(pipelineId)
      $scope.stages = PipelineService.stages(pipelineId)
      $scope.basicFields = PipelineService.basicFields
      $scope.notes = PipelineService.notes

      $scope.$on('pipeline:updated',
        (event, data)->
          $scope.pipeline = data
      )
  ]
)

app.controller('ToggleCtrl', ['$scope',
  ($scope) ->
    $scope.linkItems =
      "All": "http://google.com"
      "Unread": "http://google.com"
      "Important": "http://google.com"
    $scope.show_email = false
])

app.controller('ToggleDoubleCtrl', ['$scope',
  ($scope)->
    $scope.show = false
    $scope.show2 = false
])

app.controller('EmailShowCtrl',['$scope', '$resource', '$http',
  '$location', '$routeParams',
  ($scope, $resource, $http, $location, $routeParams)->
    $scope.messages=null

    EmailRetrieveRsc = $resource('/contextio/email/:id.json',
      id: '@id',
      get:
        method: 'GET'
    )

    EmailRetrieveRsc.get(id: $routeParams.cid)
    .$promise.then(
      (messages)->
      $scope.messages = messages
    )
])


app.controller('AccordionDemoCtrl',['$scope',
  ($scope)->
    $scope.oneAtATime = true

    $scope.addItem = ->
      newItemNo = $scope.items.length + 1
      $scope.items.push('Item ' + newItemNo)

    $scope.status =
      isFirstOpen: true
      isFirstDisabled: false
])
