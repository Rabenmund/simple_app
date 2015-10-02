require_relative '../../../../lib/use_cases/end_of_year_use_case/team_prolongations'

RSpec.describe EndOfYearUseCase::TeamProlongations do
  subject(:prolongations) do
    EndOfYearUseCase::TeamProlongations.decisions(date: date)
  end

  let(:date) { Date.new(2016,6,30) }
  let(:team) { double("Team") }

  it "asks all teams with ending contracts to decide prolongations" do
    expect(TeamRepository::EndingContracts)
      .to receive(:new)
      .with(date: date)
      .and_return double("EndingContracts", players: [team])
    team_prolongations = double "TeamProlongations"
    expect(TeamUseCase::PlayerProlongations)
      .to receive(:new)
      .with(team: team, date: date)
      .and_return team_prolongations
    expect(team_prolongations)
      .to receive(:prolongate_players)
      .and_return [1,2,3]
    expect(prolongations).to eq [1,2,3]
  end

end
