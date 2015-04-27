FactoryGirl.define do

  factory :appointment do
    appointable
    appointed_at DateTime.now
  end

  factory :appointable, class: Game do
  end

  factory :season do
    sequence(:year) { |n| 2009+n }
  end

  factory :federation do
    sequence(:name) { |n| "Verband ##{n}" }
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
    # factory :league do
    # end
  end

  factory :league do
    season
    federation
    sequence(:name) { |n| "Liga ##{n}" }
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
