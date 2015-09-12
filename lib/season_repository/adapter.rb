module SeasonRepository
  class Adapter
    def initialize(id:)
      @season = Season.find(id)
    end

    def league_ids
      season
        .leagues
        .order(level: :asc)
        .ids
    end

    def team_ids
      season
        .teams
        .ids
        .uniq
    end

    def start_date
      season.start_date
    end

    private

    attr_reader :season

  end
end
