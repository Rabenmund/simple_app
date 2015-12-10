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
  let(:team3) { create :team }
  let(:team4) { create :team }

  before do
    allow(draw)
      .to receive(:undrawed_teams)
      .and_return([team1, team2])
    allow(team1)
      .to receive(:current_level)
      .and_return 1
    allow(team2)
      .to receive(:current_level)
      .and_return 2
    allow(team3)
      .to receive(:current_level)
      .and_return 3
    allow(team4)
      .to receive(:current_level)
      .and_return 1
    create :appointment, appointable: event
  end

  it "is valid" do
    expect(event).to be_valid
  end

  it "calls the draw" do
    expect(event.step).to eq([team2, team1])
  end

  it "does not perform a step if the draw is already finished" do
    allow(draw).to receive(:finished?).and_return true
    expect(event.step).to eq false
  end

  it "does not perform a step if the cup has less than 2 games to be drawed" do
    allow(draw).to receive(:undrawed_teams).and_return []
    expect(event.step).to eq false
  end

  it "performs all needed steps" do
    allow(draw)
      .to receive(:undrawed_teams)
      .and_return([team1, team2, team3, team4])
    games = event.perform
    expect(games.size).to eq 2
  end
end

