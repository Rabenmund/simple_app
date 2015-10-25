require 'spec_helper'

RSpec.describe PlayerRepository::BestPlayer do
  subject(:players) do
    PlayerRepository::BestPlayer
      .new(type: :keeper,
           date: Date.today,
           reputation: 100,
           team: double("Team", id: 1)
          )
  end

  it "queries the best player" do
    expect(Player)
      .to receive_message_chain(
            :active, :without_offer_by, :without_contract_at,
            :without_too_many_hard_competitors, :where, :not,
            :order, :first)
      .and_return :best_player
    expect(players.best_player).to eq :best_player
  end

  it "fails if no player is found" do
    allow(Player)
      .to receive_message_chain(
            :active, :without_offer_by, :without_contract_at,
            :without_too_many_hard_competitors, :where, :not,
            :order, :first)
      .and_return nil
    expect{players.best_player}
      .to raise_error(PlayerRepository::NoBestPlayerFoundError)
  end
end
