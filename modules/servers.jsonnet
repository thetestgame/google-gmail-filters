local serverEmails = [
    [
    "aws.amazon.com",
    "azure.microsoft.com",
    "digitalocean.com"
];

// List of filters to use for automatic server email sorting.
// This is a list of common server email addresses that are used to identify server emails.
local serversFilter = {
  or: [{ from: email } for email in serverEmails]
};

// Export our rules
{
  filters: serversFilter
}