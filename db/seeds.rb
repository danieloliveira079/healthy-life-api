[
  { title: "Family Habits", active: true, description: "Get inspired by happy habits", interval: "01:00", category: "Family" },
  { title: "Alcohool", active: false, description: "Stop drinking", interval: "01:30", category: "Alcohool" },
  { title: "Stress", active: true, description: "Search inside yourself", interval: "00:30", category: "Daily Routine" },
  { title: "Nutrition", active: true, description: "Eat beeter live better", interval: "01:10", category: "Diet" },
  { title: "Cigars", active: false, description: "Stop smoking", interval: "02:00", category: "Bad Habits" }
].each do |campaign_attributes|
  Campaign.create(campaign_attributes)
end

User.create(email: "xunda.user@example.org", password: "password")
