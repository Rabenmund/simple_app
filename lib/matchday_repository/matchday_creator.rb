module MatchdayRepository
  module MatchdayCreator
    class << self
      def create(attributes)
        defaults = {name: "#{attributes[:number]}.Spieltag"}
        Matchday.create defaults.merge(attributes)
      end
    end
  end
end
