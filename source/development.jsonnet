//

//
local labels = [
    'Development / Github'
];

local github = {
    filter: {
        from: 'notifications@github.com'
    },
    actions: {
        labels: ['Development / Github'],        
    }
};

//
local rules = [
    github
];

// Export the file values.
{
  rules: rules,
  labels: labels
}