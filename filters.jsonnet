// JsonNet file for generating Gmail filters for my personal email account.
// This file contains a list of filters to apply to incoming messages
// to automatically sort them into labels and mark them as spam.

local lib = import 'gmailctl.libsonnet';
local financialEmails = import 'data/financial.json';
local carrierEmails = import 'data/carriers.json';
local spamEmails = import 'data/spam.json';

// Variables for common email addresses and personal information
local name = 'Jordan Maxwell';

local me = 'me@jordan-maxwell.info';
local spam = 'spam@jordan-maxwell.info';
local alice = 'alice@jordan-maxwell.info';

// Constants for folder names
local savedInfoLabel = "Saved Info";
local deliveriesLabel = "Deliveries";
local purchasesLabel = "Purchases";
local financialLabel = "Financial";
local developmentLabel = "Development";

local importantFilters = {
  or: [
    { to: me },
    { to: alice },
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
        { to: spam }
      ]
    }
  ],
};

// Generates a folder rule for a given set of filters and label.
local FolderRule(filters, label) = {
  filter: filters,
  actions: {
      archive: true,
      markSpam: false,
      delete: false,
      labels: [label],
  }
};

// Generates a delete rule for a given set of filters.
local DeleteRule(filters) = {
  filter: filters,
  actions: { delete: true },
};

// Generates a rule for marking emails as important and ensuring
// they are not marked as spam.
local MarkImportant(filters) = {
  filter: filters,
  actions: { 
    markImportant: true,
    markSpam: false,
  },
};

// Define our gmail rules for managing emails.
{
  version: "v1alpha3",
  author: {
    name: name,
    email: me
  },

  labels: [
    { name: savedInfoLabel },
    { name: deliveriesLabel },
    { name: purchasesLabel },
    { name: financialLabel },
    { name: developmentLabel },
  ],

  // Filters to apply to incoming messages
  rules: [
    // Mark emails going to my primary public emails as important. 
    // Someone is likely trying to reach me directly.
    MarkImportant(importantFilters),

    // Apply our automatic deletion rules
    DeleteRule(spamFilter),     // Automatically delete emails from known spam senders
    DeleteRule(cleanupFilter),  // Automatically delete old emails
  
    // Automatically sort emails into folders
    FolderRule(deliveriesFilter, deliveriesLabel),      // Automatically sort delivery emails into the Shopping/Deliveries label
    FolderRule(purchasesFilter, purchasesLabel),        // Automatically sort purchase confirmation emails into the Purchase Confirmations labels
    FolderRule(financialFilter, financialLabel),        // Automatically sort financial emails into the Financial label
    FolderRule(developmentFilter, developmentLabel)     // Automatically sort development emails into the Development label
  ]
}
