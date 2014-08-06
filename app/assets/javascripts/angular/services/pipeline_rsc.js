app.factory("Pipelines", function ($resource) {
    return $resource(
        "/pipelines/:Id.json",
        {Id: "@Id" },
        {
            'get': {method:'GET',
                    isArray:true,
                    },
            'getPipe':{method:'GET'}

        }
    );
});
