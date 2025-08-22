local carrierEmails = [
  "usps.com",
  "ups.com",
  "fedex.com",
  "dhl.com",
  "royalmail.com",
  "canadapost.ca",
  "auspost.com.au",
  "post.japan",
  "upsmychoice.com",
  "order-update@amazon.com",
  "shipment-tracking@amazon.com"
];

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

// Export our rules
{
  filters: deliveriesFilter
}