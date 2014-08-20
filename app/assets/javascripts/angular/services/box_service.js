/*
 * BoxService allows you to perform all logic related to
 * Boxes. In particular you can:
 * - Get all contacts related to a pipeline
 * - Group them by stages by default
 * - You can select multiple contacts
 * - You can email the selected contacts
 * - You can edit and update Boxes
 * - You can change stages for contacts
 * Upon updates, this service broadcasts to
 *   stageContacts, allContactsSelection, and
 *   stageSelection
 */

app.factory("BoxService", ["$resource", "ContactsBoxRsc", "$rootScope",
  function ($resource, ContactsBoxRsc, $rootScope) {
    var pipelineId, contacts, stageContacts, stageSelection,
      allContactsSelection;

    // By default group all contacts by stages
    var setUp = function(pipeline_id) {
      pipelineId = pipeline_id;
      stageContacts = {};
      stageSelection = {};
      contacts = ContactsBoxRsc.query({pipeline_id: pipelineId});
      contacts.$promise.then(groupByStages);
      allContactsSelection = false;
    };

    var groupByStages = function(contacts) {
      stageContacts = {};
      for (var contactIndex = 0; contactIndex < contacts.length; contactIndex++) {
        var contact = contacts[contactIndex];
        var contactStageId = contact.stage_id;
        if (!stageContacts[contactStageId]) {
          stageContacts[contactStageId] = [];
        }
        stageContacts[contactStageId].push(contact);
      };

      $rootScope.$broadcast('stageContacts:updated', stageContacts);
    };

    var markAll = function(contacts, value) {
      for (var i = 0; i < contacts.length; i++) {
        var contact = contacts[i];
        contact.selected = value;
      }
    };

    var selectAll = function(contacts) {
      markAll(contacts, true);
    };

    var deselectAll = function(contacts) {
      markAll(contacts, false);
    };

    var toggleAllContactSelection = function() {
      allContactsSelection = !allContactsSelection;
      markAll(contacts, allContactsSelection);
      $rootScope.$broadcast('allContactsSelection:updated', allContactsSelection);
    };

    var toggleStageSelection = function(stage) {
      stageSelection[stage.id] = !stageSelection[stage.id];
      markAll(stageContacts[stage.id], stageSelection[stage.id]);
      $rootScope.$broadcast('stageSelection:updated', stageSelection);
    };

    var changeStage = function(contact, stage) {
      var currentStageId = contact.stage_id;
      var contactIndex = stageContacts[currentStageId].indexOf(contact);
      stageContacts[currentStageId].splice(contactIndex, 1);
      stageContacts[stage.id].push(contact);
      contact.stage_id = stage.id;

      ContactsBoxRsc.update({id: contact.id, pipeline_id:
        pipelineId, contact: contact, stage_id: contact.stage_id});

      $rootScope.$broadcast('stageContacts:updated', stageContacts);
    };

    var toggleEditable = function(contact) {
      contact.showEdit = !contact.showEdit;
    };

    var sendEmailToSelected = function() {
      var recipients = "";

      for (var index in contacts) {
        var contact = contacts[index]
        if (contact.selected) {
          recipients += contact.email + "; ";
        }
      }

      var link = "http://mail.google.com/mail/?view=cm&fs=1" +
        "&bcc=" + recipients;
      window.open(link, '_blank');
    };

    var updateBox = function(contact) {
      contact.showEdit = !contact.showEdit;
      ContactsBoxRsc.update({pipeline_id: pipelineId, id: contact.id, contact: contact});
    };

    var test = function() {
      return true;
    };

    return {
      test: test,
      contacts: contacts,
      stageContacts: stageContacts,
      setUp: setUp,
      toggleAllContactSelection: toggleAllContactSelection,
      toggleStageSelection: toggleStageSelection,
      updateBox: updateBox,
      changeStage: changeStage,
      stageSelection: stageSelection,
      toggleEditable: toggleEditable,
      sendEmailToSelected: sendEmailToSelected
    };
}]);
