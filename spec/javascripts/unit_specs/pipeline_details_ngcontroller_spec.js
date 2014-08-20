describe('PipelineDetailsCtrl', function() {
  var scope, $httpBackend, ctrl;

  beforeEach(function(){
    this.addMatchers({
      toEqualData: function(expected) {
        return angular.equals(this.actual, expected);
      }
    });
  });

  beforeEach(module('crmApp'));

  beforeEach(inject(function(_$httpBackend_, $rootScope, $controller) {

    $httpBackend = _$httpBackend_;

    $httpBackend.whenGET('/pipelines.json').
        respond([
          {"id":1,"name":"Admissions","created_at":"2014-08-15T17:11:49.827Z","updated_at":"2014-08-15T17:11:49.827Z","trashed":false},
          {"id":2,"name":"Hiring","created_at":"2014-08-15T17:11:49.907Z","updated_at":"2014-08-15T17:11:49.907Z","trashed":false},
          {"id":3,"name":"Get alumni jobs","created_at":"2014-08-15T17:11:49.935Z","updated_at":"2014-08-15T17:11:49.935Z","trashed":false}
        ]);

    $httpBackend.whenGET('/pipelines/1.json').
        respond(
          {"id":1,"name":"Admissions","created_at":"2014-08-15T17:11:49.827Z","updated_at":"2014-08-15T17:11:49.827Z","trashed":false}
        );

    $httpBackend.whenGET('/pipelines/1/fields.json').
        respond([{"id":3,"field_name":"cohort_desired","field_type":"string","pipeline_id":1},{"id":4,"field_name":"candidate_quality_grade","field_type":"float","pipeline_id":1}]);

    $httpBackend.whenGET('/pipelines/1/contacts.json').
        respond([{"id":4,"name":"Jon","email":"jon@gmail.com","city":"San Francisco","phonenumber":"(650) 555-5126","stage_id":4,"cohort_desired":"Value 3:3","candidate_quality_grade":"Value 3:4"},{"id":5,"name":"Catherine","email":"catherine@gmail.com","city":"Barstow","phonenumber":"(650) 555-5126","stage_id":5,"cohort_desired":"Value 4:3","candidate_quality_grade":"Value 4:4"},{"id":6,"name":"DJ","email":"dj@gmail.com","city":"Barstow","phonenumber":"(650) 555-5126","stage_id":6,"cohort_desired":"Value 5:3","candidate_quality_grade":"Value 5:4"}]);

    $httpBackend.whenGET('/pipelines/1/stages.json').
        respond([{"id":4,"name":"First contact","description":"reach out","pipeline_id":1,"pipeline_location":1,"created_at":"2014-08-15T17:11:50.797Z","updated_at":"2014-08-15T17:11:50.797Z"},{"id":5,"name":"Interview","description":"judge them harshly","pipeline_id":1,"pipeline_location":2,"created_at":"2014-08-15T17:11:50.830Z","updated_at":"2014-08-15T17:11:50.830Z"},{"id":6,"name":"Decision","description":"let them know","pipeline_id":1,"pipeline_location":3,"created_at":"2014-08-15T17:11:50.867Z","updated_at":"2014-08-15T17:11:50.867Z"}]);


    scope = $rootScope.$new();
    ctrl = $controller('PipelineDetailsCtrl', {$scope: scope, $routeParams: {id:1}});
  }));

  xit('should get pipelines data', function() {

    $httpBackend.expectGET('/pipelines/1.json');
    $httpBackend.expectGET('/pipelines/1/fields.json');
    $httpBackend.expectGET('/pipelines/1/contacts.json');
    $httpBackend.expectGET('/pipelines/1/stages.json');

    // The responses are not returned until we call the $httpBackend.flush
    $httpBackend.flush();
    expect(scope.basicFields).toEqualData([{field_name: "name"}, {field_name: "email"}]);

  });

  xit('should handle api failures', function() {
    $httpBackend.expectGET('/pipelines/1.json').respond(500, '');

    $httpBackend.flush();
    expect(scope.state).toBe('error');
  });

});
