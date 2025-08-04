//

// 
local labels = [
  'Jobs / Recruiters',
];

local recruiters = {
  filter: {
    or: [
      // Things recruiters call themselves
      { has: 'recruiter' },
      { has: 'recruiting' },
      { has: 'sourcer' },
      { has: 'technical sourcer' },
      { has: 'talent manager' },
      { has: 'talent advisor' },
      { has: 'talent associate' },
      { has: 'talent scout' },
      { has: 'talent acquisition' },
      { has: 'talent partner' },
      { has: 'talent specialist' },
      { has: 'talent search specialist' },
      { has: 'talent director' },
      { has: 'talent team' },
      { has: 'talent & growth' },
      { has: 'head of talent' },
      
      // Phrases they like to use
      { has: 'your experience at microsoft' },
      { has: 'your experience at strange loop games' },
      { has: 'the hiring manager' },
      { has: 'job description' },
      { has: 'early-stage startup' },
      { has: 'pre-seed' },
      { has: 'Series A' },
      { has: 'Series B' },
      { has: 'Series C' },
      { has: 'We have raised' },
      { has: 'founding engineer' },
      { has: 'founding engineering' },
      { has: 'founding team' },
      { has: 'I lead recruiting' },
      { has: 'you would be a great fit' },
      { has: 'your availability is' },
      { has: 'your next move' },
      { has: 'open to new opportunities' },
      { has: 'open to connecting' },
      { has: 'reached out to you' },
      { has: 'open to a quick' },
      { has: 'intro chat' },
      { has: 'fast-growing' },
      { has: 'in this role' },
    ],
  },
  actions: {
    archive: true,
    markRead: true,
    labels: ['Jobs / Recruiters'],
  },
};

// 
local rules = [
  recruiters
];

// Export the file values.
{
  rules: rules,
  labels: labels
}