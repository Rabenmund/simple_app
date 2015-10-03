require_relative '../../../../lib/use_cases/player_use_case/all_decide_offers'

RSpec.describe PlayerUseCase::AllDecideOffers do
  subject(:decision) do
    PlayerUseCase::AllDecideOffers.decisions
  end

  it "let players decide about all open offers" do
    expect(PlayerRepository::OpenOffers)
      .to receive(:all)
      .and_return([:player1, :player2])
    expect(PlayerUseCase::DecideOffers)
      .to receive(:new)
      .with(player: :player1)
      .and_return double("Decision", decide!: true)
    expect(PlayerUseCase::DecideOffers)
      .to receive(:new)
      .with(player: :player2)
      .and_return double("Decision", decide!: true)
    decision
  end
end
