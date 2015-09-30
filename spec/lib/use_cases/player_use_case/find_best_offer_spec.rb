require_relative '../../../../lib/use_cases/player_use_case/find_best_offer'

RSpec.describe PlayerUseCase::FindBestOffer do
  subject(:offer) { PlayerUseCase::FindBestOffer.new(player: player) }
  let(:player) { double("Player") }

  it "selects an offer" do
    allow(PlayerRepository::OfferQuery)
      .to receive(:new)
      .with(player: player)
      .and_return double(
        "PlayerRepo", id_and_reputations: [[1, 100],[2,101],[3,99]])
      expect([1,2,3]).to include offer.find
  end

  it "returns nil if no offer is given" do
    allow(PlayerRepository::OfferQuery)
      .to receive(:new)
      .with(player: player)
      .and_return double(
        "PlayerRepo", id_and_reputations: [])
      expect(offer.find).to eq nil
  end

end
