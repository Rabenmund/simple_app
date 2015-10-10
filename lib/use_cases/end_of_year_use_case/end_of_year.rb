module EndOfYearUseCase
  module EndOfYear
    class << self

      def call(year: year)
        PlayerRetirements.new(year: year).decisions
        TeamProlongations.new(date: end_date(year)).decisions
        PlayerUseCase::AllDecideOffers.decisions
        # TODO: move that to season teardown before final negotiation round
        ProduceMissingPlayers.at(Date.new(year+1, 7, 1))
      end

      private

      def end_date(year)
        @end_date ||= Date.new((year + 1),6,30)
      end
    end
  end
end
