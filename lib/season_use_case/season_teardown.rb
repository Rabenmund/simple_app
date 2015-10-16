module SeasonUseCase
  class SeasonTeardown
    def initialize(id:)
      @id = id
    end

    def teardown
      # put everything here that should be done for a dying season

      # check whether contracts of retired players finish.
      # If so - set the profession to inactive
    end

    private

    attr_reader :id
  end
end
