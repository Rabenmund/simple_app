module DrawRepository
  module DrawCreator
    class << self
      def create(matchday:, cup:)
        draw = cup.draws.create(
          name: "Auslosung #{matchday.name}",
          performed_at: draw_date_for(matchday),
          matchday: matchday
        )
        event = SeasonEventing::DrawEventCreator
          .create(season: cup.season,
                  eventable: draw,
                  appointed_at: draw.performed_at
                 )
        draw
      end

      private

      def draw_date_for(matchday)
        if matchday.number == 1
          matchday.start - 14.days + 18.hours + 30.minutes
        else
          previous(matchday).start + 1.day + 23.hours + 30.minutes
        end
      end

      def previous(matchday)
        matchday.previous
      end
    end
  end
end
