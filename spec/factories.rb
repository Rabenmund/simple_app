FactoryGirl.define do

  factory :team do
    sequence(:name) { |n| "Team ##{n}" }
    sequence(:short_name) { |n| "S ##{n}" }
    sequence(:abbreviation) { |n| "#{n}" }
  end
  
  factory :competition do
    sequence(:name) { |n| "Competition ##{n}" }
    
    factory :competition_ready do      
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
    competition
  end
  
  factory :game do
    matchday
    before :create do |g|
      home = create :team
      guest = create :team
      g.competition.teams << home
      g.competition.teams << guest
      g.home_id = home.id
      g.guest_id = guest.id
    end
    factory :finished_game do |fg|
      fg.home_goals 1
      fg.guest_goals 0
    end
  end
  
  factory :season do
    sequence(:name) { |n| "Season ##{n}" } 
  end
  
end