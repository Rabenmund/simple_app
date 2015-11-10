module LeagueRepository
  module  Finder
    class << self
      def by_name(season:, name:)
        season
          .leagues
          .find_by(name: name)
      end
    end
  end
end
