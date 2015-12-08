require 'spec_helper'

RSpec.describe DrawRepository::DrawCreator do
  subject(:creator) { DrawRepository::DrawCreator }

  let(:cup) { create :cup }
  let!(:first) { create :matchday, number: 1, competition: cup }
  let(:second) { create :matchday, number: 2, competition: cup }

  it "creates a draw for first matchday" do
    draw = creator.create(matchday: first, cup: cup)
    expect(cup.draws).to eq [draw]
    expect(draw.appointed_at).to eq draw.performed_at
    expect(draw.performed_at).to eq first.start - 14.days + 18.hours + 30.minutes
  end

  it "creates a draw for a second matchday" do
    draw = creator.create(matchday: second, cup: cup)
    expect(cup.draws).to eq [draw]
    expect(draw.appointed_at).to eq draw.performed_at
    start = first.start
    expect(draw.performed_at).to eq (start + 1.days + 23.hours + 30.minutes)
  end
end
