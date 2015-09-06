require_relative "../../../lib/team_service/best_offer"
require_relative "../../../lib/team_repository/reputation"
require_relative "../../../lib/player_repository/best_player"
require_relative "../../../lib/team_service/end_date"

RSpec.describe TeamService::BestOffer do
  subject(:best_offer) do
    TeamService::BestOffer.new(id: 1, type: :keeper, date: date)
  end

  let(:date) { Date.new(2015,7,1) }
  let(:end_date) {double "EndDate" }

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
      .and_return double("BestPlayer", best_player: :best_player)
    allow(TeamService::EndDate)
      .to receive(:new)
      .with(1)
      .and_return end_date
    allow(end_date)
      .to receive(:end_date_for)
      .with(:best_player)
      .and_return :end_date

    expect(OfferRepository::Create)
      .to receive(:create)
      .with(
        player: :best_player,
        team_id: 1,
        reputation: :reputation,
        start_date: date,
        end_date: :end_date)
      .and_return :best_offer

    expect(best_offer.offer).to eq :best_offer
  end
end
