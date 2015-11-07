module LeagueRepository
  module Subleagues
    class << self
      def find_all_for(league)
        league
          .season
          .leagues
          .where(level: (league.level + 1))
      end
    end
  end
end
