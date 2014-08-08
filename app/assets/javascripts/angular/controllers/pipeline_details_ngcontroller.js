app.directive('dndList', function(){

// Custom directive for drag/drop between stages
    // Watch for changes to contact; use "true" to receive updates when values change
    return function(scope, element, attrs){
      console.log(scope)
      // $(contact).sortable({
      //   items: 'form',
      //   start:function(event, ui){

      //   },
      //   stop:function(event, ui){
      //     contact.stage = 1
      //   },
      //   axis: 'y'
      // })

      // ContactBoxRsc.update(contact);
    }
})

app.controller('PipelineDetailsCtrl',
  ['$scope', '$resource',
  '$routeParams','PipelinesRsc',
  'ContactsBoxRsc', 'FieldsRsc',
  'StagesRsc',
  function($scope, $resource, $routeParams,
    PipelinesRsc, ContactsBoxRsc, FieldsRsc,
    StagesRsc, dndList) {

    $scope.pipeline_id = $routeParams.id;
    $scope.editData = false;

    PipelinesRsc.getPipe({Id: $routeParams.id})
      .$promise.then(function(data){
        $scope.pipeline = data;
    });

    $scope.basicFields = [{field_name: "name"}, {field_name: "email"}];
    $scope.fields = FieldsRsc.query({pipeline_id: $routeParams.id});

    $scope.contacts = ContactsBoxRsc.query({pipeline_id: $routeParams.id});

    $scope.stages = StagesRsc.query({pipeline_id: $routeParams.id});

// Edit the entry in the browser by double-clicking the text; press enter to update in the database
    $scope.keyup = function(event, contact) {
      if (event.keyCode == 13) {
        contact.showEdit = !contact.showEdit;
        contact.cid = contact.id;
        contact.contact_id = contact.id;
        contact.pid = $routeParams.id;
        ContactBoxRsc.update(contact);
      }
    };
    $('.contacts').sortable();

    $scope.$watch(dndList, function(value){
      console.log("Contact: " + value)
    })
    // // Watch for changes to contact; use "true" to receive updates when values change
    // $scope.$watch($scope.contact, function(value){
    //   console.log("Contact: " + value//.map(function(e){
    //     //return e.id //????
    //   // }
    //   )//.join(','));
    // }, true);

// Define the rails path that will be hit by the http requests
    var ContactBoxRsc = $resource('/pipelines/:pid/contacts/:cid.json',
      {cid: '@cid', pid: '@pid'},
      {
       get: {method: 'GET'},
       update: { method: 'PUT', params: $scope.cb}
        }
      );

  }]);
