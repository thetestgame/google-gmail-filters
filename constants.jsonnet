// This file is a JSONnet file that defines constants and variables for use in other files. It includes variables for common email addresses and personal information, 
// as well as constants for folder names. The file also includes functions for generating folder rules and delete rules based on filters and labels.

// Variables for common email addresses and personal information
local name = 'Jordan Maxwell';

local me = 'me@jordan-maxwell.info';
local spam = 'spam@jordan-maxwell.info';
local alice = 'alice@jordan-maxwell.info';

// Constants for folder names
local savedInfoLabel = "Saved Info";
local serversLabel = "Servers";
local deliveriesLabel = "Deliveries";
local shoppingLabel = "shopping";
local financialLabel = "Financial";
local developmentLabel = "Development";

// Export the constants for use in other files
{
    // Variables for common email addresses and personal information
    name: name,
    me: me,
    spam: spam,
    alice: alice,

    // Constants for folder names
    savedInfoLabel: savedInfoLabel,
    serversLabel: serversLabel,
    deliveriesLabel: deliveriesLabel,
    shoppingLabel: shoppingLabel,
    financialLabel: financialLabel,
    developmentLabel: developmentLabel
}