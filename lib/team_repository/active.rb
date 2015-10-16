module TeamRepository
  module Active
    class << self
      def at(date)
        Team
          .joins(:competitions)
          .joins(:seasons)
          .where(
            "seasons.start_date <= ? AND seasons.end_date >= ?",
            date, date
          )
      end
    end
  end
end

