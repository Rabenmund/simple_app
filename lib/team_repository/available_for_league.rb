module TeamRepository
  class NotEnoughTeamsError < StandardError; end

  class AvailableForLeague
    def initialize(league:)
      @league = league
      @federation = league.federation
    end

    def random(size)
      fail NotEnoughTeamsError unless available.size >= size
      choose size
    end

    private

    attr_reader :league, :federation

    def scheduled
      @scheduled ||= league
        .federation
        .teams
        .joins(:competitions)
    end

    def available
      @available ||= teams - scheduled
    end

    def teams
      @teams ||= federation.teams
    end

    def choose(size)
      chosen = []
      rest_available = available
      size.times do |n|
        index = rand(rest_available.size)
        found = rest_available[index]
        chosen <<  found
        rest_available = available - chosen
      end
      chosen
    end
  end
end
