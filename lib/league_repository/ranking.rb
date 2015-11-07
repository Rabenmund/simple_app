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

    def between(from, to)
      league
        .teams
        .joins(:results)
        .order("results.rank")
        .where("results.rank" => from..to)

    end

    private

    attr_reader :league

  end

end
