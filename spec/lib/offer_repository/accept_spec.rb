require 'spec_helper'

RSpec.describe OfferRepository::Accept do
  subject(:repo) { OfferRepository::Accept.new(id: offer.id) }
  let(:offer) { create :offer }

  it "accepts an offer" do
    repo.accept!
    expect(offer.reload.accepted).to eq true
  end
end
