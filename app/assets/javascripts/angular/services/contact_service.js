app.factory("ContactService", ["$resource", "$rootScope", "ContactsBoxRsc",
  function ($resource, $rootScope, ContactsBoxRsc) {
    var cb, toggleShowEdit, updateEntry;
//var pipeline, basicFields, otherFields, stages, pipelineId;

//     var setUp = function(pipeline_id) {
//       pipelineId = pipeline_id;
//       pipeline = PipelinesRsc.get({id: pipelineId})
//         .$promise.then(function(data) {
//           $rootScope.$broadcast('pipeline:updated', data);
//         });
//       basicFields = [{field_name: "name"}, {field_name: "email"}];
//       // otherFields = FieldsRsc.query({pipeline_id: pipelineId})
//       //   .$promise.then(function(data) {
//       //     $rootScope.$broadcast('fields:updated', fields())
//       // });
//       stages = StagesRsc.get({pipeline_id: pipelineId})
//         .$promise.then(function(data){
//           $rootScope.$broadcast('stages:updated', data);
//       });
//     };
    var toggleShowEdit = function() {
      cb.showEdit=!cb.showEdit;
    }

    var updateEntry = function(contactBox) {
      contactBox = !contactBox;
      ContactsBoxRsc.update(contactBox)
    }

//     var fields = function() {
//       return basicFields + []; //otherFields;
//     };

    return {
      cb: cb,
      toggleShowEdit: toggleShowEdit,
      // updateEntry: ContactsBoxRsc.update,

//       pipeline: pipeline,
//       fields: fields(),
//       stages: stages,
//       setUp: setUp
    }
  }
]);
