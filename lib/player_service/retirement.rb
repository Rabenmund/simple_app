require 'player_repository/adapter'
require 'player_repository/age'

module PlayerService
  class Retirement
    def initialize(id:, birthyear:)
      @id = id
      @birthyear = birthyear
    end

    def retire?
      decision? && retire!
    end

    private

    attr_reader :id, :birthyear

    def decision?
      (rand(100) + 1) <= probability
    end

    def probability
      # exponential increase: 1,4,16,25,36,49,64,81,100
      # percentage of retiring players per age:
      # 30: 1,31: 5,32: 20,33: 40,34: 62,35: 81,36: 93,37: 97,38: 100
      years_over ** 2
    end

    def retire!
      PlayerRepository::Adapter.new(id: id).retire!
    end

    def years_over
      PlayerRepository::Age.years_over(id: id, birthyear: birthyear)
    end

  end
end
