//

//
local labels = [
    'Development / Github',
    'Development / Trending',
    'Development / Pipelines',
];

//
local trending = {
    filter: {
        and: [
            { from: 'notifications@github.com' },
            {
                or: [
                    { has: 'new daily trending' },
                    { has: 'new monthly trending' }
                ]
            }
        ]
    },
    actions: {
        archive: true,
        labels: ['Development / Trending'],        
    }
};

//
local pipelines = {
    filter: {
        and: [
            { from: 'notifications@github.com' },
            {
                or: [
                    { has: 'run failed' }
                ]
            }
        ]
    },
    actions: {
        archive: true,
        labels: ['Development / Pipelines'],        
    }
};

// Rules defined by this module
local rules = [
    trending,
    pipelines
];

// Export the file values.
{
  rules: rules,
  labels: labels
}