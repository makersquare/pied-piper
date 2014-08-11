app.factory("PipelinesRsc", function ($resource) {

    var pipeList = [];

    var pipersc = $resource(
        "/pipelines/:Id.json",
        {Id: "@Id" },
        {
          'createPipe':{
            method:"POST",
          }
        }
    );

    var updatePipeList = function(){
      pipeList = pipersc.query()
    };

    updatePipeList();

    return {
      pipersc   : pipersc,
      updatePipeList : updatePipeList,
      pipeList  : pipeList
    }
});
