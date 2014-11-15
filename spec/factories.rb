FactoryGirl.define do

  factory :appointment do
    appointable
    appointed_at DateTime.now
  end

  factory :appointable, class: Game do
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
    name 'Bundesliga'
    competable_type 'League'
  end
end
