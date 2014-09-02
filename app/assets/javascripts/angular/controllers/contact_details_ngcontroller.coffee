# This controller gives scope to the dom template "contacts.html" and adds
# functionality for manually adding contacts to the dom and db simultaneously.
# It also contains the logic for adding/removing a contact to/from a pipeline.

app.controller('ContactDetailsCtrl',
  ['$scope', '$resource', 'ContactsRsc', 'PipelinesRsc', 'ContactsBoxRsc',
  ($scope, $resource, ContactsRsc, PipelinesRsc, ContactsBoxRsc) ->
    $scope.buttonClicked = false
    $scope.showContactForm = ->
      $scope.buttonClicked = true
    $scope.hideContactForm = ->
      $scope.buttonClicked = false

    # This function finds all the pipelines a contact is NOT in and
    # outputs the result to an array.
    setUnaddedPipelinesForContacts = (contacts, pipelines) ->
      _.each(contacts,
        (contact) ->
          contactPipelineIds = _.map(contact.pipelines,
            (pipeline) ->
              return pipeline.id)
          unaddedPipelines = _.reject(pipelines,
            (pipeline)->
              return contactPipelineIds.indexOf(pipeline.id) >= 0
        )
        contact.unaddedPipelines = unaddedPipelines
      )


    $scope.pipelines = PipelinesRsc.query()
    $scope.contacts = ContactsRsc.query()
    $scope.newContact = {}

    $scope.addNewContact = ->
      ContactsRsc.save($scope.newContact,
        (contact)->
          $scope.contacts.unshift(contact)
          setUnaddedPipelinesForContacts($scope.contacts, $scope.pipelines)
          $scope.newContact = {}
        )

    $scope.pipelines.$promise.then(
      (result) ->
        $scope.pipelines = result
        return $scope.contacts.$promise
      )
    .then(
      (result)->
        $scope.contacts = result
        setUnaddedPipelinesForContacts($scope.contacts, $scope.pipelines)
    )

    $scope.addContactToPipeline = (pipeline, contact)->
      contact.pipelines.push(pipeline)
      index = contact.unaddedPipelines.indexOf(pipeline)
      contact.unaddedPipelines.splice(index, 1)
      data =
        pipeline_id: pipeline.id,
        contact_id: contact.id

      ContactsBoxRsc.save(data)


    $scope.removeContactFromPipeline = (pipeline, contact)->
      index = contact.pipelines.indexOf(pipeline)
      contact.pipelines.splice(index, 1)
      contact.unaddedPipelines.push(pipeline)
      data =
        pipeline_id: pipeline.id,
        id: contact.id
      ContactsBoxRsc.remove(data)
  ]
)
