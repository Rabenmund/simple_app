require_relative '../../../lib/player_service/select_offer_and_contract'

RSpec.describe PlayerService::SelectOfferAndContract do
  subject(:select) { PlayerService::SelectOfferAndContract.new(id: 1) }
  let(:date) { Date.new(2015,7,1) }

  before do
    allow(PlayerService::FindBestOffer)
      .to receive(:new)
      .and_return double("Select", select_offer: 1)
    allow(OfferRepository::Adapter)
      .to receive(:new)
      .and_return double(offer:
                    double("Offer", id: 3, team_id: 2,
                           start_date: date, end_date: date+1))
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
        player_id: 1,
        team_id: 2,
        from: date,
        to: date+1
      )
      select.create_contract!
  end

  it "accepts the selected offer" do
    expect(OfferRepository::Accept)
      .to receive(:new)
      .with(id: 3)
      .and_return double("Accept", accept!: true)
    select.create_contract!
  end

  it "closes all players offers" do
    allow(PlayerRepository::CloseAllOffers)
      .to receive(:new)
      .with(id: 1)
      .and_return double("Close", close: true)
    select.create_contract!
  end

  it "fails if there is no offer to contract" do
    allow(PlayerService::FindBestOffer)
      .to receive(:new)
      .and_return double("Select", select_offer: nil)
    expect{select.create_contract!}
      .to raise_error PlayerService::NoBestOfferToContractError
  end
end
