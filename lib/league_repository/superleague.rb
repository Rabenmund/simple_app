module LeagueRepository
  module Superleague
    class << self
      def find_for(league)
        league
          .season
          .leagues
          .find_by(level: (league.level - 1))
      end
    end
  end
end
