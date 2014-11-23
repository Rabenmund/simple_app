FactoryGirl.define do

  factory :appointment do
    appointable
    appointed_at DateTime.now
  end

  factory :appointable, class: Game do
  end

  factory :season do
   year 2010
  end

  factory :federation do
    name 'DFB'
  end

  factory :team do
    sequence(:name) { |n| "Mannschaft ##{n}" }
    sequence(:short_name) { |n| "MSV ##{n}" }
    sequence(:abbreviation) { |n| "#{n}" }
    federation
    factory :home do
    end
    factory :guest do
    end
  end

  factory :game do
    performed_at DateTime.now
    home
    guest
    matchday
  end

  factory :matchday do
    number 1
    start DateTime.now
    competition
  end

  factory :competition do
    season
    federation
    name 'Bundesliga'
    type 'League'
    start DateTime.now
  end

  factory :cup do
    season
    federation
    name 'DFB Pokal'
    start DateTime.now
  end

  factory :draw do
    name 'Auslosung'
    performed_at DateTime.now
    cup
  end
end
