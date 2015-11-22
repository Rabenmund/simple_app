module SeasonUseCase
  module CompetitionStart
    class << self

      def date_for(year:)
        earliest_start = Date.new(year,8,2)
        earliest_start + days_between(earliest_start.wday, saturday)
      end

      private

      def saturday
        6
      end

      def days_between(start, goal)
        goal - start
      end

    end
  end
end
