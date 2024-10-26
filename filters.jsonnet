// This file contains the filters used to automatically sort emails into different labels.
// It contains filters for important emails, cleanup, deliveries, shopping, financial, development, and spam.

local lib = import 'gmailctl.libsonnet';
local constants = import 'constants.jsonnet';

local carrierEmails = import 'data/carriers.json';
local developmentEmails = import 'data/development.json';
local financialEmails = import 'data/financial.json';
local serverEmails = import 'data/servers.json';
local shoppingEmails = import 'data/shopping.json';
local spamEmails = import 'data/spam.json';

local importantFilters = {
  or: [
    { to: constants.me },
    { to: constants.alice },
  ]
};

// List of filters to use for automatic cleanup.
local cleanupFilter = {
  or: [
    // Custom
    { query: "label:servers older_than:3d" },
    { query: "label:financial older_than:3d" },
    { query: "label:development older_than:3d" },
    { query: "label:shopping older_than:3d" },

    // Built In
    { query: "category:promotions older_than:3d" },
    { query: "category:social older_than:3d" },
    { query: "category:forums older_than:3d" },
    { query: "category:updates older_than:3d" },
  ]
};

// List of filters to use for automatic server email sorting.
// This is a list of common server email addresses that are used to identify server emails.
local serversFilter = {
  or: [{ from: email } for email in serverEmails]
};

// List of filters to use for automatic delivery email sorting.
// This is a list of common delivery email addresses and subjects
// that are used to identify delivery emails.
local deliveriesFilter = {
    or: [
        // Search for emails for common delivery statuses
        { 
          or: [
            { query: "Tracking Number" },
            { query: "Shipment ID" },
            { query: "Order Number" },
            { query: "Estimated Delivery Date" },
            { query: "Shipping Date" },
            { query: "Customs Declaration" },
            { query: "Package Weight" },
            { query: "Package Dimensions" },
            { query: "Signature Required" },
            { query: "Shipped" },
            { query: "Out for Delivery" },
            { query: "Delivered" },
            { query: "In Transit"},
          ],
        },

        // Common delivery services
        { or: [{ from: email } for email in carrierEmails] },
    ],
};

// List of filters to use for automatic shopping confirmation sorting.
// This is a list of common shopping confirmation email addresses and subjects
// that are used to identify shopping confirmation emails.
local shoppingFilter = {
    or: [
      {
        or: [
            { query: "confirmation" },
            { query: "receipt" },
            { query: "order" },
            { query: "purchase" },
            { query: "invoice" },
            { query: "thank you for order" },
            { query: "order confirmation" },
            { query: "paid, monthly" },
        ]
      },
      {
        or: [{ from: email } for email in shoppingEmails],
      }
    ]
};

// List of filters to use for automatic financial email sorting.
// This is a list of common financial email addresses and subjects
// that are used to identify financial emails.
local financialFilter = {
    or: [{ from: email } for email in financialEmails],
};

// List of filters to use for automatic development email sorting.
// This is a list of common development email addresses and subjects
// that are used to identify development emails.
local developmentFilter = {
    or: [{ from: email } for email in developmentEmails],
};

// List of filters to use for automatic spam detection.
local spamFilter = {
  or: [
    // Common spam email list 
    { or: [{ from: email } for email in spamEmails] },
    
    // Person spam email
    { 
      or: [
        { to: constants.spam }
      ]
    }
  ],
};

// Special filter that handles abuse of how Gmail operates to allow spam. This filter
// catches all email directed towards my inbox but is not actually addressed to me or any
// of my aliases. This is a common tactic used by spammers to bypass spam filters.
local abuseSpamFilter = {
  and: [
    { not: me },
    { not: alice },
    { not: gmail },
  ]
};

// Export the filters for use in other files
{
  importantFilters: importantFilters,
  cleanupFilter: cleanupFilter,
  serversFilter: serversFilter,
  deliveriesFilter: deliveriesFilter,
  shoppingFilter: shoppingFilter,
  financialFilter: financialFilter,
  developmentFilter: developmentFilter,
  spamFilter: spamFilter,
  abuseSpamFilter: abuseSpamFilter,
}