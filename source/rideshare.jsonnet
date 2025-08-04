//

//
local labels = [
    'Rideshare / Lyft',
    'Rideshare / Uber',
];

// Archive lyft ride notifications
local lyftRides = {
  filter: {
    and: [
      { from: 'no-reply@lyftmail.com' },
      {
        or: [
          { subject: 'Your Ride with' },
          { subject: 'Your Lyft Bike ride' },
        ],
      },
    ],
  },
  actions: {
    archive: true,
    markRead: true,
    labels: ['Rideshare / Lyft'],
  },
};

// Archive uber ride notifications
local uberRides = {
  filter: {
    and: [
      {
        or: [
          { from: 'uber.us@uber.com' },
          { from: 'noreply@uber.com' },
        ],
      },
      { subject: 'trip with uber' },
    ],
  },
  actions: {
    archive: true,
    markRead: true,
    labels: ['Rideshare / Uber'],
  },
};

// Rules defined by this module
local rules = [
    lyftRides,
    uberRides
];

// Export the file values.
{
  rules: rules,
  labels: labels
}