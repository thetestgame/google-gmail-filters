// This file defines the rules for managing emails in Gmail.
// It uses the filters defined in filters.jsonnet to automatically sort emails into different labels.
// It also defines rules for marking emails as important and deleting spam emails.

local lib = import 'gmailctl.libsonnet';
local constants = import 'constants.jsonnet';
local filters = import 'filters.jsonnet';

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
    name: constants.name,
    email: constants.me
  },

  labels: [
    { name: constants.savedInfoLabel },
    { name: constants.serversLabel },
    { name: constants.deliveriesLabel },
    { name: constants.shoppingLabel },
    { name: constants.financialLabel },
    { name: constants.developmentLabel },
  ],

  // Filters to apply to incoming messages
  rules: [
    // Mark emails going to my primary public emails as important. 
    // Someone is likely trying to reach me directly.
    MarkImportant(filters.importantFilters),

    // Apply our automatic deletion rules
    DeleteRule(filters.spamFilter),     // Automatically delete emails from known spam senders
    DeleteRule(filters.cleanupFilter),  // Automatically delete old emails
  
    // Automatically sort emails into folders
    FolderRule(filters.serversFilter, constants.serversLabel),            // Automatically sort server emails into the Servers label
    FolderRule(filters.deliveriesFilter, constants.deliveriesLabel),      // Automatically sort delivery emails into the Shopping/Deliveries label
    FolderRule(filters.shoppingFilter, constants.shoppingLabel),          // Automatically sort purchase confirmation emails into the Purchase Confirmations labels
    FolderRule(filters.financialFilter, constants.financialLabel),        // Automatically sort financial emails into the Financial label
    FolderRule(filters.developmentFilter, constants.developmentLabel)     // Automatically sort development emails into the Development label
  ]
}
