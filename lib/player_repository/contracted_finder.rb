module PlayerRepository
  module ContractedFinder
    class << self
      def at(date)
        Player
          .joins(:human)
          .joins(:contracts)
          .where("contracts.to >= ?", date)
          .uniq
      end

      def for_team_at(team:, date:)
        for_teams_at teams: [team], date: date
      end

      def for_teams_at(teams:, date:)
        Player
          .joins(:human)
          .joins(:contracts)
          .joins(:organizations)
          .joins(:teams)
          .where("contracts.to >= ?", date)
          .where("teams.id IN (?)", teams.map(&:id))
          .uniq
      end
    end
  end
end

