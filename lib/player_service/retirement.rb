module PlayerService
  class Retirement
    def initialize(id:, year:)
      @id = id
      @year = year
    end

    def retire?
      # decide for a player whether to retire
      # make the decision persistent (flag)
      # true or false
    end

    private

    attr_reader :id, :year
  end
end
