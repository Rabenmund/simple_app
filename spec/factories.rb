FactoryGirl.define do

  factory :team do
    sequence(:name) { |n| "Team ##{n}" }
  end
  
  factory :competition do
    sequence(:name) { |n| "Competition ##{n}" }
    
    # before :create do |c|
    #   6.times do
    #     t = create :team
    #     c.teams << t
    #   end
    # end
  end
  
end