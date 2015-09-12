module PlayerRepository
  class Age
    def initialize(year:)
      @year = year
    end

    def old
      Player
        .joins(:human)
        .where("humen.birthday < ?", Date.new(old_age))
    end

    private

    attr_reader :year

    def old_age
      year - 30
    end
  end
end
