module LeagueRepository
  class Ranking
    def initialize(league:)
      @league = league
    end

    def first(no = 1)
      league
        .teams
        .joins(:results)
        .order("results.rank")
        .first(no)
    end

    def last(no = 1)
      league
        .teams
        .joins(:results)
        .order("results.rank")
        .last(no)
    end

    def from(from, size)
      league
        .teams
        .joins(:results)
        .order("results.rank")
        .where("results.rank" => from..(from+size - 1))
    end

    private

    attr_reader :league
  end
end
