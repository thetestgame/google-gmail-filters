// JsonNet file for generating Gmail filters for my personal email account.
// This file contains a list of filters to apply to incoming messages
// to automatically sort them into labels and mark them as spam.

local lib = import 'gmailctl.libsonnet';

// Variables for common email addresses and personal information
local name = 'Jordan Maxwell';
local me = 'me@jordan-maxwell.info';

// Constants for folder names
local savedInfoLabel = "Saved Info";
local deliveriesLabel = "Deliveries";
local purchasesLabel = "Purchases";
local financialLabel = "Financial";
local developmentLabel = "Development";

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
        { from: 'USPS' },
        { from: "order-update@amazon.com" },
        { from: "mcinfo@ups.com" },
        { from: "shipment-tracking@amazon.com" },
        { query: "\"out for delivery\"" },
        { subject: "FedEx" },
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
        { from: "purchase-noreply@twitch.tv" },
        { from: "support@privacy.com" },
        { from: "instacart.com" },
        {
            subject: "Amazon Web Services Invoice Available",
            isEscaped: true
        },
        { from: "noreply@online.wingstop.com" },
        { query: "Glitch Productions Store" },
        { from: "no-reply@doordash.com" },
        {
            subject: "Your amazon.com order",
            isEscaped: true
        },
        { query: "paid, monthly" },
        { from: "no-reply@toppers.com" },
        { from: "do_not_reply@deltadentalcoversme.com" },
        { query: "Disney Experience Thank you for Order" },
    ],
};

// List of filters to use for automatic financial email sorting.
// This is a list of common financial email addresses and subjects
// that are used to identify financial emails.
local financialFilter = {
    or: [
        { query: "SoFI" },
        { from: "affirm.com" },
        { from: "*.creditkarma.com" },
        { from: "nerdwallet@mail.nerdwallet.com" },
        { from: "no-reply@alertsp.chase.com" },
        { from: "chase.com" },
        { from: "service@paypal.com" },
        { from: "e.breadfinancial.com" },
    ],
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
                { from: "*@github.com" },
                { from: "noreply@kronnect.com" },
            ],
        },
        { not: purchasesFilter },
    ],
};

// List of filters to use for automatic spam detection.
// This is a list of common spam email subjects and senders
// that are used to identify spam emails.
local spamFilter = {
    and: [
      {
        or: [
            // Spam
            { query: "Pre-approved" },   
            { query: "CarShield" },
            { query: "ENDURANCE AUTO" },
            { query: "Auto Insurance" },
            { query: "AutoInsurance" },
            { query: "insurance -{chase, affirm}" },
            { query: "LinkedIn Job Alerts" },
            {
                subject: "Your Prime Gaming claim is confirmed",
                isEscaped: true
            },
            { from: "calendar-notification@google.com" },
            { from: "redditmail.com" },
            { from: "mail.coinbase.com" },
            { from: "*.smartweak.com" },
            {
                subject: "Shop together with",
                isEscaped: true
            },
        ],
      },

      // If it matches any of the other filters, it's not spam.
      { not: deliveriesFilter },
      { not: purchasesFilter },
      { not: financialFilter },
      { not: developmentFilter },
    ],
};

// Generates a folder rule for a given set of filters and label.
local FolderRule(filters, label) = {
    filter: filters,
    actions: {
        archive: true,
        markSpam: false,
        labels: [label],
    }
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
    // Mark emails going to my primary public email as important. 
    // Someone is likely trying to reach me directly.
    {
      filter: { to: me },
      actions: {
        markImportant: true,
        markSpam: false,
      }
    },

    // Automatically identify spam emails and delete them.
    // This same rule also handles automatic cleanup of old emails.
    {
        filter: {
            or: [
                spamFilter,
                cleanupFilter,
            ],
        },
        actions: { delete: true },
    },
  
    // Automatically sort emails into folders
    FolderRule(deliveriesFilter, deliveriesLabel),      // Automatically sort delivery emails into the Shopping/Deliveries label
    FolderRule(purchasesFilter, purchasesLabel),        // Automatically sort purchase confirmation emails into the Purchase Confirmations labels
    FolderRule(financialFilter, financialLabel),        // Automatically sort financial emails into the Financial label
    FolderRule(developmentFilter, developmentLabel)     // Automatically sort development emails into the Development label
  ]
}
