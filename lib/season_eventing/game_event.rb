module SeasonEventing
  class GameEvent < SeasonEvent

    def perform
      perform! { all_steps }
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

    attr_writer :snapshot

    def snapshot
      @snapshot ||= Snapshot.new(game)
    end

    def steps(times)
      times.times do |time|
        finish! if to_be_finished?
        break if finished?
        add_step_time
        snapshot = GameMover.move(snapshot)
      end
    end

  end
end


class GameMover
  def self.move(snapshot)
    # entscheidungen:
    # ball_position -> field_position
    # ball_owner -> team
    # home_formation -> formation
    # guest_formation -> formation
    # home_ofcon -> ofcon
    # guest_ofcon -> ofcon
    #
    # effects:
    # events
    #
    # use:
    #

  end
end

class Snapshot
  attr_reader :game

  def initialize(game)
    @game = game
  end




end
