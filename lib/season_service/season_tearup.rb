module SeasonService
  class SeasonTearUp
    def initialize(id:)
      @id = id
    end

    def tearup
      # create new season
      # fill up all teams with players
    end

    private

    attr_reader :id
  end
end
