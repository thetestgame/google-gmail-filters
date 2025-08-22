//

local lib = import 'gmailctl.libsonnet';
local framework = import 'modules/framework.jsonnet';
local recruiters = import 'modules/recruiters.jsonnet';
local deliveries = import 'modules/deliveries.jsonnet';

local labels = [{ name: l } for l in [
  '+ Important',
  '+ Needs Filters',
  'Deliveries / Packages',
  'Deliveries / Mailbox',
  'Flight Confirmations',
  'Money / Receipts',
  'Money / Statements',
  'Development / Github',
  'Development / Pipelines',
  'Development / Trending',
  'Development / Servers',
  'Jobs / Linkedin',
  'Jobs / Recruiters',
  'Rideshare / Lyft',
  'Rideshare / Uber',
  'Venmo / Cashout',
  'Venmo / Paid'
]];

// Construct our final rules data.
{
  version: 'v1alpha3',
  author: {
    name: framework.author
  },

  labels: labels,

  // Filters to apply to incoming messages
  rules: [
    // Mark emails going to my primary public emails as important. 
    // Someone is likely trying to reach me directly.
    //MarkImportant(filters.importantFilters),

    // Apply our automatic deletion rules
    //DeleteRule(filters.spamFilter),       // Automatically delete emails from known spam senders
    //DeleteRule(filters.abuseSpamFilter),  // Automatically delete emails that don't belong in my inbox
    //DeleteRule(filters.cleanupFilter),    // Automatically delete old emails
  
    // Automatically sort emails into folders
    framework.FolderRule(recruiters.filters, 'Jobs / Recruiters'),
    framework.FolderRule(deliveries.filters, 'Deliveries / Packages'),
    framework.FolderRule(servers.filters, 'Development / Servers'),
    //FolderRule(filters.shoppingFilter, constants.shoppingLabel),          // Automatically sort purchase confirmation emails into the Purchase Confirmations labels
    //FolderRule(filters.financialFilter, constants.financialLabel),        // Automatically sort financial emails into the Financial label
    //FolderRule(filters.developmentFilter, constants.developmentLabel)     // Automatically sort development emails into the Development label
  ]
}