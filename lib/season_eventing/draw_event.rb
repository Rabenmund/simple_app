module SeasonEventing
  class DrawEvent < SeasonEvent

    def perform
      all_steps
    end

    def step
      return false unless drawable?
      appointment.add_a_minute!
      game_with random_teams
    end

    private

    def draw
      eventable
    end

    def undrawed
      draw.undrawed_teams
    end

    def drawable?
      finish! if undrawed.size < 2
      draw.finished? ? false : true
    end

    def finish!
      draw.finished? || draw.finish!
      if appointment
        update_attributes(performed_at: appointed_at)
        appointment.delete
      end
    end

    def all_steps
      return true unless step
      all_steps
    end

    def game_with(home, guest)
      GameRepository::GameCreator
        .create(date: GameStart.date,
                attributes: {
                 home: home,
                  guest: guest,
                  decision: true
                })
        return home, guest
    end

    def random_teams(teams = undrawed)
      first, second = random_numbers(size: teams.size)
      ordered_teams(teams, first, second)
    end

    def random_numbers(size:)
      first = random_number(size: teams.size) - 1
      second = random_number(size: teams.size, ignore: first) - 1
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
      guest.current_level < home.current_level ? [guest, home] : [home, guest]
    end
  end
end
