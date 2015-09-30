require_relative '../../../lib/player_service/select_offer_and_contract'

RSpec.describe PlayerService::SelectOfferAndContract do
  subject(:select) do
    PlayerService::SelectOfferAndContract.new(player: player)
  end
  let(:date) { Date.new(2015,7,1) }
  let(:player) { double("Player") }
  let(:team) { double("Team") }
  let(:offer) do
    double("Offer", id: 3, team: team, start_date: date, end_date: date+1.day)
  end

  before do
    allow(PlayerUseCase::FindBestOffer)
      .to receive(:new)
      .and_return double("Offer", find: offer)
    allow(OfferRepository::Accept)
      .to receive(:new)
      .and_return double("Accept", accept!: true)
    allow(PlayerRepository::CloseAllOffers)
      .to receive(:new)
      .and_return double("Close", close: true)
    allow(ContractRepository::Create)
      .to receive(:new)
      .and_return double("Create", create: true)
  end

  it "creates a contract" do
    expect(ContractRepository::Create)
      .to receive(:new)
      .with(
        player: player,
        team: team,
        from: date,
        to: date+1
      )
      select.create_contract!
  end

  it "accepts the selected offer" do
    expect(OfferRepository::Accept)
      .to receive(:new)
      .with(offer: offer)
      .and_return double("Accept", accept!: true)
    select.create_contract!
  end

  it "closes all players offers" do
    allow(PlayerRepository::CloseAllOffers)
      .to receive(:new)
      .with(player: player)
      .and_return double("Close", close: true)
    select.create_contract!
  end

  it "fails if there is no offer to contract" do
    allow(PlayerUseCase::FindBestOffer)
      .to receive(:new)
      .and_return double("Select", find: nil)
    expect{select.create_contract!}
      .to raise_error PlayerService::NoBestOfferToContractError
  end
end
