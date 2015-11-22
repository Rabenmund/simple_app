module MatchdayRepository
  module MatchdayCreator
    class << self
      def create(attributes)
        Matchday.create attributes
      end
    end
  end
end
