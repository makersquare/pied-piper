describe('Example Specifcation', function() {

    beforeEach(function() {
        browser.get('/#/pipelines');
    });

    it('should be able to find the rails test server', function() {
        expect(true).toBeTruthy();
    })

    it('title should be correct', function() {
      expect(browser.getTitle()).toEqual('Super Calculator');
    })
});
