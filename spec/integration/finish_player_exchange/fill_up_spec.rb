require 'spec_helper'

RSpec.describe TeamService::FillUp do
  subject(:filler) { TeamService::FillUp }
  let(:team1) { create :team }
  let(:team2) { create :team }
  let(:team3) { create :team }
  let(:date) { Date.new(2016,7,1) }

  before do
    2.times { player_creator :keeper, team1 }
    1.times { player_creator :keeper, team1, Date.new(2016, 6, 30) }
    7.times { player_creator :defender, team1 }
    1.times { player_creator :defender, team1, Date.new(2016, 6, 30) }
    7.times { player_creator :midfielder, team1 }
    3.times { player_creator :attacker, team1 }

    3.times { player_creator :keeper, team2 }
    8.times { player_creator :defender, team2 }
    8.times { player_creator :midfielder, team2 }
    4.times { player_creator :attacker, team2 }

    3.times { create :keeper }
    8.times { create :defender }
    9.times { create :midfielder }
    5.times { create :attacker }
  end

  it "contracts count of missing players" do
    expect(players_for team1).to eq 19
    expect(players_for team2).to eq 23
    expect(players_for team3).to eq 0
    filler
      .new(teams: [team1, team2, team3], start_date: date)
      .fill_up
    expect(players_for team1).to eq 23
    expect(players_for team2).to eq 23
    expect(players_for team3).to eq 23
  end

  def player_creator(type, team, to=Date.new(2017, 6, 30))
    player = create(type)
    create :contract,
      human: player.human,
      organization: team.organization,
      from: Date.new(2015, 7, 1),
      to: to
  end

  def players_for(team)
    TeamRepository::PlayerQuery.new(team: team).players_at(date).count
  end
end


