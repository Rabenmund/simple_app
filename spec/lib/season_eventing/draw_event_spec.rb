require 'spec_helper'

RSpec.describe SeasonEventing::DrawEvent do
  subject(:event) do
    create :draw_event, eventable: draw
  end

  let(:season) { create :season }
  let(:cup) { create :cup, season: season }
  let(:matchday) { create :matchday, competition: cup, number: 1 }
  let(:draw) { create :draw, matchday: matchday }
  let(:team1) { create :team }
  let(:team2) { create :team }

  before do
    allow(draw)
      .to receive(:undrawed_teams)
      .and_return([:team1, :team2])
  end

  it "is valid" do
    expect(event).to be_valid
  end

  it "calls the draw" do
    expect(event.step).to eq false
  end

  it "does not perform a step if the draw is already finished" do
    allow(draw).to receive(:finished?).and_return true
    expect(event.step).to eq false
  end

  it "does not perform a step if the cup has less than 2 games to be drawed" do
    allow(draw).to receive(:undrawed_teams).and_return []
    expect(event.step).to eq false
  end
end

