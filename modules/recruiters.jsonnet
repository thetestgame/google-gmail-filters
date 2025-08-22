//
local recruitersFilter = {
    "or": [
      { "has": "recruiter" },
      { "has": "recruiting" },
      { "has": "sourcer" },
      { "has": "technical sourcer" },
      { "has": "talent manager" },
      { "has": "talent advisor" },
      { "has": "talent associate" },
      { "has": "talent scout" },
      { "has": "talent acquisition" },
      { "has": "talent partner" },
      { "has": "talent specialist" },
      { "has": "talent search specialist" },
      { "has": "talent director" },
      { "has": "talent team" },
      { "has": "talent & growth" },
      { "has": "head of talent" },
      { "has": "VP of Engineering" },
      { "has": "I’m the CTO" },
      { "has": "I’m the Co-Founder" },
      { "has": "your experience at sentry" },
      { "has": "the hiring manager" },
      { "has": "job description" },
      { "has": "early-stage startup" },
      { "has": "pre-seed" },
      { "has": "Series A" },
      { "has": "Series B" },
      { "has": "Series C" },
      { "has": "We have raised" },
      { "has": "founding engineer" },
      { "has": "founding engineering" },
      { "has": "founding team" },
      { "has": "connect with me on LinkedIn" },
      { "has": "connect on LinkedIn" },
      { "has": "cash flow positive" },
      { "has": "product-market fit" },
      { "has": "vc-funded" },
      { "has": "vc-backed" },
      { "has": "I lead recruiting" },
      { "has": "you would be a great fit" },
      { "has": "your availability is" },
      { "has": "your next move" },
      { "has": "open to new opportunities" },
      { "has": "open to connecting" },
      { "has": "reached out to you" },
      { "has": "sequoia" },
      { "has": "open to a quick" },
      { "has": "intro chat" },
      { "has": "fast-growing" },
      { "has": "in this role" }
    ]
};

// Export our rules
{
  filters: recruitersFilter
}