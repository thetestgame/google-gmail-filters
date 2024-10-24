// JsonNet file for generating Gmail filters for my personal email account.
// This file contains a list of filters to apply to incoming messages
// to automatically sort them into labels and mark them as spam.

local lib = import 'gmailctl.libsonnet';

// Variables for common email addresses
local me = 'me@jordan-maxwell.info';

// List of filters to use for automatic spam detection.
// This is a list of common spam email subjects and senders
// that are used to identify spam emails.
// 
// This list also covers automatic folder clean up rules.
local spam = {
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
        {
            subject: "Shop together with",
            isEscaped: true
        },

        // Clean up
        { query: "label:deliveries older_than:3d" },
        { query: "label:financial older_than:3d" },
        { query: "label:development older_than:3d" },
        { query: "label:shopping older_than:3d" },
    ],
};

// List of filters to use for automatic delivery email sorting.
// This is a list of common delivery email addresses and subjects
// that are used to identify delivery emails.
local deliveries = {
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
local confirmations = {
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
local financial = {
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
local development = {
    and: [
        {
            or: [
                { from: "*@github.com" },
                { from: "noreply@kronnect.com" },
            ],
        },
        { not: confirmations },
    ],
};

// Define our gmail rules for managing emails.
{
  version: "v1alpha3",
  author: {
    name: "Jordan Maxwell",
    email: me
  },

  // Note: labels management is optional. If you prefer to use the
  // GMail interface to add and remove labels, you can safely remove
  // this section of the config.
  labels: [
    { name: "Saved Info" },
    { name: "[Imap]/Drafts" },
    { name: "Conversation History" },
    { name: "Financial" },
    { name: "Deliveries" },
    { name: "Development" },
    { name: "Purchase Confirmations" }
  ],

  // Filters to apply to incoming messages
  rules: [
    // Mark emails going to my primary public email as important. 
    // Someone is likely trying to reach me directly.
    {
      filter: {
        to: me
      },
      actions: {
        markImportant: true,
        markSpam: false,
      }
    },


    // Automatically sort delivery emails into the Shopping/Deliveries label
    {
      filter: deliveries,
      actions: {
        archive: true,
        markSpam: false,
        labels: [
          "Deliveries"
        ]
      }
    },

    // Automatically identify spam emails and delete them
    {
        filter: spam,
        actions: {
            delete: true,
        },
    },

    // Automatically sort purchase confirmation emails into the Purchase Confirmations labels
    {
      filter: confirmations,
      actions: {
        archive: true,
        markSpam: false,
        labels: [
          "Purchase Confirmations"
        ]
      }
    },

    // Automatically sort financial emails into the Financial label
    {
      filter: financial,
      actions: {
        archive: true,
        labels: [
          "Financial"
        ]
      }
    },

    // Automatically sort development emails into the Development label
    {
      filter: development,
      actions: {
        archive: true,
        markSpam: false,
        markImportant: true,
        labels: [
          "Development"
        ]
      }
    },
  ]
}
