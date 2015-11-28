require 'spec_helper'

RSpec.describe PlanMatchday do
  subject(:matchday) do
    PlanMatchday.new(start: date,
                     number: 1,
                     plan: [[1,2],[3,4]],
                     type: :league,
                     level: 1
                    )
  end
  let(:date) { Date.new(2015,8,8) }

  it "has attributes" do
    expect(matchday.attributes).to eq(
      {number: 1, start: date})
  end

  it "plans games" do
    expect(matchday.games.size).to eq 2
    expect(matchday.games.first.attributes).to eq({home_id: 1, guest_id: 2})
    expect(matchday.games.first.start).to eq DateTime.new(2015,8,7,20,30)
  end
end
