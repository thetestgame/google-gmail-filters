//

//
local labels = [
    'Deliveries / Packages'
];

//
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

//
local packages = {
    filter: {
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
    }
};

// Rules defined by this module
local rules = [
    packages
];

// Export the file values.
{
  rules: rules,
  labels: labels
}