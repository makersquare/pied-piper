// This controller gives scope to the dom template "contacts.html" and adds
// functionality for manually adding contacts to the dom and db simultaneously.
// It also contains the logic for adding/removing a contact to/from a pipeline.

app.controller('ContactsCtrl',
  ['$scope', '$resource', 'ContactsRsc', 'PipelinesRsc', 'ContactsBoxRsc',
  function($scope, $resource, ContactsRsc, PipelinesRsc, ContactsBoxRsc) {
    $scope.buttonClicked = false;
    $scope.showContactForm = function(){
      $scope.buttonClicked = true;
    };
    $scope.hideContactForm = function(){
      $scope.buttonClicked = false;
    };

    // This function finds all the pipelines a contact is NOT in and
    // outputs the result to an array.
    var setUnaddedPipelinesForContacts = function(contacts, pipelines) {
      _.each(contacts, function(contact) {
        var contactPipelineIds = _.map(contact.pipelines, function(pipeline) { return pipeline.id; });
        var unaddedPipelines = _.reject(pipelines, function(pipeline) {
          return contactPipelineIds.indexOf(pipeline.id) >= 0;
        });
        contact.unaddedPipelines = unaddedPipelines;
      });
    };

    $scope.pipelines = PipelinesRsc.query();
    $scope.contacts = ContactsRsc.query();
    console.log($scope.contacts)
    $scope.newContact = {};

    $scope.addNewContact = function(){
      ContactsRsc.save($scope.newContact, function(contact) {
        $scope.contacts.unshift(contact);
        $scope.newContact = {};
      });
    };

    $scope.pipelines.$promise.then(function(result) {
      $scope.pipelines = result;
      return $scope.contacts.$promise;
    }).then(function(result) {
      $scope.contacts = result;
      setUnaddedPipelinesForContacts($scope.contacts, $scope.pipelines);
    });

    $scope.addContactToPipeline = function(pipeline, contact) {
      contact.pipelines.push(pipeline);
      var index = contact.unaddedPipelines.indexOf(pipeline);
      contact.unaddedPipelines.splice(index, 1);
      var data = {
        pipeline_id: pipeline.id,
        contact_id: contact.id
      };
      ContactsBoxRsc.save(data);
    };

    $scope.removeContactFromPipeline = function(pipeline, contact) {
      var index = contact.pipelines.indexOf(pipeline);
      contact.pipelines.splice(index, 1);
      contact.unaddedPipelines.push(pipeline);
      var data = {
        pipeline_id: pipeline.id,
        id: contact.id
      };
      ContactsBoxRsc.remove(data);
    };

  }]);
