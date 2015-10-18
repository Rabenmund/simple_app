module SeasonEventing
  module HalfTimeCreator
    class << self
      def for_season(season)
        half_time = HalfTime.create!(season: season)

        appointment_date = Date.new(season.start_date.year, 12, 31)
        Appointment.create!(appointable: half_time,
                            appointed_at: appointment_date)

      end
    end
  end
end
