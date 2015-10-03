require_relative '../../../../lib/use_cases/player_use_case/decide_offers'

RSpec.describe PlayerUseCase::DecideOffers do
  subject(:decision) { PlayerUseCase::DecideOffers.new(player: player) }
  let(:player) { double("Player") }
  let(:offer) do
    double("Offer", team: :team, start_date: :start, end_date: :end)
  end

  it "accepts a best offer" do
    allow(PlayerUseCase::OfferDecision)
      .to receive(:new)
      .with(player: player)
      .and_return double("Decision", acceptable?: true)
    expect(PlayerUseCase::FindBestOffer)
      .to receive(:new)
      .with(player: player)
      .and_return double("Offer", find!: offer)
    expect(OfferRepository::Accept)
      .to receive(:new)
      .with(offer: offer)
      .and_return double("Offer", accept!: true)
    expect(PlayerRepository::CloseAllOffers)
      .to receive(:new)
      .with(player: player)
      .and_return double("Closer", close: true)
    expect(ContractRepository::Create)
      .to receive(:new)
      .with(player: player, team: :team, from: :start, to: :end)
      .and_return double("Contract", create: :created)
    expect(decision.accept_acceptable_offer).to eq :created
  end

  it "does not accept a non-acceptable offer" do
    expect(PlayerUseCase::OfferDecision)
      .to receive(:new)
      .with(player: player)
      .and_return double("Decision", acceptable?: false)
    allow(PlayerUseCase::FindBestOffer)
      .to receive(:new)
      .with(player: player)
      .and_return double("Offer", find!: offer)
    expect(decision.accept_acceptable_offer).to eq nil
  end
end
