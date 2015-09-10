module SeasonService
  class SeasonTeardown
    def initialize(id:)
      @id = id
    end

    private

    attr_reader :id
  end
end
