require_relative "../../../lib/team_service/best_offer"
require_relative "../../../lib/team_repository/reputation"
require_relative "../../../lib/player_repository/best_player"
require_relative "../../../lib/offer_repository/create"
require_relative "../../../lib/team_service/end_date"

RSpec.describe TeamService::BestOffer do
  subject(:best_offer) do
    TeamService::BestOffer.new(id: 1, type: :keeper, date: date)
  end

  let(:date) { Date.new(2015,7,1) }
  let(:best_player) { double("BestPlayer", id: 1) }

  it "places an offer for the best given player" do
    allow(TeamRepository::Reputation)
      .to receive(:new)
      .with(1)
      .and_return double("Reputation", reputation: :reputation)
    allow(PlayerRepository::BestPlayer)
      .to receive(:new)
      .with(
        team_id: 1,
        type: :keeper,
        date: date,
        reputation: :reputation)
      .and_return double("BestPlayer", best_player: best_player)
    allow(TeamService::EndDate)
      .to receive(:new)
      .with(start_date: date)
      .and_return double("EndDate", end_date: :end_date)

    expect(OfferRepository::Create)
      .to receive(:create)
      .with(
        player_id: 1,
        team_id: 1,
        reputation: :reputation,
        start_date: date,
        end_date: :end_date)
      .and_return :best_offer

    expect(best_offer.offer).to eq :best_offer
  end
end
