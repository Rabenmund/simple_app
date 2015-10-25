require_relative "../../../lib/team_service/best_offer"

RSpec.describe TeamService::BestOffer do
  subject(:best_offer) do
    TeamService::BestOffer.new(team: team, date: date)
  end

  let(:team) { double("Team", reputation: 100) }
  let(:date) { Date.new(2015,7,1) }
  let(:best_player) { double("BestPlayer") }

  it "places an offer for the best given player" do
    allow(PlayerRepository::BestPlayer)
      .to receive(:new)
      .with(
        team: team,
        type: :keeper,
        date: date,
        reputation: 100)
      .and_return double("BestPlayer", best_player: best_player)
    allow(PlayerUseCase::ContractEndDate)
      .to receive(:call)
      .with(start_date: date, player: best_player)
      .and_return :end_date

    expect(OfferRepository::Create)
      .to receive(:create)
      .with(
        player: best_player,
        team: team,
        reputation: team.reputation,
        start_date: date,
        end_date: :end_date)
      .and_return :best_offer

    expect(best_offer.offer_player(type: :keeper)).to eq :best_offer
  end
end
