require 'spec_helper'

describe LeagueService::PlayerNegotiationRound do

  subject(:round) do
    LeagueService::PlayerNegotiationRound
      .new(teams: teams, contract_start: :date)
  end

  let(:teams) { [:team1, :team2] }

  it "places and negotiates offers for the needs of all teams" do
    expect(TeamService::OfferForAllNeeds)
      .to receive(:new)
      .with(team: :team1, contract_start: :date)
      .and_return double(offer: [1,3])
    expect(TeamService::OfferForAllNeeds)
      .to receive(:new)
      .with(team: :team2, contract_start: :date)
      .and_return double(offer: [2,3])
    expect(PlayerService::NegotiateOffers)
      .to receive(:new)
      .with([1,3,2])
      .and_return double(negotiate: true)
    round.execute
  end
end
