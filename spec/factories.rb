FactoryGirl.define do

  factory :team do
    sequence(:name) { |n| "Team ##{n}" }
    sequence(:short_name) { |n| "S ##{n}" }
    sequence(:abbreviation) { |n| "#{n}" }
  end
  
  factory :competition do
    sequence(:name) { |n| "Competition ##{n}" }
    season
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
    
    factory :best_season do
      before :create do |s|
        competition = create :competition
        s.competitions << competition
        competition.no_of_teams.times do
          t = create :team
          competition.teams << t
        end
        number = 0    
        competition.plan.each do |matchday|
          number += 1
          created_matchday = create :matchday, number: number, competition: competition
          matchday.each do |game|
            created_game = create :game, matchday: created_matchday, home_id: competition.plan_positions[game[0]-1], guest_id: competition.plan_positions[game[1]-1]
          end
        end
        
      end
    end
        
  end
  
end