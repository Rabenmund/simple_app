module PlayerUseCase
  class Retirement
    def initialize(player:, year:)
      @player = player
      @year = year
    end

    def retire?
      decision? && retire!
    end

    def retire!
      PlayerRepository::Updater.new(player: player).retire!
    end

    private

    attr_reader :player, :year

    YEARS_TO_BE_OLD = 30

    def birthyear
      year - YEARS_TO_BE_OLD
    end

    def decision?
      (rand(100) + 1) <= probability
    end

    def probability
      # exponential increase: 1,4,16,25,36,49,64,81,100
      # percentage of retiring players per age:
      # 30: 1,31: 5,32: 20,33: 40,34: 62,35: 81,36: 93,37: 97,38: 100
      years_over ** 2
    end

    def years_over
      over = birthyear - player.birthday.year
      over > 0 ? over : 0
    end

  end
end
