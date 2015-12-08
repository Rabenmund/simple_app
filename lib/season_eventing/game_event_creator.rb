module SeasonEventing
  module GameEventCreator
    class << self
      def create(season:, eventable:, appointed_at:)
        event = SeasonEventing::GameEvent
          .create(season: season, eventable: eventable)
        Appointment.create(appointable: event, appointed_at: appointed_at)
        event
      end
    end
  end
end
