# This factory establishes a restful http api that talks to the notes controller in rails
app.factory('NotesAPI', ['$resource',
  ($resource)->
    return $resource('/pipelines/:pid/contacts/:cid/notes/:nid.json',
      pid: '@pid'
      cid: '@cid'
      nid: '@nid',
      update:
        method: 'PUT'
  )
])

# this custom directive gives functionality to delete buttons on the dom to
# delete fields in the dom and database simultaneously
app.directive('deletenote', ['NotesAPI', '$routeParams',
  (NotesAPI, $routeParams)->
    return
    (scope, element)->
      element.bind('click',
        (e)->
          e.preventDefault();
          NotesAPI.remove(
            pid: $routeParams.pid
            cid: $routeParams.cid,
            element,
            (element)->
              scope.notes.splice(element.context.dataset.index, 1)
      )
    )
])

# this controller gives scope to the dom template "contact_box.html" and adds
# functionality for adding notes to the dom and db simultaneously

# PENDING AUTHENTICATION - pass user_id to database with params based on who is logged in
app.controller('NotesCtrl', ['$routeParams', '$scope', '$http', 'NotesAPI',
  ($routeParams, $scope, $http, NotesAPI)->

#    $scope.notes = NotesAPI.query({pid: $routeParams.pid, cid: $routeParams.cid});
#     $scope.routes = {pid: $routeParams.pid, cid: $routeParams.cid}
#  console.log($scope);
#    $scope.addNote = function() {
#      $scope.note = new NotesAPI();
#      $scope.note.$save({pid: $routeParams.pid, cid: $routeParams.cid, pipeline_id: $routeParams.pid, contact_id: $routeParams.cid, notes: $scope.newNote},
#        function(data) {
#          $scope.notes.push({note: $scope.newNote, id: data.id});
#          $scope.newNote = "";
#      });
#    };
])


#  app.controller('ContactBoxCtrl', ['$scope', '$resource', '$http', '$location', '$routeParams',
#    function($scope, $resource, $http, $location, $routeParams) {
#      $scope.cb = null;

#   Define the rails path that will be hit by the http requests
#      var ContactBoxRsc = $resource('/pipelines/:pid/contacts/:cid.json',
#        {cid: '@cid', pid: '@pid'},
#        {
#         get: {method: 'GET'},
#         update: { method: 'PUT', params: $scope.cb}
#          }
#        );

#   Send 'get' request
#      ContactBoxRsc.get(
#        {cid: $routeParams.cid,
#          pid: $routeParams.pid
#        })
#        .$promise.then(function(cb){
#          $scope.cb = cb.table;
#          $scope.cb.contact.contact_id = $routeParams.cid;
#          $scope.cb.cid = $routeParams.cid;
#          $scope.cb.pid = $routeParams.pid;
#          $scope.cb.contact_id = $routeParams.cid;
#          console.log($scope.cb)
#        })

#   Update the entry by sending the 'update' request
#      $scope.updateEntry = function(){
#        entry = ContactBoxRsc.update(
#          $scope.cb)
#      }

#    }]);

