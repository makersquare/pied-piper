//this controller gives scope to the dom template "contacts.html" and adds
//functionality for manually adding contacts to the dom and db simultaneously
'use strict';

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

    // An array of all the pipelines a contact is not in
    var setUnaddedPipelinesForContacts = function(contacts, pipelines) {
      _.each(contacts, function(contact) {
        var contactPipelineIds = _.map(contact.pipelines, function(pipeline) { return pipeline.id });
        var unaddedPipelines = _.reject(pipelines, function(pipeline) {
          return contactPipelineIds.indexOf(pipeline.id) >= 0;
        });
        contact.unaddedPipelines = unaddedPipelines;
        // console.log(unaddedPipelines);
      });
    }

    $scope.pipelines = PipelinesRsc.pipersc.query();
    $scope.contacts = ContactsRsc.query();
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
      setUnaddedPipelinesForContacts($scope.contacts, $scope. pipelines);
    });

    $scope.addContactToPipeline = function(pipeline, contact) {
      // console.log(pipeline);
      // console.log(contact);
      var data = {
        pipeline_id: pipeline.id,
        contact_id: contact.id
      };
      contact.pipelines.push(pipeline);
      var index = contact.unaddedPipelines.indexOf(pipeline);
      contact.unaddedPipelines.splice(index, 1);
      ContactsBoxRsc.save(data);
      console.log(data);
    }

    $scope.removeContactFromPipeline = function(pipeline, contact) {
      // console.log(pipeline);
      // console.log(contact);
      var data = {
        pipeline_id: pipeline.id,
        id: contact.id
      };
      var index = contact.pipelines.indexOf(pipeline);
      contact.pipelines.splice(index, 1);
      contact.unaddedPipelines.push(pipeline);
      ContactsBoxRsc.remove(data);
      console.log(data);
    }

  }]);
