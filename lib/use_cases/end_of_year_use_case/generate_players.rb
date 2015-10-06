module EndOfYearUseCase
  class GeneratePlayers
    def initialize(year:)
      @year = year
    end

    def generate
      # generate new young players to replace retirees
      #
      # bedarf?
      # anzahl teams pro saison * 25
      # anzahl spieler dieser teams mit vertrag zum saisonende
      # anzahl spieler ohne vertrag zum saisonende
      #
    end

    private

    attr_reader :year
  end
end
