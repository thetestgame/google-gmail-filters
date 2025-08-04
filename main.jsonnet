//

local lib = import 'gmailctl.libsonnet';
local constants = import 'source/constants.jsonnet';
local jobmarket = import 'source/jobmarket.jsonnet';
local rideshare = import 'source/rideshare.jsonnet';
local deliveryapps = import 'source/deliveryapps.jsonnet';
local development = import 'source/development.jsonnet';

// Labels used by this email address.
local labels = [
    jobmarket.labels,
    rideshare.labels,
    deliveryapps.labels,
    development.labels,
];

// Rules used by this email address.
local rules = [
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