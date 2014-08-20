/*
 * PipelineService gives you all information related to a pipeline
 * You can retrives it's information, it's fields, and it's stages
 */
app.factory("PipelineService", ["$rootScope", "PipelinesRsc",
  "StagesRsc", "FieldsRsc",
  function ($rootScope, PipelinesRsc, StagesRsc, FieldsRsc) {

    var basicFields = [{field_name: "name"}, {field_name: "email"}];

    var retrievePipeline = function(pipelineId) {
      pipeline = PipelinesRsc.get({id: pipelineId})
        .$promise.then(function(data) {
          $rootScope.$broadcast('pipeline:updated', data);
        });
      return pipeline;
    };

    var retrieveStages = function(pipelineId) {
      return StagesRsc.query({pipeline_id: pipelineId});
    };

    var retrieveFields = function(pipelineId) {
      return FieldsRsc.query({pipeline_id: pipelineId});
    };

    return {
      pipeline: retrievePipeline,
      stages: retrieveStages,
      fields: retrieveFields,
      basicFields: basicFields
    };
  }
]);
