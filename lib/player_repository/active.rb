module PlayerRepository
  module Active
    class << self
      def for_teams_at(teams:, date:)
        PlayerRepository::ContractableFinder.at(date) +
          PlayerRepository::ContractedFinder
          .for_teams_at(teams: teams, date: date)
      end

    end
  end
end
