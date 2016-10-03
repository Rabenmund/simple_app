module SeasonEventing
  class DrawEvent < SeasonEvent

    def perform
      all_steps
    end

    def step
      return false unless performable?
      appointment.add_a_minute!
      game_with random_teams
    end

    private

    attr_accessor :undrawed_teams

    def draw
      eventable
    end

    def undrawed
      @undrawed_teams ||= draw.undrawed_teams
    end

    def performable?
      finish! if undrawed.size < 2
      !draw.finished?
    end

    def finish!
      draw.finished? || draw.finish!
      if appointment
        update_attributes(performed_at: appointed_at)
        appointment.delete
      end
    end

    def all_steps
      return eventable.games unless step
      all_steps
    end

    def game_with(attr)
      home = attr[0]
      guest = attr[1]
      game = GameCreator
        .create(
          date: game_start,
          attributes: {
            home: home,
            guest: guest,
            matchday: draw.matchday,
            decision: true
          }
      )
      @undrawed_teams -= [home, guest]
      return home, guest
    end

    def game_start
      SeasonUseCase::GameStart
        .date_time(type: :cup,
                   level: draw.cup.level,
                   matchday_start: draw.matchday.start,
                   md_number: draw.matchday.number,
                   g_number: (draw.matchday.games.count + 1)
                  )
    end

    def random_teams(teams = undrawed)
      first, second = random_numbers(size: teams.size)
      ordered_teams(teams, first, second)
    end

    def random_numbers(size:)
      first = random_number(size: size) - 1
      second = random_number(size: size, ignore: first + 1) - 1
      return first, second
    end

    def random_number(size:, ignore: nil)
      number = rand(1..size)
      number == ignore ? random_number(size: size, ignore: ignore) : number
    end

    def ordered_teams(teams, first, second)
      # TODO move to Teams use case
      home = teams[first]
      guest = teams[second]
      return guest, home if guest.current_level > home.current_level
      return home, guest
    end
  end
end
