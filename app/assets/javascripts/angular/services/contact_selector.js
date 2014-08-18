// This service allows the selection, and deselection
// of multiple contacts. It also allows you to send
// emails to selected contacts.
app.factory("ContactSelector", ['$resource', function ($resource) {
  return {
    selected: {},

    contacts: {},

    markAll: function(contacts, value) {
      for (var i = 0; i < contacts.length; i++) {
        var contact = contacts[i];
        this.selected[contact.id] = value;
        this.contacts[contact.id] = contact;
      }
    },

    selectAll: function(contacts) {
      this.markAll(contacts, true);
    },

    deselectAll: function(contacts) {
      this.markAll(contacts, false);
    },

    sendEmail: function () {
      var recepientList = ""
      for (var id in this.selected) {
        if (this.selected[id]) {
          var contact = this.contacts[id]
          recepientList += contact.email + "; ";
        }
      }

      this.sendGmail(recepientList);
    },

    sendGmail: function (recepients) {
      var link = "http://mail.google.com/mail/?view=cm&fs=1" +
        "&bcc=" + recepients;
      window.open(link, '_blank');
    }
  }
}]);
