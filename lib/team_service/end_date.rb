module TeamService
  class EndDate
    def initialize(start_date:)
      @start_date = start_date
    end

    def end_date
      start_date + length
    end

    private

    attr_reader :start_date

    def length
      # TODO implement in future a more sophisticated logic to determine
      # the length of an offered contract.
      # Probably depending on
      #   - strength of player compared to team
      #   - age of player
      #   - reputation of player (yep, that's missing
      (rand(5) + 1).years
    end
  end
end
