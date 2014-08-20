describe('PipelinesRsc', function(){

  var PipelinesRsc, $httpBackend;

  beforeEach(module('crmApp'));

  beforeEach(inject(function(_$httpBackend_, _PipelinesRsc_) {
    $httpBackend = _$httpBackend_;
    PipelinesRsc = _PipelinesRsc_;

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

  }));


  it('get all pipelines', function() {
    console.log($httpBackend);
     $httpBackend.expectGET('/pipelines.json')

     pipes = PipelinesRsc.query()

     $httpBackend.flush();

     expect(pipes.length).toEqual(3);
  });

  it('gets one pipeline', function() {

    $httpBackend.expectGET('/pipelines/1.json')

    pipe = PipelinesRsc.get({id:1});

    $httpBackend.flush();

    expect(pipe.name).toEqual("Admissions");
  });

});
