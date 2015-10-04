require 'spec_helper'

RSpec.describe PlayerUseCase::FindBestOffer do
  subject(:offer) { PlayerUseCase::FindBestOffer.new(player: player) }
  let(:player) { double("Player") }

  it "selects an offer" do
    allow(offer).to receive(:rand).and_return(150)
    allow(Offer)
      .to receive(:find)
      .with(2)
      .and_return :offer
    expect(PlayerRepository::OfferQuery)
      .to receive(:new)
      .with(player: player)
      .and_return double(
        "PlayerRepo", id_and_reputations: [[1, 100],[2,101],[3,99]])
      expect(offer.find!).to eq :offer
  end

  it "returns nil if no offer is given" do
    allow(Offer)
      .to receive(:find)
    allow(PlayerRepository::OfferQuery)
      .to receive(:new)
      .with(player: player)
      .and_return double(
        "PlayerRepo", id_and_reputations: [])
      expect{offer.find!}
        .to raise_error PlayerUseCase::NoBestOfferToContractError
  end

end
