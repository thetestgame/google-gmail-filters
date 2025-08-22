// This file defines common rules and labels used across all email addresses.
// It provides a framework for creating and managing email filters and actions.

// Constants used across rules
local author = 'Jordan Maxwell';

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

// Export the file values.
{
  author: author,
  FolderRule: FolderRule,
  DeleteRule: DeleteRule,
  MarkImportant: MarkImportant
}