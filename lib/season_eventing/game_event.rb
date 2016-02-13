module SeasonEventing
  class GameEvent < SeasonEvent

    def perform
      perform! { all_steps }
    end

    def step
      perform! { steps(10) }
    end

    private

    STEP_TIME = 6
    GAME_END = 5400

    def game
      eventable
    end

    def perform!(&block)
      return false unless performable?
      yield
      save
      return eventable
    end

    def performable?
      return false if game.finished?
      game.start! unless game.started?
      true
    end

    def all_steps
      return game unless steps(1)
      all_steps
    end

    def steps(times)
      times.times do |time|
        finish! if to_be_finished?
        break if finished?
        add_step_time
        # probably:
        # have a scene: contains positions (players and ball)
        # have an action function to create events and returns a new scene
        # game_scene.perform
      end
    end

    # TODO: find another name and class
    def game_scene
      @game_scene ||= GameScene.new(
        game: game,
        home_lineup: game.home_lineup,
        guest_lineup: game.guest_lineup
      )
    end

    def add_step_time
      game.second = game.second + STEP_TIME
    end

    def to_be_finished?
      game.second >= GAME_END
    end

    def finished?
      game.finished?
    end

    def finish!
      game.finish!
    end
  end
end
