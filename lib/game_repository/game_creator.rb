module GameRepository
  module GameCreator
    class << self
      def with_appointment(date:, attributes:)
        game = Game.create(attributes)
        Appointment.create(appointed_at: date, appointable: game)
        game
      end
    end
  end
end
