# this custom directive gives functionality to delete buttons on the dom to
# delete stages in the dom and database simultaneously
app.directive('deletestage', ['StagesRsc', '$routeParams',
  (StagesRsc, $routeParams)->
    return (scope, element)->
      element.bind('click',
        (e)->
          e.preventDefault()
          StagesRsc.remove(
            pipeline_id: $routeParams['pipeline_id']
            id: this.dataset.id,
            element,
            (element)->
              scope.stages.splice(element.context.dataset.index, 1)
          )
      )
])

# this controller gives scope to the dom template "createFields.html" and adds
# functionality for adding stages to the dom and db simultaneously
app.controller('StagesCtrl', ['$routeParams', '$scope', '$http', 'StagesRsc',
  ($routeParams, $scope, $http, StagesRsc)->
    $scope.stages = StagesRsc.query(
      pipeline_id: $routeParams['pipeline_id']
    )

    $scope.addStage = ->
      $scope.stage = new StagesRsc()
      $scope.stage.$save(
        pipeline_id: $routeParams['pipeline_id']
        name: $scope.stageName
        description: $scope.stageDesc
        pipeline_location: $scope.stageLoc,
        (data)->
          $scope.stages.push(
            name: $scope.stageName
            description: $scope.stageDesc
            pipeline_location: $scope.stageLoc
            id: data.id
          )
          $scope.stageName = ""
    )
  ]
)
