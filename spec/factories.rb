FactoryGirl.define do

  factory :logical_date do
    logical_date Date.today
  end

  factory :german_pre_name do
    name "Franz"
    weight 1
  end

  factory :german_family_name do
    name "Beckenbauer"
    weight 999
  end

  factory :appointment do
    appointable
    appointed_at DateTime.now
  end

  factory :appointable, class: Game do
  end

  factory :season do
    sequence(:year) { |n| 2009+n }
    start_date Date.today
  end

  factory :federation do
    sequence(:name) { |n| "Verband ##{n}" }
  end

  factory :team do
    sequence(:name) { |n| "Mannschaft ##{n}" }
    sequence(:short_name) { |n| "MSV ##{n}" }
    sequence(:abbreviation) { |n| "#{n}" }
    # reputation 100
    federation
    organization
    factory :home do
    end
    factory :guest do
    end
  end

  factory :player do
    human
    factory :keeper do
      keeper 100
    end
    factory :defender do
      defense 100
    end
    factory :midfielder do
      midfield 100
    end
    factory :attacker do
      attack 100
    end
  end

  factory :human do
    sequence(:name) { |n| "Spieler ##{n}" }
  end

  factory :contract do
    human
    organization
    from Date.today-2.days
    to Date.today-1.day
  end

  factory :organization do
  end

  factory :lineup do
    game
    initiative 100
    defending 100
    attacking 100
    factory :home_lineup do
    end
    factory :guest_lineup do
    end
  end

  factory :game do
    performed_at DateTime.now
    home
    guest
    matchday
  end

  factory :matchday do
    sequence(:number) { |n| n }
    start DateTime.now
    competition
  end

  factory :competition do
    season
    federation
    start DateTime.now
    sequence(:name) { |n| "Liga ##{n}" }
    type 'League'
  end

  factory :league do
    season
    federation
    level 1
    sequence(:name) { |n| "Liga ##{n}" }
    start DateTime.now
  end

  factory :cup do
    season
    federation
    sequence(:name) { |n| "Cup ##{n}" }
    start DateTime.now
  end

  factory :draw do
    matchday
    name 'Auslosung'
    performed_at DateTime.now
    cup
    before :create do |draw|
      draw.matchday = create(:matchday, competition: draw.competition)
    end
  end

  factory :offer do
    player
    team
    reputation 100
    start_date Date.today-1.year
    end_date Date.today-1.day
  end

  factory :teardown do
    teardownable
    performed_at DateTime.now
  end

  factory :teardownable, parent: :competition do
  end
end
