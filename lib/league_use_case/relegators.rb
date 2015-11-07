module LeagueUseCase
  class Relegators
    def initialize(league:)
      @league = league
    end

    def last(relegators_no)
      superleague = LeagueRepository::Superleague
        .find_for league

      LeagueRepository::Ranking
        .new(league: superleague)
        .last(relegators_no)
    end

    private

    attr_reader :league

  end
end
