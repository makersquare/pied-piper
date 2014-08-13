// An example configuration file.

exports.config = {
    // The address of a running selenium server.
    seleniumAddress: 'http://localhost:4444/wd/hub',

    // Capabilities to be passed to the webdriver instance.
    capabilities: {
        'browserName': 'phantomjs'
    },

    // Spec patterns are relative to the current working directly when
    // protractor is called.
    specs: ['e2e_specs/**/*.js'],

    baseUrl: 'http://localhost:4000',

    // Options to be passed to Jasmine-node.
    jasmineNodeOpts: {
        showColors: true,
        defaultTimeoutInterval: 30000
    },

};
