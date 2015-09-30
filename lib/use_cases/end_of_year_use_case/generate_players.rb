module EndOfYearUseCase
  class GeneratePlayers
    def initialize(year:)
      @year = year
    end

    def generate
      # generate new young players to replace retirees
    end

    private

    attr_reader :year
  end
end
