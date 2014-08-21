describe('BoxService', function() {
  var BoxService, $httpBackend;

  beforeEach(module('crmApp'));
  beforeEach(inject(function(_BoxService_, _$httpBackend_, _ContactsBoxRsc_) {
    $httpBackend = _$httpBackend_;
    BoxService = _BoxService_;
    ContactsBoxRsc = _ContactsBoxRsc_;
    // var pipelineId, contacts, stageContacts, stageSelection, allContactsSelection;

    $httpBackend.whenGET('/pipelines/1/contacts.json').
        respond([
          {'id': 4, 'name': "Jon", 'email': "jon@gmail.com", 'city': "San Francisco", 'phonenumber': "(650) 555-5126", 'stage_id': 4, 'cohort_desired': "Value 3:3", 'candidate_quality_grade': "Value 3:4"},
          {'id': 5, 'name': "Catherine", 'email': "catherine@gmail.com", 'city': "Barstow", 'phonenumber': "(650) 555-5126", 'stage_id': 5, 'cohort_desired': "Value 4:3", 'candidate_quality_grade': "Value 4:4"},
          {'id': 6, 'name': "DJ", 'email': "dj@gmail.com", 'city': "Barstow",'phonenumber': "(650) 555-5126", 'stage_id': 6, 'cohort_desired': "Value 5:3", 'candidate_quality_grade': "Value 5:4"}
        ]);

  }));

  describe('setUp', function() {
    it('grab all contacts', function() {
      $httpBackend.expectGET('/pipelines/1/contacts.json');

      var contacts = ContactsBoxRsc.query({pipeline_id: 1});
      $httpBackend.flush();

      expect(contacts.length).toEqual(3);
      expect(contacts[0].id).toEqual(4);
      expect(contacts[0].name).not.toBe(null);
      expect(contacts[0].email).not.toBe(null);
      expect(contacts[0].city).not.toBe(null);
      expect(contacts[0].phonenumber).not.toBe(null);
      expect(contacts[0].stage_id).not.toBe(null);
      expect(contacts[0].cohort_desired).not.toBe(null);
      expect(contacts[0].candidate_quality_grade).not.toBe(null);
    });

    it('should group contacts into stages by stage id', function() {
      $httpBackend.expectGET('/pipelines/1/contacts.json');

      BoxService.setUp(1);
      $httpBackend.flush();

      expect(BoxService.stageContacts()[4][0].name).toEqual('Jon');
    });
  });

  describe('toggleAllContactsSelection', function() {
    xit('should change the contact selected property', function() {
      $httpBackend.expectGET('/pipelines/1/contacts.json');

      BoxService.setUp(1);
      BoxService.toggleAllContactSelection();
      $httpBackend.flush();

      expect(BoxService.stageContacts()[4][0]).toEqual(true);
    });
  });

});

