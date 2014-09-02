# this custom directive gives functionality to delete buttons on the dom to
# delete fields in the dom and database simultaneously
app.directive('deletefield',
  ['FieldsRsc', '$routeParams',
    (FieldsRsc, $routeParams)->
      return (scope, element)->
        element.bind('click', (e)->
          e.preventDefault()
          FieldsRsc.remove(
            pipeline_id: $routeParams['pipeline_id']
            id: this.dataset.id, element,
            (element)->
              scope.fields.splice(element.context.dataset.index, 1)
            )
        )
  ]
)

# this controller gives scope to the dom template "createFields.html" and adds
# functionality for adding fields to the dom and db simultaneously
app.controller('CreateFieldsCtrl',
  ['$routeParams', '$scope', '$http', 'FieldsRsc',
  ($routeParams, $scope, $http, FieldsRsc)->
    $scope.fields = FieldsRsc.query(
      pipeline_id: $routeParams['pipeline_id']
      )

    $scope.addField = ->
      $scope.field = new FieldsRsc()
      $scope.field.$save(
        pipeline_id: $routeParams['pipeline_id']
        field_name: $scope.fieldName
        field_type: 'string',
        (data)->
          $scope.fields.push(
            field_name: $scope.fieldName
            id: data.id
          )
          $scope.fieldName = ""
      )
  ]
)





