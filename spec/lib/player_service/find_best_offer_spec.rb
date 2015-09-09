require_relative '../../../lib/player_service/find_best_offer'

RSpec.describe PlayerService::FindBestOffer do
  subject(:offer) { PlayerService::FindBestOffer.new(id: 1) }

  it "selects an offer" do
    allow(PlayerRepository::Adapter)
      .to receive(:new)
      .with(id: 1)
      .and_return double(
        "PlayerRepo", offer_reputations: [[1, 100],[2,101],[3,99]])
      expect([1,2,3]).to include offer.select_offer
  end

  it "returns nil if no offer is given" do
    allow(PlayerRepository::Adapter)
      .to receive(:new)
      .with(id: 1)
      .and_return double(
        "PlayerRepo", offer_reputations: [])
      expect(offer.select_offer).to eq nil
  end

end
