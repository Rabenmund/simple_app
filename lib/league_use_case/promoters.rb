module LeagueUseCase
  class SubleaguesDoNotMatchPromotersNumberError < StandardError; end
  class Promoters

    def initialize(league:)
      @league = league
    end

    def first(promoters_no)
      subleagues = LeagueRepository::Subleagues
        .find_all_for league

      # funktioniert nur mit einem Aufsteiger pro subleague
      unless promoters_no == subleagues.size
        fail SubleaguesDoNotMatchPromotersNumberError
      end

      # array/hash/enum.inject(initialize memo) {|memo, v/k,v/v} returns memo
      subleagues.inject([]) do |memo, subleague|
        memo << LeagueRepository::Ranking
          .new(league: subleague)
          .first
      end
    end

    private

    attr_reader :league

  end
end
