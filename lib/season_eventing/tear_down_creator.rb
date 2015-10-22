module SeasonEventing
  module TearDownCreator
    class << self
      def for_season(season)
        tear_down = TearDown.create(season: season)
        Appointment
          .create(appointable: tear_down, appointed_at: season.end_date)
      end
    end
  end
end
