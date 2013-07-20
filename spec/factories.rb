FactoryGirl.define do

  factory :team do
    sequence(:name) { |n| "Mannschaft ##{n}" }
    sequence(:short_name) { |n| "MSV ##{n}" }
    sequence(:abbreviation) { |n| "#{n}" }
  end
  
  factory :league do
    sequence(:name) { |n| "Liga ##{n}" }
    season
    factory :league_ready do      
      before :create do |c|
        c.no_of_teams.times do
          t = create :team
          c.teams << t
        end
      end
    end
    
  end
  
  factory :matchday do
    sequence(:number) { |n| n }
    league
  end
  
  factory :game do
    matchday
    before :create do |g|
      home = create :team
      guest = create :team
      g.league.teams << home
      g.league.teams << guest
      g.home_id = home.id
      g.guest_id = guest.id
    end
    factory :finished_game do |fg|
      fg.home_goals 1
      fg.guest_goals 0
    end
        
  end
  
end