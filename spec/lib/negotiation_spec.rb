require "spec_helper"

describe Negotiation do
  let(:offer) { create :offer }
  let(:negotiation) { Negotiation.new(player: offer.player) }

  it "negotiates" do
    expect(negotiation).to receive :deal_with
    expect(negotiation).to receive :decline_open_offers
    negotiation.negotiate!
  end

  it "deals with the best team" do
    allow(Season).to receive(:current).and_return double(
      start_date: Date.today, end_date: Date.today+1.year)
    negotiation.deal_with offer
    expect(offer.reload).to be_negotiated
    expect(offer.reload).to be_accepted
    expect(Contract.first.organization).to eq offer.team.organization
    expect(Contract.first.human).to eq offer.player.human
  end

  it "declines all open offers" do
    negotiation.decline_open_offers
    expect(offer.reload).to be_negotiated
    expect(offer.reload).to_not be_accepted
  end
end
