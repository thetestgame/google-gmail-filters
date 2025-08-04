//

local lib = import 'gmailctl.libsonnet';
local constants = import 'source/constants.jsonnet';

local deliveries = import 'source/deliveries.jsonnet';
local deliveryapps = import 'source/deliveryapps.jsonnet';
local development = import 'source/development.jsonnet';
local jobmarket = import 'source/jobmarket.jsonnet';
local rideshare = import 'source/rideshare.jsonnet';

// Labels used by this email address.
local labels = [
    // Common labels
    constants.labels,

    // Module labels
    deliveries.labels,
    deliveryapps.labels,
    development.labels,
    jobmarket.labels,
    rideshare.labels,
];

// Rules used by this email address.
local rules = [
  deliveries.rules,
  jobmarket.rules,
  rideshare.rules,
  deliveryapps.rules,
  development.rules
];

// Construct our final rules data.
{
  version: 'v1alpha3',
  labels: [{ name: l } for l in std.flattenArrays(labels)],
  rules: std.flattenArrays(rules),
}