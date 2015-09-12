module SeasonService
  class SeasonTeardown
    def initialize(id:)
      @id = id
    end

    def teardown
      # put everything here that should be done for a dying season
    end

    private

    attr_reader :id
  end
end
