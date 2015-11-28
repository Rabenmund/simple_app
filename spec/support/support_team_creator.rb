module SupportTeamCreator
  def create_team(n, m=n, league=nil, federation=federation)
    eval "@team#{n} = create :team, federation: federation"
    if league
      eval "league.teams << @team#{n}"
      eval "create :result, team: @team#{n}, league: league, rank: #{m}"
    end
  end

end
