module LeagueUseCase
  class Remainers
    def initialize(league:)
      @league = league
    end

    def between(promoters_no:, relegators_no:)
      LeagueRepository::Ranking
        .new(league: league)
        .from_to(promoters_no, relegators_no)
    end

    private

    attr_reader :league

  end
end
