module SeasonEventing
  class GameEvent < SeasonEvent

    def perform
      return false if game.finished?
      GamePublisher.publish(game_play_event)
    end

    private

    def game
      eventable
    end

    def game_play_event
      GamePlayEvent.new(game)
    end

    # STEP_TIME = 6
    # GAME_END = 5400

    # def perform!(&block)
    #   yield
    #   save
    #   return eventable
    # end

    # def performable?
    #   return false if game.finished?
    #   game.start! unless game.started?
    #   true
    # end

    # def add_step_time
    #   game.second = game.second + STEP_TIME
    # end

    # def to_be_finished?
    #   game.second >= GAME_END
    # end

    # def finish!
    #   game.finish!
    # end

    # def steps(times)
    #   times.times do |time|
    #     finish! if to_be_finished?
    #     break if finished?
    #     add_step_time
    #   end
    # end
  end
end
