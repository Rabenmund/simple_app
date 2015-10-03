require_relative '../../../../lib/use_cases/player_use_case/offer_decision'

RSpec.describe PlayerUseCase::OfferDecision do
  subject(:decision) { PlayerUseCase::OfferDecision.new(player: player) }
  let(:player) { double("Player", retired?: false) }

  it "decides whether to accept an offer" do
    allow(decision).to receive(:rand).and_return 1
    expect(decision.acceptable?(:offer)).to eq true
  end

  it "does not accept if the player is retired" do
    allow(player).to receive(:retired?).and_return(true)
    expect(decision.acceptable?(:offer)).to eq false
  end
end
