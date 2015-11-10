module LeagueRepository
  class LeagueCreator
    attr_accessor :league

    def initialize(attributes)
      @league = League.new(attributes)
    end

    def invoke_with_teams(teams)
      league.save!
      # Create matchdays and games
      teams.each {|team| league.teams << team }
      league
    end
  end
end
