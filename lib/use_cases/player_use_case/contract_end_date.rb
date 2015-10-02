module PlayerUseCase
  module ContractEndDate
    class << self
      def call(start_date: start_date, player: player)
        @age = HumanRepository::Age.new(human: player.human)
          .age_at(start_date)
        start_date + duration.years - 1.day
      end

      private

      attr_reader :age

      def duration
        # TODO implement in future a more sophisticated logic to determine
        # the duration of an offered contract.
        # Probably more depending on
        #   - strength of player compared to team
        #   - reputation of player (yep, that's missing)

        len = (rand(3) + 1)
        len += 1 if young?
        len += 1 if very_young?
        len -= 1 if old?
        len -= 1 if very_old?
        len < 1 ? 1 : len
      end

      def young?
        age < 24
      end

      def very_young?
        age < 20
      end

      def old?
        age > 28
      end

      def very_old?
        age > 32
      end
    end
  end
end
