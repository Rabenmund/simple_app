FactoryGirl.define do

  factory :team do
    sequence(:name) { |n| "Team ##{n}" }
    sequence(:short_name) { |n| "S ##{n}" }
    sequence(:abbreviation) { |n| "##{n}" }
  end
  
  factory :competition do
    sequence(:name) { |n| "Competition ##{n}" }
    
    factory :competition_prepared do      
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
  end
  
end