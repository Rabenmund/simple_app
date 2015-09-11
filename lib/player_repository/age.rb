module PlayerRepository
  class Age
    def initialize(year:)
      @year = year
    end

    def old
      # Get old player_ids from repo
    end

    private

    attr_reader :year
  end
end
