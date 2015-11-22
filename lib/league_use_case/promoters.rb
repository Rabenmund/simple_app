module LeagueUseCase
  class SubleaguesDoNotMatchPromotersNumberError < StandardError; end
  class Promoters

    def initialize(league:)
      @league = league
    end

    def first(promoters_no)
      subleagues = LeagueRepository::Subleagues
        .find_all_for league

      # funktioniert nur mit einem Aufsteiger pro subleague oder 1 subleague
      unless promoters_no == subleagues.size || subleagues.size < 2
        fail SubleaguesDoNotMatchPromotersNumberError
      end

      # array/hash/enum.inject(initialize memo) {|memo, v/k,v/v} returns memo
      memo = subleagues.inject([]) do |memo, subleague|
        ranks = LeagueRepository::Ranking
          .new(league: subleague)
          .first(promoters_no)
        memo.concat ranks
      end
      memo
    end

    private

    attr_reader :league

  end
end
