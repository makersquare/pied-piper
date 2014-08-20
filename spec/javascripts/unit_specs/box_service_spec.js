describe('BoxService', function() {
  var BoxService, $httpBackend;

  beforeEach(module('crmApp'));
  beforeEach(inject(function(_BoxService_, _$httpBackend_) {
    $httpBackend = _$httpBackend_;
    BoxService = _BoxService_;

    // $httpBackend.whenGET('/pipelines/1.json').
    //     respond(
    //       {"id":1,"name":"Admissions","created_at":"2014-08-15T17:11:49.827Z","updated_at":"2014-08-15T17:11:49.827Z","trashed":false}
    //     );

  }));

  describe('test', function() {
    it('should return true', function() {
      test = BoxService.test();

      expect(test).toEqual(true);
    });
  });
});
