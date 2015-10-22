module SeasonEventing
  module FinishPlayerExchangeCreator
    class << self
      def for_season(season)
        finisher = FinishPlayerExchange.create(season: season)
        Appointment
          .create(appointable: finisher, appointed_at: season.end_date)
      end
    end
  end
end
