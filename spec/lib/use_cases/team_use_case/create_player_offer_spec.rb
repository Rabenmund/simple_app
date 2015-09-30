require_relative '../../../../lib/use_cases/team_use_case/create_player_offer'

RSpec.describe TeamUseCase::CreatePlayerOffer do
  subject do
    TeamUseCase::CreatePlayerOffer.at(team: team, player: player, date: date)
  end

  let(:team) { double("Team", reputation: 100) }
  let(:player) { double("Player") }
  let(:date) { double("Date") }

  it "creates an offer" do
    allow(PlayerUseCase::ContractEndDate)
      .to receive(:call)
      .and_return(:end_date)
    expect(OfferRepository::Create)
      .to receive(:create)
      .with(
        player: player,
        team: team,
        reputation: 100,
        start_date: date,
        end_date: :end_date
      )
      .and_return :created
    expect(subject).to eq :created
  end
end

