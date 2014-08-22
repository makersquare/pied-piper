app.factory("SingleBoxService", ["$resource", "ContactsBoxRsc", "$rootScope", "NotesRsc", "EmailsRsc",
  function ($resource, ContactsBoxRsc, $rootScope, NotesRsc, EmailsRsc) {
    var showBoxPanel = false;

    var retrieveBox = function(contact_id, pipeline_id) {
      this.showBoxPanel = true;

      var box = ContactsBoxRsc.get({pipeline_id: pipeline_id, id: contact_id});
      box.$promise.then(formatBox);
      return box;
    };

    var retrieveNotes = function(contact_id, pipeline_id) {
      return NotesRsc.query({contact_id: contact_id, pipeline_id: pipeline_id});
    }

    var retrieveEmails = function(contact_id) {
      return EmailsRsc.get({id: contact_id})
    }

    // After retrieving Box information, this function
    // gathers BoxField names and values into fields_info
    // as key/value pairs, and add it as a property
    var formatBox = function(box){
      var fields_info = [];
      angular.forEach(box.fields, function(field){
        angular.forEach(box.field_values,function(value){
          if(field.id === value.field_id){
            fields_info.push({field: field,
              field_value: value});
          }
        });
      });

      box.fields_info = fields_info
      return box;
    };

    var hideBox = function() {
      this.showBox = false;
    }

    return {
      showBoxPanel: showBoxPanel,
      retrieveBox: retrieveBox,
      hideBox: hideBox,
      retrieveNotes: retrieveNotes,
      retrieveEmails: retrieveEmails
    }
  }
]);