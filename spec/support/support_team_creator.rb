module SupportTeamCreator
  def create_team(number:, federation:, rank: number, league: nil)
    eval "@team#{number} = create :team, federation: federation"
    if league
      eval "league.teams << @team#{number}"
      eval "create :result, team: @team#{number}, league: league, rank: #{rank}"
    end
  end

end
