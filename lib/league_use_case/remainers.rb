module LeagueUseCase
  class Remainers
    def initialize(league:)
      @league = league
    end

    def from(promoters_no:, size:)
      LeagueRepository::Ranking
        .new(league: league)
        .from(below(promoters_no), size)
    end

    private

    attr_reader :league

    def below(promoters)
      promoters + 1
    end
  end
end
