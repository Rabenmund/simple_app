require 'spec_helper'

RSpec.describe OfferRepository::Adapter do
  subject(:repo) { OfferRepository::Adapter.new(id: offer.id) }
  let(:offer) { create :offer }

  it "has a valid offer" do
    expect(repo.offer).to eq offer
  end
end
