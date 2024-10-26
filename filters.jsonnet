// This file contains the filters used to automatically sort emails into different labels.
// It contains filters for important emails, cleanup, deliveries, purchases, financial, development, and spam.

local lib = import 'gmailctl.libsonnet';
local constants = import 'constants.jsonnet';

local financialEmails = import 'data/financial.json';
local carrierEmails = import 'data/carriers.json';
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
    { query: "label:deliveries older_than:3d" },
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

// List of filters to use for automatic purchase confirmation sorting.
// This is a list of common purchase confirmation email addresses and subjects
// that are used to identify purchase confirmation emails.
local purchasesFilter = {
    or: [
        { query: "confirmation" },
        { query: "receipt" },
        { query: "order" },
        { query: "purchase" },
        { query: "invoice" },
        { query: "thank you for order" },
        { query: "order confirmation" },
        { from: "purchase-noreply@twitch.tv" },
        { query: "paid, monthly" },
        { query: "Glitch Productions Store" },

        { from: "support@privacy.com" },
        { from: "instacart.com" },
        {
            subject: "Amazon Web Services Invoice Available",
            isEscaped: true
        },
        { from: "noreply@online.wingstop.com" },
        { from: "no-reply@doordash.com" },
        {
            subject: "Your amazon.com order",
            isEscaped: true
        },
        { from: "no-reply@toppers.com" },
        { from: "do_not_reply@deltadentalcoversme.com" },
    ],
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
//
// This list ignores emails matching the confirmations filter.
local developmentFilter = {
    and: [
        {
            or: [
                { from: "github.com" },
                { from: "noreply@kronnect.com" },
            ],
        },
        { not: purchasesFilter },
    ],
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

// Export the filters for use in other files
{
  importantFilters: importantFilters,
  cleanupFilter: cleanupFilter,
  deliveriesFilter: deliveriesFilter,
  purchasesFilter: purchasesFilter,
  financialFilter: financialFilter,
  developmentFilter: developmentFilter,
  spamFilter: spamFilter,
}