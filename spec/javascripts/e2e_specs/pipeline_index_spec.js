// Remeber this test depends on the seeded database
describe('Pipeline Index Page Spec', function() {

    var BASE_URL = 'http://localhost:4000';

    beforeEach(function() {
        browser.get('/#/pipelines');
    });

    describe('side nav bar', function() {

      it('should contain links to each pipeline stage', function() {

        var pipe_links_nav = element.all(by.repeater("pipe in pipelineList"));

        expect(pipe_links_nav.count()).toEqual(3);

      })

      it('should contain allow you to visit subpage', function() {

        var pipe_nav_link = element.all(by.repeater("pipe in pipelineList")).first();

        pipe_nav_link.element(by.css('a')).click().then(function(newUrl){
            expect(browser.getCurrentUrl()).toEqual(BASE_URL + '/#/pipeline/1');
        });
        
      })

    });

});
